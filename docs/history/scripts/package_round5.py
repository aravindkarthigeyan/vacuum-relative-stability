"""Package the three review documents and the checked Lean source subset.

Each TeX-only archive is compiled from its own fresh extraction.
The review bundle excludes downloaded toolchains, mathlib, caches and previews.
"""
from pathlib import Path
import argparse
import hashlib
import json
import re
import shutil
import subprocess
import tempfile
import zipfile

ROOT = Path(__file__).resolve().parent
PROJECTS = ("paper-a-lattice", "paper-b-momentum", "companion-notes")
INPUT = re.compile(r"\\(?:input|include)\{([^}]+)\}")
DIAGNOSTIC = re.compile(
    r"Overfull|Underfull|undefined references|Citation .*undefined|"
    r"Reference .*undefined|LaTeX Warning|Package .* Warning|Missing character")


def digest(data):
    return hashlib.sha256(data).hexdigest()


def write_zip(path, contents):
    records = []
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as archive:
        for name, data in sorted(contents.items()):
            archive.writestr(name, data)
            records.append({"path": name, "bytes": len(data), "sha256": digest(data)})
    with zipfile.ZipFile(path) as archive:
        assert archive.testzip() is None
        for record in records:
            assert digest(archive.read(record["path"])) == record["sha256"]
    return {"archive": path.name, "bytes": path.stat().st_size,
            "sha256": digest(path.read_bytes()), "included_files": records}


def required_tex(project):
    contents = {}
    def visit(path):
        path = path.resolve()
        if path.parent != project.resolve() or not path.is_file():
            raise RuntimeError(f"Unexpected TeX input {path}")
        if path.name in contents:
            return
        data = path.read_bytes()
        text = data.decode("utf-8-sig")
        if any(ord(c) < 32 and c not in "\r\n\t" for c in text):
            raise RuntimeError(f"Control character in {path}")
        if re.search(r"[A-Z]:[\\/](?:Users|Windows|Program)|\\href\{run:|/Users/|/home/", text):
            raise RuntimeError(f"Nonportable path in {path}")
        contents[path.name] = data
        for child in INPUT.findall(text):
            visit(path.parent / (child if child.endswith(".tex") else child + ".tex"))
    visit(project / "main.tex")
    return contents


def clean_package(name):
    from pypdf import PdfReader
    project = ROOT / name
    archive_path = ROOT / (name + "-sources.zip")
    manifest = write_zip(archive_path, required_tex(project))
    compiler = shutil.which("pdflatex")
    if compiler is None:
        raise RuntimeError("PDFLaTeX not available.")
    parent = ROOT / "tmp"
    parent.mkdir(exist_ok=True)
    qa = Path(tempfile.mkdtemp(prefix=name + "-check-", dir=parent))
    with zipfile.ZipFile(archive_path) as archive:
        archive.extractall(qa)
    (qa / "build").mkdir()
    for i in range(3):
        result = subprocess.run(
            [compiler, "--disable-installer", "-interaction=nonstopmode",
             "-halt-on-error", "-file-line-error", "-output-directory=build", "main.tex"],
            cwd=qa, stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=False)
        (qa / f"pass-{i+1}.txt").write_bytes(result.stdout)
        if result.returncode:
            raise RuntimeError(f"Clean-source compilation failed in {qa}")
    log = (qa / "build" / "main.log").read_text(encoding="utf-8", errors="replace")
    diagnostics = [line for line in log.splitlines() if DIAGNOSTIC.search(line)]
    assert not diagnostics, diagnostics
    fresh = PdfReader(qa / "build" / "main.pdf")
    primary = PdfReader(project / (name + ".pdf"))
    fresh_text = "\n".join(page.extract_text() or "" for page in fresh.pages)
    primary_text = "\n".join(page.extract_text() or "" for page in primary.pages)
    assert fresh_text == primary_text, name + ": extracted text differs"
    manifest["validation"] = {
        "fresh_compile": "passed", "passes": 3, "pages": len(fresh.pages),
        "compiler_diagnostics": diagnostics, "text_matches_review_pdf": True,
        "text_sha256": digest(fresh_text.encode("utf-8")),
        "check_directory": qa.relative_to(ROOT).as_posix(), "submitted": False}
    (ROOT / (name + "-manifest.json")).write_text(
        json.dumps(manifest, indent=2), encoding="utf-8")
    print(json.dumps({k: v for k, v in manifest.items() if k != "included_files"}, indent=2))


def bundle():
    files = set(ROOT.glob("*.md"))
    files.update(ROOT / name for name in (
        "package_round5.py", "prepare_companion.py", "verify_split_pdfs.py",
        "verify_round5_delivery.py", "ROUND5_VERIFICATION.json"))
    for name in PROJECTS:
        project = ROOT / name
        files.update(project.glob("*.tex"))
        for file in ("build.ps1", name + ".pdf", "verification.json"):
            files.add(project / file)
        files.add(ROOT / (name + "-sources.zip"))
        files.add(ROOT / (name + "-manifest.json"))
    for name, pdf in (
        ("vacuum-relative-stability-paper", "vacuum-relative-stability.pdf"),
        ("stability-qed-paper", "stability-qed-paper.pdf"),
    ):
        project = ROOT / name
        files.update(project.glob("*.tex"))
        files.add(project / pdf)
        for extra in ("build.ps1", "verify_pdf.py", "verification.json", "README.txt"):
            if (project / extra).is_file():
                files.add(project / extra)
    lean = ROOT / "lean-core"
    for path in lean.rglob("*"):
        relative = path.relative_to(lean)
        if any(part in {"tools", "vendor", ".lake", ".cache", ".git", "__pycache__"} for part in relative.parts):
            continue
        if path.is_file() and (path.suffix in {".lean", ".md", ".json", ".ps1", ".log", ".txt", ".py"}
                               or path.name in {"lean-toolchain", ".gitignore"}):
            files.add(path)
    files.update((ROOT / "numerics").glob("*.py"))
    files.update((ROOT / "numerics").glob("*.json"))
    files.update((ROOT / "numerics").glob("*.output.txt"))
    contents = {}
    for path in files:
        if not path.is_file() or not path.resolve().is_relative_to(ROOT):
            raise RuntimeError(f"Missing or invalid review input {path}")
        contents[path.relative_to(ROOT).as_posix()] = path.read_bytes()
    report = write_zip(ROOT / "round5-review-package.zip", contents)
    report["scope"] = (
        "Three review PDFs and their sources; Lean project source and logs, "
        "without downloaded toolchain or dependency artifacts; consolidated and historical "
        "manuscripts, technical reports and numerics.")
    (ROOT / "round5-review-package-manifest.json").write_text(
        json.dumps(report, indent=2), encoding="utf-8")
    print(json.dumps({k: v for k, v in report.items() if k != "included_files"}, indent=2))


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--bundle-only", action="store_true")
    parser.add_argument("--project", choices=PROJECTS)
    args = parser.parse_args()
    if not args.bundle_only:
        for name in (args.project,) if args.project else PROJECTS:
            clean_package(name)
    if args.bundle_only or args.project is None:
        bundle()
