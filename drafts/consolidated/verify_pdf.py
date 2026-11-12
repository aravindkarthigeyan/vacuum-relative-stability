"""Render every page and record final PDF checks."""
from pathlib import Path
import json
import math
import re
from PIL import Image, ImageDraw
from pypdf import PdfReader
import pypdfium2 as pdfium

root = Path(__file__).resolve().parent
path = root / "vacuum-relative-stability.pdf"
qa = root / "tmp" / "pdfs"
qa.mkdir(parents=True, exist_ok=True)
reader = PdfReader(str(path))
texts = [p.extract_text() or "" for p in reader.pages]
full_text = "\n".join(texts)
(qa / "extracted-text.txt").write_text(full_text, encoding="utf-8")
doc = pdfium.PdfDocument(str(path))
thumbs = []
for index in range(len(doc)):
    page = doc[index]
    bitmap = page.render(scale=1.5)
    im = bitmap.to_pil().convert("RGB")
    im.save(qa / f"page-{index+1:02d}.png")
    thumb = im.copy()
    thumb.thumbnail((420, 550))
    canvas = Image.new("RGB", (450, 590), "#e8e8e8")
    canvas.paste(thumb, ((450-thumb.width)//2, 24))
    ImageDraw.Draw(canvas).text((16, 567), f"Page {index+1}", fill="black")
    thumbs.append(canvas)
    bitmap.close()
    page.close()
for batch in range(math.ceil(len(thumbs)/6)):
    sheet = Image.new("RGB", (1350, 1180), "white")
    for offset, thumb in enumerate(thumbs[batch*6:(batch+1)*6]):
        sheet.paste(thumb, ((offset % 3)*450, (offset//3)*590))
    sheet.save(qa / f"contact-{batch+1:02d}.png")
log = (root / "build" / "vacuum-relative-stability.log").read_text(
    encoding="utf-8", errors="replace")
diagnostics = [line for line in log.splitlines() if re.search(
    r"Overfull|Underfull|undefined references|Citation .*undefined|"
    r"Reference .*undefined|LaTeX Warning|Package .* Warning|Missing character",
    line)]
checks = dict(
    pdf=str(path), pages=len(reader.pages), bytes=path.stat().st_size,
    title=reader.metadata.title, approximate_words=len(full_text.split()),
    blank_pages=[i+1 for i,t in enumerate(texts) if not t.strip()],
    unresolved_references="??" in full_text, compiler_diagnostics=diagnostics,
    has_photon_extension="quantized transverse photons" in full_text,
    has_references="References" in full_text,
    contact_sheets=math.ceil(len(thumbs)/6))
(root / "verification.json").write_text(json.dumps(checks, indent=2), encoding="utf-8")
print(json.dumps(checks, indent=2))
assert not checks["blank_pages"]
assert not checks["unresolved_references"]
assert not diagnostics
