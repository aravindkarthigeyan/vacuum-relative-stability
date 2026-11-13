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

Phase: **step 1 (pilot), waiting for author approval.** Nothing frozen, nothing
committed by this campaign yet.

- Paper A sources: SHA-256 checked against `lean/status.json` on 2026-11-12; unchanged.
- Legacy library: five-bin test of the 23 `QEDCore` lemmas recorded in
  [`audits/LEGACY_BINDER_TEST.md`](audits/LEGACY_BINDER_TEST.md). All 23 have EXCESS
  binders relative to the paper; they are helpers only.
- Proposed declarations: six definitions and two theorems in namespace
  `QEDCore.PaperA` (see "Proposed declarations" below). They elaborate against the
  pinned Mathlib with only the two intended `sorry` bodies. They are proposals, not
  formalization, and have no status until approved and frozen.
- Numerical check of the proposed statements (Python, 334 random step histories with
  spatial dimension 1–3, high-precision recheck of the 18 ill-conditioned cases): no
  counterexample; reality fails as expected if the centering sign is flipped.
- Independent pre-approval statement audits: `audits/pilot/STATEMENT_AUDIT_A.md` and
  `audits/pilot/STATEMENT_AUDIT_B.md` (fresh Opus sessions).

## Proposed declarations (v1, awaiting approval)

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

1. **R1 (blocking): history class.** Either (a) freeze v1 for finite piecewise-constant
   histories (free steps with constant Hermitian `v_j`, constant `M ≥ m_*I`, `τ ≥ 0`;
   separate instantaneous kicks `exp(i Θ⊗1)`), recording a specialization deviation;
   or (b) replace D1–D6 by an ODE carrier with coefficient paths. Orchestrator
   recommendation: (a). The time-dependent case is then a later, separately frozen
   approximation result (outside this campaign's scope).
2. R2: arbitrary finite spatial type `ι` (empty allowed), every Hermitian Clifford set,
   and `d` as a binder with `4|ι| = 2d`.
3. R3: Lemma 3.2's `F_0` is stated as `Im F_0 = 0 ∧ ‖F_q‖ ≤ … · Re F_0`.
4. R4: kicks are parameterized by a Hermitian generator `Θ` with centering computed
   from `Θ` (transfer.tex 26, 83–84); the phase is independent of the choice of
   logarithm (checked numerically by both auditors).
5. Scope of `thm:main`: its finite-dimensional content is Lemma 3.2 applied with
   `D = 4N`, `d = 2N`, `m_* = m`, plus the Wilson mass bound `M(U) ≥ mI` (model.tex
   (2.4)) and the `m = 0` nonnegativity remark (transfer.tex 89–91). Proposed: draft
   these after T1 and T2 are frozen.

## Infrastructure notes for step 2

- `lean/scripts/AxiomAudit.lean` fails on any `sorryAx`, and
  `scripts/update_readme.py --check` fails on comment-stripped `sorry`. D5 in
  `docs/DECISIONS.md` defers the exemption for registered frozen statements to the first
  freeze. Plan: a frozen-anchor manifest modeled on the `lean-orchestrator` template,
  checked by its `check_frozen_anchors.py`; both audits exempt exactly the manifested
  `DRAFT_SORRY` exports and nothing else.
- D3: the library is not on the Lean module system. Frozen files will follow D3 unless
  the author decides otherwise; a later port moves their bytes and must be recorded as
  a semantics-neutral hash change.
