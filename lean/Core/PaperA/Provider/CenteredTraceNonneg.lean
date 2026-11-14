/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime
import Core.PaperA.Transfer.NonnegMass
import Frozen.PaperA.PositivityAndTransferAnnulus
import Mathlib.LinearAlgebra.Matrix.PosDef

/-!
# Provider for the nonnegative-mass remark after Paper A, Lemma 3.1

`QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass` has exactly the statement of
the frozen anchor `Frozen/PaperA/CenteredTraceNonneg.lean` (manifest entry
`rem_nonneg_mass_v1`), copied verbatim, and proves it as transfer.tex L89–L91 does ("replace
`M` by `M + εI`, apply Lemma 3.1 and pass to the finite-dimensional limit"), from the graph
nodes landed in `Core/PaperA/Transfer/NonnegMass.lean`:

* `rem:nonneg-mass#apply-transfer`: for `ε > 0` the shifted history
  `hist.map (Step.shiftMass ε)` (every mass coefficient `M` replaced by `M + ε I`) satisfies
  the hypotheses of the sealed Lemma 3.1 (`QEDCore.PaperA.positivity_and_transfer_annulus`)
  with `d = 2 |ι|`, `m_* = ε` and the same `b`: its free step `free τ v M` comes from the step
  `free τ v (M - ε I)` of `hist`, whose mass coefficient is positive semidefinite, its kicks
  are kicks of `hist`, and its total free time is `b`. So `F_ε` is a positive real.
* `rem:nonneg-mass#continuity`: `ε ↦ F_ε` is continuous with `F_0 = F`, and
  `{z | Im z = 0 ∧ 0 ≤ Re z}` is closed, so `F = lim_{ε → 0⁺} F_ε` is real and nonnegative
  (`centeredTrace_nonneg_of_shiftMass`).

The anchor is sealed by `by exact` of this theorem applied to its own binders. This module
imports the sealed Lemma 3.1 anchor, never its own anchor or any other frozen anchor.
-/

namespace QEDCore.PaperA.Provider

open Matrix
open scoped Kronecker ComplexOrder

/-- Proof of the remark after Paper A, Lemma 3.1 (nonnegative mass) for piecewise-constant
histories; see the frozen anchor. -/
theorem centeredTrace_nonneg_of_posSemidef_mass
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (b : ℝ) (hb : 0 < b) (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ M.PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b) :
    (centeredTrace α β hist).im = 0 ∧ 0 ≤ (centeredTrace α β hist).re := by
  -- `rem:nonneg-mass#continuity`: it suffices to treat the shifted histories, `ε > 0`.
  refine centeredTrace_nonneg_of_shiftMass fun ε hε => ?_
  -- `rem:nonneg-mass#apply-transfer`: Lemma 3.1 for the shifted history, `m_* = ε`.
  obtain ⟨⟨hre, him⟩, -⟩ :=
    QEDCore.PaperA.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
      hαβ_anti (2 * Fintype.card ι) (by ring) ε b hε hb (hist.map (Step.shiftMass ε))
      (fun τ v M h => hfree τ v _ (mem_of_free_mem_map_shiftMass h))
      (fun Θ h => hkick Θ (mem_of_kick_mem_map_shiftMass h))
      (by rw [sum_freeTime_map_shiftMass, htime])
  exact ⟨him, hre.le⟩

end QEDCore.PaperA.Provider
