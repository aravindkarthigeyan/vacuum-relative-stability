/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.DiracOperator
import Mathlib.Analysis.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Tactic.Module

/-! The norm bound of Paper A, (2.5): graph node `eq:mass-bound#norm-bound`.

For `T_j` with `T_jᴴ T_j = 1` (node `eq:mass-bound#shift-unitary`, proved for the lattice shift in
`Core.PaperA.Wilson.Shift`), Hermitian `α_j`, `β` squaring to `1`, `a > 0`, `m ≥ 0`, `r ≥ 0`, and
`s = ±1`, the matrix `h_* • 1 + s • h_W` is positive semidefinite, where `h_* = m + (3 + 6r)/a`
and `h_W = Σ_j v_j ⊗ α_j + M ⊗ β` with `v_j = (2 i a)⁻¹ (T_j - T_jᴴ)` and
`M = m + (r/2a) Σ_j (2 - T_j - T_jᴴ)` (`posSemidef_bound_add_smul_diracOperator`).

The proof is a sum-of-squares decomposition, with no norms: for every `W` with `Wᴴ W = 1`,
`2 + s (W + Wᴴ) = (1 + s W)ᴴ (1 + s W) ⪰ 0`. This is applied to
* `W = -i (T_j ⊗ α_j)`, with `v_j ⊗ α_j = (1/2a) (W + Wᴴ)` (`posSemidef_hopping`);
* `W = 1 ⊗ β`, for the constant part `m β` of `M ⊗ β` (`posSemidef_mass_const`);
* `W = 1 ⊗ β` and `W = T_j ⊗ β` (with the opposite sign), for the Wilson term
  `(2 - T_j - T_jᴴ) ⊗ β` (`posSemidef_wilson_term`).
Summing with the weights `1/2a`, `m/2` and `r/2a` gives `h_* • 1 + s • h_W`. The anticommutation
relations of `α`, `β` are not needed.
-/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

section Kronecker

variable {l m n p : Type*}

/-- The Kronecker product is additive in its left factor: subtraction. -/
theorem matrix_sub_kronecker (A₁ A₂ : Matrix l m ℂ) (B : Matrix n p ℂ) :
    (A₁ - A₂) ⊗ₖ B = A₁ ⊗ₖ B - A₂ ⊗ₖ B := by
  ext ⟨i, i'⟩ ⟨j, j'⟩
  simp [sub_mul]

end Kronecker

/-- `(2 i a)⁻¹ = -i · (1 / 2a)`. -/
theorem inv_two_mul_I_mul_ofReal (a : ℝ) :
    (2 * Complex.I * (a : ℂ))⁻¹ = -Complex.I * ((1 / (2 * a) : ℝ) : ℂ) := by
  rw [mul_inv, mul_inv, Complex.inv_I]
  push_cast
  ring

section Bound

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- If `Wᴴ W = 1`, then `2 + (W + Wᴴ) = (1 + W)ᴴ (1 + W)` is positive semidefinite. -/
theorem posSemidef_two_smul_one_add_self_add_conjTranspose (W : Matrix ι ι ℂ)
    (hW : Wᴴ * W = 1) : ((2 : ℂ) • (1 : Matrix ι ι ℂ) + (W + Wᴴ)).PosSemidef := by
  have h : (2 : ℂ) • (1 : Matrix ι ι ℂ) + (W + Wᴴ) = (1 + W)ᴴ * (1 + W) := by
    rw [conjTranspose_add, conjTranspose_one, add_mul, mul_add, mul_add, hW]
    simp only [one_mul, mul_one, two_smul]
    abel
  rw [h]
  exact posSemidef_conjTranspose_mul_self _

/-- If `Wᴴ W = 1` and `s² = 1` (`s` real), then `2 + s (W + Wᴴ) ⪰ 0`. -/
theorem posSemidef_two_smul_one_add_real_smul (W : Matrix ι ι ℂ) (hW : Wᴴ * W = 1) (s : ℝ)
    (hs : s * s = 1) : ((2 : ℂ) • (1 : Matrix ι ι ℂ) + (s : ℂ) • (W + Wᴴ)).PosSemidef := by
  have hst : star (s : ℂ) = s := Complex.conj_ofReal s
  have h1 : ((s : ℂ) • W)ᴴ * ((s : ℂ) • W) = 1 := by
    rw [conjTranspose_smul, hst, smul_mul_smul_comm, hW, ← Complex.ofReal_mul, hs,
      Complex.ofReal_one, one_smul]
  have h2 := posSemidef_two_smul_one_add_self_add_conjTranspose _ h1
  rwa [conjTranspose_smul, hst, ← smul_add] at h2

