# Campaign progress: finite-dimensional core of Paper A

Durable handoff notes. A new session should read this file first, then
`lean/status.json`, `docs/DECISIONS.md` and `docs/ERRATA-AND-DEVIATIONS.md`.

## Scope (author brief of 2026-11-12)

In scope: Lemma 3.1 `lem:transfer` (C5 form preservation, β-form monotonicity,
eigenvalue pairing λ ↔ 1/conj λ with algebraic multiplicity, positivity of the
centered fermion determinant), Lemma 3.2 `lem:fourier`, and the charge-gap theorem
`thm:main` only as far as it is finite-dimensional.
Out of scope: Hamiltonian self-adjointness, Hubbard–Stratonovich and path measures,
Trotter limits, thermodynamic limits, Paper B, companion notes.

Steps: (1) pilot statements and audits, wait for approval; (2) freeze approved
statements as `DRAFT_SORRY` with a manifest entry; (3) source dependency graph with
`SOURCE_GAP` records; (4) bounded proof tasks; (5) seal plus two independent audits
per theorem in `docs/audits/`; (6) errata with refutation attempts; (7) after each
landing: `lean/status.json`, `scripts/update_readme.py`, commit.

Hard constraints: no custom axioms, no unmanifested `sorry`, no hypotheses smuggled in
as binders, no toolchain or Mathlib bump without asking, at most 2 concurrent Lake
processes (Windows laptop; one `lake env lean` of a Mathlib-importing file takes about
4 minutes here). Frozen statements never change; a wrong one gets an author-approved
versioned successor.

## Current state

Phase: **Lemmas 3.1 and 3.2 AUDITED; the finite-dimensional proof steps of Theorem 4.1 are
frozen (DRAFT_SORRY, 2026-11-14), their dependency graph (step 3) is next.**

- 2026-11-12, step 4: compile gate `scripts/lean-gate.sh` (two machine-wide slots,
  D15). The Mathlib API map is [`campaign/MATHLIB_API.md`](campaign/MATHLIB_API.md).
- Landed: 12 sorry-free helper modules under `lean/Core/PaperA/{Transfer,Fourier}/`,
  covering layers A–D, the history-level facts H1, and the Lemma 3.2 pieces G1, G2, G4
  and the algebraic part of G3. They prove the two `[substantive]` source gaps (spectral
  pairing with algebraic multiplicity; Liouville per step, for Hermitian generators)
  and the β-form calculus. The axiom audit passes (236 declarations, standard axioms
  outside the two drafts).
- 2026-11-12: **Lemma 3.1 sealed** (`lem_transfer_v1` SEALED; `status.json` PROVED).
  Provider `lean/Core/PaperA/Provider/PositivityAndTransferAnnulus.lean` (statement copied
  verbatim) assembles Homotopy (H4) and Annulus (H23). The frozen file changed only in its
  proof body: `by exact QEDCore.PaperA.Provider.positivity_and_transfer_annulus` applied to
  the anchor's own binders. Checks: build, axiom audit (standard axioms; one draft left),
  `leanchecker` kernel replay of the anchor, the provider and the main helpers (exit 0),
  frozen-anchor guard (adaptation 5 for seals), graph gate (manifest hash re-pinned).
- 2026-11-12: Lemma 3.1 **AUDITED**: two independent seal audits passed
  ([`audits/seal/LEM_TRANSFER_AUDIT_1.md`](audits/seal/LEM_TRANSFER_AUDIT_1.md): fidelity and
  seal integrity; [`audits/seal/LEM_TRANSFER_AUDIT_2.md`](audits/seal/LEM_TRANSFER_AUDIT_2.md):
  premise discharge, axioms, kernel replay, non-vacuity).
- 2026-11-12: **Lemma 3.2 sealed** (`lem_fourier_v1`; PROVED). Provider
  `lean/Core/PaperA/Provider/CanonicalFourierBound.lean` (statement verbatim) uses the sealed
  Lemma 3.1 once and `Fourier/Bound.lean`. Its hypothesis `hq : |q| ≤ d` is not needed (both
  sides vanish for |q| > d); it stays in the frozen statement. No `sorry` remains anywhere.
