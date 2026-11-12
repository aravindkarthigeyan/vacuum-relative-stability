"""Render every page and record basic artifact checks."""
from pathlib import Path
import json
import math
import re
from PIL import Image, ImageDraw
from pypdf import PdfReader
import pypdfium2 as pdfium

root = Path(__file__).resolve().parent
path = root / "stability-qed-paper.pdf"
qa = root / "tmp" / "pdfs"
qa.mkdir(parents=True, exist_ok=True)
reader = PdfReader(str(path))
text_pages = [page.extract_text() or "" for page in reader.pages]
full_text = "\n".join(text_pages)
(qa / "extracted-text.txt").write_text(full_text, encoding="utf-8")
doc = pdfium.PdfDocument(str(path))
thumbs = []
for index in range(len(doc)):
    page = doc[index]
    bitmap = page.render(scale=1.4)
    image = bitmap.to_pil().convert("RGB")
    image.save(qa / f"page-{index+1:02d}.png")
    thumb = image.copy()
    thumb.thumbnail((420, 550))
    canvas = Image.new("RGB", (450, 590), "#e8e8e8")
    canvas.paste(thumb, ((450-thumb.width)//2, 24))
    ImageDraw.Draw(canvas).text((16, 567), f"Page {index+1}", fill="black")
    thumbs.append(canvas)
    bitmap.close()
    page.close()

for batch in range(math.ceil(len(thumbs) / 6)):
    sheet = Image.new("RGB", (1350, 1180), "white")
    for offset, thumb in enumerate(thumbs[batch*6:(batch+1)*6]):
        sheet.paste(thumb, ((offset % 3)*450, (offset // 3)*590))
    sheet.save(qa / f"contact-{batch+1:02d}.png")

log_path = root / "build" / "stability-qed-paper.log"
if not log_path.exists():
    log_path = root / "stability-qed-paper.log"
log = log_path.read_text(encoding="utf-8", errors="replace")
bad_log = [line for line in log.splitlines() if re.search(
    r"Overfull|Underfull|undefined references|Citation .*undefined|Reference .*undefined|"
    r"LaTeX Warning|Package .* Warning|ignored error|Missing character|duplicate ignored", line)]
checks = {
    "pdf": str(path),
    "pages": len(reader.pages),
    "file_bytes": path.stat().st_size,
    "title": reader.metadata.title,
    "approximate_words": len(full_text.split()),
    "named_destinations": len(reader.named_destinations),
    "blank_pages": [i+1 for i, text in enumerate(text_pages) if not text.strip()],
    "unresolved_question_mark_pairs": "??" in full_text,
    "compiler_diagnostics": bad_log,
    "has_references": "References" in full_text,
    "has_finite_cutoff_appendix": "Agent report: finite-cutoff" in full_text,
    "has_qed_literature_appendix": "Agent report: QED literature" in full_text,
    "has_relativistic_appendix": "Agent report: relativistic Coulomb" in full_text,
    "contact_sheets": math.ceil(len(thumbs)/6),
}
(qa / "verification.json").write_text(json.dumps(checks, indent=2), encoding="utf-8")
print(json.dumps(checks, indent=2))
