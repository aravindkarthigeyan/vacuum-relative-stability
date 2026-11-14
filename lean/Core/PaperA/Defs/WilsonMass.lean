/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.LatticeShift
import Mathlib.LinearAlgebra.Matrix.ConjTranspose

/-! Frozen definition `def_wilson_mass_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, model.tex lines 27–35,
equation (2.3)
(author approval of 2026-11-14, docs/DECISIONS.md, D16). -/

namespace QEDCore.PaperA

open Matrix

/-- The Wilson mass `M(U) = m + (r / 2a) Σ_j (2 - T_j(U) - T_j(U)^*)` (Paper A, (2.3)). -/
noncomputable def wilsonMass (n : ℕ) (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) :
    Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ :=
  (m : ℂ) • 1 +
    ((r / (2 * a) : ℝ) : ℂ) • ∑ j, ((2 : ℂ) • 1 - latticeShift n U j - (latticeShift n U j)ᴴ)

end QEDCore.PaperA
