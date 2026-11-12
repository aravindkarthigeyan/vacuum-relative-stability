# arXiv-format package and review status

The first-review package is paper-a-lattice-sources.zip. Paper B and
the companion notes have separate clean source archives. Each contains
one top-level main.tex, its required TeX inputs, and an inline bibliography.
They contain no compiled PDF, build logs, backup archives, machine-specific
paths, or external-file PDF links.
Compile from the archive root with PDFLaTeX, three passes. BibTeX and
shell escape are not needed.

Each package is a locally tested submission-format draft, not an uploaded
or accepted arXiv submission. External specialist review has not happened.
The prepared review request is in SPECIALIST_REVIEW_REQUEST.md.

The project owner requested the credits “Opus 5.5 + Astra 6.” These are
shown as research-tool credits and in the disclosure. The human author
field is intentionally empty, with a visible review-draft notice.
Before an actual submission, supply the responsible human authors and
affiliations, confirm the tool disclosure and full content, select a
license, and complete the normal account/endorsement steps. No human
identity, affiliation, reviewer, or license has been invented.

Suggested subject area: math-ph; hep-lat may be a suitable cross-list,
subject to the submitter's and moderators' judgment.

Preparation follows these official sources, checked 29 October 2026:

- [TeX submissions](https://info.arxiv.org/help/submit_tex.html): use a
  clean source package and compile paths relative to the package root.
- [Ancillary files](https://info.arxiv.org/help/ancillary_files.html):
  supporting code/data belong under the root anc directory.
- [00README format](https://info.arxiv.org/help/00README.html): the modern
  submission system normally generates this file; no manual file is
  necessary for this single-main-document package.
- [AI-tool policy](https://info.arxiv.org/help/moderation/index.html#policy-for-authors-use-of-generative-ai-language-tools):
  significant AI use is disclosed; AI tools are not listed as authors.

The round-five review bundle is separate: round5-review-package.zip.
It includes the split documents, consolidated and historical manuscripts,
incoming briefs, internal technical reports, numerical work, and the
partial Lean verification sources and logs. Downloaded Lean/mathlib
artifacts are excluded. Its README specifies the exact formal coverage.
Those materials are not silently included as extra arXiv manuscript files.

The previous vacuum-relative-stability-arxiv.zip is preserved as the
round-four consolidated package with ancillary code/data. It is not the
new first-review package. None of these files has been submitted.
