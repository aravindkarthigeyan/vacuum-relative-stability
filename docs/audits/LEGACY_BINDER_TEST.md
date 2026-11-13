# Five-bin binder test of the legacy `QEDCore` lemmas

Date: 2026-11-12. Auditor: the campaign orchestrator session (it did not write these
lemmas; they predate the campaign). Source: Paper A, LaTeX pinned by SHA-256 in
[`lean/status.json`](../../lean/status.json), checked unchanged on this date.

## Purpose and reading

The 23 theorems in `lean/Core/` (Lean v4.35.0, Mathlib v4.35.0) are a helper library.
None of them states a numbered result of Paper A, and none is claimed to. This test
classifies every binder of every theorem relative to the paper statement it supports,
so that the campaign can reuse the lemmas as internal helpers without mistaking any of
them for a formalization of the paper.

Bins (from the `lean-statement-audit` skill): SOURCE (explicit premise of the supported
source statement), STANDING (standing convention of the paper), TYPING (pure type
formation), RULED (author ruling; none exist), EXCESS (anything else).

"EXCESS" here is a statement about fidelity to the paper, not a defect in the lemma: an
internal helper may take its proof-step inputs as hypotheses, provided a frozen anchor's
proof later discharges them. Three kinds of EXCESS are distinguished in the notes:

- **step**: a fact the paper proves (form preservation, invertibility, strict drop,
  Gronwall bound, eigenvalue bound, integrability, ...), assumed instead.
- **case**: a case hypothesis or proof-internal object of the paper's argument
  ("if |λ| < 1", "for any eigenvector v"); harmless in a helper, never a premise of
  the lemma.
- **carrier**: the binder ranges over a broader or different object than the paper's
  (an arbitrary real `t` in place of `|λ|²`, an abstract monoid in place of complex
  matrices, an arbitrary measure in place of the path measure).

Supported statements: `lem:transfer` = Lemma 3.1, `lem:fourier` = Lemma 3.2,
`thm:main` = Theorem 4.1.

## Summary

| # | Theorem | Supports | EXCESS binders | Free of EXCESS? |
|---|---|---|---|---|
| 1 | `preservesForm_mul` | 3.1 | `hU`, `hV` (step); `A`, `C`, `U`, `V` (carrier) | no |
| 2 | `preservesForm_one` | 3.1 | `A`, `C` (carrier) | no hypotheses; carrier only |
| 3 | `preservesForm_list_prod` | 3.1 | `h` (step); `A`, `L` (carrier) | no |
| 4 | `adjoint_eq_conjugate_inverse` | 3.1 | `hC`, `hUV`, `hU` (step); `A`, `V` (carrier) | no |
| 5 | `no_unit_factor_of_strict_drop` | 3.1 | `hdrop`, `hendpoint` (step); `t`, `B0`, `BT` (carrier) | no |
| 6 | `stable_endpoint_positive` | 3.1 | `hdrop`, `hendpoint` (step); `ht` (case); `t`, `B0`, `BT` (carrier) | no |
| 7 | `unstable_endpoint_negative` | 3.1 | `hdrop`, `hendpoint` (step); `ht` (case); `t`, `B0`, `BT` (carrier) | no |
| 8 | `stable_annulus_from_endpoint` | 3.1 | `hB`, `hendpoint`, `hcontract` (step); `t`, `r`, `B0`, `BT` (carrier) | no |
| 9 | `unstable_annulus_from_endpoint` | 3.1 | `hB`, `hendpoint`, `hcontract` (step); `t`, `r`, `B0`, `BT` (carrier) | no |
| 10 | `inverse_eigenvector` | 3.1 | `hVU`, `hlam` (step); `hx`, `x`, `lam` (case); `U`, `V` (carrier) | no |
| 11 | `involution_mulVec_ne_zero` | 3.1 | `hC` (step); `hx`, `x` (case); `C` (carrier) | no |
| 12 | `adjoint_inverse_eigenvector` | 3.1 | `hC`, `hUV`, `hVU`, `hform`, `hlam` (step); `hx`, `x`, `lam` (case); `C`, `U`, `V` (carrier) | no |
| 13 | `elementary_zero` | 3.2 | `lam` (carrier) | no hypotheses; carrier only |
| 14 | `norm_elementary_le` | 3.2 | `hlam` (step); `lam`, `r` (carrier) | no |
| 15 | `correlation_zero` | 3.2 | `a` (carrier) | no hypotheses; carrier only |
| 16 | `one_le_vacuumWeight` | 3.2 | `ha` (step); `a` (carrier) | no |
| 17 | `norm_correlation_le` | 3.2 | `hr0`, `hr1`, `ha` (step); `a`, `r` (carrier) | no |
| 18 | `elementary_correlation_bound` | 3.2 | `hr0`, `hr1`, `hlam` (step); `lam`, `r` (carrier) | no |
| 19 | `relative_correlation_bound` | 3.2 | `hr0`, `hr1`, `hlam` (step); `lam`, `r` (carrier) | no |
| 20 | `positive_measure_comparison` | 4.1 | `hf`, `hw`, `h` (step); `X`, `mu`, `f`, `w`, `B` (carrier) | no |
| 21 | `phase_preserves_bound` | 4.1 | `hp` (step); `hv` (case) | no |
| 22 | `scaled_coefficient_comparison` | 4.1 | `hr0`, `hr1`, `hlam`, `hC`, `hp` (step); `lam`, `r`, `C`, `phase` (carrier) | no |
| 23 | `canonical_integral_comparison` | 4.1 | `hr0`, `hr1`, `hlam`, `hC`, `hp`, `hf`, `hw` (step); `X`, `mu`, `lam`, `C`, `phase`, `r` (carrier) | no |

