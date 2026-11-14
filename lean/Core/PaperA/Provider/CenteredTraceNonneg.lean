/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime

/-!
# Provider for the nonnegative-mass remark after Paper A, Lemma 3.1

This module will prove `QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass`, whose statement
must be exactly that of the frozen anchor `Frozen/PaperA/CenteredTraceNonneg.lean`
(manifest entry `rem_nonneg_mass_v1`). The anchor is sealed by replacing its `by sorry` with an
exact use of that theorem.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`). It may import the sealed anchors of Lemmas 3.1 and 3.2.
-/
