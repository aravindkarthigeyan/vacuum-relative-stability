/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.DiracOperator
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Core.PaperA.Wilson.GaugeCovariance
import Mathlib.Analysis.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.Kronecker

/-!
# Provider for the gauge covariance of the Wilson operator (Paper A, model.tex line 71)

Proves `QEDCore.PaperA.Provider.wilson_gauge_covariance` (graph node `model:gauge-covariance`),
whose statement is exactly that of the frozen anchor `Frozen/PaperA/WilsonGaugeCovariance.lean`
(manifest entry `gauge_covariance_v1`). The anchor is sealed by replacing its `by sorry` with an
exact use of that theorem.

Proof: with `D = diag u`, the helpers of `Core.PaperA.Wilson.GaugeCovariance` give
`v_j(U^u) = D^* v_j(U) D` and `M(U^u) = D^* M(U) D` (using `‖u x‖ = 1` for the latter). Each
Kronecker summand is then conjugated by `D^* ⊗ 1`, `D ⊗ 1` via `kronecker_conj_one`, and the
finite sum and sum with the mass term pass through the matrix product.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`).
-/

namespace QEDCore.PaperA.Provider

open Matrix
open scoped Kronecker ComplexOrder

set_option linter.unusedVariables false in
theorem wilson_gauge_covariance
    {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (u : (Fin 3 → ZMod n) → ℂ) (hu : ∀ x, ‖u x‖ = 1) :
    diracOperator α β
        (wilsonHopping n a fun x j => u x * U x j * star (u (x + Pi.single j 1)))
        (wilsonMass n a m r fun x j => u x * U x j * star (u (x + Pi.single j 1))) =
      ((Matrix.diagonal u)ᴴ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) *
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U) *
        (Matrix.diagonal u ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) := by
  simp only [diracOperator, wilsonMass_gauge a m r U u hu, wilsonHopping_gauge a U u,
    Matrix.mul_add, Matrix.add_mul, Matrix.mul_sum, Matrix.sum_mul, kronecker_conj_one]

end QEDCore.PaperA.Provider
