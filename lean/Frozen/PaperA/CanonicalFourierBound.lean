/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- FROZEN_ANCHOR_PREFIX_BEGIN
import Core.PaperA.Provider.CanonicalFourierBound
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-! Frozen theorem `lem_fourier_v1` (see `lean/frozen-manifest.json`): Paper A, Lemma 3.2
`lem:fourier`, transfer.tex lines 93–104, for piecewise-constant histories (author rulings
R1(a)–R4, docs/DECISIONS.md, D11). Approved by the author on 2026-11-12. Only the proof body
may change, and only to a short exact use of the provider theorem. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- **Paper A, Lemma 3.2 (Canonical Fourier bound).** Append to a history of Lemma 3.1 the
global charge twist `e^{iφQ}`, `Q = dΓ(I) - d`, let `F(φ)` be its centered trace and
`F_q = (2π)⁻¹ ∫_0^{2π} e^{-iqφ} F(φ) dφ`. Then `F_0` is real and, for `|q| ≤ d`,
`|F_q| ≤ binom(2d, d + |q|) e^{-b m_* |q|} F_0`. -/
theorem canonical_fourier_bound
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
    (htime : (hist.map Step.freeTime).sum = b)
    (q : ℤ) (hq : |q| ≤ d) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    (Fhat 0).im = 0 ∧
      ‖Fhat q‖ ≤ ((2 * d).choose (d + q.natAbs) : ℝ) *
        Real.exp (-(b * mStar * |(q : ℝ)|)) * (Fhat 0).re :=
-- FROZEN_ANCHOR_PROOF_BEGIN
  by exact QEDCore.PaperA.Provider.canonical_fourier_bound α β hα_herm hβ_herm hα_sq hβ_sq
      hα_anti hαβ_anti d hd mStar b hm hb hist hfree hkick htime q hq
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN

end QEDCore.PaperA
-- FROZEN_ANCHOR_SUFFIX_END
