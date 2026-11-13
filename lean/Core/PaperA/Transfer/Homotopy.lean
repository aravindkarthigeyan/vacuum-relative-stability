/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.StepFreeTime
import Core.PaperA.Transfer.History
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Topology.Instances.Matrix
import Mathlib.Topology.UniformSpace.Matrix
import Mathlib.Topology.Order.IntermediateValue

/-! The homotopy argument for the sign of the centered trace (Paper A, Lemma 3.1,
transfer.tex L73–L77): `F > 0`.

The history `H` is deformed to `H_σ` by scaling the kicks and the spatial coefficients by
`1 - σ` and replacing the mass matrix by `(1 - σ) M + σ m_* I`, keeping the free times. The
deformation parameter is written `σ` here (the source writes `s`, which Paper A also uses for
`e^{-b m_*}`).

* Each `H_σ`, `σ ∈ [0, 1]`, is admissible, and `H_0 = H`.
* `σ ↦ F(H_σ)` is continuous.
* At `σ = 1` every free step is `free τ 0 (m_* I)`, with generator `τ m_* (1 ⊗ β)`, and every
  kick is trivial, so `U₁ = exp (-(b m_*) (1 ⊗ β))`, the centering exponent vanishes because
  `tr (1 ⊗ β) = 0`, and `F(H_1) = det (1 + exp (-(b m_*) (1 ⊗ β))) > 0`.
* If `F(H_σ) ≠ 0` on `[0, 1]` (graph node `#homotopy-nonvanishing`, taken here as a premise),
  then `F(H) > 0` by the intermediate value theorem, since each `F(H_σ)` is real.

Graph nodes served: `lem:transfer#homotopy-admissible`, `#homotopy-continuity`,
`#homotopy-endpoint`, `#homotopy-nonvanishing` (as a premise), `#positivity`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
  {α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ} {β : Matrix (Fin 4) (Fin 4) ℂ}

/-- The deformation of transfer.tex L73-L75 at parameter σ: kicks and spatial coefficients
scaled by `1 - σ`, mass `(1 - σ) M + σ m_* I`, free times unchanged. -/
def Step.deform (mStar σ : ℝ) : Step ι → Step ι
  | .free τ v M => .free τ (fun j => ((1 - σ : ℝ) : ℂ) • v j)
      (((1 - σ : ℝ) : ℂ) • M + ((σ * mStar : ℝ) : ℂ) • (1 : Matrix ι ι ℂ))
  | .kick Θ => .kick (((1 - σ : ℝ) : ℂ) • Θ)

omit [Fintype ι] in
/-- The deformation at `σ = 0` is the identity. -/
theorem Step.deform_zero (mStar : ℝ) (s : Step ι) : s.deform mStar 0 = s := by
  cases s with
  | free τ v M => simp [Step.deform]
  | kick Θ => simp [Step.deform]

omit [Fintype ι] [DecidableEq ι] in
private lemma isHermitian_ofReal_smul {A : Matrix ι ι ℂ} (hA : A.IsHermitian) (c : ℝ) :
    ((c : ℂ) • A).IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_smul, hA.eq, Complex.star_def, Complex.conj_ofReal]

/-- Graph node `lem:transfer#homotopy-admissible`: every deformed step is admissible. -/
theorem Step.IsAdmissible.deform {mStar σ : ℝ} {s : Step ι} (hs : s.IsAdmissible mStar)
    (hσ0 : 0 ≤ σ) (hσ1 : σ ≤ 1) : (s.deform mStar σ).IsAdmissible mStar := by
  -- Only `σ ≤ 1` is used (it makes `1 - σ ≥ 0`); `0 ≤ σ` is kept to match the source.
  have _ := hσ0
  cases s with
  | free τ v M =>
    obtain ⟨hτ, hv, hM⟩ := hs
    refine ⟨hτ, fun j => isHermitian_ofReal_smul (hv j) _, ?_⟩
    have hc : (0 : ℂ) ≤ ((1 - σ : ℝ) : ℂ) := Complex.zero_le_real.mpr (sub_nonneg.mpr hσ1)
    have heq : ((1 - σ : ℝ) : ℂ) • M + ((σ * mStar : ℝ) : ℂ) • (1 : Matrix ι ι ℂ) -
        (mStar : ℂ) • 1 = ((1 - σ : ℝ) : ℂ) • (M - (mStar : ℂ) • 1) := by
      rw [smul_sub, smul_smul]
      push_cast
      module
    rw [heq]
    exact hM.smul hc
  | kick Θ => exact isHermitian_ofReal_smul (show Θ.IsHermitian from hs) _

omit [Fintype ι] in
/-- The deformation keeps the free times. -/
theorem Step.freeTime_deform (mStar σ : ℝ) (s : Step ι) :
    (s.deform mStar σ).freeTime = s.freeTime := by
  cases s <;> rfl

/-! ### Continuity -/

