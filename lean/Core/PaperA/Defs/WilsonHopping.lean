/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.LatticeShift
import Mathlib.LinearAlgebra.Matrix.ConjTranspose

/-! Frozen definition `def_wilson_hopping_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, model.tex lines 27–32,
equation (2.3)
(author approval of 2026-11-14, docs/DECISIONS.md, D16). -/

namespace QEDCore.PaperA

open Matrix

/-- `v_j(U) = (T_j(U) - T_j(U)^*) / (2 i a)` (Paper A, (2.3)). -/
noncomputable def wilsonHopping (n : ℕ) (a : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (j : Fin 3) :
    Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ :=
  (2 * Complex.I * (a : ℂ))⁻¹ • (latticeShift n U j - (latticeShift n U j)ᴴ)

end QEDCore.PaperA
