/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.Coefficients
import Core.PositiveMeasure

namespace QEDCore
open MeasureTheory

/-- A fully derived finite coefficient estimate after a positive prefactor
and a unit-modulus canonical projection phase have been supplied. -/
theorem scaled_coefficient_comparison {N q : ℕ} (lam : Fin N → ℂ)
    {r C : ℝ} {phase : ℂ} (hr0 : 0 ≤ r) (hr1 : r ≤ 1)
    (hlam : ∀ i, ‖lam i‖ ≤ r) (hC : 0 ≤ C) (hp : ‖phase‖ = 1) :
    ‖phase * (C : ℂ) * correlation N q (elementary lam)‖ ≤
      (((N + N).choose (N + q) : ℝ) * r ^ q) *
      (C * vacuumWeight N (elementary lam)) := by
  rw [norm_mul, norm_mul, hp, one_mul, Complex.norm_real, Real.norm_eq_abs,
    abs_of_nonneg hC]
  calc
    C * ‖correlation N q (elementary lam)‖ ≤
        C * ((((N + N).choose (N + q) : ℝ) * r ^ q) *
          vacuumWeight N (elementary lam)) :=
      mul_le_mul_of_nonneg_left (relative_correlation_bound lam hr0 hr1 hlam) hC
    _ = _ := by ring

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
      ∫ x, C x * vacuumWeight N (elementary (lam x)) ∂mu := by
  apply positive_measure_comparison mu _ _ _ hf hw
  exact Filter.Eventually.of_forall (fun x =>
    scaled_coefficient_comparison (lam x) hr0 hr1 (hlam x) (hC x) (hp x))

end QEDCore
