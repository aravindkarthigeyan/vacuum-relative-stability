/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Transfer.DiracLift
import Core.PaperA.Transfer.ExpForm
import Core.PaperA.Transfer.DetExp
import Core.PaperA.Transfer.SpectralPairing

/-! History-level facts about the transfer matrix `U` and the centered trace `F` of Paper A,
Lemma 3.1 (transfer.tex L11–L43, equation (3.1)), for piecewise-constant histories.

* The admissibility predicate `Step.IsAdmissible` packaging the hypotheses `hfree`/`hkick` of
  the frozen statements, and its Hermiticity consequences.
* `U` is invertible (a product of matrix exponentials).
* `U` preserves the form of `1 ⊗ C₅`: `Uᴴ (1 ⊗ C₅) U = 1 ⊗ C₅`.
* Liouville's formula along the history: `det U = exp (-Σ tr A)`.
* `Σ tr A` is purely imaginary, since free generators are traceless and kick generators have
  trace `-4 i tr Θ` with `Θ` Hermitian.
* `F` is real: with `V = U⁻¹` and `C = 1 ⊗ C₅`, `Uᴴ = C V C`, so
  `star det (1 + U) = det (1 + V) = det V · det (1 + U) = exp (Σ tr A) det (1 + U)`, which the
  centering factor `exp (½ Σ tr A)` exactly compensates.

Graph nodes served: `lem:transfer#propagator-invertible`, `#form-preservation` (history level),
`#liouville` (history level), `#trace-h-zero`, `#det-conjugation`, `#centered-trace-real`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- One step satisfies the hypotheses `hfree`/`hkick` of the frozen statements. -/
def Step.IsAdmissible {ι : Type*} [Fintype ι] [DecidableEq ι] (mStar : ℝ) : Step ι → Prop
  | .free τ v M => 0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef
  | .kick Θ => Θ.IsHermitian

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
  {α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ} {β : Matrix (Fin 4) (Fin 4) ℂ}

/-- The hypotheses `hfree`/`hkick` of the frozen statements make every step admissible. -/
theorem isAdmissible_of_mem {mStar : ℝ} {hist : List (Step ι)}
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian) :
    ∀ s ∈ hist, s.IsAdmissible mStar := by
  intro s hs
  cases s with
  | free τ v M => exact hfree τ v M hs
  | kick Θ => exact hkick Θ hs

omit [Fintype ι] in
private lemma isHermitian_ofReal_smul_one (m : ℝ) :
    ((m : ℂ) • (1 : Matrix ι ι ℂ)).IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_smul, conjTranspose_one, Complex.star_def, Complex.conj_ofReal]

/-- An admissible step has Hermitian data: a mass matrix bounded below by a real multiple of
the identity is Hermitian. -/
theorem Step.IsAdmissible.isHermitianData {mStar : ℝ} {s : Step ι}
    (hs : s.IsAdmissible mStar) : s.IsHermitianData := by
  cases s with
  | free τ v M =>
    obtain ⟨-, hv, hM⟩ := hs
    refine ⟨hv, ?_⟩
    have h1 := hM.isHermitian.add (isHermitian_ofReal_smul_one (ι := ι) mStar)
    rwa [sub_add_cancel] at h1
  | kick Θ => exact hs

/-! ### The transfer matrix along a history -/

/-- The transfer matrix of the empty history is `1`. -/
theorem transferMatrix_nil : transferMatrix α β ([] : List (Step ι)) = 1 := by
  simp only [transferMatrix, List.map_nil, List.reverse_nil, List.prod_nil]

/-- Prepending a step multiplies the transfer matrix by its propagator on the right (the
earliest step acts first). -/
theorem transferMatrix_cons (s : Step ι) (hist : List (Step ι)) :
    transferMatrix α β (s :: hist) =
      transferMatrix α β hist * NormedSpace.exp (-(s.generator α β)) := by
  simp only [transferMatrix, List.map_cons, List.reverse_cons, List.prod_append,
    List.prod_cons, List.prod_nil, mul_one]

