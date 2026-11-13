/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.StepGenerator
import Mathlib.Analysis.Normed.Algebra.MatrixExponential

/-! Frozen definition `def_transfer_matrix_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, transfer.tex
lines 11–21 (`U' = -A U`). -/

namespace QEDCore.PaperA

open Matrix

/-- The one-particle transfer matrix `U` of a history: the ordered product of the step
propagators `exp (-∫A)`, later steps on the left. -/
noncomputable def transferMatrix {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hist : List (Step ι)) : Matrix (ι × Fin 4) (ι × Fin 4) ℂ :=
  (hist.map fun s => NormedSpace.exp (-(s.generator α β))).reverse.prod

end QEDCore.PaperA
