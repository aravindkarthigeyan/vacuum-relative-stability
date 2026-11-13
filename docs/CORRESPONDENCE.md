# Correspondence between Paper A and the Lean library

This page explains, step by step, what the Lean library in [`lean/`](../lean) checks
and how each declaration relates to [Paper A](../paper-a/paper-a-lattice.pdf)
(*Vacuum-relative stability and charge gaps in compact Hamiltonian lattice QED*,
draft of 29 October 2026; LaTeX sources in [`paper-a/`](../paper-a)). The state of
every numbered result, and the list of checked declarations, is recorded in
[`lean/status.json`](../lean/status.json); the README tables are generated from it.

**No numbered result of Paper A is formalized as stated.** The library checks
conditional algebraic, finite-coefficient and integration steps used inside the
proofs of Lemma 3.1, Lemma 3.2 and Theorem 4.1. Each such lemma has, among its
hypotheses, facts that Paper A proves analytically and that Lean does not check.
Those facts are explicit hypotheses of the Lean statements, never axioms.

Recommended status language: *“A companion Lean project checks the finite product
algebra, selected endpoint implications, an eigenvector-level inverse-adjoint
correspondence, and the finite Vandermonde/canonical integration estimate. The
analytic and full spectral arguments and the physical theorem remain outside the
formalization.”* Avoid “the stability theorem is formally verified,” “the
spectral-pairing lemma is fully formalized,” or “the ODE positivity proof is machine
checked.”

All Lean names below have the prefix `QEDCore.`.

## Lemma 3.1 (`lem:transfer`), positivity and the transfer annulus

Source: [`paper-a/transfer.tex`](../paper-a/transfer.tex).

| Lean file and names | Checked content | Boundary |
|---|---|---|
| [`Core/PseudoUnitary.lean`](../lean/Core/PseudoUnitary.lean): `preservesForm_mul`, `preservesForm_one`, `preservesForm_list_prod` | If every factor satisfies `star U * C * U = C`, so does the ordered product (in any monoid with a star-multiplication). | That each free evolution and each scalar kick preserves `C_5` is an input; the derivation from the anticommutation relations `A* C_5 + C_5 A = 0` is not formalized. |
| `adjoint_eq_conjugate_inverse` | From `C * C = 1`, `U * V = 1` and form preservation, `star U = C * V * C`. | The identity `U* = C_5 U^{-1} C_5`, with the inverse `V` supplied explicitly. |
| `no_unit_factor_of_strict_drop`, `stable_endpoint_positive`, `unstable_endpoint_negative`, `stable_annulus_from_endpoint`, `unstable_annulus_from_endpoint` | Real-number implications: a strict drop `B(T) < B(0)` with `B(T) = t B(0)` excludes `t = 1`, fixes the sign of `B(0)` according to `t < 1` or `t > 1`, and lets an assumed integrated bound `B(T) ≤ r B(0)` be divided by `B(0)`. | Consequences of (3.3). The derivative identity (3.3), the strict integrated decrease, non-vanishing of the transported vector, Gronwall, and the identification `t = |λ|²` are not formalized. |
| [`Core/Eigenvectors.lean`](../lean/Core/Eigenvectors.lean): `inverse_eigenvector`, `involution_mulVec_ne_zero`, `adjoint_inverse_eigenvector` | `U x = λ x` with `λ ≠ 0` implies `V x = λ⁻¹ x` for an explicit left inverse `V`; `C x ≠ 0` when `x ≠ 0` and `C * C = 1`; with a two-sided inverse and form preservation, `U* (C x) = λ⁻¹ (C x)`. | Eigenvector level only. Pairing with algebraic multiplicities, the exact count of `d` stable eigenvalues, reality and positivity of the centered trace, and the homotopy argument are not formalized. |

## Lemma 3.2 (`lem:fourier`), canonical Fourier bound

Source: [`paper-a/transfer.tex`](../paper-a/transfer.tex), inequality (3.4).

