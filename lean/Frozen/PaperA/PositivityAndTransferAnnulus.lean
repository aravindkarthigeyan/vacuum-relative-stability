/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- FROZEN_ANCHOR_PREFIX_BEGIN
import Core.PaperA.Provider.PositivityAndTransferAnnulus
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.LinearAlgebra.Matrix.Charpoly.Basic
import Mathlib.Algebra.Polynomial.Roots
import Mathlib.Analysis.SpecialFunctions.Exp

/-! Frozen theorem `lem_transfer_v1` (see `lean/frozen-manifest.json`): Paper A, Lemma 3.1
`lem:transfer`, transfer.tex lines 9–36, for piecewise-constant histories (author rulings
R1(a)–R4, docs/DECISIONS.md, D11). Approved by the author on 2026-11-12. Only the proof body
may change, and only to a short exact use of the provider theorem. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- **Paper A, Lemma 3.1 (Positivity and the transfer annulus).** For a history of free
evolutions with Dirac operators `Σ_j α_j v_j + β M`, `M ≥ m_* I > 0`, total free time
`b > 0`, interspersed with spin-scalar kicks: the centered trace is positive, exactly `d`
transfer eigenvalues (with algebraic multiplicity) satisfy `|λ| ≤ e^{-b m_*}`, and the
remaining `d` are their partners `1 / conj λ`, of modulus at least `e^{b m_*}`. -/
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
      ¬ ‖z‖ ≤ Real.exp (-(b * mStar)) → Real.exp (b * mStar) ≤ ‖z‖ :=
-- FROZEN_ANCHOR_PROOF_BEGIN
  by sorry
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN

end QEDCore.PaperA
-- FROZEN_ANCHOR_SUFFIX_END