No theorem has a SOURCE, STANDING or RULED hypothesis binder. Every binder is TYPING
(numeric dimensions `n`, `N`, `q`, instance arguments) or EXCESS. The three theorems
without hypotheses (2, 13, 15) are true facts about project definitions, but their
carriers are not the paper's objects (an arbitrary monoid, an arbitrary vector `lam`,
an arbitrary sequence `a`), so none of them states a step of the paper on its own.

## Per-theorem tables

TYPING binders (`{n : ℕ}`, `{N q : ℕ}`, instance arguments `[Monoid A] [StarMul A]`,
`[MeasurableSpace X]`) are listed once per file and omitted from the rows.

### `Core/PseudoUnitary.lean` (supports Lemma 3.1)

TYPING: `[Monoid A]`, `[StarMul A]` (types formed only to host the carrier `A`).

| Theorem | Binder | Bin | Note, with source location (transfer.tex) |
|---|---|---|---|
| `preservesForm_mul` | `A`, `C U V : A` | EXCESS (carrier) | Paper: `C_5`, `U` are complex matrices, `C_5 = α_1α_2α_3β` (model.tex l.116). |
| | `hU`, `hV : PreservesForm C _` | EXCESS (step) | Paper proves `U^*C_5U = C_5` for the whole propagator from `A^*C_5 + C_5A = 0` (l.38–40); per-factor preservation is never a premise. |
| `preservesForm_one` | `A`, `C` | EXCESS (carrier) | — |
| `preservesForm_list_prod` | `A`, `C`, `L : List A` | EXCESS (carrier) | `L` is any list, not the free evolutions and kicks of l.11–16. |
| | `h : ∀ U ∈ L, PreservesForm C U` | EXCESS (step) | Form preservation of each free evolution and kick is a proof step (l.38). |
| `adjoint_eq_conjugate_inverse` | `A`, `C U V` | EXCESS (carrier) | `V` is any right inverse supplied by the caller. |
| | `hC : C * C = 1` | EXCESS (step) | `C_5² = 1` follows from the Clifford relations (model.tex l.27–28, l.116); not a premise of 3.1. |
| | `hUV : U * V = 1` | EXCESS (step) | Invertibility of the propagator is a fact the paper uses (l.42), not a premise. |
| | `hU : PreservesForm C U` | EXCESS (step) | l.40. |
| `no_unit_factor_of_strict_drop` | `B0 BT t : ℝ` | EXCESS (carrier) | Paper: `B(0)`, `B(T)` of a transported eigenvector, `t = |λ|²` (l.52–61). Here they are arbitrary reals. |
| | `hdrop : BT < B0` | EXCESS (step) | Strict decrease, proved from (3.3), `b > 0` and non-vanishing (l.61–62). |
| | `hendpoint : BT = t * B0` | EXCESS (step) | `B(T) = |λ|²B(0)`, proved by transport (l.61). |
| `stable_endpoint_positive` | `B0 BT t` | EXCESS (carrier) | as above |
| | `hdrop`, `hendpoint` | EXCESS (step) | as above |
| | `ht : t < 1` | EXCESS (case) | Case `|λ| < 1` (l.64). |
| `unstable_endpoint_negative` | `B0 BT t`; `hdrop`, `hendpoint`; `ht : 1 < t` | carrier; step; case | Case `|λ| > 1` (l.67). |
| `stable_annulus_from_endpoint` | `B0 BT t r` | EXCESS (carrier) | `r` is arbitrary, not `e^{-2bm_*}`. |
| | `hB : 0 < B0` | EXCESS (step) | Proved from the strict drop (l.64–65). |
| | `hendpoint` | EXCESS (step) | l.61. |
| | `hcontract : BT ≤ r * B0` | EXCESS (step) | The integrated (Gronwall) bound (l.65–66). |
| `unstable_annulus_from_endpoint` | `B0 BT t r`; `hB : B0 < 0`; `hendpoint`; `hcontract` | carrier; step; step; step | l.67–70. |

