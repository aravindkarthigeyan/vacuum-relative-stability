"""Build a clean arXiv-format source archive and compile its exact contents.

Requires PDFLaTeX on PATH and pypdf. No upload is performed.
"""
from pathlib import Path
import hashlib
import json
import re
import shutil
import subprocess
import tempfile
import zipfile

from pypdf import PdfReader

ROOT = Path(__file__).resolve().parent
PROJECT = ROOT / "vacuum-relative-stability-paper"
ARCHIVE = ROOT / "vacuum-relative-stability-arxiv.zip"
MANIFEST = ROOT / "vacuum-relative-stability-arxiv-manifest.json"
INPUT = re.compile(r"\\(?:input|include)\{([^}]+)\}")
DIAGNOSTIC = re.compile(
    r"Overfull|Underfull|undefined references|Citation .*undefined|"
    r"Reference .*undefined|LaTeX Warning|Package .* Warning|Missing character"
)


def sha256(data):
    return hashlib.sha256(data).hexdigest()


def tex_inputs(path, found):
    path = path.resolve()
    if path in found:
        return
    if not path.is_file() or path.parent != PROJECT.resolve():
        raise RuntimeError(f"Unexpected TeX input: {path}")
    data = path.read_bytes()
    text = data.decode("utf-8-sig")
    if any(ord(char) < 32 and char not in "\t\r\n" for char in text):
        raise RuntimeError(f"Control character in {path.name}")
    if re.search(r"[A-Z]:[\\/](?:Users|Windows|Program)|\\href\{run:|/Users/|/home/", text):
        raise RuntimeError(f"Nonportable link in {path.name}")
    found[path] = data
    for child in INPUT.findall(text):
        tex_inputs(path.parent / (child if child.endswith(".tex") else child + ".tex"), found)


tex = {}
tex_inputs(PROJECT / "main.tex", tex)
contents = {path.name: data for path, data in tex.items()}
names = {
    "check_gaussian_domination.py", "gaussian_domination_checks.json",
    "round2_mass_gap_checks.py", "round2_mass_gap_checks.json",
    "claude_scripts_reproduction.json",
}
for path in (ROOT / "numerics").glob("claude*"):
    if path.is_file() and path.suffix in (".py", ".txt", ".json"):
        names.add(path.name)
for name in sorted(names):
    path = ROOT / "numerics" / name
    data = path.read_bytes()
    if re.search(rb"[A-Z]:[\\/]|/Users/|/home/", data):
        raise RuntimeError(f"Machine-specific path in ancillary file {name}")
    contents["anc/numerics/" + name] = data
contents["anc/README.txt"] = (
    "Supporting finite-dimensional numerical diagnostics\n"
    "==================================================\n"
    "These are diagnostics, not substitutes for the mathematical proofs.\n"
    "Keep all scripts in numerics together: two supplied checks execute the\n"
    "shared setup in claude_gd_random_check.py using a relative path.\n"
    "Requirements: Python 3, NumPy and SciPy. Run a .py file directly.\n"
    "The .json and .output.txt files record earlier reproducibility checks;\n"
    "the manuscript distinguishes their scope and counterexamples.\n"
    "No computations are required to compile the manuscript.\n"
).encode("utf-8")

records = []
with zipfile.ZipFile(ARCHIVE, "w", zipfile.ZIP_DEFLATED) as archive:
    for name, data in sorted(contents.items()):
        archive.writestr(name, data)
        records.append({"path": name, "bytes": len(data), "sha256": sha256(data)})
with zipfile.ZipFile(ARCHIVE) as archive:
    assert archive.testzip() is None
    for record in records:
        assert sha256(archive.read(record["path"])) == record["sha256"]

compiler = shutil.which("pdflatex")
if compiler is None:
    raise RuntimeError("PDFLaTeX is required for the clean-extraction check.")
qa_parent = ROOT / "tmp"
qa_parent.mkdir(exist_ok=True)
qa = Path(tempfile.mkdtemp(prefix="arxiv-compile-", dir=qa_parent))
with zipfile.ZipFile(ARCHIVE) as archive:
    archive.extractall(qa)
(qa / "build").mkdir()
for pass_number in range(1, 4):
    run = subprocess.run(
        [compiler, "--disable-installer", "-interaction=nonstopmode",
         "-halt-on-error", "-file-line-error", "-output-directory=build", "main.tex"],
        cwd=qa, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=False,
    )
    (qa / f"pass-{pass_number}.txt").write_bytes(run.stdout)
    if run.returncode:
        raise RuntimeError(f"Fresh compilation failed; inspect {qa}.")
log = (qa / "build" / "main.log").read_text(encoding="utf-8", errors="replace")
diagnostics = [line for line in log.splitlines() if DIAGNOSTIC.search(line)]
assert not diagnostics, diagnostics
fresh = PdfReader(qa / "build" / "main.pdf")
primary = PdfReader(PROJECT / "vacuum-relative-stability.pdf")
fresh_text = "\n".join(page.extract_text() or "" for page in fresh.pages)
primary_text = "\n".join(page.extract_text() or "" for page in primary.pages)
assert fresh_text == primary_text, "Fresh package PDF text differs from primary PDF."
assert "??" not in fresh_text
summary = {
    "archive": ARCHIVE.name,
    "files": len(records),
    "tex_files": len(tex),
    "bytes": ARCHIVE.stat().st_size,
    "sha256": sha256(ARCHIVE.read_bytes()),
    "validation": {
        "fresh_extraction_compile": "passed",
        "passes": 3,
        "pages": len(fresh.pages),
        "compiler_diagnostics": diagnostics,
        "text_matches_primary_pdf": True,
        "extracted_text_sha256": sha256(fresh_text.encode("utf-8")),
        "human_author_metadata": "not supplied; review draft",
        "submitted": False,
        "check_directory": qa.relative_to(ROOT).as_posix(),
    },
    "included_files": records,
}
MANIFEST.write_text(json.dumps(summary, indent=2), encoding="utf-8")
print(json.dumps({key: value for key, value in summary.items()
                  if key != "included_files"}, indent=2))
