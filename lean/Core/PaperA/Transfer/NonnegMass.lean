/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.StepFreeTime
import Core.PaperA.Transfer.History
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Topology.Instances.Matrix
import Mathlib.Topology.UniformSpace.Matrix
import Mathlib.Topology.Order.DenselyOrdered

/-! The mass shift of the remark after Paper A, Lemma 3.1 (transfer.tex L89–L91): "replace
`M` by `M + εI`, apply Lemma 3.1 and pass to the finite-dimensional limit".

`Step.shiftMass ε` replaces the mass coefficient `M` of a free step by `M + ε I` and keeps the
kicks and the free times.

* `rem:nonneg-mass#apply-transfer` (the history part): a free step `free τ v M` of the shifted
  history comes from the step `free τ v (M - ε I)` of the original one
  (`mem_of_free_mem_map_shiftMass`), its kicks are kicks of the original one
  (`mem_of_kick_mem_map_shiftMass`), and its total free time is unchanged
  (`sum_freeTime_map_shiftMass`). So if every mass coefficient of the original history is
  positive semidefinite, the shifted history satisfies the hypotheses of Lemma 3.1 with
  `m_* = ε`; the application of the sealed Lemma 3.1 itself is in the provider
  `Core/PaperA/Provider/CenteredTraceNonneg.lean`.
* `rem:nonneg-mass#continuity`: the shifted generator is `A + (ε τ) (1 ⊗ β)`, affine in `ε`
  (`Step.generator_shiftMass`), so `ε ↦ F_ε` is continuous (`continuous_centeredTrace_shiftMass`)
  and `F_0 = F` (`map_shiftMass_zero`). Hence if `F_ε` is real and nonnegative for every
  `ε > 0`, so is `F`, the set `{z | Im z = 0 ∧ 0 ≤ Re z}` being closed
  (`centeredTrace_nonneg_of_shiftMass`).

Graph nodes served: `rem:nonneg-mass#apply-transfer` (history part), `#continuity`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- The mass shift of transfer.tex L89–L90: the mass coefficient `M` of a free step is
replaced by `M + ε I`; free times, spatial coefficients and kicks are unchanged. -/
def Step.shiftMass {ι : Type*} [DecidableEq ι] (ε : ℝ) : Step ι → Step ι
  | .free τ v M => .free τ v (M + (ε : ℂ) • (1 : Matrix ι ι ℂ))
  | .kick Θ => .kick Θ

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
  {α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ} {β : Matrix (Fin 4) (Fin 4) ℂ}

omit [Fintype ι] in
/-- The shift by `0` is the identity. -/
theorem Step.shiftMass_zero (s : Step ι) : s.shiftMass 0 = s := by
  cases s with
  | free τ v M => simp only [Step.shiftMass, Complex.ofReal_zero, zero_smul, add_zero]
  | kick Θ => rfl

omit [Fintype ι] in
/-- Shifting every step of a history by `0` gives the history back. -/
theorem map_shiftMass_zero (hist : List (Step ι)) : hist.map (Step.shiftMass 0) = hist := by
  rw [show Step.shiftMass 0 = (id : Step ι → Step ι) from funext Step.shiftMass_zero,
    List.map_id]

omit [Fintype ι] in
/-- The mass shift keeps the free time of a step. -/
theorem Step.freeTime_shiftMass (ε : ℝ) (s : Step ι) :
    (s.shiftMass ε).freeTime = s.freeTime := by
  cases s <;> rfl

omit [Fintype ι] in
/-- The mass shift keeps the total free time of a history. -/
theorem sum_freeTime_map_shiftMass (ε : ℝ) (hist : List (Step ι)) :
    ((hist.map (Step.shiftMass ε)).map Step.freeTime).sum = (hist.map Step.freeTime).sum := by
  have h : (Step.freeTime ∘ Step.shiftMass ε : Step ι → ℝ) = Step.freeTime :=
    funext (Step.freeTime_shiftMass ε)
  rw [List.map_map, h]

omit [Fintype ι] in
/-- A free step `free τ v M` of the shifted history is the shift of the step
`free τ v (M - ε I)` of the original history. -/
theorem mem_of_free_mem_map_shiftMass {ε : ℝ} {hist : List (Step ι)} {τ : ℝ}
    {v : Fin 3 → Matrix ι ι ℂ} {M : Matrix ι ι ℂ}
    (h : Step.free τ v M ∈ hist.map (Step.shiftMass ε)) :
    Step.free τ v (M - (ε : ℂ) • (1 : Matrix ι ι ℂ)) ∈ hist := by
  obtain ⟨s, hs, heq⟩ := List.mem_map.mp h
  cases s with
  | free τ' v' M' =>
    simp only [Step.shiftMass, Step.free.injEq] at heq
    obtain ⟨rfl, rfl, rfl⟩ := heq
    rwa [add_sub_cancel_right]
  | kick Θ => simp only [Step.shiftMass, reduceCtorEq] at heq

