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
| P1 | orchestrator | `Provider/PositivityAndTransferAnnulus.lean` | provider and seal of Lemma 3.1 | sealed; AUDITED (two passing seal audits, `docs/audits/seal/`) |
| Q2 | Opus | `Fourier/Bound.lean`, `Provider/CanonicalFourierBound.lean` | Lemma 3.2 assembly and provider | proved, landed |
| P2 | orchestrator | seal of Lemma 3.2 | — | sealed; AUDITED (two passing seal audits, `docs/audits/seal/`) |

## Follow-ups (non-blocking, from the seal audits)

- `exists_fin_enum` (Fourier/Factorization) and `exists_fin_enum_of_card` (Fourier/Bound)
  overlap; merge them in a later cleanup. Helper lemmas are not frozen, so this needs no
  ruling.
- `Step.IsAdmissible.deform` keeps an unused `0 ≤ σ`, and `betaForm_exp_lt` and the Lemma 3.2
  provider keep unused hypotheses (silenced with `linter.unusedVariables`). This is harmless:
  each use discharges them.

## Wave 3: the frozen proof steps T3–T6 of Theorem 4.1 (started 2026-11-14)

Lean routes (graph nodes in parentheses; helpers in `lean/Core/PaperA/Wilson/` unless noted):

- **T5** `wilson_mass_bound`. `T_j(U)ᴴ T_j(U) = 1` for unit links (`eq:mass-bound#shift-unitary`);
  `M(U) - m = (r/2a) Σ_j (1 - T_j)ᴴ(1 - T_j)` (`#mass-lower-bound`). For `Wᴴ W = 1`,
  `2 ± (W + Wᴴ) = (1 ± W)ᴴ(1 ± W) ⪰ 0`; applied to `W = -i T_j ⊗ α_j` (each hopping term within
  `±1/a`), to `1 ⊗ β` (the `m` term, within `±m`) and to `T_j ⊗ β` (the `2 - T - Tᴴ` terms, within
  `±2r/a` each), the sum gives `h_* ± h_W ⪰ 0` (`#norm-bound`).
- **T6** `wilson_gauge_covariance`. `T_j(U^u) = uᴴ T_j(U) u` entrywise
  (`model:gauge-covariance#shift-covariance`), then linearity, `uᴴ u = 1` for the `m` and `2`
  terms, and `mul_kronecker_mul`.
- **T4** `centeredTrace_nonneg_of_posSemidef_mass` (in `Transfer/`). Shift every mass by `ε • 1`;
  the sealed Lemma 3.1 at `m_* = ε` gives `F_ε > 0` real (`rem:nonneg-mass#apply-transfer`);
  `ε ↦ F_ε` is continuous with `F_0 = F` (`#continuity`), so `F` is a limit of positive reals.
- **T3** `wilson_twisted_trace_pos_and_fourier_bound`. The Wilson history followed by the kick
  `diag(ϑ + φ)` satisfies Lemma 3.1's hypotheses with `ι = X`, `d = 2n³`, `m_* = m`
  (`thm:main#wilson-history`, using T5's helper lemmas, not T5); `diag(ϑ + φ) = diag ϑ + φ • 1`
  splits the kick (`thm:main#twist-split`), so `F` is Lemma 3.2's twisted trace of the history
  ending in `diag ϑ` (`thm:main#apply-fourier`).

| ID | Model | Files owned | Target | Status |
|---|---|---|---|---|
| W9 | Sonnet | `Wilson/Shift.lean` | shift-unitary, wilson-hopping-hermitian, mass-lower-bound | proved, landed |
| W10 | Sonnet | `Wilson/GaugeCovariance.lean`, `Provider/WilsonGaugeCovariance.lean` | T6 | proved, landed, sealed |
| W11 | Opus | `Transfer/NonnegMass.lean`, `Provider/CenteredTraceNonneg.lean` | T4 | proved, landed, sealed |
| W12 | Opus | `Wilson/TwistSplit.lean`; after W9, `Provider/WilsonTwistedTraceBound.lean` | twist-split, then T3 | proved, landed, sealed |
| W13 | Opus | `Wilson/MassBound.lean`, `Provider/WilsonMassBound.lean` | T5 norm bound, after W9 | proved, landed, sealed |

Each provider's statement is byte-identical to its anchor's. The T3 provider consumes the sealed
anchors `QEDCore.PaperA.positivity_and_transfer_annulus` and `canonical_fourier_bound` (not
their providers); the T4 provider consumes the sealed Lemma 3.1 once per `ε > 0`. Seal audits:
two, each covering T3–T6, both passing with no BLOCKING or MINOR finding
(`docs/audits/seal/THM_MAIN_STEPS_AUDIT_1.md`, statement fidelity and seal integrity;
`THM_MAIN_STEPS_AUDIT_2.md`, consumption and hypothesis hygiene); T3–T6 AUDITED.

## Follow-ups from the wave 3 seal audits (non-blocking)

- Done 2026-11-14 (audit 2, X-N1): the rule that providers reach other results through sealed
  anchors, never through other providers, is now mechanical. `scripts/check_frozen_anchors.py`
  (adaptation 6) rejects a direct import of a sealed anchor's provider, or its export name,
  outside that anchor; the axiom audit rejects any declaration whose elaborated term names a
  provider export other than its own anchor (D12).
- The checker confirms that a seal body passes binder names, not their order or count; audit 1
  verified both by hand.
- `latticeShift_mul_conjTranspose_self` (Wilson/Shift) is unused by every provider; keep it as
  the second half of the graph node `eq:mass-bound#shift-unitary`.

## Landing checklist (per wave)

1. Read every diff; reject any added hypothesis or changed target.
2. Add the modules to `lean/Core.lean`; `lake build` through the gate.
3. Run the axiom audit, `scripts/check_frozen_anchors.py`, `scripts/proof_depgraph.py --check`
   and `scripts/update_readme.py --check`.
4. Update this board and `docs/PROGRESS.md`; commit and push.
