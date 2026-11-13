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

Phase: **step 2 done (statements frozen); step 3 (source dependency graph) next.**

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

1. Step 3: build the source dependency graph from the two anchors down through
   transfer.tex (skill `build-proof-dependency-graph`), with `SOURCE_GAP` records for
   every skipped step; independent topology review; list the gaps for the author.
2. Step 4: bounded proof tasks from the dependency-ready frontier. Expected hard
   nodes: C-form preservation of a matrix exponential with C-anti-Hermitian
   generator; the β-form derivative along `exp(-t h)` and the per-step Gronwall bound;
   eigenvalue pairing with algebraic multiplicity via the characteristic polynomial
   (Mathlib has `Matrix.charpoly_inv`, `Matrix.det_eq_prod_roots_charpoly`);
   `det (exp X) = exp (tr X)` for Hermitian and i·Hermitian `X` (a Mathlib TODO; no
   Schur triangulation in Mathlib, so use the spectral theorem); reality and
   positivity of the centered trace along the homotopy. Lemma 3.2's provider must not
   import Lemma 3.1's quarantined provider; shared results go in ordinary modules.
3. The finite-dimensional part of `thm:main` (Lemma 3.2 with `D = 4N`, the Wilson
   mass bound `M(U) ≥ mI` of model.tex (2.4), the `m = 0` remark) needs separately
   approved statements; not drafted yet.

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

None pending. R1(a)–R4 are decided (D11).

## Infrastructure notes

See [DECISIONS.md](DECISIONS.md) D12. To seal an anchor: prove the provider theorem in
`lean/Core/PaperA/Provider/…` with exactly the frozen statement, replace only the
draft's `by sorry` by `by exact QEDCore.PaperA.Provider.…`, set the manifest state to
`SEALED` (the prefix and suffix hashes do not change), run the four checks above, get
two independent audits into `docs/audits/`, then update `lean/status.json`.
