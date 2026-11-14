/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- FROZEN_ANCHOR_PREFIX_BEGIN
import Core.PaperA.Provider.CenteredTraceNonneg
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime
import Mathlib.LinearAlgebra.Matrix.PosDef

/-! Frozen theorem `rem_nonneg_mass_v1` (see `lean/frozen-manifest.json`): Paper A, the remark
after Lemma 3.1, transfer.tex lines 89–91, used for `m = 0` in the proof of Theorem 4.1
(comparison.tex lines 98–99), in Lemma 3.1's frozen setting (author ruling R7,
docs/DECISIONS.md, D16). Approved by the author on 2026-11-14. Only the proof body may
change, and only to a short exact use of the provider theorem. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- **Paper A, remark after Lemma 3.1 (nonnegative mass).** If every free step of a
history has a positive semidefinite mass coefficient, the centered trace is real and
nonnegative; it may vanish. -/
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
    (centeredTrace α β hist).im = 0 ∧ 0 ≤ (centeredTrace α β hist).re :=
-- FROZEN_ANCHOR_PROOF_BEGIN
  by sorry
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN

end QEDCore.PaperA
-- FROZEN_ANCHOR_SUFFIX_END