- 2026-11-13: Lemma 3.2 **AUDITED**: two independent seal audits passed
  ([`audits/seal/LEM_FOURIER_AUDIT_1.md`](audits/seal/LEM_FOURIER_AUDIT_1.md),
  [`audits/seal/LEM_FOURIER_AUDIT_2.md`](audits/seal/LEM_FOURIER_AUDIT_2.md)). Kernel replay of all
  30 modules, one per process: 0 failures
  ([`audits/seal/KERNEL_REPLAY_2026-11-13.md`](audits/seal/KERNEL_REPLAY_2026-11-13.md)).
  After audit 1, the checker's seal rule was tightened to read only the top-level binders
  (mutation-tested).
- 2026-11-14: **finite-dimensional part of Theorem 4.1 frozen** (author approval and rulings
  R5–R8, [DECISIONS.md](DECISIONS.md) D16; deviations 9 and 10). Sealed definitions
  `def_lattice_shift_v1`, `def_wilson_hopping_v1`, `def_wilson_mass_v1`
  (`lean/Core/PaperA/Defs/`); DRAFT_SORRY anchors `main_twisted_integrand_v1`
  (`Frozen/PaperA/WilsonTwistedTraceBound.lean`, T3) and `rem_nonneg_mass_v1`
  (`Frozen/PaperA/CenteredTraceNonneg.lean`, T4), with empty providers. Declaration text is
  byte-identical to the audited draft (`audits/pilot-chargegap/audited-draft-v1.lean.txt`).
  `status.json` lists T3 and T4 under the new `frozen_steps` (they are proof steps, so
  `thm:main` stays NOT_STARTED); `update_readme.py` checks and renders that list. The graph
  is only re-pinned to the new manifest; it does not cover T3/T4 yet.
- In progress: two independent statement audits of T5 `wilson_mass_bound` (model.tex (2.5))
  and T6 `wilson_gauge_covariance` (model.tex L71), reports
  `audits/pilot-chargegap/STATEMENT_AUDIT_T5T6_{A,B}.md`. Approved on condition that both pass
  with no EXCESS binder and no new ruling (D16); then freeze them like T3/T4.
- Next: step 3 for `thm:main`'s frozen steps (graph roots T3–T6, corpus comparison.tex
  L54–L99, model.tex (2.3), (2.5), L64–L71, transfer.tex L89–L91), then step 4 workers.
- Landing procedure while workers write into the same checkout: stage only finished
  files, export the index with `git checkout-index -a --prefix=<tmp>/`, copy
  `lean/.lake/axiom-audit.json` into it, and run `update_readme.py`,
  `check_frozen_anchors.py` and `proof_depgraph.py --check` there.

- 2026-11-12, step 3: [`graph/DEPGRAPH.md`](graph/DEPGRAPH.md) has 52 nodes, 134 edges,
  roots `lem:transfer` and `lem:fourier`, and 8 frozen nodes bound to the manifest.
  [`graph/DEPGRAPH_COVERAGE.md`](graph/DEPGRAPH_COVERAGE.md) has 27 items, 4 of them
  excluded. Every node and item was reviewed by `topology-reviewer-1`, and the root closure
  by `global-reviewer-1`; both are fresh Opus sessions. The reports and the merge log are in
  [`audits/graph/`](audits/graph). The full gate (`--require-reviewed
  --require-complete-coverage --require-initial-lean-status --require-all-reachable
  --check`) passes and runs in CI (D14). 21 `SOURCE_GAP` nodes, listed below; no
  erratum.

- 2026-11-12: the author approved v1 with "Approve with R1(a)" (rulings R1(a)–R4,
  [DECISIONS.md](DECISIONS.md) D11). Frozen as `DRAFT_SORRY` with manifest entries
  ([`lean/frozen-manifest.json`](../lean/frozen-manifest.json), mechanics in D12):
  `QEDCore.PaperA.positivity_and_transfer_annulus` (`lem_transfer_v1`) and
  `QEDCore.PaperA.canonical_fourier_bound` (`lem_fourier_v1`), plus six sealed
  definitions. `lean/status.json`: both lemmas `FROZEN_UNPROVED`.
- Verified on 2026-11-12: `lake build` (Core and Frozen; the only `sorry` warnings are
  the two drafts), `lake env lean scripts/Audit/AxiomAudit.lean` (68 declarations, 16
  modules, standard axioms outside the two registered drafts),
  `scripts/check_frozen_anchors.py` (OK; five mutations each detected),
  `scripts/update_readme.py --check` (current).
