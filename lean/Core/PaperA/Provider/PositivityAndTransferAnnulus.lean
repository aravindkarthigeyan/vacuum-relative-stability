/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime
import Core.PaperA.Transfer.Annulus
import Core.PaperA.Transfer.Homotopy

/-!
# Provider for Paper A, Lemma 3.1 (`lem:transfer`)

`QEDCore.PaperA.Provider.positivity_and_transfer_annulus` has exactly the statement of the
frozen anchor `Frozen/PaperA/PositivityAndTransferAnnulus.lean` (manifest entry
`lem_transfer_v1`), copied verbatim, and proves it from the graph nodes landed in
`Core/PaperA/Transfer/`:

* `F > 0`: the homotopy of transfer.tex L73-L77 (`re_centeredTrace_pos_of_ne_zero`), with
  nonvanishing along the deformation from `centeredTrace_ne_zero` (the deformed histories are
  admissible and keep total free time `b`), and reality from `im_centeredTrace`;
* the annulus conjuncts: `transferMatrix_annulus` (β-form bounds along the history, spectral
  pairing with algebraic multiplicity, and the count of roots per region).

The anchor is sealed by `by exact` of this theorem applied to its own binders. While the
anchor was `DRAFT_SORRY`, only it could import this module.
-/

namespace QEDCore.PaperA.Provider

open Matrix
open scoped Kronecker ComplexOrder

/-- Proof of Paper A, Lemma 3.1 for piecewise-constant histories; see the frozen anchor. -/
theorem positivity_and_transfer_annulus
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b) :
    (0 < (centeredTrace α β hist).re ∧ (centeredTrace α β hist).im = 0) ∧
    ((transferMatrix α β hist).charpoly.roots.filter
        (fun z => ‖z‖ ≤ Real.exp (-(b * mStar)))).card = d ∧
    (transferMatrix α β hist).charpoly.roots.filter
        (fun z => ¬ ‖z‖ ≤ Real.exp (-(b * mStar))) =
      ((transferMatrix α β hist).charpoly.roots.filter
        (fun z => ‖z‖ ≤ Real.exp (-(b * mStar)))).map (fun z => (star z)⁻¹) ∧
    ∀ z ∈ (transferMatrix α β hist).charpoly.roots,
      ¬ ‖z‖ ≤ Real.exp (-(b * mStar)) → Real.exp (b * mStar) ≤ ‖z‖ := by
  have h : IsDiracClifford α β := ⟨hα_herm, hβ_herm, hα_sq, hβ_sq, hα_anti, hαβ_anti⟩
  have hadm : ∀ s ∈ hist, s.IsAdmissible mStar := isAdmissible_of_mem hfree hkick
  have hb' : 0 < (hist.map Step.freeTime).sum := htime ▸ hb
  refine ⟨⟨?_, im_centeredTrace h fun s hs => (hadm s hs).isHermitianData⟩,
    transferMatrix_annulus h hd hm hb hadm htime⟩
  refine re_centeredTrace_pos_of_ne_zero h hadm fun σ hσ => ?_
  refine centeredTrace_ne_zero h hm (hist := hist.map (Step.deform mStar σ)) ?_ ?_
  · intro s hs
    obtain ⟨s₀, hs₀, rfl⟩ := List.mem_map.1 hs
    exact (hadm s₀ hs₀).deform hσ.1 hσ.2
  · simpa [List.map_map, Function.comp_def, Step.freeTime_deform] using hb'

end QEDCore.PaperA.Provider