### `Core/Eigenvectors.lean` (supports Lemma 3.1)

TYPING: `{n : ℕ}`.

| Theorem | Binder | Bin | Note |
|---|---|---|---|
| `inverse_eigenvector` | `U V`, `x`, `lam` | `U`, `V`: EXCESS (carrier: any matrix and a supplied inverse, not the transfer matrix); `x`, `lam`: EXCESS (case) | Proof-internal eigenpair (l.52). |
| | `hVU : V * U = 1` | EXCESS (step) | Invertibility. |
| | `hx : U *ᵥ x = lam • x` | EXCESS (case) | "For any transfer eigenvector" (l.52). |
| | `hlam : lam ≠ 0` | EXCESS (step) | Follows from invertibility. |
| `involution_mulVec_ne_zero` | `C`, `x`; `hC : C * C = 1`; `hx : x ≠ 0` | `C`: EXCESS (carrier); `hC`: EXCESS (step); `x`, `hx`: EXCESS (case) | `C_5² = 1` is derived (model.tex l.116). |
| `adjoint_inverse_eigenvector` | `C U V x lam` | `C`, `U`, `V`: EXCESS (carrier); `x`, `lam`: EXCESS (case) | — |
| | `hC`, `hUV`, `hVU`, `hform`, `hlam` | EXCESS (step) | `C_5² = 1`, invertibility (both sides), form preservation (l.40), `λ ≠ 0`. |
| | `hx` | EXCESS (case) | l.52. |

The conclusion is an eigenvector-level statement. Lemma 3.1 pairs eigenvalues with
algebraic multiplicity (l.42–43, l.70–71); no multiplicity statement is made.

### `Core/Coefficients.lean` (supports Lemma 3.2)

TYPING: `{N q : ℕ}`, `(k : ℕ)`.