/-- Graph node `lem:transfer#propagator-invertible`: the transfer matrix is invertible. -/
theorem isUnit_transferMatrix (hist : List (Step ι)) : IsUnit (transferMatrix α β hist) := by
  induction hist with
  | nil => rw [transferMatrix_nil]; exact isUnit_one
  | cons s hist ih => rw [transferMatrix_cons]; exact ih.mul (Matrix.isUnit_exp _)

/-- Graph node `lem:transfer#form-preservation` (history level):
`Uᴴ (1 ⊗ C₅) U = 1 ⊗ C₅`. -/
theorem transferMatrix_preservesForm (h : IsDiracClifford α β) {hist : List (Step ι)}
    (hH : ∀ s ∈ hist, s.IsHermitianData) :
    (transferMatrix α β hist)ᴴ * ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) * transferMatrix α β hist =
      (1 : Matrix ι ι ℂ) ⊗ₖ c5 α β := by
  induction hist with
  | nil => simp [transferMatrix_nil]
  | cons s hist ih =>
    have hs := conjTranspose_exp_neg_mul_mul_exp_neg
      (h.generator_adjoint_c5 s (hH s (by simp)))
    have ih' := ih (fun t ht => hH t (List.mem_cons_of_mem s ht))
    rw [transferMatrix_cons, conjTranspose_mul]
    calc _ = (NormedSpace.exp (-(s.generator α β)))ᴴ *
          ((transferMatrix α β hist)ᴴ * ((1 : Matrix ι ι ℂ) ⊗ₖ c5 α β) *
            transferMatrix α β hist) * NormedSpace.exp (-(s.generator α β)) := by
          simp only [mul_assoc]
      _ = _ := by rw [ih', hs]

omit [Fintype ι] [DecidableEq ι] in
private lemma isHermitian_kronecker_one {Θ : Matrix ι ι ℂ} (hΘ : Θ.IsHermitian) :
    (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)).IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_kronecker, hΘ.eq, conjTranspose_one]

/-- Graph node `lem:transfer#liouville` (one step, in generator form):
`det (exp (-A)) = exp (-tr A)`. -/
theorem det_exp_neg_generator (h : IsDiracClifford α β) {s : Step ι}
    (hs : s.IsHermitianData) :
    (NormedSpace.exp (-(s.generator α β))).det = Complex.exp (-(s.generator α β).trace) := by
  cases s with
  | free τ v M =>
    obtain ⟨hv, hM⟩ := hs
    have hh := h.isHermitian_diracOperator hv hM
    simp only [Step.generator]
    rw [← neg_smul, det_exp_smul_of_isHermitian hh, trace_smul, smul_eq_mul, neg_mul]
  | kick Θ =>
    have hk := isHermitian_kronecker_one (show Θ.IsHermitian from hs)
    simp only [Step.generator]
    rw [neg_neg, det_exp_smul_of_isHermitian hk, trace_neg, trace_smul, smul_eq_mul, neg_neg]

/-- Graph node `lem:transfer#liouville` (history level): `det U = exp (-Σ tr A)`. -/
theorem det_transferMatrix (h : IsDiracClifford α β) {hist : List (Step ι)}
    (hH : ∀ s ∈ hist, s.IsHermitianData) :
    (transferMatrix α β hist).det =
      Complex.exp (-(hist.map fun s => (s.generator α β).trace).sum) := by
  induction hist with
  | nil => simp [transferMatrix_nil]
  | cons s hist ih =>
    rw [transferMatrix_cons, det_mul, ih (fun t ht => hH t (List.mem_cons_of_mem s ht)),
      det_exp_neg_generator h (hH s (by simp)), List.map_cons, List.sum_cons,
      ← Complex.exp_add]
    congr 1
    ring

/-- Graph node `lem:transfer#trace-h-zero` (history level): the total generator trace
`Σ tr A` is purely imaginary. -/
theorem re_sum_trace_generator (h : IsDiracClifford α β) {hist : List (Step ι)}
    (hH : ∀ s ∈ hist, s.IsHermitianData) :
    (hist.map fun s : Step ι => (s.generator α β).trace).sum.re = 0 := by
  induction hist with
  | nil => simp
  | cons s hist ih =>
    rw [List.map_cons, List.sum_cons, Complex.add_re, h.trace_generator_re s (hH s (by simp)),
      ih (fun t ht => hH t (List.mem_cons_of_mem s ht)), add_zero]

