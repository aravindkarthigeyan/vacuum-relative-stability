/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime

/-!
# Provider for Paper A, Lemma 3.1 (`lem:transfer`)

This module will prove `QEDCore.PaperA.Provider.positivity_and_transfer_annulus`, whose
statement must be exactly that of the frozen anchor
`Frozen/PaperA/PositivityAndTransferAnnulus.lean` (manifest entry `lem_transfer_v1`).
The anchor is sealed by replacing its `by sorry` with an exact use of that theorem.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`).
-/
