/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.LinearAlgebra.Matrix.Charpoly.Coeff
import Mathlib.Analysis.Complex.Polynomial.Basic
import Core.PseudoUnitary

/-! Graph nodes `lem:transfer#inverse-adjoint` and `lem:transfer#spectral-pairing` (Paper A,
transfer.tex L42-L43), plus the root facts used by `lem:transfer#eigenvalue-count`.

If `U * V = 1`, `C * C = 1` and `Uᴴ * C * U = C`, then `Uᴴ = C * V * C` is similar to
`V = U⁻¹`. The source asserts that the eigenvalues of `U`, counted with algebraic multiplicity,
are paired under `z ↦ (star z)⁻¹` without the characteristic-polynomial argument; it is supplied
here. The characteristic polynomial of `Uᴴ` has the conjugated coefficients of that of `U`, so
its roots are the conjugates of the roots of `U`; the characteristic polynomial of `U⁻¹` is a
nonzero constant times the reverse of that of `U`, so its roots are the inverses. Hence the
multiset of roots `R` of the characteristic polynomial of `U` satisfies
`R.map star = R.map (·⁻¹)`, which is the pairing. -/

namespace QEDCore.PaperA

open Matrix Polynomial

variable {n : Type*} [Fintype n] [DecidableEq n]

/-! ### Polynomial helpers -/

private lemma reverse_X_sub_C (μ : ℂ) : (X - C μ : ℂ[X]).reverse = 1 - C μ * X := by
  have h : (X - C μ : ℂ[X]) = X + C (-μ) := by simp [sub_eq_add_neg]
  rw [h, Polynomial.reverse_add_C]
  have : (X : ℂ[X]).reverse = 1 := by simp [Polynomial.reverse]
  rw [this, natDegree_X, pow_one, map_neg]
  ring

private lemma reverse_prod (s : Multiset ℂ) :
    ((s.map fun μ => (X - C μ : ℂ[X])).prod).reverse
      = (s.map fun μ => (1 - C μ * X : ℂ[X])).prod := by
  induction s using Multiset.induction_on with
  | empty => simpa using Polynomial.reverse_C (1 : ℂ)
  | cons a s ih =>
    simp only [Multiset.map_cons, Multiset.prod_cons]
    rw [Polynomial.reverse_mul_of_domain, ih, reverse_X_sub_C]

private lemma one_sub_C_mul_X {μ : ℂ} (hμ : μ ≠ 0) :
    (1 - C μ * X : ℂ[X]) = C (-μ) * (X - C μ⁻¹) := by
  have h : C (-μ) * C μ⁻¹ = (-1 : ℂ[X]) := by
    rw [← C_mul, neg_mul, mul_inv_cancel₀ hμ, C_neg, C_1]
  rw [mul_sub, h, C_neg]
  ring

