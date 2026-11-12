/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.LinearAlgebra.Matrix.ConjTranspose
import Mathlib.Tactic

/-!
Conditional algebra of form preservation. Analytic statements asserting that an
ODE propagator or a matrix exponential preserves the form are NOT axioms here:
they are outside this file and must provide the hypotheses of these theorems.
-/

namespace QEDCore

section StarMonoid
variable {A : Type*} [Monoid A] [StarMul A]

def PreservesForm (C U : A) : Prop := star U * C * U = C

theorem preservesForm_mul {C U V : A}
    (hU : PreservesForm C U) (hV : PreservesForm C V) :
    PreservesForm C (U * V) := by
  unfold PreservesForm at *
  calc
    star (U * V) * C * (U * V) = star V * (star U * C * U) * V := by
      simp only [star_mul, mul_assoc]
    _ = star V * C * V := by rw [hU]
    _ = C := hV

theorem preservesForm_one (C : A) : PreservesForm C 1 := by
  simp [PreservesForm]

theorem preservesForm_list_prod (C : A) (L : List A)
    (h : ∀ U ∈ L, PreservesForm C U) : PreservesForm C L.prod := by
  induction L with
  | nil => simpa using preservesForm_one C
  | cons U L ih =>
      simp only [List.prod_cons]
      exact preservesForm_mul (h U (by simp))
        (ih (fun V hV => h V (by simp [hV])))

/-- The inverse-adjoint conjugacy. V is an explicit right inverse, not an
    unproved assertion of invertibility of a physical propagator. -/
theorem adjoint_eq_conjugate_inverse {C U V : A}
    (hC : C * C = 1) (hUV : U * V = 1) (hU : PreservesForm C U) :
    star U = C * V * C := by
  have h : star U * C = C * V := by
    calc
      star U * C = star U * C * (U * V) := by rw [hUV, mul_one]
      _ = (star U * C * U) * V := by simp only [mul_assoc]
      _ = C * V := by rw [hU]
  calc
    star U = (star U * C) * C := by rw [mul_assoc, hC, mul_one]
    _ = C * V * C := by rw [h]
end StarMonoid

/-! These endpoint consequences do not formalize the differential inequality
or Gronwall. B0, BT are real beta-form values and t is the squared modulus of
an eigenvalue, supplied by the analytic/spectral argument. -/

theorem no_unit_factor_of_strict_drop {B0 BT t : ℝ}
    (hdrop : BT < B0) (hendpoint : BT = t * B0) : t ≠ 1 := by
  intro ht
  rw [ht, one_mul] at hendpoint
  linarith

theorem stable_endpoint_positive {B0 BT t : ℝ}
    (hdrop : BT < B0) (hendpoint : BT = t * B0) (ht : t < 1) : 0 < B0 := by
  nlinarith

theorem unstable_endpoint_negative {B0 BT t : ℝ}
    (hdrop : BT < B0) (hendpoint : BT = t * B0) (ht : 1 < t) : B0 < 0 := by
  nlinarith

theorem stable_annulus_from_endpoint {B0 BT t r : ℝ}
    (hB : 0 < B0) (hendpoint : BT = t * B0) (hcontract : BT ≤ r * B0) :
    t ≤ r := by
  nlinarith

theorem unstable_annulus_from_endpoint {B0 BT t r : ℝ}
    (hB : B0 < 0) (hendpoint : BT = t * B0) (hcontract : BT ≤ r * B0) :
    r ≤ t := by
  nlinarith

end QEDCore
