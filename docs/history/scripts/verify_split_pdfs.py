"""Render and check the split review PDFs. Run after their build.ps1 scripts."""
from pathlib import Path
import argparse
import hashlib
import json
import math
import re
from PIL import Image, ImageDraw
from pypdf import PdfReader
import pypdfium2 as pdfium

ROOT = Path(__file__).resolve().parent
parser = argparse.ArgumentParser()
parser.add_argument("projects", nargs="*", default=[
    "paper-a-lattice", "paper-b-momentum", "companion-notes"])
args = parser.parse_args()
for name in args.projects:
    project = ROOT / name
    path = project / (name + ".pdf")
    reader = PdfReader(path)
    texts = [page.extract_text() or "" for page in reader.pages]
    text = "\n".join(texts)
    log = (project / "build" / (name + ".log")).read_text(
        encoding="utf-8", errors="replace")
    diagnostics = [line for line in log.splitlines() if re.search(
        r"Overfull|Underfull|undefined references|Citation .*undefined|"
        r"Reference .*undefined|LaTeX Warning|Package .* Warning|Missing character", line)]
    qa = project / "tmp" / "pdfs"
    qa.mkdir(parents=True, exist_ok=True)
    (qa / "extracted-text.txt").write_text(text, encoding="utf-8")
    doc = pdfium.PdfDocument(path)
    thumbs = []
    for index in range(len(doc)):
        page = doc[index]
        bitmap = page.render(scale=1.5)
        im = bitmap.to_pil().convert("RGB")
        im.save(qa / f"page-{index+1:02d}.png")
        im.thumbnail((420, 550))
        canvas = Image.new("RGB", (450, 590), "#e8e8e8")
        canvas.paste(im, ((450-im.width)//2, 12))
        ImageDraw.Draw(canvas).text((16, 568), f"Page {index+1}", fill="black")
        thumbs.append(canvas)
        bitmap.close()
        page.close()
    doc.close()
    for batch in range(math.ceil(len(thumbs)/6)):
        sheet = Image.new("RGB", (1350, 1180), "white")
        for offset, thumb in enumerate(thumbs[batch*6:(batch+1)*6]):
            sheet.paste(thumb, ((offset % 3)*450, (offset//3)*590))
        sheet.save(qa / f"contact-{batch+1:02d}.png")
    checks = {
        "pdf": path.name, "pages": len(texts), "bytes": path.stat().st_size,
        "sha256": hashlib.sha256(path.read_bytes()).hexdigest(),
        "title": reader.metadata.title,
        "blank_pages": [i+1 for i,t in enumerate(texts) if not t.strip()],
        "unresolved_references": "??" in text,
        "compiler_diagnostics": diagnostics,
        "contact_sheets": math.ceil(len(thumbs)/6),
        "text_sha256": hashlib.sha256(text.encode("utf-8")).hexdigest(),
    }
    (project / "verification.json").write_text(
        json.dumps(checks, indent=2), encoding="utf-8")
    print(json.dumps(checks, indent=2))
    assert not diagnostics
    assert not checks["unresolved_references"]
    assert not checks["blank_pages"]