omit [Fintype ι] in
/-- The generator of a deformed step is affine in the parameter. -/
private lemma generator_deform (mStar σ : ℝ) (s : Step ι) :
    (s.deform mStar σ).generator α β =
      ((1 - σ : ℝ) : ℂ) • s.generator α β +
        ((σ * (mStar * s.freeTime) : ℝ) : ℂ) • ((1 : Matrix ι ι ℂ) ⊗ₖ β) := by
  cases s with
  | free τ v M =>
    simp only [Step.deform, Step.generator, Step.freeTime, diracOperator, add_kronecker,
      smul_kronecker, ← Finset.smul_sum]
    push_cast
    module
  | kick Θ =>
    simp only [Step.deform, Step.generator, Step.freeTime, smul_kronecker]
    push_cast
    simp only [mul_zero, zero_smul, add_zero]
    module

omit [Fintype ι] in
private lemma continuous_generator_deform (mStar : ℝ) (s : Step ι) :
    Continuous fun σ : ℝ => (s.deform mStar σ).generator α β := by
  simp only [generator_deform]
  fun_prop

private lemma continuous_matrix_exp {n : Type*} [Fintype n] [DecidableEq n] :
    Continuous (NormedSpace.exp : Matrix n n ℂ → Matrix n n ℂ) := by
  exact @NormedSpace.exp_continuous (Matrix n n ℂ) Matrix.linftyOpNormedRing
    Matrix.linftyOpNormedAlgebra (inferInstance : CompleteSpace (Matrix n n ℂ))

private lemma continuous_transferMatrix_deform (mStar : ℝ) (hist : List (Step ι)) :
    Continuous fun σ : ℝ => transferMatrix α β (hist.map (Step.deform mStar σ)) := by
  induction hist with
  | nil => simp only [List.map_nil, transferMatrix_nil]; exact continuous_const
  | cons s hist ih =>
    simp only [List.map_cons, transferMatrix_cons]
    exact ih.mul (continuous_matrix_exp.comp (continuous_generator_deform mStar s).neg)

private lemma continuous_sum_trace_deform (mStar : ℝ) (hist : List (Step ι)) :
    Continuous fun σ : ℝ =>
      ((hist.map (Step.deform mStar σ)).map fun s => (s.generator α β).trace).sum := by
  induction hist with
  | nil => simp only [List.map_nil, List.sum_nil]; exact continuous_const
  | cons s hist ih =>
    simp only [List.map_cons, List.sum_cons]
    exact (continuous_generator_deform mStar s).matrix_trace.add ih

/-- Graph node `lem:transfer#homotopy-continuity`: `σ ↦ F(H_σ)` is continuous. -/
theorem continuous_centeredTrace_deform (mStar : ℝ) (hist : List (Step ι)) :
    Continuous fun σ : ℝ => centeredTrace α β (hist.map (Step.deform mStar σ)) := by
  unfold centeredTrace
  exact (Complex.continuous_exp.comp (continuous_const.mul
    (continuous_sum_trace_deform mStar hist))).mul
    (continuous_const.add (continuous_transferMatrix_deform mStar hist)).matrix_det

/-! ### The endpoint `σ = 1` -/

omit [Fintype ι] in
private lemma generator_deform_one (mStar : ℝ) (s : Step ι) :
    (s.deform mStar 1).generator α β =
      ((s.freeTime * mStar : ℝ) : ℂ) • ((1 : Matrix ι ι ℂ) ⊗ₖ β) := by
  rw [generator_deform]
  push_cast
  simp only [sub_self, zero_smul, zero_add, one_mul]
  congr 1
  ring

private lemma transferMatrix_deform_one (mStar : ℝ) (hist : List (Step ι)) :
    transferMatrix α β (hist.map (Step.deform mStar 1)) =
      NormedSpace.exp (-((((hist.map Step.freeTime).sum * mStar : ℝ) : ℂ) •
        ((1 : Matrix ι ι ℂ) ⊗ₖ β))) := by
  induction hist with
  | nil => simp [transferMatrix_nil]
  | cons s hist ih =>
    rw [List.map_cons, transferMatrix_cons, ih, generator_deform_one, ←
      Matrix.exp_add_of_commute]
    · congr 1
      simp only [List.map_cons, List.sum_cons]
      push_cast
      module
    · exact ((Commute.refl _).smul_left _).smul_right _ |>.neg_left |>.neg_right

