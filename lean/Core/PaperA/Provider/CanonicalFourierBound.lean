/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime

/-!
# Provider for Paper A, Lemma 3.2 (`lem:fourier`)

This module will prove `QEDCore.PaperA.Provider.canonical_fourier_bound`, whose statement
must be exactly that of the frozen anchor `Frozen/PaperA/CanonicalFourierBound.lean`
(manifest entry `lem_fourier_v1`). The anchor is sealed by replacing its `by sorry` with an
exact use of that theorem.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`). It must not import the Lemma 3.1 anchor or provider
while either is quarantined; it consumes the results of Lemma 3.1 from the ordinary,
`sorry`-free modules that prove its dependency-graph nodes.
-/
