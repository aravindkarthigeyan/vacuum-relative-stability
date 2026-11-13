# Vacuum-relative stability of lattice QED: papers and a partial Lean formalization

[![Build and verify](https://github.com/aravindkarthigeyan/vacuum-relative-stability/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/aravindkarthigeyan/vacuum-relative-stability/actions/workflows/build.yml)
[![Comparator](https://github.com/aravindkarthigeyan/vacuum-relative-stability/actions/workflows/comparator.yml/badge.svg?branch=main)](https://github.com/aravindkarthigeyan/vacuum-relative-stability/actions/workflows/comparator.yml)

<!-- BEGIN badges -->
![Paper A results proved in Lean: 0/10](https://img.shields.io/badge/Paper%20A%20results%20proved%20in%20Lean-0%2F10-lightgrey) ![frozen statements: 0 proved, 2 unproved](https://img.shields.io/badge/frozen%20statements-0%20proved%2C%202%20unproved-blue) ![supporting lemmas checked: 23](https://img.shields.io/badge/supporting%20lemmas%20checked-23-blue) ![unregistered sorry: 0](https://img.shields.io/badge/unregistered%20sorry-0-brightgreen) ![axioms: standard only](https://img.shields.io/badge/axioms-standard%20only-brightgreen) ![Lean: v4.35.0](https://img.shields.io/badge/Lean-v4.35.0-blue) ![Mathlib: v4.35.0](https://img.shields.io/badge/Mathlib-v4.35.0-blue) ![papers: drafts, not specialist-reviewed](https://img.shields.io/badge/papers-drafts%2C%20not%20specialist--reviewed-orange)
<!-- END badges -->

<!-- BEGIN progress -->
![Paper A numbered results (10): 0/10 proved; Frozen theorem statements (2): 0/2 proved](docs/img/progress.svg)
<!-- END progress -->

This repository contains three draft papers on the stability of matter relative to
the interacting vacuum in quantum electrodynamics with a regulator, and a small Lean 4
library. The first paper, **Paper A**, proves for a compact $U(1)$ Hamiltonian
lattice gauge theory with Wilson fermions and exact Gauss law that static charges
cannot lower the energy below the vacuum: $E_\nu \ge E_0 + m\,|Q_\nu|$. **This is a
partial formalization: it does not formalize that stability theorem, or any other
numbered result of the papers, as stated.** A companion Lean project checks the
finite product algebra, selected endpoint implications, an eigenvector-level
inverse-adjoint correspondence, and the finite Vandermonde/canonical integration
estimate. The analytic and full spectral arguments and the physical theorem remain
outside the formalization. **The papers are drafts and have not yet been reviewed by
specialists.**

**Author:** Aravind Karthigeyan.

## At a glance

<!-- BEGIN glance -->
- ⬜ **The stability theorem is not formalized.** 0 of the 10 numbered results of Paper A are proved in Lean, and 2 have a frozen Lean statement whose proof is in progress.
- ✅ **What is checked.** The library compiles on Lean v4.35.0 with Mathlib v4.35.0, with no `sorry` except the 2 registered proof placeholders of the frozen statements; every declaration other than those 2 frozen statements depends only on `propext`, `Classical.choice`, `Quot.sound`. It contains 23 conditional supporting lemmas for steps of 3 results.
- ⬜ **Lemma 2.1, Operator realization** (`lem:operator`): not formalized.
- 🔧 **Lemma 3.1, Positivity and the transfer annulus** (`lem:transfer`): statement frozen as `QEDCore.PaperA.positivity_and_transfer_annulus`, proof in progress. By author ruling R1(a) the frozen statement covers piecewise-constant histories: free steps with constant coefficients, and separate instantaneous kicks (deviation 7). Checked supporting lemmas: the product algebra of form preservation, the inverse-adjoint identity with an explicit inverse, the scalar endpoint implications of a strict β-form drop, and the eigenvector-level inverse-adjoint correspondence (12 lemmas). Not in Lean: form preservation of the actual propagators, derived from the generator relations; the β-form derivative identity (3.3), the strict decrease and the Gronwall integration; algebraic multiplicities and the exact eigenvalue count; reality and positivity of the centered trace along the homotopy; measurable histories.
- 🔧 **Lemma 3.2, Canonical Fourier bound** (`lem:fourier`): statement frozen as `QEDCore.PaperA.canonical_fourier_bound`, proof in progress. By author ruling R1(a) the frozen statement covers piecewise-constant histories (deviation 7); it states `F_0` real and bounds `|F_q|` by its real part (ruling R3). Checked supporting lemmas: the finite coefficient estimate inside the proof, that is, the elementary-symmetric bounds and the Vandermonde bound for the antidiagonal correlation relative to the vacuum weight, for every natural `q` (7 lemmas). Not in Lean: the factorization `F(φ) = C ∏_j |1 + e^{iφ} λ_j|²`, the identification of `F_q` with the finite antidiagonal correlation, and negative `q` by conjugation.
- 🔧 **Theorem 4.1, Exact physical-sector comparison** (`thm:main`): not formalized as stated. Checked supporting lemmas: the final integration step behind (4.2), for an abstract positive measure and conditional on a supplied factored representation (4 lemmas). Not in Lean: the compact-rotor heat kernel, the Dyson and Feynman–Kac representation, the twisted trace formula, the exact gauge projection and the change of torus coordinates that produces `F_{Q_ν}`, the ground-energy limit, the case `m = 0`, and the identification of the auxiliary ground energy with `E_0`.
- ⬜ **Lemma 4.2, Uniform lattice self-energy** (`lem:green`): not formalized.
- ⬜ **Corollary 4.3, Stability after individual nuclear subtraction** (`cor:stability`): not formalized.
- ⬜ **Lemma 5.1, Cutting with retained rotors** (`lem:cut`): not formalized.
- ⬜ **Theorem 5.2, Vacuum thermodynamic limit** (`thm:vacuum-limit`): not formalized.
- ⬜ **Proposition 5.3, Fixed-cell relative bounds** (`prop:cell`): not formalized.
- ⬜ **Theorem 5.4, Open zero-flux source limit** (`thm:open-source`): not formalized.
- 📄 **Errata and deviations:** 0 errata, 8 deviations → [docs/ERRATA-AND-DEVIATIONS.md](docs/ERRATA-AND-DEVIATIONS.md)

✅ proved in Lean · 🔧 statement frozen, or conditional lemmas for some proof steps checked · ⬜ nothing in Lean
<!-- END glance -->

## The papers

| Paper | PDF | Sources | Contents |
|---|---|---|---|
| **A.** Vacuum-relative stability and charge gaps in compact Hamiltonian lattice QED | [PDF](paper-a/paper-a-lattice.pdf) | [`paper-a/`](paper-a) | The lattice theorem, the charge gap, individual nuclear self-energy subtraction, the vacuum thermodynamic limit, and the open zero-flux source limit. This is the paper the Lean library refers to. |
| **B.** Vacuum-relative stability and regulator obstructions in momentum-cutoff QED | [PDF](paper-b/paper-b-momentum.pdf) | [`paper-b/`](paper-b) | Momentum-cutoff relative bounds, photons, ordering windows, and ultraviolet and exchange counterexamples. Not formalized. |
| Companion notes: low-energy matching and obstructions | [PDF](companion-notes/companion-notes.pdf) | [`companion-notes/`](companion-notes) | Frozen-link matching, a clover correction, electric localization, bare-vacuum obstructions, and the conditions still needed for a dynamical nonrelativistic reduction. Not formalized. |

All three are dated 29 October 2026 and carry no human author metadata yet. The
earlier consolidated draft and the original research memorandum are kept unchanged in
[`drafts/`](drafts). The current mathematical status of the whole project, including
what remains open, is in [docs/CURRENT_RESEARCH_REPORT.md](docs/CURRENT_RESEARCH_REPORT.md).

### What Paper A proves, in brief

The model is one four-component Wilson fermion on a periodic cubic lattice with
spacing $a$, bare mass $m \ge 0$, Wilson parameter $r \ge 0$, coupling $g^2$,
untruncated compact rotors on every link, and every local Gauss constraint. For an
admissible integer static source $\nu$ with total charge $Q_\nu$:

- **Theorem 4.1.** $E_\nu \ge E_0 + m\,|Q_\nu|$, including the sources' electric
  self-energy, at every positive coupling.
- **Corollary 4.3.** After subtracting prescribed individual nuclear self-energies, the
  energy relative to the vacuum is at least
  $m Z_{\mathrm{tot}} - \frac{13\pi\alpha}{8a} Z_{\max}^2 K$ for $K$ nuclei, uniformly
  in the volume.
- **Theorems 5.2 and 5.4.** At fixed spacing, the vacuum energy density has a limit,
  and so does the source energy density in open boxes with zero boundary flux. The
  periodic-source limit is conditional on a boundary-flux hypothesis (BF) that the paper
  states and does not prove.

These are finite-regulator results. They do not construct renormalized continuum QED
or establish a neutral pair gap, binding, or crystalline order.

## Statistics

<!-- BEGIN stats -->
```text
Paper A results  ▒▒▒▒▒▒░░░░░░░░░░░░░░  0/10 proved (0%), 2 frozen, 1 with supporting lemmas only
```
`█` proved · `▒` statement frozen or supporting lemmas checked · `░` nothing in Lean

| | |
|---|---|
| Paper A numbered results | 10 |
| … proved in Lean (`PROVED` or `AUDITED`) | 0 (0 audited) |
| … frozen statement, unproved (`FROZEN_UNPROVED`) | 2 |
| … `NOT_STARTED`, with checked supporting lemmas | 1 |
| … `NOT_STARTED`, nothing in Lean | 7 |
| Frozen theorem statements in `lean/frozen-manifest.json` (proved / unproved) | 0 / 2 |
| Frozen definitions in `lean/frozen-manifest.json` | 6 |
| Supporting lemmas listed in `lean/status.json` | 23 |
| Theorems in the axiom audit | 25 |
| Declarations audited (including auxiliary ones) | 68 |
| Library modules / files / lines | 16 / 16 / 632 |
| Comparator files in `lean/Audit/` | 0 |
| Registered `sorry` (proof bodies of frozen, unproved statements) | 2 |
| Unregistered `sorry` or `admit` outside `lean/Audit/` | 0 |
| `axiom` declarations in the project | 0 |
| Axioms used | `propext`, `Classical.choice`, `Quot.sound` |
| Toolchain | Lean v4.35.0, Mathlib v4.35.0 (`56a005855ea1`) |
<!-- END stats -->

## Paper A and the Lean library

The state of each numbered result of Paper A, by its LaTeX label, as recorded in
[`lean/status.json`](lean/status.json). A result is `PROVED` only when a Lean
statement of the result itself is proved; checked supporting lemmas never change a
result's state. [docs/CORRESPONDENCE.md](docs/CORRESPONDENCE.md) explains every row.

<!-- BEGIN table -->
| # | Paper A result | Label | State | Lean statement | Checked supporting lemmas |
|---|---|---|---|---|---|
| 2.1 | ⬜ Lemma: Operator realization | [`lem:operator`](paper-a/model.tex) | `NOT_STARTED` | — | — |
| 3.1 | 🔧 Lemma: Positivity and the transfer annulus | [`lem:transfer`](paper-a/transfer.tex) | `FROZEN_UNPROVED` | [`PaperA.positivity_and_transfer_annulus`](lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean) | `preservesForm_mul`, `preservesForm_one`, `preservesForm_list_prod`, `adjoint_eq_conjugate_inverse`, `no_unit_factor_of_strict_drop`, `stable_endpoint_positive`, `unstable_endpoint_negative`, `stable_annulus_from_endpoint`, `unstable_annulus_from_endpoint`, `inverse_eigenvector`, `involution_mulVec_ne_zero`, `adjoint_inverse_eigenvector` |
| 3.2 | 🔧 Lemma: Canonical Fourier bound | [`lem:fourier`](paper-a/transfer.tex) | `FROZEN_UNPROVED` | [`PaperA.canonical_fourier_bound`](lean/Frozen/PaperA/CanonicalFourierBound.lean) | `elementary_zero`, `norm_elementary_le`, `correlation_zero`, `one_le_vacuumWeight`, `norm_correlation_le`, `elementary_correlation_bound`, `relative_correlation_bound` |
| 4.1 | 🔧 Theorem: Exact physical-sector comparison | [`thm:main`](paper-a/comparison.tex) | `NOT_STARTED` | — | `positive_measure_comparison`, `phase_preserves_bound`, `scaled_coefficient_comparison`, `canonical_integral_comparison` |
| 4.2 | ⬜ Lemma: Uniform lattice self-energy | [`lem:green`](paper-a/comparison.tex) | `NOT_STARTED` | — | — |
| 4.3 | ⬜ Corollary: Stability after individual nuclear subtraction | [`cor:stability`](paper-a/comparison.tex) | `NOT_STARTED` | — | — |
| 5.1 | ⬜ Lemma: Cutting with retained rotors | [`lem:cut`](paper-a/thermodynamics.tex) | `NOT_STARTED` | — | — |
| 5.2 | ⬜ Theorem: Vacuum thermodynamic limit | [`thm:vacuum-limit`](paper-a/thermodynamics.tex) | `NOT_STARTED` | — | — |
| 5.3 | ⬜ Proposition: Fixed-cell relative bounds | [`prop:cell`](paper-a/thermodynamics.tex) | `NOT_STARTED` | — | — |
| 5.4 | ⬜ Theorem: Open zero-flux source limit | [`thm:open-source`](paper-a/thermodynamics.tex) | `NOT_STARTED` | — | — |

Each supporting lemma is a conditional statement about a single proof step. Its hypotheses include facts that Paper A proves analytically and Lean does not:

| Lean declaration (`QEDCore.`) | File | Paper A result | Step checked |
|---|---|---|---|
| `preservesForm_mul` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | Product algebra: `U* C U = C` and `V* C V = C` imply `(UV)* C (UV) = C`, in any monoid with a star-multiplication. |
| `preservesForm_one` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | The identity preserves every form. |
| `preservesForm_list_prod` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | An ordered product of form-preserving factors preserves the form. That each free evolution and kick preserves `C_5` is a hypothesis. |
| `adjoint_eq_conjugate_inverse` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | From `C C = 1`, `U V = 1` and `U* C U = C`, derive `U* = C V C`: the identity `U* = C_5 U⁻¹ C_5`, with the inverse supplied explicitly. |
| `no_unit_factor_of_strict_drop` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | Scalar endpoint implication: `B(T) < B(0)` and `B(T) = t B(0)` exclude `t = 1`. The strict drop itself is a hypothesis. |
| `stable_endpoint_positive` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | Scalar endpoint implication: with a strict drop, `t < 1` forces `B(0) > 0`. |
| `unstable_endpoint_negative` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | Scalar endpoint implication: with a strict drop, `t > 1` forces `B(0) < 0`. |
| `stable_annulus_from_endpoint` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | Division step: `B(0) > 0`, `B(T) = t B(0)` and an assumed integrated bound `B(T) ≤ r B(0)` give `t ≤ r`. |
| `unstable_annulus_from_endpoint` | [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) | `lem:transfer` | Division step with `B(0) < 0`: the same hypotheses give `r ≤ t`. |
| `inverse_eigenvector` | [lean/Core/Eigenvectors.lean](lean/Core/Eigenvectors.lean) | `lem:transfer` | Eigenvector level: `U x = λ x`, `V U = 1` and `λ ≠ 0` give `V x = λ⁻¹ x`. |
| `involution_mulVec_ne_zero` | [lean/Core/Eigenvectors.lean](lean/Core/Eigenvectors.lean) | `lem:transfer` | `C C = 1` and `x ≠ 0` give `C x ≠ 0`. |
| `adjoint_inverse_eigenvector` | [lean/Core/Eigenvectors.lean](lean/Core/Eigenvectors.lean) | `lem:transfer` | Eigenvector-level inverse-adjoint correspondence: `U* (C x) = λ⁻¹ (C x)`. No multiplicity statement. |
| `elementary_zero` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | `e_0 = 1` for the elementary symmetric coefficients, defined as subset sums. |
| `norm_elementary_le` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | `\|e_k\| ≤ binom(N, k) r^k` when every `\|λ_i\| ≤ r`. |
| `correlation_zero` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | The zeroth antidiagonal coefficient equals the vacuum weight `Σ_j \|a_j\|²`. |
| `one_le_vacuumWeight` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | `a_0 = 1` implies that the vacuum weight is at least 1. |
| `norm_correlation_le` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | Termwise bound and Mathlib's Vandermonde identity: if `\|a_k\| ≤ binom(N, k) r^k` for every `k`, then `\|corr_q\| ≤ binom(2N, N+q) r^q` for `0 ≤ r ≤ 1` and every natural `q`. |
| `elementary_correlation_bound` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | The same bound for the elementary symmetric coefficients of `λ`. |
| `relative_correlation_bound` | [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) | `lem:fourier` | The finite coefficient estimate behind (3.4): `\|corr_q\| ≤ binom(2N, N+q) r^q` times the vacuum weight. |
| `positive_measure_comparison` | [lean/Core/PositiveMeasure.lean](lean/Core/PositiveMeasure.lean) | `thm:main` | The norm of an integrable complex integral is at most the integral of a pointwise majorant against a positive measure. |
| `phase_preserves_bound` | [lean/Core/PositiveMeasure.lean](lean/Core/PositiveMeasure.lean) | `thm:main` | A unit-modulus phase preserves a norm bound (removing `e^{-iθ·ν}`). |
| `scaled_coefficient_comparison` | [lean/Core/CanonicalComparison.lean](lean/Core/CanonicalComparison.lean) | `thm:main` | Pointwise: phase times nonnegative prefactor times correlation is bounded by the binomial factor times prefactor times vacuum weight. |
| `canonical_integral_comparison` | [lean/Core/CanonicalComparison.lean](lean/Core/CanonicalComparison.lean) | `thm:main` | The integrated comparison behind (4.2), conditional on a supplied measure, nonnegative prefactor, unit phase, eigenvalue bound and integrability. |
<!-- END table -->

### Frozen statements and the strongest checked lemmas

First, the author-approved Lean statements of Paper A results, frozen verbatim in
[`lean/Frozen/`](lean/Frozen) and registered with their source ranges, rulings and
SHA-256 hashes in [`lean/frozen-manifest.json`](lean/frozen-manifest.json). A frozen
statement never changes; only its proof body may, from the registered placeholder
`by sorry` to a short use of the finished proof. Their departures from the printed
lemmas are deviations 7 and 8 in [docs/ERRATA-AND-DEVIATIONS.md](docs/ERRATA-AND-DEVIATIONS.md).
Then the headline supporting lemmas, which are not results of Paper A. Every
hypothesis is visible in the statement.

<!-- BEGIN verbatim -->
`QEDCore.PaperA.positivity_and_transfer_annulus`, the frozen statement of Lemma 3.1 (`lem:transfer`), verbatim from [lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean](lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean); proof in progress: its body is the registered placeholder `by sorry`.

```lean
/-- **Paper A, Lemma 3.1 (Positivity and the transfer annulus).** For a history of free
evolutions with Dirac operators `Σ_j α_j v_j + β M`, `M ≥ m_* I > 0`, total free time
`b > 0`, interspersed with spin-scalar kicks: the centered trace is positive, exactly `d`
transfer eigenvalues (with algebraic multiplicity) satisfy `|λ| ≤ e^{-b m_*}`, and the
remaining `d` are their partners `1 / conj λ`, of modulus at least `e^{b m_*}`. -/
theorem positivity_and_transfer_annulus
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b) :
    (0 < (centeredTrace α β hist).re ∧ (centeredTrace α β hist).im = 0) ∧
    ((transferMatrix α β hist).charpoly.roots.filter
        (fun z => ‖z‖ ≤ Real.exp (-(b * mStar)))).card = d ∧
    (transferMatrix α β hist).charpoly.roots.filter
        (fun z => ¬ ‖z‖ ≤ Real.exp (-(b * mStar))) =
      ((transferMatrix α β hist).charpoly.roots.filter
        (fun z => ‖z‖ ≤ Real.exp (-(b * mStar)))).map (fun z => (star z)⁻¹) ∧
    ∀ z ∈ (transferMatrix α β hist).charpoly.roots,
      ¬ ‖z‖ ≤ Real.exp (-(b * mStar)) → Real.exp (b * mStar) ≤ ‖z‖ :=
```

`QEDCore.PaperA.canonical_fourier_bound`, the frozen statement of Lemma 3.2 (`lem:fourier`), verbatim from [lean/Frozen/PaperA/CanonicalFourierBound.lean](lean/Frozen/PaperA/CanonicalFourierBound.lean); proof in progress: its body is the registered placeholder `by sorry`.

```lean
/-- **Paper A, Lemma 3.2 (Canonical Fourier bound).** Append to a history of Lemma 3.1 the
global charge twist `e^{iφQ}`, `Q = dΓ(I) - d`, let `F(φ)` be its centered trace and
`F_q = (2π)⁻¹ ∫_0^{2π} e^{-iqφ} F(φ) dφ`. Then `F_0` is real and, for `|q| ≤ d`,
`|F_q| ≤ binom(2d, d + |q|) e^{-b m_* |q|} F_0`. -/
theorem canonical_fourier_bound
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b)
    (q : ℤ) (hq : |q| ≤ d) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    (Fhat 0).im = 0 ∧
      ‖Fhat q‖ ≤ ((2 * d).choose (d + q.natAbs) : ℝ) *
        Real.exp (-(b * mStar * |(q : ℝ)|)) * (Fhat 0).re :=
```

`QEDCore.adjoint_eq_conjugate_inverse`, a supporting lemma for Lemma 3.1 (`lem:transfer`), verbatim from [lean/Core/PseudoUnitary.lean](lean/Core/PseudoUnitary.lean) (namespace `QEDCore`; its proof follows the `:=`). It uses the section variables `variable {A : Type*} [Monoid A] [StarMul A]`.

```lean
/-- The inverse-adjoint conjugacy. V is an explicit right inverse, not an
    unproved assertion of invertibility of a physical propagator. -/
theorem adjoint_eq_conjugate_inverse {C U V : A}
    (hC : C * C = 1) (hUV : U * V = 1) (hU : PreservesForm C U) :
    star U = C * V * C :=
```

`QEDCore.relative_correlation_bound`, a supporting lemma for Lemma 3.2 (`lem:fourier`), verbatim from [lean/Core/Coefficients.lean](lean/Core/Coefficients.lean) (namespace `QEDCore`; its proof follows the `:=`).

```lean
/-- The denominator is derived from a_0=1, rather than assumed bounded below. -/
theorem relative_correlation_bound {N q : ℕ} (lam : Fin N → ℂ) {r : ℝ}
    (hr0 : 0 ≤ r) (hr1 : r ≤ 1) (hlam : ∀ i, ‖lam i‖ ≤ r) :
    ‖correlation N q (elementary lam)‖ ≤
      (((N + N).choose (N + q) : ℝ) * r ^ q) * vacuumWeight N (elementary lam) :=
```

`QEDCore.canonical_integral_comparison`, a supporting lemma for Theorem 4.1 (`thm:main`), verbatim from [lean/Core/CanonicalComparison.lean](lean/Core/CanonicalComparison.lean) (namespace `QEDCore`; its proof follows the `:=`).

```lean
/-- Canonical coefficient comparison conditional on a positive measure and
the factored representation. No determinant or Hubbard--Stratonovich identity
is postulated as a Lean axiom: the theorem has explicit data and hypotheses. -/
theorem canonical_integral_comparison {X : Type*} [MeasurableSpace X]
    (mu : Measure X) {N q : ℕ} (lam : X → Fin N → ℂ)
    (C : X → ℝ) (phase : X → ℂ) {r : ℝ}
    (hr0 : 0 ≤ r) (hr1 : r ≤ 1) (hlam : ∀ x i, ‖lam x i‖ ≤ r)
    (hC : ∀ x, 0 ≤ C x) (hp : ∀ x, ‖phase x‖ = 1)
    (hf : Integrable (fun x => phase x * (C x : ℂ) *
      correlation N q (elementary (lam x))) mu)
    (hw : Integrable (fun x => C x * vacuumWeight N (elementary (lam x))) mu) :
    ‖∫ x, phase x * (C x : ℂ) * correlation N q (elementary (lam x)) ∂mu‖ ≤
      (((N + N).choose (N + q) : ℝ) * r ^ q) *
      ∫ x, C x * vacuumWeight N (elementary (lam x)) ∂mu :=
```
<!-- END verbatim -->

## Scope and faithfulness

- **What Lean checks.** Every proof in the library [`lean/Core`](lean/Core) is checked
  by Lean's kernel on each build, and the [axiom audit](lean/scripts/Audit/AxiomAudit.lean)
  computes, for every declaration in the library and in [`lean/Frozen`](lean/Frozen),
  the axioms it depends on. Any `sorry`, any axiom other than `propext`,
  `Classical.choice` and `Quot.sound`, or any axiom declared in the project fails the
  build in CI. The one exception is the proof placeholder `by sorry` of a frozen
  statement that [`lean/frozen-manifest.json`](lean/frozen-manifest.json) registers as
  unproved; [`scripts/check_frozen_anchors.py`](scripts/check_frozen_anchors.py) checks
  that it is exactly that placeholder, that every frozen byte is unchanged, and that
  nothing else imports or uses an unproved statement.
- **What it does not.** For the frozen statements of Lemmas 3.1 and 3.2, Lean defines
  the transfer matrix and the centered trace of a piecewise-constant history; their
  proofs are in progress. Lean does not see the Hamiltonian, the Gauss sectors or the
  path measure of Paper A. In the supporting lemmas, facts the paper proves (form
  preservation of the propagators, the ODE estimate (3.3) and Gronwall, algebraic
  multiplicities and the eigenvalue count, the factorization of the centered trace,
  the Feynman–Kac and trace formulas, and every limit) enter as explicit hypotheses.
  They are not axioms, and they are not checked.
- **Faithfulness.** Compilation shows that the Lean statements are proved, not that
  they match the paper. Read the hypotheses against the paper:
  [docs/CORRESPONDENCE.md](docs/CORRESPONDENCE.md) maps them step by step, and
  [docs/ERRATA-AND-DEVIATIONS.md](docs/ERRATA-AND-DEVIATIONS.md) records how the Lean
  statements differ from the printed ones. The two frozen statements had two
  independent pre-approval statement audits each
  ([`docs/audits/pilot/`](docs/audits/pilot)); a result becomes `AUDITED` only after
  its frozen statement is proved and audited again, so none is yet.
- **Pinned source.** `lean/status.json` pins the Paper A LaTeX files by SHA-256. If
  Paper A changes, CI fails until the manifest has been rechecked against the new text.
- **Numerics.** The scripts in [`numerics/`](numerics) are diagnostics, not proof
  premises.

## Errata and deviations

[docs/ERRATA-AND-DEVIATIONS.md](docs/ERRATA-AND-DEVIATIONS.md) has the record; the
counts are in [At a glance](#at-a-glance). No erratum in Paper A has been found. The
deviations say how the Lean statements are narrower or more abstract than the printed
ones: the coefficient bound of Lemma 3.2 is stated for the finite autocorrelation of
elementary symmetric coefficients rather than for Fourier coefficients of a trace,
and for natural rather than integer `q`; the spectral pairing of Lemma 3.1 is stated
for eigenvectors rather than with algebraic multiplicities. The frozen statements of
Lemmas 3.1 and 3.2 are the printed lemmas for piecewise-constant histories (by author
ruling) and for any finite spatial index.

## How to verify

You need git, [elan](https://github.com/leanprover/elan) (it installs the Lean
version pinned in [`lean/lean-toolchain`](lean/lean-toolchain)) and Python 3.9 or
later. In a clone of this repository:

```bash
cd lean
lake exe cache get                      # download Mathlib's prebuilt files
lake build                              # Lean checks every proof
lake env lean scripts/Audit/AxiomAudit.lean   # axioms of every declaration; fails on sorry
cd ..
python3 -I scripts/check_frozen_anchors.py --root lean --manifest lean/frozen-manifest.json --allow-non-module
python3 -I scripts/update_readme.py --check
```

`lake build` reports a `sorry` only as a warning; the audit is what rules it out,
admitting only the registered placeholders of frozen, unproved statements. The
frozen-anchor check compares every frozen file with its manifest hashes. The last
command checks [`lean/status.json`](lean/status.json) against the audit report
and the pinned Paper A sources, and checks that every generated number in this README
is current. `lake env lean scripts/PrintAxioms.lean` prints `#print axioms` for each
supporting lemma; each reports exactly `propext`, `Classical.choice` and `Quot.sound`
or a subset of them. CI runs all of this on every push
([build workflow](.github/workflows/build.yml)). The
[comparator workflow](.github/workflows/comparator.yml) is a stub until a Paper A
result has a proved Lean statement to restate; see
[`lean/Audit/README.md`](lean/Audit/README.md).

To rebuild a paper, run `pdflatex main.tex` three times in its folder (or the
folder's `build.ps1`, which does the same with MiKTeX). No BibTeX or shell escape is
needed.

## Repository layout

- [`paper-a/`](paper-a), [`paper-b/`](paper-b), [`companion-notes/`](companion-notes):
  the three drafts, with LaTeX sources and PDFs.
- [`lean/`](lean): the Lean library `Core` (with the frozen Paper A definitions in
  [`lean/Core/PaperA/Defs/`](lean/Core/PaperA/Defs)), the frozen statements in
  [`lean/Frozen/`](lean/Frozen) and their manifest
  [`lean/frozen-manifest.json`](lean/frozen-manifest.json), the audit scripts, the
  comparator stub [`lean/Audit/`](lean/Audit), and the status manifest
  [`lean/status.json`](lean/status.json).
- [`numerics/`](numerics): numerical diagnostics and their captured output.
- [`figures/`](figures): the system figure, with its TikZ and Python sources.
- [`drafts/`](drafts): the earlier consolidated 64-page draft and the original research
  memorandum, unchanged.
- [`docs/`](docs): the correspondence, [decisions](docs/DECISIONS.md), errata and
  deviations, the current research report, the arXiv preparation notes and an unsent
  specialist-review request. [`docs/audits/`](docs/audits) has the internal audit
  reports; [`docs/history/`](docs/history) has the research-round reports and handoffs,
  the retired packaging scripts, package manifests and the retired Lean 4.19 setup,
  with a [table of file moves](docs/history/MOVES.md) from the pre-repository layout.
- [`scripts/update_readme.py`](scripts/update_readme.py): generates the numbers and the
  progress chart in this README;
  [`scripts/check_frozen_anchors.py`](scripts/check_frozen_anchors.py): checks the
  frozen statements against their manifest.
- [`docs/PROGRESS.md`](docs/PROGRESS.md): the state of the current formalization
  campaign and its open decisions.
- [`docs/graph/`](docs/graph): the source dependency graph of the frozen statements of
  Lemmas 3.1 and 3.2 (every proof step, and every place where the paper skips one, marked
  `SOURCE_GAP`), checked by [`scripts/proof_depgraph.py`](scripts/proof_depgraph.py).

## How this was made

Significant parts of the research, the proof drafts, the exposition and the internal
checking were produced with generative-AI tools; the papers carry the research-tool
credit **Opus 5.5 + Astra 6** and a tool-use disclosure. Early work on the research
memorandum in [`drafts/memorandum/`](drafts/memorandum) and the numerical scripts named
`claude_*` was done in Claude (Anthropic) sessions, which handed the project to Codex
(OpenAI) on 27 October 2026 ([handoff](docs/history/CODEX_HANDOFF.md)). Codex sessions
carried out the later research rounds, split the work into the three papers, and wrote
the original Lean project on Lean 4.19.0. Claude Opus 5.5, in Claude Code, turned the
folder into this repository: the layout, the migration to Lean v4.35.0 and Mathlib
v4.35.0, the CI, the status manifest, the README generator and this README.

Internal AI-assisted audits ([docs/audits/](docs/audits)) are not peer review, and no
specialist has reviewed the papers. No claim of priority is made.

## License

The code in this repository (the Lean library and scripts in [`lean/`](lean), the
scripts in [`scripts/`](scripts) and [`numerics/`](numerics), and the CI workflows) is
released under the [Apache License 2.0](LICENSE). The papers, their LaTeX sources, the
figures and the documentation are not covered by that license; no license has been
granted for them yet. Mathlib and the other dependencies keep their own licenses.
