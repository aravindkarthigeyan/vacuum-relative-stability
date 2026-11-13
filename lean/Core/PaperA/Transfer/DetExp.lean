/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Analysis.Matrix.Spectrum
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.Analysis.SpecialFunctions.Exponential

/-! Graph node `lem:transfer#liouville` (one step): Liouville's formula
`det (exp X) = exp (tr X)` for the step generators `X = c • H` with `H` Hermitian. The proof
diagonalizes `H` by the spectral theorem, `H = U D U⁻¹` with `U` unitary and `D` diagonal, so that
`exp (c • H) = U exp (c • D) U⁻¹` and both sides reduce to `∏ᵢ exp (c λᵢ) = exp (c ∑ᵢ λᵢ)`. -/

namespace QEDCore.PaperA

open Matrix

/-- Liouville's formula for scalar multiples of Hermitian matrices:
`det (exp (c • H)) = exp (c * tr H)`. -/
theorem det_exp_smul_of_isHermitian {n : Type*} [Fintype n] [DecidableEq n]
    {H : Matrix n n ℂ} (hH : H.IsHermitian) (c : ℂ) :
    (NormedSpace.exp (c • H)).det = Complex.exp (c * H.trace) := by
  set U : Matrix n n ℂ := (hH.eigenvectorUnitary : Matrix n n ℂ) with hUdef
  have hUU : star U * U = 1 := Unitary.star_mul_self_of_mem hH.eigenvectorUnitary.2
  have hUinv : U⁻¹ = star U := Matrix.inv_eq_left_inv hUU
  have hUunit : IsUnit U :=
    ⟨⟨U, star U, Unitary.mul_star_self_of_mem hH.eigenvectorUnitary.2, hUU⟩, rfl⟩
  have hspec : H = U * diagonal (fun i => (hH.eigenvalues i : ℂ)) * U⁻¹ := by
    rw [hUinv]
    conv_lhs => rw [hH.spectral_theorem]
    rw [Unitary.conjStarAlgAut_apply]
    rfl
  have hcH : c • H = U * diagonal (fun i => c * (hH.eigenvalues i : ℂ)) * U⁻¹ := by
    conv_lhs => rw [hspec]
    rw [← Matrix.smul_mul, ← Matrix.mul_smul, ← diagonal_smul]
    rfl
  rw [hcH, Matrix.exp_conj _ _ hUunit, Matrix.exp_diagonal, Matrix.det_conj hUunit, det_diagonal,
    hH.trace_eq_sum_eigenvalues, Finset.mul_sum, Complex.exp_sum, Complex.exp_eq_exp_ℂ]
  simp

end QEDCore.PaperA