| Theorem | Binder | Bin | Note |
|---|---|---|---|
| `elementary_zero` | `lam : Fin N → ℂ` | EXCESS (carrier) | Any vector, not the `d` small transfer eigenvalues (l.106–107). |
| `norm_elementary_le` | `lam`, `r` | EXCESS (carrier) | `r` arbitrary, not `s = e^{-bm_*}` (l.118). |
| | `hlam : ∀ i, ‖lam i‖ ≤ r` | EXCESS (step) | The eigenvalue bound is the conclusion of Lemma 3.1 (l.106–107, eq. (3.2)). |
| `correlation_zero` | `a : ℕ → ℂ` | EXCESS (carrier) | — |
| `one_le_vacuumWeight` | `a`; `ha : a 0 = 1` | carrier; EXCESS (step) | `e_0 = 1` is a fact (discharged by `elementary_zero` in #19). |
| `norm_correlation_le` | `a`, `r` | EXCESS (carrier) | — |
| | `hr0 : 0 ≤ r`, `hr1 : r ≤ 1` | EXCESS (step) | `0 < s < 1` follows from `b, m_* > 0`. |
| | `ha : ∀ k, ‖a k‖ ≤ choose N k * r^k` | EXCESS (step) | `|e_j| ≤ binom(d,j)s^j` (l.121). |
| `elementary_correlation_bound` | `lam`, `r`; `hr0`, `hr1`, `hlam` | carrier; step | — |
| `relative_correlation_bound` | `lam`, `r`; `hr0`, `hr1`, `hlam` | carrier; step | The conclusion bounds `correlation`, which is `F_q / C` only after the factorization of l.110 and the Fourier identification, neither formalized. |

### `Core/PositiveMeasure.lean` (supports Theorem 4.1)

TYPING: `[MeasurableSpace X]`.

| Theorem | Binder | Bin | Note (comparison.tex) |
|---|---|---|---|
| `positive_measure_comparison` | `X`, `mu`, `f`, `w`, `B` | EXCESS (carrier) | Arbitrary measure and integrands, not the bridge and gauge-angle measure of (4.5)–(4.6). |
| | `hf`, `hw : Integrable _ mu` | EXCESS (step) | Integrability follows from the Dyson bound (l.33–39, l.66–68). |
| | `h : ∀ᵐ x, ‖f x‖ ≤ B * w x` | EXCESS (step) | The pointwise bound is Lemma 3.2 applied fibrewise (l.86–89). |
| `phase_preserves_bound` | `phase`, `value`, `bound`; `hp : ‖phase‖ = 1`; `hv` | carrier; step; case | — |

### `Core/CanonicalComparison.lean` (supports Theorem 4.1)

| Theorem | Binder | Bin | Note |
|---|---|---|---|
| `scaled_coefficient_comparison` | `lam`, `r`, `C`, `phase` | EXCESS (carrier) | — |
| | `hr0`, `hr1`, `hlam` | EXCESS (step) | as in #17–#19 |
| | `hC : 0 ≤ C` | EXCESS (step) | Positivity of the remaining constant (transfer.tex l.114–115). |
| | `hp : ‖phase‖ = 1` | EXCESS (step) | `e^{-iϑ·ν}` has modulus one. |
| `canonical_integral_comparison` | `X`, `mu`, `lam`, `C`, `phase`, `r` | EXCESS (carrier) | The integrand is *assumed* to have the factored shape `phase · C · correlation`; the paper derives that shape (transfer.tex l.106–116, comparison.tex l.82–91). |
| | `hr0`, `hr1`, `hlam`, `hC`, `hp`, `hf`, `hw` | EXCESS (step) | as above |

## Consequence for the campaign

The new anchors for Lemmas 3.1 and 3.2 must not take any of these EXCESS inputs as
binders. The lemmas may be reused inside provider proofs, where each EXCESS hypothesis
must be discharged by a proved graph predecessor: for example
`relative_correlation_bound` can supply the coefficient estimate inside Lemma 3.2 once
the eigenvalue bound comes from the proved Lemma 3.1 and the factorization and Fourier
identification are proved.
