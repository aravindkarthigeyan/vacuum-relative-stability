/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.LinearAlgebra.Matrix.Charpoly.Coeff
import Mathlib.LinearAlgebra.Matrix.Charpoly.Eigs
import Mathlib.Analysis.Complex.Polynomial.Basic

/-! Graph node `lem:fourier#factorization` (Paper A, transfer.tex L106-L116): for a complex
square matrix `U`, `det (1 + z U)` is the product of `1 + z μ` over the eigenvalues `μ` of `U`
counted with algebraic multiplicity (roots of the characteristic polynomial); this uses
determinant eigenvalues only, so it also holds for defective matrices. -/

namespace QEDCore.PaperA

open Polynomial

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

theorem det_one_add_smul_eq_prod_roots {n : Type*} [Fintype n] [DecidableEq n]
    (U : Matrix n n ℂ) (z : ℂ) :
    (1 + z • U).det = (U.charpoly.roots.map fun μ => 1 + z * μ).prod := by
  have hsplit : (U.charpoly.roots.map fun μ => (X - C μ : ℂ[X])).prod = U.charpoly :=
    Polynomial.prod_multiset_X_sub_C_of_monic_of_roots_card_eq U.charpoly_monic
      (Polynomial.splits_iff_card_roots.mp (IsAlgClosed.splits (U.charpoly : ℂ[X])))
  have h1 := congrArg (Polynomial.eval (-z)) (Matrix.reverse_charpoly U)
  rw [← hsplit, reverse_prod, Polynomial.eval_multiset_prod] at h1
  rw [Matrix.charpolyRev, ← Polynomial.coe_evalRingHom, RingHom.map_det] at h1
  have hm : (Polynomial.evalRingHom (-z)).mapMatrix (1 - (X : ℂ[X]) • U.map C) = 1 + z • U := by
    ext i j
    rcases eq_or_ne i j with hij | hij <;> simp [hij] <;> ring
  rw [hm] at h1
  rw [← h1, Multiset.map_map]
  congr 1
  refine Multiset.map_congr rfl fun μ _ => ?_
  simp
  ring
