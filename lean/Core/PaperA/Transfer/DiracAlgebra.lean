/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.StepGenerator
import Mathlib.LinearAlgebra.Matrix.Hermitian
import Mathlib.LinearAlgebra.Matrix.Trace

/-! Dirac-matrix algebra of Paper A (model.tex L27–28, L116): the Clifford conventions on
`α₁ α₂ α₃ β`, the chirality matrix `C₅ = α₁ α₂ α₃ β`, and its Hermiticity, involution and
anticommutation with `α_j` and `β`, together with tracelessness of `α_j` and `β`.

Graph nodes served: `lem:transfer#c5-involution`, `#c5-anticommutes-h`, `#trace-h-zero`,
`#generator-c5-relation` (finite-dimensional factor), and the β-anticommutator of
`eq:beta-form`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker

/-- The Dirac conventions of Paper A (model.tex L27–28), exactly the six Clifford hypotheses
of the frozen statements. -/
structure IsDiracClifford (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) : Prop where
  herm_α : ∀ j, (α j).IsHermitian
  herm_β : β.IsHermitian
  sq_α : ∀ j, α j * α j = 1
  sq_β : β * β = 1
  anti_α : ∀ j k, j ≠ k → α j * α k + α k * α j = 0
  anti_αβ : ∀ j, α j * β + β * α j = 0

/-- `C₅ = α₁ α₂ α₃ β` (model.tex L116). -/
def c5 (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ) :
    Matrix (Fin 4) (Fin 4) ℂ :=
  α 0 * α 1 * α 2 * β

namespace IsDiracClifford

variable {α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ} {β : Matrix (Fin 4) (Fin 4) ℂ}

private lemma anti_of {A B : Matrix (Fin 4) (Fin 4) ℂ} (h : A * B + B * A = 0) :
    B * A = -(A * B) := by
  rw [eq_neg_iff_add_eq_zero, add_comm]; exact h

private lemma anti_α' (h : IsDiracClifford α β) {j k : Fin 3} (hjk : j ≠ k) :
    α k * α j = -(α j * α k) := anti_of (h.anti_α j k hjk)

private lemma anti_αβ' (h : IsDiracClifford α β) (j : Fin 3) :
    β * α j = -(α j * β) := anti_of (h.anti_αβ j)

private lemma anti_βα' (h : IsDiracClifford α β) (j : Fin 3) :
    α j * β = -(β * α j) := by
  rw [anti_αβ' h j, neg_neg]

private lemma swaps (h : IsDiracClifford α β) :
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, α 1 * (α 0 * Z) = -(α 0 * (α 1 * Z))) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, α 2 * (α 0 * Z) = -(α 0 * (α 2 * Z))) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, α 2 * (α 1 * Z) = -(α 1 * (α 2 * Z))) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, β * (α 0 * Z) = -(α 0 * (β * Z))) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, β * (α 1 * Z) = -(α 1 * (β * Z))) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, β * (α 2 * Z) = -(α 2 * (β * Z))) := by
  have h10 := anti_α' h (j := 0) (k := 1) (by decide)
  have h20 := anti_α' h (j := 0) (k := 2) (by decide)
  have h21 := anti_α' h (j := 1) (k := 2) (by decide)
  refine ⟨?_, ?_, ?_, ?_, ?_, ?_⟩ <;> intro Z <;> rw [← mul_assoc]
  · rw [h10, neg_mul, mul_assoc]
  · rw [h20, neg_mul, mul_assoc]
  · rw [h21, neg_mul, mul_assoc]
  · rw [anti_αβ' h 0, neg_mul, mul_assoc]
  · rw [anti_αβ' h 1, neg_mul, mul_assoc]
  · rw [anti_αβ' h 2, neg_mul, mul_assoc]

private lemma swaps0 (h : IsDiracClifford α β) :
    α 1 * α 0 = -(α 0 * α 1) ∧ α 2 * α 0 = -(α 0 * α 2) ∧ α 2 * α 1 = -(α 1 * α 2) ∧
    β * α 0 = -(α 0 * β) ∧ β * α 1 = -(α 1 * β) ∧ β * α 2 = -(α 2 * β) :=
  ⟨anti_α' h (j := 0) (k := 1) (by decide), anti_α' h (j := 0) (k := 2) (by decide),
    anti_α' h (j := 1) (k := 2) (by decide), anti_αβ' h 0, anti_αβ' h 1, anti_αβ' h 2⟩

private lemma sqs (h : IsDiracClifford α β) :
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, α 0 * (α 0 * Z) = Z) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, α 1 * (α 1 * Z) = Z) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, α 2 * (α 2 * Z) = Z) ∧
    (∀ Z : Matrix (Fin 4) (Fin 4) ℂ, β * (β * Z) = Z) := by
  refine ⟨?_, ?_, ?_, ?_⟩ <;> intro Z <;> rw [← mul_assoc]
  · rw [h.sq_α 0, one_mul]
  · rw [h.sq_α 1, one_mul]
  · rw [h.sq_α 2, one_mul]
  · rw [h.sq_β, one_mul]

