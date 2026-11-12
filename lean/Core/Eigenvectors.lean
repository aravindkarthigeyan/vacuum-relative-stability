/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PseudoUnitary

namespace QEDCore
open Matrix

/-- Conditional eigenvector-level correspondence. This does not prove
algebraic multiplicities or the exact number of stable eigenvalues. -/
theorem inverse_eigenvector {n : ℕ} {U V : Matrix (Fin n) (Fin n) ℂ}
    {x : Fin n → ℂ} {lam : ℂ} (hVU : V * U = 1)
    (hx : U *ᵥ x = lam • x) (hlam : lam ≠ 0) :
    V *ᵥ x = lam⁻¹ • x := by
  have hh : x = lam • (V *ᵥ x) := by
    calc
      x = (V * U) *ᵥ x := by rw [hVU, one_mulVec]
      _ = V *ᵥ (U *ᵥ x) := (mulVec_mulVec x V U).symm
      _ = lam • (V *ᵥ x) := by rw [hx, mulVec_smul]
  calc
    V *ᵥ x = lam⁻¹ • (lam • (V *ᵥ x)) := by simp [smul_smul, hlam]
    _ = lam⁻¹ • x := by rw [← hh]

theorem involution_mulVec_ne_zero {n : ℕ} {C : Matrix (Fin n) (Fin n) ℂ}
    {x : Fin n → ℂ} (hC : C * C = 1) (hx : x ≠ 0) : C *ᵥ x ≠ 0 := by
  intro hz
  apply hx
  calc
    x = (C * C) *ᵥ x := by rw [hC, one_mulVec]
    _ = C *ᵥ (C *ᵥ x) := (mulVec_mulVec x C C).symm
    _ = 0 := by rw [hz, mulVec_zero]

theorem adjoint_inverse_eigenvector {n : ℕ}
    {C U V : Matrix (Fin n) (Fin n) ℂ} {x : Fin n → ℂ} {lam : ℂ}
    (hC : C * C = 1) (hUV : U * V = 1) (hVU : V * U = 1)
    (hform : PreservesForm C U) (hx : U *ᵥ x = lam • x) (hlam : lam ≠ 0) :
    star U *ᵥ (C *ᵥ x) = lam⁻¹ • (C *ᵥ x) := by
  rw [adjoint_eq_conjugate_inverse hC hUV hform]
  calc
    (C * V * C) *ᵥ (C *ᵥ x) = (C * V) *ᵥ x := by
      simp only [mulVec_mulVec, mul_assoc, hC, mul_one]
    _ = C *ᵥ (V *ᵥ x) := (mulVec_mulVec x C V).symm
    _ = lam⁻¹ • (C *ᵥ x) := by rw [inverse_eigenvector hVU hx hlam, mulVec_smul]

end QEDCore