/-- Hopping term: `(1/a) • 1 + s • (v ⊗ α) ⪰ 0` for `v = (2 i a)⁻¹ (T - Tᴴ)`, `Tᴴ T = 1`, `α`
a Hermitian involution, `a > 0` and `s² = 1`; that is, `‖v ⊗ α‖ ≤ 1/a`. -/
theorem posSemidef_hopping (A : Matrix (Fin 4) (Fin 4) ℂ) (hA : A.IsHermitian)
    (hA_sq : A * A = 1) (a : ℝ) (ha : 0 < a) (T : Matrix ι ι ℂ) (hT : Tᴴ * T = 1) (s : ℝ)
    (hs : s * s = 1) :
    (((1 / a : ℝ) : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) +
      (s : ℂ) • (((2 * Complex.I * (a : ℂ))⁻¹ • (T - Tᴴ)) ⊗ₖ A)).PosSemidef := by
  set W : Matrix (ι × Fin 4) (ι × Fin 4) ℂ := (-Complex.I) • (T ⊗ₖ A) with hW
  have hWh : Wᴴ = Complex.I • (Tᴴ ⊗ₖ A) := by
    rw [hW, conjTranspose_smul, conjTranspose_kronecker, hA.eq, star_neg, Complex.star_def,
      Complex.conj_I, neg_neg]
  have hWW : Wᴴ * W = 1 := by
    rw [hWh, hW, smul_mul_smul_comm, ← mul_kronecker_mul, hT, hA_sq, one_kronecker_one]
    simp
  have hc : (0 : ℂ) ≤ ((1 / (2 * a) : ℝ) : ℂ) := Complex.zero_le_real.mpr (by positivity)
  have hP := (posSemidef_two_smul_one_add_real_smul W hWW s hs).smul hc
  have h1a : ((1 / a : ℝ) : ℂ) = 2 * ((1 / (2 * a) : ℝ) : ℂ) := by
    push_cast
    ring
  convert hP using 1
  rw [hWh, hW, h1a, inv_two_mul_I_mul_ofReal, smul_kronecker, matrix_sub_kronecker]
  module

/-- Constant part of the mass term: `m • 1 + s • (m • (1 ⊗ β)) ⪰ 0` for `m ≥ 0`, `β` a
Hermitian involution and `s² = 1`. -/
theorem posSemidef_mass_const (β : Matrix (Fin 4) (Fin 4) ℂ) (hβ : β.IsHermitian)
    (hβ_sq : β * β = 1) (m : ℝ) (hm : 0 ≤ m) (s : ℝ) (hs : s * s = 1) :
    ((m : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) +
      (s : ℂ) • ((m : ℂ) • ((1 : Matrix ι ι ℂ) ⊗ₖ β))).PosSemidef := by
  have hBh : ((1 : Matrix ι ι ℂ) ⊗ₖ β)ᴴ = (1 : Matrix ι ι ℂ) ⊗ₖ β := by
    rw [conjTranspose_kronecker, conjTranspose_one, hβ.eq]
  have hBB : ((1 : Matrix ι ι ℂ) ⊗ₖ β)ᴴ * ((1 : Matrix ι ι ℂ) ⊗ₖ β) = 1 := by
    rw [hBh, ← mul_kronecker_mul, one_mul, hβ_sq, one_kronecker_one]
  have hc : (0 : ℂ) ≤ ((m / 2 : ℝ) : ℂ) := Complex.zero_le_real.mpr (by positivity)
  have hP := (posSemidef_two_smul_one_add_real_smul _ hBB s hs).smul hc
  convert hP using 1
  rw [hBh]
  push_cast
  module

