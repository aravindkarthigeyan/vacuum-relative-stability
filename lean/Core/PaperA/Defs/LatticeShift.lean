/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Matrix.Basic
import Mathlib.Data.ZMod.Basic
import Mathlib.Basic.Complex.Basic

/-! Frozen definition `def_lattice_shift_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, model.tex lines 27–32,
equation (2.3)
(author approval of 2026-11-14, docs/DECISIONS.md, D16). -/

namespace QEDCore.PaperA

/-- The link shift `T_j(U)` of Paper A, (2.3): `(T_j(U) f)(x) = conj(U_{x j}) f(x + e_j)` on the
torus `X = (ℤ/nℤ)³`, where `e_j = Pi.single j 1` and `U_{x j}` is the link variable on the link
from `x` to `x + e_j`. -/
def latticeShift (n : ℕ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (j : Fin 3) :
    Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ :=
  Matrix.of fun x y => if y = x + Pi.single j 1 then star (U x j) else 0

end QEDCore.PaperA
