/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.LinearAlgebra.Matrix.Kronecker
import Mathlib.Basic.Complex.Basic

/-! Frozen definition `def_dirac_operator_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, model.tex lines 27–38
and transfer.tex line 13. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker

/-- `h = Σ_j α_j v_j + β M` on `ℓ²(ι) ⊗ ℂ⁴`, the spatial factor first
(Paper A, (2.3) and Lemma 3.1). -/
def diracOperator {ι : Type*} (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ) :
    Matrix (ι × Fin 4) (ι × Fin 4) ℂ :=
  ∑ j, v j ⊗ₖ α j + M ⊗ₖ β

end QEDCore.PaperA