private lemma prod_one_sub_C_mul_X {s : Multiset ℂ} (hs : (0 : ℂ) ∉ s) :
    (s.map fun μ => (1 - C μ * X : ℂ[X])).prod
      = C ((s.map fun μ => -μ).prod) * ((s.map (·⁻¹)).map fun μ => (X - C μ : ℂ[X])).prod := by
  induction s using Multiset.induction_on with
  | empty => simp
  | cons a s ih =>
    have ha : a ≠ 0 := fun h => hs (h ▸ Multiset.mem_cons_self a s)
    have hs' : (0 : ℂ) ∉ s := fun h => hs (Multiset.mem_cons_of_mem h)
    simp only [Multiset.map_cons, Multiset.prod_cons]
    rw [ih hs', one_sub_C_mul_X ha, C_mul]
    ring

/-- The roots of the reverse of a product of linear factors with nonzero roots are the inverses
of those roots, with multiplicity. -/
private lemma roots_reverse_prod {s : Multiset ℂ} (hs : (0 : ℂ) ∉ s) :
    ((s.map fun μ => (X - C μ : ℂ[X])).prod).reverse.roots = s.map (·⁻¹) := by
  have hne : (s.map fun μ => -μ).prod ≠ 0 := by
    refine Multiset.prod_ne_zero ?_
    rw [Multiset.mem_map]
    rintro ⟨μ, hμ, h⟩
    exact hs (neg_eq_zero.mp h ▸ hμ)
  rw [reverse_prod, prod_one_sub_C_mul_X hs, roots_C_mul _ hne,
    Polynomial.roots_multiset_prod_X_sub_C]

/-! ### Characteristic polynomials -/

private lemma prod_roots_charpoly (U : Matrix n n ℂ) :
    (U.charpoly.roots.map fun μ => (X - C μ : ℂ[X])).prod = U.charpoly :=
  Polynomial.prod_multiset_X_sub_C_of_monic_of_roots_card_eq U.charpoly_monic
    (Polynomial.splits_iff_card_roots.mp (IsAlgClosed.splits (U.charpoly : ℂ[X])))

/-- The characteristic polynomial of a complex matrix has `Fintype.card n` roots counted with
multiplicity. -/
theorem card_charpoly_roots (U : Matrix n n ℂ) :
    Multiset.card U.charpoly.roots = Fintype.card n := by
  rw [Polynomial.splits_iff_card_roots.mp (IsAlgClosed.splits (U.charpoly : ℂ[X])),
    Matrix.charpoly_natDegree_eq_dim]

/-- An invertible matrix does not have `0` as a root of its characteristic polynomial. -/
theorem zero_not_mem_charpoly_roots {U V : Matrix n n ℂ} (hUV : U * V = 1) :
    (0 : ℂ) ∉ U.charpoly.roots := by
  intro h
  have hroot : U.charpoly.IsRoot 0 := Polynomial.isRoot_of_mem_roots h
  have hdet : U.det = 0 := by
    rw [Matrix.det_eq_sign_charpoly_coeff, Polynomial.coeff_zero_eq_eval_zero, hroot.eq_zero,
      mul_zero]
  exact Matrix.det_ne_zero_of_right_inverse hUV hdet

/-- Every root of the characteristic polynomial is an eigenvalue: it has an eigenvector. -/
theorem exists_eigenvector_of_mem_charpoly_roots {U : Matrix n n ℂ} {z : ℂ}
    (hz : z ∈ U.charpoly.roots) : ∃ v : n → ℂ, v ≠ 0 ∧ U *ᵥ v = z • v := by
  have h : U.charpoly.IsRoot z := Polynomial.isRoot_of_mem_roots hz
  have h1 : ((scalar n) z - U).det = 0 := by rw [← Matrix.eval_charpoly]; exact h
  obtain ⟨v, hv, hv0⟩ := Matrix.exists_mulVec_eq_zero_iff.mpr h1
  refine ⟨v, hv, ?_⟩
  rw [Matrix.sub_mulVec] at hv0
  simpa [Matrix.scalar_apply, Matrix.smul_eq_diagonal_mul, sub_eq_zero, eq_comm] using hv0

/-- The roots of the reverse characteristic polynomial are the inverses of the eigenvalues. -/
private lemma roots_charpolyRev {U : Matrix n n ℂ} (h0 : (0 : ℂ) ∉ U.charpoly.roots) :
    U.charpolyRev.roots = U.charpoly.roots.map (·⁻¹) := by
  have h := roots_reverse_prod h0
  rw [prod_roots_charpoly, Matrix.reverse_charpoly] at h
  exact h

/-- The eigenvalues of a right inverse are the inverses of the eigenvalues, with multiplicity. -/
private lemma roots_charpoly_of_mul_eq_one {U V : Matrix n n ℂ} (hUV : U * V = 1) :
    V.charpoly.roots = U.charpoly.roots.map (·⁻¹) := by
  have hU : IsUnit U :=
    (Matrix.isUnit_iff_isUnit_det (A := U)).mpr (Matrix.isUnit_det_of_right_inverse hUV)
  have hV : V = U⁻¹ := (Matrix.inv_eq_right_inv hUV).symm
  have hdet : U.det ≠ 0 := Matrix.det_ne_zero_of_right_inverse hUV
  have hc : ((-1 : ℂ[X]) ^ Fintype.card n * C (Ring.inverse U.det))
      = C ((-1) ^ Fintype.card n * U.det⁻¹) := by
    rw [Ring.inverse_eq_inv, C_mul, C_pow, C_neg, C_1]
  have hne : ((-1 : ℂ) ^ Fintype.card n * U.det⁻¹) ≠ 0 :=
    mul_ne_zero (pow_ne_zero _ (neg_ne_zero.mpr one_ne_zero)) (inv_ne_zero hdet)
  rw [hV, Matrix.charpoly_inv U hU, hc, roots_C_mul _ hne,
    roots_charpolyRev (zero_not_mem_charpoly_roots hUV)]

/-- The characteristic polynomial of `Uᴴ` has the conjugated coefficients. -/
private lemma charpoly_conjTranspose (U : Matrix n n ℂ) :
    Uᴴ.charpoly = U.charpoly.map (starRingEnd ℂ) := by
  have h : Uᴴ = Uᵀ.map (starRingEnd ℂ) := by
    ext i j
    simp [Matrix.conjTranspose_apply]
  rw [h, Matrix.charpoly_map, Matrix.charpoly_transpose]

/-- The eigenvalues of `Uᴴ` are the conjugates of the eigenvalues of `U`, with multiplicity. -/
private lemma roots_charpoly_conjTranspose (U : Matrix n n ℂ) :
    Uᴴ.charpoly.roots = U.charpoly.roots.map star := by
  rw [charpoly_conjTranspose,
    (IsAlgClosed.splits (U.charpoly : ℂ[X])).roots_map_of_injective (starRingEnd ℂ).injective]
  rfl

/-! ### Inverse-adjoint and spectral pairing -/

/-- Graph node `lem:transfer#inverse-adjoint`: a form-preserving matrix with right inverse `V`
for an involution `C` satisfies `Uᴴ = C * V * C`. -/
theorem conjTranspose_eq_conj_inverse {U C V : Matrix n n ℂ}
    (hUV : U * V = 1) (hC : C * C = 1) (hform : Uᴴ * C * U = C) :
    Uᴴ = C * V * C :=
  QEDCore.adjoint_eq_conjugate_inverse (A := Matrix n n ℂ) hC hUV hform

/-- Graph node `lem:transfer#spectral-pairing`: the roots of the characteristic polynomial of a
`C`-form-preserving invertible matrix, counted with algebraic multiplicity, form a multiset
invariant under `z ↦ (star z)⁻¹`. -/
theorem charpoly_roots_map_star_inv {U C V : Matrix n n ℂ}
    (hUV : U * V = 1) (hC : C * C = 1) (hform : Uᴴ * C * U = C) :
    U.charpoly.roots.map (fun z => (star z)⁻¹) = U.charpoly.roots := by
  have hadj := conjTranspose_eq_conj_inverse hUV hC hform
  -- `Uᴴ = C * (V * C)` has the characteristic polynomial of `V * C * C = V`.
  have hcp : Uᴴ.charpoly = V.charpoly := by
    rw [hadj, mul_assoc, Matrix.charpoly_mul_comm, mul_assoc, hC, mul_one]
  have hstar : U.charpoly.roots.map star = U.charpoly.roots.map (·⁻¹) := by
    rw [← roots_charpoly_conjTranspose, hcp, roots_charpoly_of_mul_eq_one hUV]
  have hcomp : (fun z : ℂ => (star z)⁻¹) = (·⁻¹) ∘ star := rfl
  rw [hcomp, ← Multiset.map_map, hstar, Multiset.map_map]
  conv_rhs => rw [← Multiset.map_id U.charpoly.roots]
  refine Multiset.map_congr rfl fun z _ => ?_
  simp

end QEDCore.PaperA
