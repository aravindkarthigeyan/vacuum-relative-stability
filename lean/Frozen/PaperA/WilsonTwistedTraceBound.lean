/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- FROZEN_ANCHOR_PREFIX_BEGIN
import Core.PaperA.Provider.WilsonTwistedTraceBound
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-! Frozen theorem `main_twisted_integrand_v1` (see `lean/frozen-manifest.json`): a proof step
of Paper A, Theorem 4.1 `thm:main`, comparison.tex lines 54–91, for piecewise-constant link
histories (author rulings R5, R6 and R8, docs/DECISIONS.md, D16). It is not Theorem 4.1.
Approved by the author on 2026-11-14. Only the proof body may change, and only to a short
exact use of the provider theorem. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- **Paper A, Theorem 4.1, proof step: the twisted Wilson integrand** (comparison.tex
lines 70–72 and 82–89). Follow a piecewise-constant link history of total time `b` on the
torus `X = (ℤ/nℤ)³` by the gauge kick `diag(ϑ + φ)` and let `F(φ)` be its centered trace and
`F_Q = (2π)⁻¹ ∫_0^{2π} e^{-iQφ} F(φ) dφ`. For `m > 0`, `F(φ)` is real and positive, `F_0` is
real, and `|F_Q| ≤ binom(4N, 2N + |Q|) e^{-bm|Q|} F_0` for `|Q| ≤ 2N`, `N = n³`. -/
theorem wilson_twisted_trace_pos_and_fourier_bound
    {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (a m r : ℝ) (ha : 0 < a) (hm : 0 < m) (hr : 0 ≤ r)
    (links : List (ℝ × ((Fin 3 → ZMod n) → Fin 3 → ℂ)))
    (hlinks : ∀ p ∈ links, 0 ≤ p.1 ∧ ∀ x j, ‖p.2 x j‖ = 1)
    (b : ℝ) (hb : 0 < b) (htime : (links.map Prod.fst).sum = b)
    (ϑ : (Fin 3 → ZMod n) → ℝ) (Q : ℤ) (hQ : |Q| ≤ 2 * (n : ℤ) ^ 3) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β
      (links.map (fun p => Step.free p.1 (wilsonHopping n a p.2) (wilsonMass n a m r p.2)) ++
        [Step.kick (Matrix.diagonal fun x => ((ϑ x + φ : ℝ) : ℂ))])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    (∀ φ : ℝ, 0 < (F φ).re ∧ (F φ).im = 0) ∧ (Fhat 0).im = 0 ∧
      ‖Fhat Q‖ ≤ ((4 * n ^ 3).choose (2 * n ^ 3 + Q.natAbs) : ℝ) *
        Real.exp (-(b * m * |(Q : ℝ)|)) * (Fhat 0).re :=
-- FROZEN_ANCHOR_PROOF_BEGIN
  by sorry
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN

end QEDCore.PaperA
-- FROZEN_ANCHOR_SUFFIX_END