- Paper A sources: SHA-256 unchanged against `lean/status.json`.
- Legacy library: five-bin test in
  [`audits/LEGACY_BINDER_TEST.md`](audits/LEGACY_BINDER_TEST.md); helpers only.
- GitHub: private repository `aravindkarthigeyan/vacuum-relative-stability` (D13).

Status fields (lean-orchestrator):

```text
DRAFT_ANCHORS: 2 (lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean, lean/Frozen/PaperA/CanonicalFourierBound.lean)
UNREGISTERED_SORRIES: 0
DRAFT_IMPORT_VIOLATIONS: 0
SEALED_THIS_TURN: 0
```

## Next steps

1. Step 4: bounded proof tasks from the dependency-ready frontier. Expected hard
   nodes: C-form preservation of a matrix exponential with C-anti-Hermitian
   generator; the β-form derivative along `exp(-t h)` and the per-step Gronwall bound;
   eigenvalue pairing with algebraic multiplicity via the characteristic polynomial
   (Mathlib has `Matrix.charpoly_inv`, `Matrix.det_eq_prod_roots_charpoly`);
   `det (exp X) = exp (tr X)` for Hermitian and i·Hermitian `X` (a Mathlib TODO; no
   Schur triangulation in Mathlib, so use the spectral theorem); reality and
   positivity of the centered trace along the homotopy. Lemma 3.2's provider must not
   import Lemma 3.1's quarantined provider; shared results go in ordinary modules.
2. The finite-dimensional part of `thm:main`: T3, T4 frozen 2026-11-14 (see "Current state");
   T5, T6 under audit; then the graph and the proofs.

## Source gaps of the graph (21; no erratum)

`[substantive]`: the source uses a standard theorem it neither proves nor names.

- `lem:transfer#spectral-pairing`: from U* = C5 U⁻¹ C5 to pairing with algebraic multiplicity
  (characteristic polynomials of similar, adjoint and inverse matrices).
- `lem:transfer#liouville`: det U = exp(−∫Tr A), which per step is det(exp X) = exp(tr X).

`[minor]`: a few lines from facts already stated.

- `lem:transfer#c5-involution`: C5 is a Hermitian involution (model.tex L116).
- `lem:transfer#c5-anticommutes-h`: C5 anticommutes with h (L38).
- `lem:transfer#dirac-hermitian`: h is Hermitian; used at L40 and L57, never stated.
- `lem:transfer#form-preservation`: from A* C5 + C5 A = 0 to U* C5 U = C5 (L40).
- `lem:transfer#propagator-invertible`: U is invertible; used at L42, L62 and L64, never stated.
- `lem:transfer#det-conjugation`: conj det(I+U) = det(U)⁻¹ det(I+U) (L46).
- `lem:transfer#trace-h-zero`: Tr h = 0, which needs the traceless Dirac matrices (L49).
- `eq:beta-form`: the derivative (3.3) is stated without its computation.
- `lem:transfer#norm-bounds-beta-form`: ‖f‖² ≥ ±B (L65, L68).
- `lem:transfer#beta-form-monotone`: B is nonincreasing along the whole history; used at
  L64-L67.
- `lem:transfer#stable-trajectory`: the sign of B(0), and λ ≠ 0.
- `lem:transfer#unstable-trajectory`: B(0) < 0.
- `lem:transfer#homotopy-admissible`: the deformation is admissible (L73-L75).
- `lem:transfer#homotopy-continuity`: F_σ is continuous in σ.
- `lem:transfer#homotopy-endpoint`: the value det(I + e^{−bm_*β}) > 0 at σ = 1.
- `lem:fourier#twist-is-kick`: e^{iφQ} is the centered lift of the kick; this is not a Lean
  obligation.
- `lem:fourier#constant-positive`: λ_j ≠ −1.
- `lem:fourier#coefficient-identification`: F_q = C Σ_j e_{j+q} conj(e_j).
- `lem:fourier#elementary-bound`: |e_j| ≤ binom(d, j) s^j.

Open source questions are recorded in [`audits/graph/MERGE_LOG.md`](audits/graph/MERGE_LOG.md).
None of them blocks the frozen statements.

## Approved declarations (v1, frozen 2026-11-12)