/-- `det (1 + exp (c H))` is a positive real for `H` Hermitian and `c` real. -/
theorem det_one_add_exp_smul_of_isHermitian {n : Type*} [Fintype n] [DecidableEq n]
    {H : Matrix n n ℂ} (hH : H.IsHermitian) (c : ℝ) :
    (1 + NormedSpace.exp ((c : ℂ) • H)).det =
      ((∏ i, (1 + Real.exp (c * hH.eigenvalues i)) : ℝ) : ℂ) := by
  set U : Matrix n n ℂ := (hH.eigenvectorUnitary : Matrix n n ℂ) with hUdef
  have hUU : star U * U = 1 := Unitary.star_mul_self_of_mem hH.eigenvectorUnitary.2
  have hUinv : U⁻¹ = star U := Matrix.inv_eq_left_inv hUU
  have hUunit : IsUnit U :=
    ⟨⟨U, star U, Unitary.mul_star_self_of_mem hH.eigenvectorUnitary.2, hUU⟩, rfl⟩
  have hspec : H = U * diagonal (fun i => (hH.eigenvalues i : ℂ)) * U⁻¹ := by
    rw [hUinv]
    conv_lhs => rw [hH.spectral_theorem]
    rw [Unitary.conjStarAlgAut_apply]
    rfl
  have hcH : (c : ℂ) • H = U * diagonal (fun i => (c : ℂ) * (hH.eigenvalues i : ℂ)) * U⁻¹ := by
    conv_lhs => rw [hspec]
    rw [← Matrix.smul_mul, ← Matrix.mul_smul, ← diagonal_smul]
    rfl
  have hUV : U * U⁻¹ = 1 := Matrix.mul_nonsing_inv U ((Matrix.isUnit_iff_isUnit_det U).mp hUunit)
  have h1 : ∀ D : Matrix n n ℂ, 1 + U * D * U⁻¹ = U * (1 + D) * U⁻¹ := fun D => by
    rw [mul_add, add_mul, mul_one, hUV]
  rw [hcH, Matrix.exp_conj _ _ hUunit, Matrix.exp_diagonal, h1, Matrix.det_conj hUunit,
    ← diagonal_one, diagonal_add, det_diagonal]
  simp only [Pi.coe_exp, ← Complex.exp_eq_exp_ℂ]
  push_cast
  rfl

/-- Graph node `lem:transfer#homotopy-endpoint`: at `σ = 1` the centered trace is a positive
real number. -/
theorem centeredTrace_deform_one (h : IsDiracClifford α β) {mStar b : ℝ} {hist : List (Step ι)}
    (htime : (hist.map Step.freeTime).sum = b) :
    0 < (centeredTrace α β (hist.map (Step.deform mStar 1))).re ∧
      (centeredTrace α β (hist.map (Step.deform mStar 1))).im = 0 := by
  have hH := h.isHermitian_one_kronecker_β (ι := ι)
  have htr : ∀ s : Step ι, ((s.deform mStar 1).generator α β).trace = 0 := fun s => by
    rw [generator_deform_one, trace_smul, trace_kronecker, h.trace_β, mul_zero, smul_zero]
  have hsum : ((hist.map (Step.deform mStar 1)).map fun s => (s.generator α β).trace).sum =
      0 := by
    rw [List.map_map]
    exact List.sum_eq_zero fun x hx => by
      obtain ⟨s, -, rfl⟩ := List.mem_map.mp hx
      exact htr s
  have hdet := det_one_add_exp_smul_of_isHermitian hH (-(b * mStar))
  unfold centeredTrace
  rw [hsum, mul_zero, Complex.exp_zero, one_mul, transferMatrix_deform_one, htime, ← neg_smul,
    ← Complex.ofReal_neg, hdet, Complex.ofReal_re, Complex.ofReal_im]
  exact ⟨Finset.prod_pos fun i _ => by positivity, rfl⟩

/-! ### Positivity -/

/-- Graph node `lem:transfer#positivity`: if the centered trace does not vanish along the
deformation (graph node `lem:transfer#homotopy-nonvanishing`), it is positive. -/
theorem re_centeredTrace_pos_of_ne_zero (h : IsDiracClifford α β) {mStar : ℝ}
    {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar)
    (hne : ∀ σ ∈ Set.Icc (0 : ℝ) 1, centeredTrace α β (hist.map (Step.deform mStar σ)) ≠ 0) :
    0 < (centeredTrace α β hist).re := by
  set f : ℝ → ℝ := fun σ => (centeredTrace α β (hist.map (Step.deform mStar σ))).re with hf
  have hcont : Continuous f :=
    Complex.continuous_re.comp (continuous_centeredTrace_deform mStar hist)
  have him : ∀ σ ∈ Set.Icc (0 : ℝ) 1,
      (centeredTrace α β (hist.map (Step.deform mStar σ))).im = 0 := by
    intro σ hσ
    apply im_centeredTrace h
    intro t ht
    obtain ⟨s, hs, rfl⟩ := List.mem_map.mp ht
    exact ((hadm s hs).deform hσ.1 hσ.2).isHermitianData
  have hf1 : 0 < f 1 := (centeredTrace_deform_one h rfl).1
  have hmap0 : hist.map (Step.deform mStar 0) = hist := by
    rw [show Step.deform mStar 0 = (id : Step ι → Step ι) from funext (Step.deform_zero mStar),
      List.map_id]
  have hf0 : f 0 = (centeredTrace α β hist).re := by rw [hf]; simp only [hmap0]
  rw [← hf0]
  by_contra hle
  push Not at hle
  obtain ⟨σ, hσ, hfσ⟩ := intermediate_value_Icc zero_le_one hcont.continuousOn
    ⟨hle, hf1.le⟩
  exact hne σ hσ (Complex.ext hfσ (him σ hσ))

end QEDCore.PaperA
