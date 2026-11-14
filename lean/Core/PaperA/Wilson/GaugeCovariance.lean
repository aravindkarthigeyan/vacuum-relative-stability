/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.DiracOperator
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Mathlib.Analysis.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.Kronecker

/-! Helper lemmas for the gauge covariance of the Wilson operator (Paper A, model.tex line 71).

Graph node `model:gauge-covariance#shift-covariance`: the gauge-transformed link shift is
`T_j(U^u) = D^* T_j(U) D` with `D = diag u` (`latticeShift_gauge`). Consequences used by the
provider: the same for the hopping `wilsonHopping` and the mass `wilsonMass` (the latter uses
`D^* D = 1`, which needs `‖u x‖ = 1`), and the Kronecker conjugation rule.
-/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker

section
variable {n : ℕ} [NeZero n]

theorem latticeShift_gauge (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (u : (Fin 3 → ZMod n) → ℂ)
    (j : Fin 3) :
    latticeShift n (fun x j => u x * U x j * star (u (x + Pi.single j 1))) j =
      (Matrix.diagonal u)ᴴ * latticeShift n U j * Matrix.diagonal u := by
  ext x y
  simp only [latticeShift, Matrix.of_apply, Matrix.diagonal_conjTranspose, Matrix.diagonal_mul,
    Matrix.mul_diagonal, Pi.star_apply]
  by_cases h : y = x + Pi.single j 1
  · subst h
    simp only [ite_true, star_mul', star_star]
  · simp [h]

private theorem diag_star_mul_diag {u : (Fin 3 → ZMod n) → ℂ} (hu : ∀ x, ‖u x‖ = 1) :
    (Matrix.diagonal u)ᴴ * Matrix.diagonal u = 1 := by
  rw [Matrix.diagonal_conjTranspose, Matrix.diagonal_mul_diagonal, ← Matrix.diagonal_one]
  congr 1
  funext x
  simp [Complex.conj_mul', hu x]

private theorem conj_conjTranspose (D T : Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ) :
    (Dᴴ * T * D)ᴴ = Dᴴ * Tᴴ * D := by
  simp [Matrix.conjTranspose_mul, Matrix.mul_assoc]

theorem wilsonHopping_gauge (a : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (u : (Fin 3 → ZMod n) → ℂ) (j : Fin 3) :
    wilsonHopping n a (fun x j => u x * U x j * star (u (x + Pi.single j 1))) j =
      (Matrix.diagonal u)ᴴ * wilsonHopping n a U j * Matrix.diagonal u := by
  unfold wilsonHopping
  rw [latticeShift_gauge, conj_conjTranspose, Matrix.mul_smul, Matrix.smul_mul]
  simp only [Matrix.mul_sub, Matrix.sub_mul]

theorem wilsonMass_gauge (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (u : (Fin 3 → ZMod n) → ℂ) (hu : ∀ x, ‖u x‖ = 1) :
    wilsonMass n a m r (fun x j => u x * U x j * star (u (x + Pi.single j 1))) =
      (Matrix.diagonal u)ᴴ * wilsonMass n a m r U * Matrix.diagonal u := by
  have h1 := diag_star_mul_diag (n := n) hu
  unfold wilsonMass
  simp only [latticeShift_gauge, conj_conjTranspose, Matrix.mul_add, Matrix.add_mul,
    Matrix.mul_smul, Matrix.smul_mul, Matrix.mul_sub, Matrix.sub_mul, Matrix.mul_one,
    Matrix.mul_sum, Matrix.sum_mul, h1]

end

theorem kronecker_conj_one {ι : Type*} [Fintype ι] [DecidableEq ι]
    (D v : Matrix ι ι ℂ) (α : Matrix (Fin 4) (Fin 4) ℂ) :
    (Dᴴ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) * (v ⊗ₖ α) * (D ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) =
      (Dᴴ * v * D) ⊗ₖ α := by
  rw [← Matrix.mul_kronecker_mul, ← Matrix.mul_kronecker_mul]
  simp

end QEDCore.PaperA