Exact audited bytes: [`audits/pilot/audited-draft-v1.lean.txt`](audits/pilot/audited-draft-v1.lean.txt),
SHA-256 `13952055e164b3a4eefd8ba22b225368184640d194474c8986f9fd10ad883d91` (both auditors
compiled a byte-identical copy). Namespace `QEDCore.PaperA`. Intended one-declaration
files:

| ID | Export | Kind | Intended path |
|---|---|---|---|
| D1 | `Step` | inductive | `lean/Core/PaperA/Defs/Step.lean` |
| D2 | `diracOperator` | def | `lean/Core/PaperA/Defs/DiracOperator.lean` |
| D3 | `Step.generator` | def | `lean/Core/PaperA/Defs/StepGenerator.lean` |
| D4 | `Step.freeTime` | def | `lean/Core/PaperA/Defs/StepFreeTime.lean` |
| D5 | `transferMatrix` | def | `lean/Core/PaperA/Defs/TransferMatrix.lean` |
| D6 | `centeredTrace` | def | `lean/Core/PaperA/Defs/CenteredTrace.lean` |
| T1 | `positivity_and_transfer_annulus` | theorem (lem:transfer) | frozen file, quarantined from `Core` |
| T2 | `canonical_fourier_bound` | theorem (lem:fourier) | frozen file, quarantined from `Core` |

Audit outcome (fresh Opus sessions A and B, refute-first):

- D2–D6 PASS in both audits. D1 FAIL in both, on its carrier only.
- T1, T2: DECLARATION_FIDELITY FAIL in both, for the same single reason: free steps
  have constant `v`, `M`, while transfer.tex 4–5, 13 and 78–80 allow time-dependent
  (bounded measurable) coefficients, and comparison.tex 70–89 applies the lemmas to
  continuous paths. A records it as a carrier specialization needing a ruling (EXCESS 0);
  B records it as one implicit EXCESS row (18c). No other EXCESS binder in either audit.
  Every conclusion conjunct equals the source in both audits.
- Truth: no counterexample (A: 600 double plus 86 high-precision trials; B: 2,325 double
  plus 204 at 40–400 digits, including Wilson-lattice histories on (ℤ/3ℤ)³). Controls
  show the tests detect wrong signs, a wrong ½, a dropped centering or a wrong tensor
  order. The bound `|λ| ≤ e^{-bm_*}` is attained, so `≤` is necessary; dropping
  `0 ≤ τ` gives a counterexample.
- Non-vacuity: both auditors proved in Lean that the hypothesis list is satisfiable
  (standard Dirac matrices, one free step).
- `NormedSpace.exp` takes its genuine series branch on these matrices (Lean probes).

## Open decisions for the author

R1(a)–R4 are decided (D11); R5–R8 and the charge-gap package are decided (D16, 2026-11-14).
Nothing is pending. The record of the approval round:

- Audited draft v1 (D7 `latticeShift`, D8 `wilsonHopping`, D9 `wilsonMass`, T3
  `wilson_twisted_trace_pos_and_fourier_bound`, T4 `centeredTrace_nonneg_of_posSemidef_mass`):
  `docs/audits/pilot-chargegap/audited-draft-v1.lean.txt`, SHA-256 `e16372fb…fa2bc`.
  Audits A and B: D7–D9 PASS; T3 and T4 PASS conditional on new rulings (audit A's R5, R7;
  R6 recorded; R8 if the finite-CAR identity stays outside Lean). No counterexample.
- T5 `wilson_mass_bound` (model.tex (2.5)) and T6 `wilson_gauge_covariance` (model.tex L71)
  were added after audit A's surface findings S2–S3: `draft-v1b-with-T5-T6.lean.txt`
  (SHA-256 `f3169e83…f339`). Checked numerically, **not yet independently audited**.
- Approved and frozen 2026-11-14 (D16); T5 and T6 conditionally on two clean audits.
  `thm:main` stays NOT_STARTED in `lean/status.json` (audit A, S0).

## Infrastructure notes

See [DECISIONS.md](DECISIONS.md) D12. To seal an anchor: prove the provider theorem in
`lean/Core/PaperA/Provider/…` with exactly the frozen statement, replace only the
draft's `by sorry` by `by exact QEDCore.PaperA.Provider.…`, set the manifest state to
`SEALED` (the prefix and suffix hashes do not change), run the four checks above, get
two independent audits into `docs/audits/`, then update `lean/status.json`.
