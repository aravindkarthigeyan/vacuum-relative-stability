/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Transfer.DiracAlgebra
import Mathlib.Analysis.Matrix.Order
import Mathlib.LinearAlgebra.Matrix.PosDef

/-! Kronecker lifts of the Dirac algebra to `ℓ²(ι) ⊗ ℂ⁴` (Paper A, Lemma 3.1 and
Lemma 3.2 algebra): `1 ⊗ C₅` anticommutes with `h` and commutes with spin-scalar kicks,
`h` is Hermitian and traceless, the `β`-anticommutator `{1 ⊗ β, h} = 2 (M ⊗ 1)`, traces and
positivity of spin-scalar lifts, and the generator relations used for the `C₅`-transfer.

Graph nodes served: `lem:transfer#c5-anticommutes-h`, `#c5-commutes-kick`, `#dirac-hermitian`,
`#trace-h-zero`, `#generator-c5-relation`, and the β-anticommutator of `eq:beta-form`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
  {α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ} {β : Matrix (Fin 4) (Fin 4) ℂ}

private lemma kronecker_neg' {m n p q : Type*} (A : Matrix m n ℂ) (B : Matrix p q ℂ) :
    A ⊗ₖ (-B) = -(A ⊗ₖ B) :=
  Matrix.ext fun _ _ => by simp [kroneckerMap_apply]

private lemma sub_kronecker' {m n p q : Type*} (A A' : Matrix m n ℂ) (B : Matrix p q ℂ) :
    (A - A') ⊗ₖ B = A ⊗ₖ B - A' ⊗ₖ B :=
  Matrix.ext fun _ _ => by simp [kroneckerMap_apply, sub_mul]

/-- `1 ⊗ C₅` anticommutes with the Dirac operator. -/
theorem IsDiracClifford.one_kronecker_c5_mul_diracOperator (h : IsDiracClifford α β)
    (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) * diracOperator α β v M =
      -(diracOperator α β v M * ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β)) := by
  unfold diracOperator
  simp only [mul_add, add_mul, Finset.mul_sum, Finset.sum_mul, ← mul_kronecker_mul, one_mul,
    mul_one, h.c5_mul_α, h.c5_mul_β, kronecker_neg', neg_add, Finset.sum_neg_distrib]

/-- Spin-scalar lifts commute with `1 ⊗ X`. -/
theorem one_kronecker_mul_kronecker_one (Θ : Matrix ι ι ℂ) (X : Matrix (Fin 4) (Fin 4) ℂ) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ X) * (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) =
      (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) * ((1 : Matrix ι ι ℂ) ⊗ₖ X) := by
  rw [← mul_kronecker_mul, ← mul_kronecker_mul]; simp

/-- The Dirac operator is Hermitian for Hermitian coefficients. -/
theorem IsDiracClifford.isHermitian_diracOperator (h : IsDiracClifford α β)
    {v : Fin 3 → Matrix ι ι ℂ} {M : Matrix ι ι ℂ} (hv : ∀ j, (v j).IsHermitian)
    (hM : M.IsHermitian) : (diracOperator α β v M).IsHermitian := by
  unfold diracOperator Matrix.IsHermitian
  rw [conjTranspose_add, conjTranspose_sum, conjTranspose_kronecker]
  simp only [conjTranspose_kronecker, (hv _).eq, (h.herm_α _).eq, hM.eq, h.herm_β.eq]

/-- The Dirac operator is traceless. -/
theorem IsDiracClifford.trace_diracOperator (h : IsDiracClifford α β)
    (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ) : (diracOperator α β v M).trace = 0 := by
  unfold diracOperator
  simp [trace_add, trace_sum, trace_kronecker, h.trace_α, h.trace_β]

/-- `{1 ⊗ β, h} = 2 (M ⊗ 1)`. -/
theorem IsDiracClifford.one_kronecker_β_anticomm (h : IsDiracClifford α β)
    (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ β) * diracOperator α β v M +
        diracOperator α β v M * ((1 : Matrix ι ι ℂ) ⊗ₖ β) =
      (2 : ℂ) • (M ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) := by
  have hα : ∀ j, β * α j = -(α j * β) := fun j => by
    rw [eq_neg_iff_add_eq_zero, add_comm]; exact h.anti_αβ j
  unfold diracOperator
  simp only [mul_add, add_mul, Finset.mul_sum, Finset.sum_mul, ← mul_kronecker_mul, one_mul,
    mul_one, hα, h.sq_β, kronecker_neg']
  rw [Finset.sum_neg_distrib, two_smul]
  abel

/-- `1 ⊗ β` is Hermitian. -/
theorem IsDiracClifford.isHermitian_one_kronecker_β (h : IsDiracClifford α β) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ β).IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_kronecker, conjTranspose_one, h.herm_β.eq]

/-- `(1 ⊗ β)² = 1`. -/
theorem IsDiracClifford.one_kronecker_β_mul_self (h : IsDiracClifford α β) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ β) * ((1 : Matrix ι ι ℂ) ⊗ₖ β) = 1 := by
  rw [← mul_kronecker_mul, one_mul, h.sq_β, one_kronecker_one]

