/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.DiracOperator
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Core.PaperA.Wilson.Shift
import Core.PaperA.Wilson.MassBound

/-!
# Provider for Paper A, (2.5) (the Wilson mass bound)

This module proves `QEDCore.PaperA.Provider.wilson_mass_bound`, whose statement is exactly that
of the frozen anchor `Frozen/PaperA/WilsonMassBound.lean` (manifest entry `eq_mass_bound_v1`),
graph node `eq:mass-bound`. The anchor is sealed by replacing its `by sorry` with an exact use of
that theorem.

* First conjunct, `M(U) - m ⪰ 0` (node `eq:mass-bound#mass-lower-bound`):
  `posSemidef_wilsonMass_sub` of `Core.PaperA.Wilson.Shift`, from `2 - T - Tᴴ = (1 - T)ᴴ (1 - T)`.
* Second and third conjuncts, `h_* • 1 ∓ h_W(U) ⪰ 0` with `h_* = m + (3 + 6r)/a` (node
  `eq:mass-bound#norm-bound`): `posSemidef_bound_add_smul_diracOperator` of
  `Core.PaperA.Wilson.MassBound` with `s = -1` and `s = 1`, applied to the lattice shifts
  `T_j = latticeShift n U j`, which satisfy `T_jᴴ T_j = 1` for unit links (node
  `eq:mass-bound#shift-unitary`, `latticeShift_conjTranspose_mul_self`). The hopping matrices
  `wilsonHopping n a U j` and the mass `wilsonMass n a m r U` are passed through their frozen
  definitions (`rfl`).

The Hermiticity of `h_W(U)` that the two-sided form needs (graph nodes
`thm:main#wilson-hopping-hermitian`, `lem:transfer#dirac-hermitian`) is not proved separately:
each conclusion is a sum of matrices `c • Xᴴ X` with `c ≥ 0`, hence Hermitian.
`isHermitian_wilsonHopping` of `Core.PaperA.Wilson.Shift` states the hopping part on its own.
The hypotheses `hn`, `hα_anti` and `hαβ_anti` of the frozen statement are not used.

While the anchor is `DRAFT_SORRY`, only the frozen anchor may import this module
(`scripts/check_frozen_anchors.py`).
-/

namespace QEDCore.PaperA.Provider

open Matrix
open scoped Kronecker ComplexOrder

set_option linter.unusedVariables false in
/-- **Paper A, (2.5) (Wilson mass bound)**, provider for the frozen `eq_mass_bound_v1`. -/
theorem wilson_mass_bound
    {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (a m r : ℝ) (ha : 0 < a) (hm : 0 ≤ m) (hr : 0 ≤ r)
    (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (hU : ∀ x j, ‖U x j‖ = 1) :
    (wilsonMass n a m r U - (m : ℂ) • 1).PosSemidef ∧
      (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 -
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef ∧
      (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 +
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef := by
  have key : ∀ s : ℝ, s * s = 1 →
      (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 +
        (s : ℂ) • diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef :=
    fun s hs => posSemidef_bound_add_smul_diracOperator α β hα_herm hβ_herm hα_sq hβ_sq a m r
      ha hm hr (latticeShift n U) (latticeShift_conjTranspose_mul_self U hU)
      (wilsonHopping n a U) (fun _ => rfl) (wilsonMass n a m r U) rfl s hs
  refine ⟨posSemidef_wilsonMass_sub a m r ha hr U hU, ?_, ?_⟩
  · have h := key (-1) (by norm_num)
    rwa [Complex.ofReal_neg, Complex.ofReal_one, neg_one_smul, ← sub_eq_add_neg] at h
  · have h := key 1 (by norm_num)
    rwa [Complex.ofReal_one, one_smul] at h

end QEDCore.PaperA.Provider
