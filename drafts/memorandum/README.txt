STABILITY OF CUTOFF QED WITH PAIR CREATION AND POINT NUCLEI
Research memorandum and audited continuation, 27 October 2026.

Open main.tex or this project folder in the Codex LaTeX editor.
The annotated PDF has 73 pages, including proofs, references, and agent reports.
Status notices added 29 October 2026 identify superseded open statements.
The current primary paper is ../vacuum-relative-stability-paper/main.tex:
Vacuum-relative stability and charge gaps in cutoff QED.
Use ../README.md and ../CURRENT_RESEARCH_REPORT.md for the current results.
The historical 72-page version is preserved in the research-folder archive
historical-memorandum-before-round2.zip.

Files
  main.tex                              Main document and typesetting setup
  paper.tex                             Initial paper, sections 1-3
  paper-part-two.tex                     Initial paper, sections 4-8
  paper-part-three.tex                   Includes the three audited continuation files
  continuation-photons.tex               Section 9: response and positive-mass modification
  continuation-meanfield.tex             Section 10: mean-field theorem and failed estimate
  continuation-program.tex               Sections 11-12: sufficient reduction and open work
  next-uv.tex                           Section 13: point-source ultraviolet counterexample
  next-photon-vacuum.tex                 Section 14: exchange destabilizes the free sea
  next-screened-lattice.tex              Section 15: correlated-state relative theorem
  next-conclusions.tex                  Section 16: current conclusions and open problems
  references.tex                        Verified linked bibliography
  appendix-finite-cutoff.tex             Initial agent report: estimates and counterexamples
  appendix-qed-literature.tex            Initial agent report: QED literature and operators
  appendix-relativistic-literature.tex   Initial agent report: Coulomb, BDF, low-energy limits
  stability-qed-paper.pdf                Compiled paper
  stability-qed-latex-sources.zip        Historical source package
  verification.json                     Compilation and PDF inspection results
  build.ps1                             Three-pass PowerShell build
  verify_pdf.py                         PDF rendering and automated artifact checks

At the research-folder level
  NEXT_STEPS_REPORT.md                   New theorems, counterexample, and limitations
  NEXT_STEPS_AGENT_REPORTS.md             Additional proof audits
  AUDIT_REPORT.md                        Previous audit findings and corrected hypotheses
  AUDIT_AGENT_REPORTS.md                 Additional agents' technical findings
  CODEX_HANDOFF.md                       Original handoff, with an audit-status notice
  numerics/                             Supporting numerical and exact-rational checks
  audit-backup-before-continuation-review.zip
                                        Original continuation source and PDF backup

The current combined package is ../vacuum-relative-stability-sources.zip.
The source archive preserves the folder layout: extract it, then open
stability-qed-paper/main.tex. No BibTeX step is required. Run build.ps1 from
PowerShell with pdflatex installed. Compiler byproducts stay under build/.
The PDF checks require Python with pypdf, pypdfium2, and Pillow. Exploratory
numerical scripts use NumPy; chi0_closed_form.py additionally uses SymPy.
The exact-rational audit_constants.py uses only the Python standard library.

Historical mathematical status (see the primary paper for superseding results)
  - The original massless fixed-momentum regulator has an L^5 vacuum-energy
    trial sequence. This does not disprove stability relative to that vacuum.
  - A fixed positive bare transverse photon-mass term gives an extensive bound.
    Static one-loop matching does not prove physical masslessness or Ward identities.
  - The photon-free mean-field relative theorem is proved for alpha < 4/pi,
    L >= 1/Lambda_f, and the explicit further lower bound on mL in Theorem 10.4.
    Its free-vacuum normalization is specific to full free-Wick ordering.
  - The periodic Kato constant and Green-function sign have analytic proofs.
  - The Ward-tuned strict kinetic-absorption estimate is false (Proposition 10.7).
    The correctly vacuum-subtracted full mean-field problem remains unresolved.
  - The relative correlation bound is sufficient for the photon-free many-body
    theorem. It remains unproved and is not equivalent merely by the energy identity.
  - Theorem 13.1 disproves a cutoff-independent point-source mean-field bound:
    already for one unit nucleus, E_HF - E_HF,vac <= m - c_alpha Lambda_f.
  - Theorem 14.5 proves an extensive lowering below the free-sea vacuum at
    one-loop static matching; Corollary 14.6 gives a necessary bare-mass threshold.
  - Theorem 15.2 proves many-body relative stability and a relative correlation
    bound for screened lattice fermions, without a spectral-gap assumption.
  - No theorem here constructs physical QED or proves its full stability claim.

Agent reports give conclusions, arguments, source checks, and limitations;
they are research deliverables, not private internal deliberations.
The revised main text supersedes less precise statements in the historical
appendices and original handoff. No novelty claim is made for the mean-field result.