| Lean file and names | Checked content | Boundary |
|---|---|---|
| [`Core/Coefficients.lean`](../lean/Core/Coefficients.lean): `elementary`, `elementary_zero`, `norm_elementary_le` | `elementary λ k` is the sum of products over `k`-element subsets; `e_0 = 1`; `‖e_k‖ ≤ binom(N,k) r^k` when every `‖λ_i‖ ≤ r`. | The elementary-symmetric estimate in the proof. The bound `‖λ_i‖ ≤ e^{-b m_*}` comes from Lemma 3.1 and is a hypothesis. |
| `correlation`, `vacuumWeight`, `correlation_zero`, `one_le_vacuumWeight` | The zeroth antidiagonal coefficient equals `Σ_j ‖a_j‖²`, which is at least 1 when `a_0 = 1`. | The normalization `F_0 = C Σ_j |e_j|² ≥ C`. |
| `norm_correlation_le`, `elementary_correlation_bound`, `relative_correlation_bound` | For `0 ≤ r ≤ 1`, `‖correlation N q (elementary λ)‖ ≤ binom(2N, N+q) r^q`, and the same times the vacuum weight, for every natural `q`. The binomial coefficient comes from Mathlib's Vandermonde identity after a proved termwise estimate. | The finite calculation behind (3.4) for `q ≥ 0`. The factorization `F(φ) = C ∏_j |1 + e^{iφ} λ_j|²`, the identification of `F_q` with the correlation, and negative `q` (by conjugation) are not formalized. |

### The finite quantity

For `λ : Fin N → ℂ` and a coefficient sequence `a : ℕ → ℂ`, where Lean's `N` is the
`d` of Lemma 3.2 (in Theorem 4.1, `d = 2N` with `N = n³` the number of sites),

```text
correlation N q a = Σ_{i+j=N+q, i≤N, j≤N} a_i · conj(a_{N-j})
vacuumWeight N a  = Σ_{j=0}^{N} ‖a_j‖²
```

Writing `k = N - j`, the correlation is `Σ_{i-k=q} a_i conj(a_k)`, the lag-`q`
autocorrelation of the coefficients. For `a = e(λ)` it is `F_q / C` in the notation of
Lemma 3.2 once the factorization of `F` is known; that identification is not part of
the Lean definitions or theorems. The final finite bound is

```text
‖correlation N q (elementary λ)‖ ≤ binom(2N, N+q) · r^q · vacuumWeight N (elementary λ).
```

It also covers `q > N`, where both sides are zero.

## Theorem 4.1 (`thm:main`), the integration step behind (4.2)

Source: [`paper-a/comparison.tex`](../paper-a/comparison.tex).

| Lean file and names | Checked content | Boundary |
|---|---|---|
| [`Core/PositiveMeasure.lean`](../lean/Core/PositiveMeasure.lean): `positive_measure_comparison`, `phase_preserves_bound` | The norm of an integrable complex integral is bounded by the integral of a pointwise majorant against a positive measure; a unit-modulus phase preserves a norm bound. | The absolute-value step that removes the phase `e^{-iθ·ν}`. Integrability of both integrands is a hypothesis. |
| [`Core/CanonicalComparison.lean`](../lean/Core/CanonicalComparison.lean): `scaled_coefficient_comparison`, `canonical_integral_comparison` | Combines the coefficient estimate above with a nonnegative prefactor, a unit-modulus phase and an arbitrary measure. | Conditional on the factored representation. The heat kernel (4.3), the Dyson/Feynman–Kac formula (4.4), the twisted trace formula (4.5), the gauge projection, the change of torus coordinates that turns the `φ`-integral into the coefficient `F_{Q_ν}`, positivity of the prefactor, the ground-energy limit, the case `m = 0` and the identification of the auxiliary ground energy with `E_0` are not formalized. |

## Results with nothing in Lean

Lemma 2.1 (`lem:operator`), Lemma 4.2 (`lem:green`), Corollary 4.3
(`cor:stability`), Lemma 5.1 (`lem:cut`), Theorem 5.2 (`thm:vacuum-limit`),
Proposition 5.3 (`prop:cell`) and Theorem 5.4 (`thm:open-source`). Hypothesis (BF)
is stated in Paper A and explicitly not proved there.

## Trust boundary

`lake build` checks every proof in the library. The
[axiom audit](../lean/scripts/AxiomAudit.lean) computes, for every declaration of the
library, the axioms it depends on, and fails on `sorryAx`, on any axiom other than
`propext`, `Classical.choice` and `Quot.sound`, and on any axiom declared in the
project. The trust base is the Lean kernel and compiler of the pinned toolchain and
the Mathlib build downloaded by `lake exe cache get`.

Compilation shows that the Lean statements are proved. It does not show that they
are faithful to the paper: a reader must compare the hypotheses above with Paper A,
and the physical operators of Paper A are not defined in Lean. Differences between
the Lean statements and the printed ones are listed in
[ERRATA-AND-DEVIATIONS.md](ERRATA-AND-DEVIATIONS.md).