/-- `C₅` is Hermitian. -/
theorem c5_isHermitian (h : IsDiracClifford α β) : (c5 α β).IsHermitian := by
  obtain ⟨l1, l2, l3, m0, m1, m2⟩ := swaps h
  obtain ⟨p1, p2, p3, q0, q1, q2⟩ := swaps0 h
  unfold Matrix.IsHermitian c5
  simp only [conjTranspose_mul, (h.herm_α _).eq, h.herm_β.eq, mul_assoc]
  simp only [m2, m1, m0, l1, l2, l3, p1, p2, p3, q0, q1, q2, mul_neg, neg_mul, neg_neg, mul_assoc]

/-- `C₅² = 1`. -/
theorem c5_mul_self (h : IsDiracClifford α β) : c5 α β * c5 α β = 1 := by
  obtain ⟨l1, l2, l3, m0, m1, m2⟩ := swaps h
  obtain ⟨p1, p2, p3, q0, q1, q2⟩ := swaps0 h
  obtain ⟨e0', e1', e2', eb'⟩ := sqs h
  have e0 := h.sq_α 0
  have e1 := h.sq_α 1
  have e2 := h.sq_α 2
  have eb := h.sq_β
  unfold c5
  simp only [mul_assoc]
  simp only [m2, m1, m0, l1, l2, l3, p1, p2, p3, q0, q1, q2, mul_neg, neg_mul, neg_neg, e0', e1', e2', eb', e0, e1, e2,
    eb, mul_one, mul_assoc, neg_neg]

/-- `C₅` anticommutes with each `α_j`. -/
theorem c5_mul_α (h : IsDiracClifford α β) (j : Fin 3) :
    c5 α β * α j = -(α j * c5 α β) := by
  obtain ⟨l1, l2, l3, m0, m1, m2⟩ := swaps h
  obtain ⟨p1, p2, p3, q0, q1, q2⟩ := swaps0 h
  obtain ⟨e0', e1', e2', eb'⟩ := sqs h
  have a0 := anti_βα' h 0
  have a1 := anti_βα' h 1
  have a2 := anti_βα' h 2
  have h10 := anti_α' h (j := 0) (k := 1) (by decide)
  have h20 := anti_α' h (j := 0) (k := 2) (by decide)
  have h21 := anti_α' h (j := 1) (k := 2) (by decide)
  unfold c5
  fin_cases j <;> simp only [Fin.zero_eta, Fin.mk_one, Fin.reduceFinMk, Fin.isValue] <;>
    simp only [mul_assoc, m2, m1, m0, l1, l2, l3, p1, p2, p3, q0, q1, q2, mul_neg, neg_mul, neg_neg, e0', e1', e2', eb',
      mul_one]

/-- `C₅` anticommutes with `β`. -/
theorem c5_mul_β (h : IsDiracClifford α β) : c5 α β * β = -(β * c5 α β) := by
  obtain ⟨l1, l2, l3, m0, m1, m2⟩ := swaps h
  obtain ⟨p1, p2, p3, q0, q1, q2⟩ := swaps0 h
  obtain ⟨e0', e1', e2', eb'⟩ := sqs h
  have eb := h.sq_β
  unfold c5
  simp only [mul_assoc, eb, mul_one]
  simp only [m2, m1, m0, p1, p2, p3, q0, q1, q2, mul_neg, neg_neg, eb', mul_assoc, eb, mul_one]

private lemma eq_zero_of_eq_neg {z : ℂ} (hz : z = -z) : z = 0 := by
  have h2 : (2 : ℂ) * z = 0 := by rw [two_mul]; nth_rewrite 1 [hz]; exact neg_add_cancel z
  exact (mul_eq_zero.mp h2).resolve_left two_ne_zero

/-- Each `α_j` is traceless. -/
theorem trace_α (h : IsDiracClifford α β) (j : Fin 3) : (α j).trace = 0 := by
  apply eq_zero_of_eq_neg
  calc (α j).trace = (α j * (β * β)).trace := by rw [h.sq_β, mul_one]
    _ = (β * (α j * β)).trace := by
      rw [← mul_assoc, trace_mul_comm]
    _ = -(α j).trace := by
      rw [← mul_assoc, anti_αβ' h j, neg_mul, mul_assoc, h.sq_β, mul_one, trace_neg]

/-- `β` is traceless. -/
theorem trace_β (h : IsDiracClifford α β) : β.trace = 0 := by
  apply eq_zero_of_eq_neg
  calc β.trace = (α 0 * (α 0 * β)).trace := by rw [← mul_assoc, h.sq_α 0, one_mul]
    _ = ((α 0 * β) * α 0).trace := trace_mul_comm _ _
    _ = -β.trace := by
      rw [anti_βα' h 0, neg_mul, mul_assoc, h.sq_α 0, mul_one, trace_neg]

end IsDiracClifford

end QEDCore.PaperA
