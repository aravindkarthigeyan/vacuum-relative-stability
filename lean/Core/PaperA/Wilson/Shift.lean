/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Mathlib.Analysis.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.PosDef

/-! Lattice shift, Wilson hopping and Wilson mass: elementary matrix facts for Paper A.

* `eq:mass-bound#shift-unitary`: for unimodular links the shift `T_j(U)` is unitary
  (`latticeShift_conjTranspose_mul_self`, `latticeShift_mul_conjTranspose_self`).
* `thm:main#wilson-hopping-hermitian`: the Wilson hopping matrix is Hermitian for every real `a`
  and every link configuration (`isHermitian_wilsonHopping`).
* `eq:mass-bound#mass-lower-bound`: `M(U) - m ≥ 0`, i.e. `M(U) ≥ m I`
  (`posSemidef_wilsonMass_sub`).
-/

namespace QEDCore.PaperA

open Matrix
open scoped ComplexOrder

variable {n : ℕ} [NeZero n]

/-- Graph node `eq:mass-bound#shift-unitary`. -/
theorem latticeShift_conjTranspose_mul_self (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (hU : ∀ x j, ‖U x j‖ = 1) (j : Fin 3) :
    (latticeShift n U j)ᴴ * latticeShift n U j = 1 := by
  ext x y
  rw [Matrix.mul_apply]
  have h : ∀ z, (latticeShift n U j)ᴴ x z * latticeShift n U j z y
      = if z = x - Pi.single j 1 then (if x = y then 1 else 0) else 0 := by
    intro z
    by_cases hz : z = x - Pi.single j 1
    · have hx : x = z + Pi.single j 1 := by rw [hz]; abel
      simp only [hz, ite_true]
      rw [← hz]
      by_cases hxy : x = y
      · subst hxy
        have : (starRingEnd ℂ) (U z j) * U z j = 1 := by
          rw [Complex.conj_mul', hU]; simp
        simp [latticeShift, Matrix.conjTranspose_apply, ← hx, this, mul_comm (U z j)]
      · have hy : y ≠ z + Pi.single j 1 := fun h => hxy (hx.trans h.symm)
        simp [latticeShift, hy, hxy]
    · have : x ≠ z + Pi.single j 1 := fun h => hz (eq_sub_of_add_eq h.symm)
      simp [latticeShift, Matrix.conjTranspose_apply, this, hz]
  simp_rw [h, Finset.sum_ite_eq', Finset.mem_univ, ite_true]
  by_cases hxy : x = y <;> simp [hxy, Matrix.one_apply]

/-- Graph node `eq:mass-bound#shift-unitary`. -/
theorem latticeShift_mul_conjTranspose_self (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (hU : ∀ x j, ‖U x j‖ = 1) (j : Fin 3) :
    latticeShift n U j * (latticeShift n U j)ᴴ = 1 := by
  ext x y
  rw [Matrix.mul_apply]
  have h : ∀ z, latticeShift n U j x z * (latticeShift n U j)ᴴ z y
      = if z = x + Pi.single j 1 then (if x = y then 1 else 0) else 0 := by
    intro z
    by_cases hz : z = x + Pi.single j 1
    · simp only [hz, ite_true]
      by_cases hxy : x = y
      · subst hxy
        have : (starRingEnd ℂ) (U x j) * U x j = 1 := by
          rw [Complex.conj_mul', hU]; simp
        simp [latticeShift, Matrix.conjTranspose_apply, this]
      · have hy : y + Pi.single j 1 ≠ x + Pi.single j 1 := fun h =>
          hxy (add_right_cancel h).symm
        simp [latticeShift, Matrix.conjTranspose_apply, hxy]
    · simp [latticeShift, hz]
  simp_rw [h, Finset.sum_ite_eq', Finset.mem_univ, ite_true]
  by_cases hxy : x = y <;> simp [hxy, Matrix.one_apply]

omit [NeZero n] in
/-- Graph node `thm:main#wilson-hopping-hermitian` (any real `a`, any `U`). -/
theorem isHermitian_wilsonHopping (a : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (j : Fin 3) :
    (wilsonHopping n a U j).IsHermitian := by
  unfold wilsonHopping Matrix.IsHermitian
  rw [Matrix.conjTranspose_smul, Matrix.conjTranspose_sub, Matrix.conjTranspose_conjTranspose]
  have hc : star ((2 * Complex.I * (a : ℂ))⁻¹) = -(2 * Complex.I * (a : ℂ))⁻¹ := by
    rw [star_inv₀]
    simp [Complex.conj_ofReal, inv_neg, mul_assoc]
  rw [hc, neg_smul, ← smul_neg, neg_sub]

/-- For a unitary-like shift, `2 - T - Tᴴ = (1 - T)ᴴ (1 - T)`. -/
private theorem two_sub_eq (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (hU : ∀ x j, ‖U x j‖ = 1) (j : Fin 3) :
    ((2 : ℂ) • 1 - latticeShift n U j - (latticeShift n U j)ᴴ
      : Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ)
      = (1 - latticeShift n U j)ᴴ * (1 - latticeShift n U j) := by
  have h := latticeShift_conjTranspose_mul_self U hU j
  rw [Matrix.conjTranspose_sub, Matrix.conjTranspose_one, sub_mul, mul_sub, mul_sub, h]
  simp only [Matrix.mul_one, Matrix.one_mul, two_smul]
  abel

/-- Graph node `eq:mass-bound#mass-lower-bound`: `M(U) ≥ m I`. -/
theorem posSemidef_wilsonMass_sub (a m r : ℝ) (ha : 0 < a) (hr : 0 ≤ r)
    (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (hU : ∀ x j, ‖U x j‖ = 1) :
    (wilsonMass n a m r U - (m : ℂ) • 1).PosSemidef := by
  unfold wilsonMass
  rw [add_sub_cancel_left]
  have hc : (0 : ℂ) ≤ ((r / (2 * a) : ℝ) : ℂ) :=
    Complex.zero_le_real.mpr (div_nonneg hr (by positivity))
  refine Matrix.PosSemidef.smul ?_ hc
  refine Matrix.posSemidef_sum _ fun j _ => ?_
  rw [two_sub_eq U hU j]
  exact Matrix.posSemidef_conjTranspose_mul_self _

end QEDCore.PaperA
