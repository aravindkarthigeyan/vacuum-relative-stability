/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
-- FROZEN_ANCHOR_PREFIX_BEGIN
import Core.PaperA.Provider.WilsonGaugeCovariance
import Core.PaperA.Defs.DiracOperator
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Mathlib.Analysis.Complex.Basic

/-! Frozen theorem `gauge_covariance_v1` (see `lean/frozen-manifest.json`): Paper A, gauge
covariance of the Wilson operator, model.tex lines 64–71. Approved by the author on 2026-11-14,
conditionally on two clean statement audits, which passed (docs/DECISIONS.md, D16). Only the
proof body may change, and only to a short exact use of the provider theorem. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

/-- **Paper A, gauge covariance of the Wilson operator** (model.tex line 71). For a gauge
function `u` with `|u_x| = 1` and `U^u_{xj} = u_x U_{xj} conj(u_{x+e_j})`,
`h_W(U^u) = u^* h_W(U) u`, with `u` acting on the spatial factor. -/
theorem wilson_gauge_covariance
    {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (u : (Fin 3 → ZMod n) → ℂ) (hu : ∀ x, ‖u x‖ = 1) :
    diracOperator α β
        (wilsonHopping n a fun x j => u x * U x j * star (u (x + Pi.single j 1)))
        (wilsonMass n a m r fun x j => u x * U x j * star (u (x + Pi.single j 1))) =
      ((Matrix.diagonal u)ᴴ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) *
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U) *
        (Matrix.diagonal u ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) :=
-- FROZEN_ANCHOR_PROOF_BEGIN
  by exact QEDCore.PaperA.Provider.wilson_gauge_covariance hn α β a m r U u hu
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN

end QEDCore.PaperA
-- FROZEN_ANCHOR_SUFFIX_END
