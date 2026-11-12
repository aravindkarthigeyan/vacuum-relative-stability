"""Rebuild and verify the current research delivery archive."""
from pathlib import Path
import hashlib
import json
import zipfile

ROOT = Path(__file__).resolve().parent
ARCHIVE = ROOT / "vacuum-relative-stability-sources.zip"
MANIFEST = ROOT / "vacuum-relative-stability-manifest.json"


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def selected_files():
    files = set(ROOT.glob("*.md"))
    files.add(ROOT / "package_research.py")
    files.add(ROOT / "package_arxiv.py")
    files.add(ROOT / "vacuum-relative-stability-arxiv.zip")
    files.add(ROOT / "vacuum-relative-stability-arxiv-manifest.json")
    for name in ("vacuum-relative-stability-paper", "stability-qed-paper"):
        project = ROOT / name
        files.update(project.glob("*.tex"))
        for filename in ("build.ps1", "verify_pdf.py", "verification.json"):
            files.add(project / filename)
    files.update({
        ROOT / "vacuum-relative-stability-paper" / "vacuum-relative-stability.pdf",
        ROOT / "stability-qed-paper" / "stability-qed-paper.pdf",
        ROOT / "stability-qed-paper" / "README.txt",
    })
    for pattern in ("*.py", "*.json", "*.output.txt"):
        files.update((ROOT / "numerics").glob(pattern))
    for path in files:
        if not path.is_file() or not path.resolve().is_relative_to(ROOT):
            raise RuntimeError(f"Invalid package input: {path}")
    return sorted(files, key=lambda path: path.relative_to(ROOT).as_posix())


files = selected_files()
records = []
with zipfile.ZipFile(ARCHIVE, "w", compression=zipfile.ZIP_DEFLATED) as archive:
    for path in files:
        relative = path.relative_to(ROOT).as_posix()
        data = path.read_bytes()
        archive.writestr(relative, data)
        records.append({"path": relative, "bytes": len(data), "sha256": sha256(data)})

with zipfile.ZipFile(ARCHIVE, "r") as archive:
    assert archive.testzip() is None
    assert len(archive.namelist()) == len(records)
    for record in records:
        assert sha256(archive.read(record["path"])) == record["sha256"]

summary = {
    "archive": str(ARCHIVE),
    "files": len(records),
    "bytes": ARCHIVE.stat().st_size,
    "sha256": sha256(ARCHIVE.read_bytes()),
    "included_files": records,
}
MANIFEST.write_text(json.dumps(summary, indent=2), encoding="utf-8")
print(json.dumps({key: value for key, value in summary.items()
                  if key != "included_files"}, indent=2))