/-- `1 ⊗ C₅` is Hermitian. -/
theorem IsDiracClifford.isHermitian_one_kronecker_c5 (h : IsDiracClifford α β) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β).IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_kronecker, conjTranspose_one, h.c5_isHermitian.eq]

/-- `(1 ⊗ C₅)² = 1`. -/
theorem IsDiracClifford.one_kronecker_c5_mul_self (h : IsDiracClifford α β) :
    ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) * ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) = 1 := by
  rw [← mul_kronecker_mul, one_mul, h.c5_mul_self, one_kronecker_one]

/-- `tr (Θ ⊗ 1) = 4 tr Θ`. -/
theorem trace_kronecker_one (Θ : Matrix ι ι ℂ) :
    (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)).trace = 4 * Θ.trace := by
  rw [trace_kronecker, trace_one]; simp [mul_comm]

/-- Lower bounds on `M` lift to the spin-scalar lift. -/
theorem posSemidef_kronecker_one_sub (M : Matrix ι ι ℂ) (m : ℝ)
    (hM : (M - (m : ℂ) • (1 : Matrix ι ι ℂ)).PosSemidef) :
    (M ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ) -
      (m : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ)).PosSemidef := by
  have h1 : (M ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ) -
      (m : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ)) =
      (M - (m : ℂ) • (1 : Matrix ι ι ℂ)) ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ) := by
    rw [sub_kronecker', smul_kronecker, one_kronecker_one]
  rw [h1]
  exact hM.kronecker Matrix.PosSemidef.one

/-- Hermiticity data of one step: Hermitian spatial coefficients and mass matrix for a free
step, Hermitian generator for a kick. -/
def Step.IsHermitianData {ι : Type*} : Step ι → Prop
  | .free _ v M => (∀ j, (v j).IsHermitian) ∧ M.IsHermitian
  | .kick Θ => Θ.IsHermitian

/-- The generator anticommutes with `1 ⊗ C₅` up to the adjoint:
`A* (1 ⊗ C₅) + (1 ⊗ C₅) A = 0`. -/
theorem IsDiracClifford.generator_adjoint_c5 (h : IsDiracClifford α β) (s : Step ι)
    (hs : s.IsHermitianData) :
    (s.generator α β)ᴴ * ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) +
      ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) * s.generator α β = 0 := by
  cases s with
  | free τ v M =>
    obtain ⟨hv, hM⟩ := hs
    have hh := (h.isHermitian_diracOperator hv hM).eq
    have key := h.one_kronecker_c5_mul_diracOperator v M
    simp only [Step.generator]
    rw [conjTranspose_smul, hh, mul_smul_comm, smul_mul_assoc, key]
    simp
  | kick Θ =>
    have hΘ := hs.eq
    have key := one_kronecker_mul_kronecker_one Θ (c5 α β)
    simp only [Step.generator]
    rw [conjTranspose_neg, conjTranspose_smul, conjTranspose_kronecker, hΘ, conjTranspose_one,
      neg_mul, mul_neg, smul_mul_assoc, mul_smul_comm, ← key]
    simp

/-- A free-step generator is traceless. -/
theorem IsDiracClifford.trace_generator_free (h : IsDiracClifford α β) (τ : ℝ)
    (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ) :
    ((Step.free τ v M).generator α β).trace = 0 := by
  simp [Step.generator, trace_smul, h.trace_diracOperator]

/-- The trace of a kick generator. -/
theorem trace_generator_kick (Θ : Matrix ι ι ℂ) :
    ((Step.kick Θ : Step ι).generator α β).trace = -(Complex.I * (4 * Θ.trace)) := by
  simp [Step.generator, trace_neg, trace_smul, trace_kronecker_one]

private lemma trace_im_eq_zero {Θ : Matrix ι ι ℂ} (hΘ : Θ.IsHermitian) : Θ.trace.im = 0 := by
  have : ∀ i, (Θ i i).im = 0 := fun i => by
    have := congrArg Complex.im (hΘ.apply i i)
    simp at this
    linarith
  simp [Matrix.trace, Complex.im_sum, this]

/-- The generator trace is purely imaginary. -/
theorem IsDiracClifford.trace_generator_re (h : IsDiracClifford α β) (s : Step ι)
    (hs : s.IsHermitianData) : (s.generator α β).trace.re = 0 := by
  cases s with
  | free τ v M => simp [h.trace_generator_free]
  | kick Θ =>
    rw [trace_generator_kick]
    have := trace_im_eq_zero hs
    simp [this]

/-- `1 ⊗ β` commutes with kick generators. -/
theorem one_kronecker_β_commute_generator_kick (Θ : Matrix ι ι ℂ) :
    Commute ((1 : Matrix ι ι ℂ) ⊗ₖ β) ((Step.kick Θ : Step ι).generator α β) := by
  unfold Commute SemiconjBy
  simp only [Step.generator, mul_neg, neg_mul, mul_smul_comm, smul_mul_assoc,
    one_kronecker_mul_kronecker_one]

end QEDCore.PaperA
