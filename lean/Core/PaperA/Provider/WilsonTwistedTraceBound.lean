/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass

/-!
# Provider for a proof step of Paper A, Theorem 4.1 (`thm:main`)

This module will prove `QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound`, whose statement
must be exactly that of the frozen anchor `Frozen/PaperA/WilsonTwistedTraceBound.lean`
(manifest entry `main_twisted_integrand_v1`). The anchor is sealed by replacing its `by sorry` with an
exact use of that theorem.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`). It may import the sealed anchors of Lemmas 3.1 and 3.2.
-/
