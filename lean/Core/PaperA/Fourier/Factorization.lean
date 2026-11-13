/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Fourier.DetProd
import Core.PaperA.Fourier.FourierCoeff

/-! Graph nodes `lem:fourier#paired-factor`, `lem:fourier#factorization` (algebraic part), and
the elementary-symmetric expansion used by `lem:fourier#coefficient-identification` (Paper A,
transfer.tex L106-L120).

For `z = e^{iφ}` and `λ ≠ 0`, the paired factor satisfies
`1 + z / conj λ = z · conj (1 + z λ) / conj λ` (transfer.tex L112-L114). Hence, if the roots of
the characteristic polynomial of `U` (with algebraic multiplicity) are `λ_1, …, λ_d` together
with their reflections `1 / conj λ_j`, then
`det (1 + e^{iφ} U) = e^{idφ} (∏_j conj λ_j)⁻¹ |P(e^{iφ})|²`, where
`P(e^{iφ}) = ∏_j (1 + e^{iφ} λ_j) = Σ_{k ≤ d} e_k(λ) e^{ikφ}` and `e_k = QEDCore.elementary`. -/

namespace QEDCore.PaperA

open scoped BigOperators

/-- A multiset of complex numbers of cardinality `n` is enumerated by `Fin n`. -/
private lemma exists_fin_enum_of_card_eq (S : Multiset ℂ) (n : ℕ) (h : Multiset.card S = n) :
    ∃ lam : Fin n → ℂ, (Finset.univ : Finset (Fin n)).val.map lam = S := by
  obtain ⟨l, rfl⟩ : ∃ l : List ℂ, (l : Multiset ℂ) = S := Quotient.exists_rep S
  rw [Multiset.coe_card] at h
  subst h
  exact ⟨l.get, by rw [Fin.univ_val_map, List.ofFn_get]⟩

/-- Every finite multiset of complex numbers is enumerated by `Fin (card S)`. -/
theorem exists_fin_enum (S : Multiset ℂ) :
    ∃ lam : Fin (Multiset.card S) → ℂ,
      (Finset.univ : Finset (Fin (Multiset.card S))).val.map lam = S :=
  exists_fin_enum_of_card_eq S _ rfl

/-- `∏_j (1 + e^{iφ} λ_j) = Σ_{k ≤ d} e_k(λ) e^{ikφ}`. -/
theorem prod_one_add_mul_eq_trigPoly {d : ℕ} (lam : Fin d → ℂ) (φ : ℝ) :
    ∏ j, (1 + Complex.exp (φ * Complex.I) * lam j) = trigPoly d (QEDCore.elementary lam) φ := by
  set z := Complex.exp (φ * Complex.I) with hz
  rw [Finset.prod_one_add, Finset.sum_powerset, Finset.card_univ, Fintype.card_fin, trigPoly]
  refine Finset.sum_congr rfl fun k _ => ?_
  have hk : Complex.exp ((k : ℂ) * φ * Complex.I) = z ^ k := by
    rw [mul_assoc, Complex.exp_nat_mul]
  rw [hk, QEDCore.elementary, Finset.sum_mul]
  refine Finset.sum_congr rfl fun t ht => ?_
  rw [Finset.prod_mul_distrib, Finset.prod_const, (Finset.mem_powersetCard.mp ht).2, mul_comm]

/-- `e^{iφ} · conj (e^{iφ}) = 1`. -/
private lemma exp_mul_star_exp (φ : ℝ) :
    Complex.exp (φ * Complex.I) * star (Complex.exp (φ * Complex.I)) = 1 := by
  rw [RCLike.star_def, ← Complex.exp_conj, ← Complex.exp_add]
  simp [map_mul, Complex.conj_ofReal]

/-- The paired factor (transfer.tex L112-L114): for `|z| = 1` and `λ ≠ 0`,
`1 + z / conj λ = z · conj (1 + z λ) · (conj λ)⁻¹`. -/
theorem one_add_mul_inv_star_eq {z w : ℂ} (hz : z * star z = 1) (hw : w ≠ 0) :
    1 + z * (star w)⁻¹ = z * star (1 + z * w) * (star w)⁻¹ := by
  have hsw : star w * (star w)⁻¹ = 1 := mul_inv_cancel₀ (star_ne_zero.mpr hw)
  rw [star_add, star_one, star_mul']
  linear_combination (-(star w * (star w)⁻¹)) * hz - hsw

/-- The algebraic part of Lemma 3.2 (transfer.tex L106-L116): if the eigenvalues of `U` are
`λ_1, …, λ_d` (all nonzero) together with their reflections `1 / conj λ_j`, then
`det (1 + e^{iφ} U) = e^{idφ} (∏_j conj λ_j)⁻¹ |P(e^{iφ})|²` with
`P(e^{iφ}) = Σ_{k ≤ d} e_k(λ) e^{ikφ}`. -/
theorem det_one_add_exp_smul_of_paired {n : Type*} [Fintype n] [DecidableEq n]
    {U : Matrix n n ℂ} {d : ℕ} (lam : Fin d → ℂ) (hlam0 : ∀ j, lam j ≠ 0)
    (hroots : U.charpoly.roots =
      (Finset.univ : Finset (Fin d)).val.map lam +
        ((Finset.univ : Finset (Fin d)).val.map lam).map (fun z => (star z)⁻¹))
    (φ : ℝ) :
    (1 + Complex.exp (φ * Complex.I) • U).det =
      Complex.exp ((d : ℂ) * φ * Complex.I) * (∏ j, star (lam j))⁻¹ *
        (trigPoly d (QEDCore.elementary lam) φ * star (trigPoly d (QEDCore.elementary lam) φ)) := by
  rw [← prod_one_add_mul_eq_trigPoly]
  have hd : Complex.exp ((d : ℂ) * φ * Complex.I) = Complex.exp (φ * Complex.I) ^ d := by
    rw [mul_assoc, Complex.exp_nat_mul]
  rw [hd]
  set z := Complex.exp (φ * Complex.I) with hz
  have hzz : z * star z = 1 := exp_mul_star_exp φ
  have hprod : (U.charpoly.roots.map fun μ => 1 + z * μ).prod =
      (∏ j, (1 + z * lam j)) * ∏ j, (1 + z * (star (lam j))⁻¹) := by
    rw [hroots, Multiset.map_add, Multiset.prod_add, Multiset.map_map, Multiset.map_map,
      Multiset.map_map]
    rfl
  rw [det_one_add_smul_eq_prod_roots, hprod,
    Finset.prod_congr rfl fun j _ => one_add_mul_inv_star_eq hzz (hlam0 j),
    Finset.prod_mul_distrib, Finset.prod_mul_distrib, Finset.prod_const, Finset.card_univ,
    Fintype.card_fin, ← star_prod, Finset.prod_inv_distrib]
  ring

end QEDCore.PaperA
