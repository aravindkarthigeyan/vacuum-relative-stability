# Vacuum-relative stability research — split review drafts, 29 October 2026

The first-review document is **Paper A: Vacuum-relative stability and
charge gaps in compact Hamiltonian lattice QED**. Paper B treats the
sharp-momentum regulator. The low-energy attempts and obstructions are
separate companion notes. The consolidated 64-page draft remains intact.

- [Paper A: lattice theorem, charge gap, and thermodynamic limits](paper-a-lattice/paper-a-lattice.pdf)
- [Paper A clean TeX sources](paper-a-lattice-sources.zip)
- [Paper B: momentum-cutoff QED and regulator obstructions](paper-b-momentum/paper-b-momentum.pdf)
- [Paper B clean TeX sources](paper-b-momentum-sources.zip)
- [Companion notes: low-energy matching and obstructions](companion-notes/companion-notes.pdf)
- [Companion clean TeX sources](companion-notes-sources.zip)
- [Round-five review bundle](round5-review-package.zip)
- [Lean verification subset and exact scope](lean-core/README.md)
- [Round-five verification and handoff](ROUND5_REVIEW_HANDOFF.md)
- [Consolidated 64-page research draft](vacuum-relative-stability-paper/vacuum-relative-stability.pdf)
- [Current mathematical status](CURRENT_RESEARCH_REPORT.md)
- [Detailed round-four report](ROUND4_RESEARCH_REPORT.md)
- [Preserved round-four research source archive](vacuum-relative-stability-sources.zip)
- [Preserved round-four arXiv-format package](vacuum-relative-stability-arxiv.zip)
- [Submission preparation and remaining metadata](ARXIV_PREPARATION.md)
- [Prepared specialist-review request, not sent](SPECIALIST_REVIEW_REQUEST.md)

## What is established

For the specified compact Wilson Hamiltonian with nonnegative bare mass,
all electric rotors retained, and exact local Gauss law,
E_nu >= E_0 + m |sum nu|. Prescribed individual source self-energy
subtraction gives an O(K) vacuum-relative bound at fixed lattice spacing.

Across the three split documents, the existing results also include:

- The fixed-spacing vacuum thermodynamic limit.
- Two-sided bounds for a fixed periodic nuclear cell.
- A source thermodynamic limit in open boxes with zero boundary flux.
- A frozen-link nonrelativistic spectral comparison, including a sharper
  relative low-energy error and explicit Wilson kinetic/magnetic matching.
- A bounded magnetic clover variant preserving vacuum stability under
  an explicit total-mass condition.
- Smooth electric localization, sharp-boundary estimates, and a first
  restricted pair-elimination equation for a specified diagonal reference.
- Actual-model counterexamples to the proposed source-only bare flux
  and bare excitation budgets, and valid volume-dependent replacements.

The periodic-source thermodynamic limit remains conditional on (BF).
A full dynamical nonrelativistic reduction still needs a dressed
pair-block gap and a source-relative remainder estimate. Continuum
renormalization, physical parameter matching, binding, and crystals
are not claimed.

The sharp-momentum-cutoff point-nucleus theorems, photon truncation proof,
charge gap, improved 5168.21 sufficient mass window at alpha=1/137, and
density-product alternative are retained with their original scopes.

## Reports and reproducibility

- [Paper A extraction and proof map](ROUND5_PAPER_A_REPORT.md)
- [Paper B extraction and proof map](ROUND5_PAPER_B_REPORT.md)
- [Companion extraction and scope](ROUND5_COMPANION_REPORT.md)
- [Lean verification report](ROUND5_LEAN_REPORT.md)
- [Matching and magnetic improvement](ROUND4_MATCHING_REPORT.md)
- [Electric localization and vacuum tails](ROUND4_FLUX_REPORT.md)
- [Thermodynamics and boundary flux](ROUND4_THERMODYNAMICS_REPORT.md)
- [Independent cross-audit outcomes](ROUND4_INDEPENDENT_AUDITS.md)
- [Round-three source report](ROUND3_RESEARCH_REPORT.md)
- [Earlier complete research status](research-backup-before-round4.zip)

All supplied briefs and scripts remain intact. The four round-two scripts
remain together in numerics, with their captured outputs. The two
round-three lattice diagnostics and their captured outputs are also
preserved. Numerical checks are diagnostics, not proof premises.

The requested credits **Opus 5.5 + Astra 6** appear as research-tool credits
and in the AI-use disclosure. Human author metadata has not been supplied.
No paper has been uploaded and no external reviewer has been contacted.
Internal AI-assisted cross-checks are not external specialist review.

## Build and historical material

Run each split project's build.ps1 with MiKTeX pdflatex, then the root
verify_split_pdfs.py with Python, pypdf, pypdfium2, and Pillow. Run
package_round5.py to rebuild the clean TeX archives and review bundle.
Each clean archive is compiled from a fresh extraction and checked against
the review PDF's extracted text. Its JSON manifest records the result.
Lean setup and build instructions are separate in lean-core/README.md;
downloaded toolchains and dependency caches are excluded from the bundle.

The [historical memorandum](stability-qed-paper/stability-qed-paper.pdf)
and its original backups remain available. The consolidated draft was
not edited during the split. Previous root metadata is preserved in
research-metadata-before-round5.zip. Clean TeX archives contain only their
respective manuscript sources; the review bundle also includes the
consolidated/historical manuscripts, technical reports, and verification
sources. No archive is an uploaded submission.
