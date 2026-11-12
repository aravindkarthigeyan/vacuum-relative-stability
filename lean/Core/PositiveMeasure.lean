/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.MeasureTheory.Integral.Bochner.Basic
import Mathlib.Tactic

namespace QEDCore
open MeasureTheory

/-- This is the comparison step after a positive-measure representation has
been established. It does not assert such a representation for a Hamiltonian. -/
theorem positive_measure_comparison {X : Type*} [MeasurableSpace X]
    (mu : Measure X) (f : X → ℂ) (w : X → ℝ) (B : ℝ)
    (hf : Integrable f mu) (hw : Integrable w mu)
    (h : ∀ᵐ x ∂mu, ‖f x‖ ≤ B * w x) :
    ‖∫ x, f x ∂mu‖ ≤ B * ∫ x, w x ∂mu := by
  calc
    ‖∫ x, f x ∂mu‖ ≤ ∫ x, ‖f x‖ ∂mu := norm_integral_le_integral_norm f
    _ ≤ ∫ x, B * w x ∂mu := integral_mono_ae hf.norm (hw.const_mul B) h
    _ = B * ∫ x, w x ∂mu := integral_const_mul B w

/-- Unit-modulus projection phases preserve the pointwise bound. -/
theorem phase_preserves_bound {phase value : ℂ} {bound : ℝ}
    (hp : ‖phase‖ = 1) (hv : ‖value‖ ≤ bound) :
    ‖phase * value‖ ≤ bound := by simpa [norm_mul, hp] using hv

end QEDCore
