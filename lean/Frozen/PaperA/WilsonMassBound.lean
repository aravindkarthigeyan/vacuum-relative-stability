/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- FROZEN_ANCHOR_PREFIX_BEGIN
import Core.PaperA.Provider.WilsonMassBound
import Core.PaperA.Defs.DiracOperator
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Mathlib.Analysis.Complex.Basic
import Mathlib.LinearAlgebra.Matrix.PosDef

/-! Frozen theorem `eq_mass_bound_v1` (see `lean/frozen-manifest.json`): Paper A, display (2.5)
`eq:mass-bound`, model.tex lines 39–46. Approved by the author on 2026-11-14, conditionally on
two clean statement audits, which passed (docs/DECISIONS.md, D16). Only the proof body may
change, and only to a short exact use of the provider theorem. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- **Paper A, (2.5) (Wilson mass bound).** For unit link variables, the Wilson mass satisfies
`M(U) ≥ mI`, and `‖h_W(U)‖ ≤ h_* = m + (3 + 6r)/a`, stated as `h_* • 1 ∓ h_W(U) ⪰ 0`. -/
theorem wilson_mass_bound
    {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (a m r : ℝ) (ha : 0 < a) (hm : 0 ≤ m) (hr : 0 ≤ r)
    (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (hU : ∀ x j, ‖U x j‖ = 1) :
    (wilsonMass n a m r U - (m : ℂ) • 1).PosSemidef ∧
      (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 -
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef ∧
      (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 +
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef :=
-- FROZEN_ANCHOR_PROOF_BEGIN
  by sorry
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN

end QEDCore.PaperA
-- FROZEN_ANCHOR_SUFFIX_END
