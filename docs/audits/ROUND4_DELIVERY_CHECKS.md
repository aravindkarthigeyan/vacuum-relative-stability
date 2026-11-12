# Round-four artifact verification

- The primary paper compiles to 64 pages with MiKTeX PDFLaTeX.
- Three passes resolve all references and citations. The final compiler
  log contains no warnings, overfull/underfull boxes, or missing glyphs.
- Every page was rendered and visually inspected through eleven contact
  sheets; dense clover and electric-localization pages were also inspected
  at full page resolution. No clipping or overlapping material was found.
- PDF extraction found no blank pages or unresolved-reference markers.
- The Codex desktop LaTeX compiler independently returned success for
  the current source.
- The arXiv-format ZIP contains 15 required TeX files and supporting
  ancillary scripts/data, 33 entries in total. It contains no PDF or logs.
- That exact ZIP was extracted into a fresh directory and compiled for
  three passes. Its 64-page PDF has identical extracted text to the
  primary PDF and no compiler diagnostics.
- Both delivery archives have CRC and per-file SHA-256 verification.
  Their external JSON manifests record contents and archive hashes.

The full research archive preserves earlier reports and numerical
diagnostics as history. The current manuscript and current-status report
distinguish which conclusions supersede earlier open questions or errors.
Internal proof audits, finite numerical diagnostics, and document checks
are different forms of verification; none is external specialist review.

Opus 5.5 + Astra 6 are credited as requested in the tool disclosure.
Human author metadata, affiliation, publication license, and specialist
recipient remain unspecified. The review request is drafted, not sent;
the arXiv-format package is prepared, not submitted.
