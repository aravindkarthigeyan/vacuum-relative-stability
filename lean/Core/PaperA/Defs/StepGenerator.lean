/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.Step
import Core.PaperA.Defs.DiracOperator

/-! Frozen definition `def_step_generator_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, transfer.tex
lines 20–26 and 83–84. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker

/-- The integral `∫ A dt` of the generator `A = c h + i Φ` of `U' = -A U` over one step:
`τ h` for a free step, and `-i (Θ ⊗ 1)` for the kick `exp (i (Θ ⊗ 1))`. -/
def Step.generator {ι : Type*} (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) : Step ι → Matrix (ι × Fin 4) (ι × Fin 4) ℂ
  | .free τ v M => (τ : ℂ) • diracOperator α β v M
  | .kick Θ => -(Complex.I • (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)))

end QEDCore.PaperA
