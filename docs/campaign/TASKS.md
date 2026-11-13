# Step 4 task board: proofs below the frozen statements of Lemmas 3.1 and 3.2

Durable record of the bounded proof tasks (lean-orchestrator worker briefs). Graph node
IDs refer to [`../graph/DEPGRAPH.md`](../graph/DEPGRAPH.md). Helper lemmas live in
ordinary, `sorry`-free modules under `lean/Core/PaperA/Transfer/` and
`lean/Core/PaperA/Fourier/`; the providers in `lean/Core/PaperA/Provider/` assemble them
when every predecessor has landed. Every Lean or Lake command goes through
`scripts/lean-gate.sh` (two machine-wide compile slots, D15).

## Lean route for Lemma 3.1 (step histories)

The provider follows the source graph with one simplification in the β-form part. Per free
step `exp(-τh)`, the source's estimate (3.3) together with ‖f‖² ≥ ±B gives *both*
`B₁ ≤ e^{-2m_*τ} B₀` and `B₁ ≤ e^{2m_*τ} B₀` unconditionally, with `B₁ < B₀` when
`τ > 0` and `f ≠ 0`. Composing along the history gives the annulus dichotomy for every
eigenvalue without the source's trajectory-sign case split. The case split (graph nodes
`stable-trajectory` and `unstable-trajectory`) is therefore not formalized as a separate
lemma; the graph is unchanged because it records the source's route.

Layers:

- **A. Dirac algebra.** `IsDiracClifford`, C5, Kronecker lifts, the generator relations.
  Nodes: c5-involution, c5-anticommutes-h, c5-commutes-kick, dirac-hermitian, trace-h-zero,
  generator-c5-relation, and the anticommutator in eq:beta-form.
- **B. Matrix exponential.** C-form preservation of `exp(-X)` when `Xᴴ C + C X = 0`;
  `det(exp(c • H)) = exp(c tr H)` for Hermitian `H`. Nodes: form-preservation (per step),
  liouville (per step).
- **C. β-form along one free step.** The two bounds and the strict drop above. Nodes:
  eq:beta-form, norm-bounds-beta-form, strict-decrease (per step), beta-form-monotone, and
  the Gronwall steps (per step).
- **D. Spectral pairing and counting.** The charpoly roots are invariant under
  `z ↦ (star z)⁻¹`, given `Uᴴ C U = C`, `C² = 1` and `U` invertible; the multiset count;
  roots have eigenvectors. Nodes: inverse-adjoint, spectral-pairing, eigenvalue-count.
- **E. History level** (wave 2). Transport and prefix products, invertibility, form
  preservation of `U`, `det U`, the conjugation identity, reality of `F`, the per-eigenvector
  dichotomy, `det(I+U) ≠ 0`.
- **F. Homotopy** (wave 2). The deformation `H_σ`, its admissibility, continuity, the
  endpoint value and the intermediate value argument.
- **P1. Provider** for `positivity_and_transfer_annulus`, then the seal (step 5).

## Lean route for Lemma 3.2

- **G1.** The twisted centered trace: `F(φ) = e^{-idφ} w det(I + e^{iφ} U)`.
- **G2.** `det(I + zU) = ∏ (1 + zμ)` over the charpoly roots.
- **G3.** Pairing gives `F(φ) = C ∏_{small} |1 + e^{iφ}λ_j|²`, with `C > 0` from `F(0) > 0`
  (wave 2).
- **G4.** Fourier coefficients of `|Σ_k a_k e^{ikφ}|²` equal the legacy `correlation`.
- **G5.** Assembly with the legacy `relative_correlation_bound`, negative `q` by
  conjugation, `F_0` real (wave 2).
- **P2. Provider** for `canonical_fourier_bound`, then the seal.

## Wave 1 (started 2026-11-12)

| ID | Model | Files owned | Target | Status |
|---|---|---|---|---|
| S | Sonnet | `docs/campaign/MATHLIB_API.md` | Mathlib API map for all layers | done |
| W1 | Sonnet | `Transfer/DiracAlgebra.lean`, `Transfer/DiracLift.lean` | layer A | proved, reviewed, builds |
| W5 | Sonnet | `Transfer/RootCount.lean` | `annulus_split_of_pairing` (D, counting) | proved, reviewed, builds |
| W6 | Sonnet | `Fourier/TwistKick.lean` | G1 | proved, reviewed, builds |
| W8 | Sonnet | `Fourier/DetProd.lean` | G2 | proved, reviewed, builds |
| W2 | Opus | `Transfer/ExpForm.lean`, `Transfer/DetExp.lean` | layer B | proved, reviewed, builds |
| W3 | Opus | `Transfer/BetaForm.lean` | layer C | running |
| W4 | Opus | `Transfer/SpectralPairing.lean` | layer D (pairing, roots, eigenvectors) | proved, reviewed, builds |
| W7 | Opus | `Fourier/FourierCoeff.lean` | G4 | proved, reviewed |

Each brief fixes the exact target statements, forbids extra hypotheses (an API gap or a
false target is reported, not patched), names one validation command, and stops after
about 25–30 compile attempts. Workers edit only their own files and never touch frozen
files, `Core.lean`, the manifest or the docs; the orchestrator integrates and lands.

## Wave 2 (started 2026-11-12)

| ID | Model | Files owned | Target | Status |
|---|---|---|---|---|
| H1 | Opus | `Transfer/History.lean` | `Step.IsAdmissible`; invertibility, form preservation, `det U`, reality of `F` (layer E) | proved, landed |
| Q1 | Opus | `Fourier/Factorization.lean` | G3, algebraic part: `det(1 + e^{iφ}U) = e^{idφ} (∏ conj λ)⁻¹ \|P\|²` | proved, landed |
| H23 | Opus | `Transfer/Annulus.lean` | eigenvalue dichotomy along a history; conjuncts 2–4 of Lemma 3.1; `det(I+U) ≠ 0` | proved, landed |
| H4 | Opus | `Transfer/Homotopy.lean` | deformation, continuity, endpoint, positivity | proved, landed |
| P1 | orchestrator | `Provider/PositivityAndTransferAnnulus.lean` | provider and seal of Lemma 3.1 | sealed 2026-11-12; audits pending |
| Q2 | — | `Fourier/Bound.lean` | Lemma 3.2 assembly (needs Q1, H4) | waiting |

## Landing checklist (per wave)

1. Read every diff; reject any added hypothesis or changed target.
2. Add the modules to `lean/Core.lean`; `lake build` through the gate.
3. Run the axiom audit, `scripts/check_frozen_anchors.py`, `scripts/proof_depgraph.py --check`
   and `scripts/update_readme.py --check`.
4. Update this board and `docs/PROGRESS.md`; commit and push.