/-! ### Reality of the centered trace -/

/-- Graph node `lem:transfer#det-conjugation`:
`star det (1 + U) = exp (Σ tr A) det (1 + U)`. -/
theorem star_det_one_add_transferMatrix (h : IsDiracClifford α β) {hist : List (Step ι)}
    (hH : ∀ s ∈ hist, s.IsHermitianData) :
    star (1 + transferMatrix α β hist).det =
      Complex.exp ((hist.map fun s => (s.generator α β).trace).sum) *
        (1 + transferMatrix α β hist).det := by
  have hdetU := det_transferMatrix h hH
  have hform := transferMatrix_preservesForm h hH
  have hUunit : IsUnit (transferMatrix α β hist).det :=
    (Matrix.isUnit_iff_isUnit_det _).mp (isUnit_transferMatrix hist)
  set U := transferMatrix α β hist with hUdef
  set S := (hist.map fun s => (s.generator α β).trace).sum with hSdef
  set C : Matrix (ι × Fin 4) (ι × Fin 4) ℂ := (1 : Matrix ι ι ℂ) ⊗ₖ c5 α β with hCdef
  have hUV : U * U⁻¹ = 1 := Matrix.mul_nonsing_inv U hUunit
  have hVU : U⁻¹ * U = 1 := Matrix.nonsing_inv_mul U hUunit
  have hCC : C * C = 1 := h.one_kronecker_c5_mul_self
  have hadj : Uᴴ = C * U⁻¹ * C := conjTranspose_eq_conj_inverse hUV hCC hform
  have hdetC : C.det * C.det = 1 := by rw [← det_mul, hCC, det_one]
  have hdetV : (U⁻¹).det = Complex.exp S := by
    have h1 : (U⁻¹).det * U.det = 1 := by rw [← det_mul, hVU, det_one]
    calc (U⁻¹).det = (U⁻¹).det * (U.det * Complex.exp S) := by
          rw [hdetU, ← Complex.exp_add, neg_add_cancel, Complex.exp_zero, mul_one]
      _ = Complex.exp S := by rw [← mul_assoc, h1, one_mul]
  have h1V : 1 + U⁻¹ = U⁻¹ * (1 + U) := by rw [mul_add, mul_one, hVU, add_comm]
  have hconj : 1 + Uᴴ = C * (1 + U⁻¹) * C := by
    rw [hadj, mul_add, add_mul, mul_one, hCC, mul_assoc]
  rw [← det_conjTranspose, conjTranspose_add, conjTranspose_one, hconj, det_mul, det_mul, h1V,
    det_mul, hdetV]
  linear_combination (Complex.exp S * (1 + U).det) * hdetC

/-- Graph node `lem:transfer#centered-trace-real`: the centered trace is real,
`star F = F`. -/
theorem star_centeredTrace (h : IsDiracClifford α β) {hist : List (Step ι)}
    (hH : ∀ s ∈ hist, s.IsHermitianData) :
    star (centeredTrace α β hist) = centeredTrace α β hist := by
  unfold centeredTrace
  have hre := re_sum_trace_generator h hH
  have hdet := star_det_one_add_transferMatrix h hH
  set S := (hist.map fun s => (s.generator α β).trace).sum with hSdef
  set D := (1 + transferMatrix α β hist).det with hDdef
  have hhalf : star ((1 / 2 : ℂ) * S) = -((1 / 2 : ℂ) * S) := by
    apply Complex.ext <;> simp [hre]
  have hstar : star (Complex.exp ((1 / 2 : ℂ) * S)) = Complex.exp (-((1 / 2 : ℂ) * S)) := by
    rw [← hhalf]
    exact (Complex.exp_conj _).symm
  rw [star_mul', hdet, hstar, ← mul_assoc, ← Complex.exp_add]
  congr 2
  ring

/-- Graph node `lem:transfer#centered-trace-real`: the centered trace has zero imaginary
part. -/
theorem im_centeredTrace (h : IsDiracClifford α β) {hist : List (Step ι)}
    (hH : ∀ s ∈ hist, s.IsHermitianData) :
    (centeredTrace α β hist).im = 0 :=
  Complex.conj_eq_iff_im.mp (star_centeredTrace h hH)

end QEDCore.PaperA
