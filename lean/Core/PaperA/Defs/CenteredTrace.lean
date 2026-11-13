/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.TransferMatrix
import Mathlib.LinearAlgebra.Matrix.Trace
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic
import Mathlib.Analysis.SpecialFunctions.Exp

/-! Frozen definition `def_centered_trace_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, transfer.tex
lines 17–23, equation (3.1). -/

namespace QEDCore.PaperA

open Matrix

/-- The centered finite-CAR trace `F = exp (½ ∫ Tr A) det (I + U)` (Paper A, (3.1)). -/
noncomputable def centeredTrace {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hist : List (Step ι)) : ℂ :=
  Complex.exp ((1 / 2 : ℂ) * (hist.map fun s => (s.generator α β).trace).sum) *
    (1 + transferMatrix α β hist).det

end QEDCore.PaperA
