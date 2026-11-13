/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

/-! Graph node `lem:transfer#form-preservation` (one step): if a generator `X` is
skew-adjoint with respect to the sesquilinear form of `C`, that is `Xᴴ C + C X = 0`, then the
step `U = exp (-X)` preserves that form, `Uᴴ C U = C`. No invertibility of `C` is needed. -/

namespace QEDCore.PaperA

open Matrix

attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

/-- Per-step form preservation: from `Xᴴ * C + C * X = 0` it follows that `U = exp (-X)`
satisfies `Uᴴ * C * U = C`. -/
theorem conjTranspose_exp_neg_mul_mul_exp_neg {n : Type*} [Fintype n] [DecidableEq n]
    {X C : Matrix n n ℂ} (h : Xᴴ * C + C * X = 0) :
    (NormedSpace.exp (-X))ᴴ * C * NormedSpace.exp (-X) = C := by
  have hs : SemiconjBy C (-X) Xᴴ := by
    rw [SemiconjBy, mul_neg, eq_comm]
    exact eq_neg_of_add_eq_zero_left h
  rw [← Matrix.exp_conjTranspose, conjTranspose_neg]
  exact hs.exp_neg_mul_mul_exp_eq_self

end QEDCore.PaperA
