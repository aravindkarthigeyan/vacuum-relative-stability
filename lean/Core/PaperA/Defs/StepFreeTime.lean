/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.Step

/-! Frozen definition `def_step_free_time_v1` (see `lean/frozen-manifest.json`). Do not edit:
a change needs an author-approved versioned successor. Source: Paper A, transfer.tex
lines 15 and 25 (`∫ c = b`). -/

namespace QEDCore.PaperA

/-- Free time of a step: `τ` for a free step, `0` for a kick. -/
def Step.freeTime {ι : Type*} : Step ι → ℝ
  | .free τ _ _ => τ
  | .kick _ => 0

end QEDCore.PaperA
