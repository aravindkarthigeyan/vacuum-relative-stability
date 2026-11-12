"""Check current PDFs, source packages, Lean source pins and the saved proof audit."""
from pathlib import Path
import hashlib
import json
import re
import zipfile

ROOT = Path(__file__).resolve().parent

def digest(data):
    return hashlib.sha256(data).hexdigest()

papers = []
for name in ("paper-a-lattice", "paper-b-momentum", "companion-notes"):
    verification = json.loads((ROOT / name / "verification.json").read_text())
    assert digest((ROOT / name / (name + ".pdf")).read_bytes()) == verification["sha256"]
    manifest = json.loads((ROOT / (name + "-manifest.json")).read_text())
    archive = ROOT / manifest["archive"]
    assert digest(archive.read_bytes()) == manifest["sha256"]
    with zipfile.ZipFile(archive) as z:
        assert z.testzip() is None
        for record in manifest["included_files"]:
            current = (ROOT / name / record["path"]).read_bytes()
            assert current == z.read(record["path"])
            assert digest(current) == record["sha256"]
    assert manifest["validation"]["text_sha256"] == verification["text_sha256"]
    assert not verification["compiler_diagnostics"]
    papers.append({"project": name, "pages": verification["pages"],
                   "source_archive_matches_current_files": True,
                   "clean_extraction_compile": "passed"})

lean = ROOT / "lean-core"
source_records = []
for line in (lean / "SOURCE_SHA256SUMS.txt").read_text().splitlines():
    expected, name = line.split("  ", 1)
    actual = digest((lean / name).read_bytes())
    assert actual == expected.lower(), name
    source_records.append(name)
theorems = []
for path in sorted((lean / "Core").glob("*.lean")):
    text = path.read_text(encoding="utf-8-sig")
    assert not re.search(r"^\s*(?:axiom|opaque)\b|\b(?:sorry|admit|native_decide)\b", text, re.M)
    theorems.extend("QEDCore." + name for name in
                    re.findall(r"^theorem\s+(\w+)", text, re.M))
audit = (lean / "logs" / "axioms.log").read_text(encoding="utf-8-sig")
records = re.findall(r"'([^']+)' depends on axioms: \[([^\]]*)\]", audit)
assert set(theorems) == {name for name, axioms in records}
allowed = {"propext", "Classical.choice", "Quot.sound"}
for name, axioms in records:
    assert {a.strip() for a in axioms.split(",") if a.strip()} <= allowed, name
root_log = (lean / "logs" / "root-recheck.log").read_text(encoding="utf-8-sig")
assert "Build completed successfully." in root_log
assert "sorryAx" not in root_log

preserved = 0
with zipfile.ZipFile(ROOT / "vacuum-relative-stability-sources.zip") as z:
    for name in z.namelist():
        if name.startswith(("vacuum-relative-stability-paper/", "stability-qed-paper/")) \
                and name.endswith((".tex", ".pdf")):
            assert (ROOT / name).read_bytes() == z.read(name), name
            preserved += 1
report = {
    "papers": papers,
    "lean": {
        "project_theorems": len(theorems),
        "all_declared_theorems_audited": True,
        "only_standard_foundational_axioms": True,
        "no_custom_axioms_or_proof_holes": True,
        "source_checksums_verified": len(source_records),
        "independent_root_build_and_audit": "passed",
        "coverage": "partial; see lean-core/README.md",
    },
    "preserved_earlier_tex_and_pdf_files": preserved,
    "submitted": False,
}
(ROOT / "ROUND5_VERIFICATION.json").write_text(json.dumps(report, indent=2), encoding="utf-8")
print(json.dumps(report, indent=2))
