/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.DiracOperator
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass

/-!
# Provider for the gauge covariance of the Wilson operator (Paper A, model.tex line 71)

This module will prove `QEDCore.PaperA.Provider.wilson_gauge_covariance`, whose statement
must be exactly that of the frozen anchor `Frozen/PaperA/WilsonGaugeCovariance.lean`
(manifest entry `gauge_covariance_v1`). The anchor is sealed by replacing its `by sorry` with an
exact use of that theorem.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`).
-/