omit [Fintype ι] in
/-- A kick of the shifted history is a kick of the original history. -/
theorem mem_of_kick_mem_map_shiftMass {ε : ℝ} {hist : List (Step ι)} {Θ : Matrix ι ι ℂ}
    (h : Step.kick Θ ∈ hist.map (Step.shiftMass ε)) : Step.kick Θ ∈ hist := by
  obtain ⟨s, hs, heq⟩ := List.mem_map.mp h
  cases s with
  | free τ v M => simp only [Step.shiftMass, reduceCtorEq] at heq
  | kick Θ' =>
    simp only [Step.shiftMass, Step.kick.injEq] at heq
    subst heq
    exact hs

/-! ### Continuity in the mass shift -/

omit [Fintype ι] in
/-- The generator of a shifted step is affine in the shift: replacing `M` by `M + ε I`
changes `h` by `ε (1 ⊗ β)`. -/
theorem Step.generator_shiftMass (ε : ℝ) (s : Step ι) :
    (s.shiftMass ε).generator α β =
      s.generator α β + ((ε * s.freeTime : ℝ) : ℂ) • ((1 : Matrix ι ι ℂ) ⊗ₖ β) := by
  cases s with
  | free τ v M =>
    simp only [Step.shiftMass, Step.generator, Step.freeTime, diracOperator, add_kronecker,
      smul_kronecker]
    push_cast
    module
  | kick Θ =>
    simp only [Step.shiftMass, Step.freeTime, mul_zero, Complex.ofReal_zero, zero_smul,
      add_zero]

omit [Fintype ι] in
private lemma continuous_generator_shiftMass (s : Step ι) :
    Continuous fun ε : ℝ => (s.shiftMass ε).generator α β := by
  simp only [Step.generator_shiftMass]
  fun_prop

private lemma continuous_matrix_exp_of_shiftMass {n : Type*} [Fintype n] [DecidableEq n] :
    Continuous (NormedSpace.exp : Matrix n n ℂ → Matrix n n ℂ) := by
  exact @NormedSpace.exp_continuous (Matrix n n ℂ) Matrix.linftyOpNormedRing
    Matrix.linftyOpNormedAlgebra (inferInstance : CompleteSpace (Matrix n n ℂ))

private lemma continuous_transferMatrix_shiftMass (hist : List (Step ι)) :
    Continuous fun ε : ℝ => transferMatrix α β (hist.map (Step.shiftMass ε)) := by
  induction hist with
  | nil => simp only [List.map_nil, transferMatrix_nil]; exact continuous_const
  | cons s hist ih =>
    simp only [List.map_cons, transferMatrix_cons]
    exact ih.mul (continuous_matrix_exp_of_shiftMass.comp (continuous_generator_shiftMass s).neg)

private lemma continuous_sum_trace_shiftMass (hist : List (Step ι)) :
    Continuous fun ε : ℝ =>
      ((hist.map (Step.shiftMass ε)).map fun s => (s.generator α β).trace).sum := by
  induction hist with
  | nil => simp only [List.map_nil, List.sum_nil]; exact continuous_const
  | cons s hist ih =>
    simp only [List.map_cons, List.sum_cons]
    exact (continuous_generator_shiftMass s).matrix_trace.add ih

/-- Graph node `rem:nonneg-mass#continuity`: `ε ↦ F_ε` is continuous. -/
theorem continuous_centeredTrace_shiftMass (hist : List (Step ι)) :
    Continuous fun ε : ℝ => centeredTrace α β (hist.map (Step.shiftMass ε)) := by
  unfold centeredTrace
  exact (Complex.continuous_exp.comp (continuous_const.mul
    (continuous_sum_trace_shiftMass hist))).mul
    (continuous_const.add (continuous_transferMatrix_shiftMass hist)).matrix_det

/-- Graph node `rem:nonneg-mass#continuity`, closing step: `F = F_0 = lim_{ε → 0⁺} F_ε`, so
if every `F_ε` with `ε > 0` is real and nonnegative, so is `F`. -/
theorem centeredTrace_nonneg_of_shiftMass {hist : List (Step ι)}
    (hpos : ∀ ε : ℝ, 0 < ε → (centeredTrace α β (hist.map (Step.shiftMass ε))).im = 0 ∧
      0 ≤ (centeredTrace α β (hist.map (Step.shiftMass ε))).re) :
    (centeredTrace α β hist).im = 0 ∧ 0 ≤ (centeredTrace α β hist).re := by
  have hS : IsClosed {z : ℂ | z.im = 0 ∧ 0 ≤ z.re} :=
    (isClosed_eq Complex.continuous_im continuous_const).inter
      (isClosed_le continuous_const Complex.continuous_re)
  have hlim : Filter.Tendsto (fun ε : ℝ => centeredTrace α β (hist.map (Step.shiftMass ε)))
      (nhdsWithin 0 (Set.Ioi 0)) (nhds (centeredTrace α β hist)) := by
    have h := ((continuous_centeredTrace_shiftMass (α := α) (β := β) hist).tendsto 0).mono_left
      (nhdsWithin_le_nhds (s := Set.Ioi 0))
    simpa only [map_shiftMass_zero] using h
  have hev : ∀ᶠ ε in nhdsWithin (0 : ℝ) (Set.Ioi 0),
      centeredTrace α β (hist.map (Step.shiftMass ε)) ∈ {z : ℂ | z.im = 0 ∧ 0 ≤ z.re} :=
    eventually_nhdsWithin_of_forall fun ε hε => hpos ε hε
  exact hS.mem_of_tendsto hlim hev

end QEDCore.PaperA