/-- Wilson term: `4 • 1 + s • ((2 - T - Tᴴ) ⊗ β) ⪰ 0` for `Tᴴ T = 1`, `β` a Hermitian
involution and `s² = 1`. -/
theorem posSemidef_wilson_term (β : Matrix (Fin 4) (Fin 4) ℂ) (hβ : β.IsHermitian)
    (hβ_sq : β * β = 1) (T : Matrix ι ι ℂ) (hT : Tᴴ * T = 1) (s : ℝ) (hs : s * s = 1) :
    ((4 : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) +
      (s : ℂ) • (((2 : ℂ) • 1 - T - Tᴴ) ⊗ₖ β)).PosSemidef := by
  have hBh : ((1 : Matrix ι ι ℂ) ⊗ₖ β)ᴴ = (1 : Matrix ι ι ℂ) ⊗ₖ β := by
    rw [conjTranspose_kronecker, conjTranspose_one, hβ.eq]
  have hBB : ((1 : Matrix ι ι ℂ) ⊗ₖ β)ᴴ * ((1 : Matrix ι ι ℂ) ⊗ₖ β) = 1 := by
    rw [hBh, ← mul_kronecker_mul, one_mul, hβ_sq, one_kronecker_one]
  have hTh : (T ⊗ₖ β)ᴴ = Tᴴ ⊗ₖ β := by
    rw [conjTranspose_kronecker, hβ.eq]
  have hTT : (T ⊗ₖ β)ᴴ * (T ⊗ₖ β) = 1 := by
    rw [hTh, ← mul_kronecker_mul, hT, hβ_sq, one_kronecker_one]
  have hs' : (-s) * (-s) = 1 := by rw [neg_mul_neg, hs]
  have hP := (posSemidef_two_smul_one_add_real_smul _ hBB s hs).add
    (posSemidef_two_smul_one_add_real_smul _ hTT (-s) hs')
  convert hP using 1
  rw [hBh, hTh, matrix_sub_kronecker, matrix_sub_kronecker, smul_kronecker]
  push_cast
  module

/-- Graph node `eq:mass-bound#norm-bound`, for any `T_j` with `T_jᴴ T_j = 1` and `s² = 1`:
`(m + (3 + 6r)/a) • 1 + s • h ⪰ 0` for `h = Σ_j v_j ⊗ α_j + M ⊗ β`, `v_j = (2 i a)⁻¹ (T_j - T_jᴴ)`
and `M = m + (r/2a) Σ_j (2 - T_j - T_jᴴ)`. -/
theorem posSemidef_bound_add_smul_diracOperator
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (a m r : ℝ) (ha : 0 < a) (hm : 0 ≤ m) (hr : 0 ≤ r)
    (T : Fin 3 → Matrix ι ι ℂ) (hT : ∀ j, (T j)ᴴ * T j = 1)
    (v : Fin 3 → Matrix ι ι ℂ) (hv : ∀ j, v j = (2 * Complex.I * (a : ℂ))⁻¹ • (T j - (T j)ᴴ))
    (M : Matrix ι ι ℂ)
    (hM : M = (m : ℂ) • 1 + ((r / (2 * a) : ℝ) : ℂ) • ∑ j, ((2 : ℂ) • 1 - T j - (T j)ᴴ))
    (s : ℝ) (hs : s * s = 1) :
    (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 + (s : ℂ) • diracOperator α β v M).PosSemidef := by
  have hX : ∀ j, (((1 / a : ℝ) : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) +
      (s : ℂ) • (v j ⊗ₖ α j)).PosSemidef := by
    intro j
    rw [hv j]
    exact posSemidef_hopping (α j) (hα_herm j) (hα_sq j) a ha (T j) (hT j) s hs
  have hB := posSemidef_mass_const (ι := ι) β hβ_herm hβ_sq m hm s hs
  have hY : ∀ j, ((4 : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) +
      (s : ℂ) • (((2 : ℂ) • 1 - T j - (T j)ᴴ) ⊗ₖ β)).PosSemidef := fun j =>
    posSemidef_wilson_term β hβ_herm hβ_sq (T j) (hT j) s hs
  have hρ : (0 : ℂ) ≤ ((r / (2 * a) : ℝ) : ℂ) := Complex.zero_le_real.mpr (by positivity)
  have hP := ((posSemidef_sum Finset.univ fun j _ => hX j).add hB).add
    ((posSemidef_sum Finset.univ fun j _ => hY j).smul hρ)
  have hcst : ((m + (3 + 6 * r) / a : ℝ) : ℂ) =
      (m : ℂ) + 3 * ((1 / a : ℝ) : ℂ) + 12 * ((r / (2 * a) : ℝ) : ℂ) := by
    push_cast
    ring
  convert hP using 1
  subst hM
  rw [hcst]
  simp only [diracOperator, add_kronecker, smul_kronecker, Fin.sum_univ_three]
  module

end Bound

end QEDCore.PaperA
