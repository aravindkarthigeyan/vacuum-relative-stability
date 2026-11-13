/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Analysis.Normed.Algebra.MatrixExponential
import Mathlib.Analysis.Matrix.Normed
import Mathlib.Analysis.SpecialFunctions.Exponential
import Mathlib.Analysis.Calculus.Deriv.MeanValue
import Mathlib.Analysis.SpecialFunctions.ExpDeriv
import Mathlib.LinearAlgebra.Matrix.PosDef

/-! The β-form of Paper A, Lemma 3.1 (transfer.tex L52–L70), read on one free step.

Graph nodes served: `eq:beta-form`, `lem:transfer#norm-bounds-beta-form`,
`lem:transfer#strict-decrease` and the two Gronwall integrations, and
`lem:transfer#kick-preserves-beta-form`.

For `g(t) = exp (-t H) f` and `B(t) = Re ⟨g, P g⟩`, with `H` Hermitian, `P` a Hermitian
involution and `H P + P H ≥ 2 m`, one has `B'(t) = -Re ⟨g, (H P + P H) g⟩ ≤ -2 m ‖g‖²`
(`hasDerivAt_betaForm_exp`, `two_mul_le_of_posSemidef`). Since `P` is unitary,
`|B| ≤ ‖g‖²` (`abs_betaForm_le`), hence both `B' ≤ -2 m B` and `B' ≤ 2 m B` hold at every
time, whatever the sign of `B`. The integrating factors `e^{± 2 m t}` then give the two
bounds of `betaForm_exp_le` unconditionally: no sign condition on `B` is needed, so the
source's case split on the sign of the trajectory (`|λ| < 1` versus `|λ| > 1`) is not needed
here. If `f ≠ 0` then `g(t) ≠ 0` (the exponential is invertible), so `B' < 0` and `B` is
strictly decreasing (`betaForm_exp_lt`). A kick `exp (i K)` with `K` Hermitian commuting with
`P` is unitary and commutes with `P`, so it leaves `B` unchanged (`betaForm_exp_kick`).

The derivative is computed with the `L∞` operator norm on matrices, installed as a local
instance only inside the proof section; all statements use the default matrix topology. -/

namespace QEDCore.PaperA

open Matrix
open scoped ComplexOrder

/-- The β-form `Re ⟨f, P f⟩`. -/
noncomputable def betaForm {n : Type*} [Fintype n] (P : Matrix n n ℂ) (f : n → ℂ) : ℝ :=
  (star f ⬝ᵥ (P *ᵥ f)).re

section Algebra

variable {n : Type*} [Fintype n]

private lemma star_mulVec_dotProduct_mulVec (A M : Matrix n n ℂ) (f : n → ℂ) :
    star (A *ᵥ f) ⬝ᵥ (M *ᵥ (A *ᵥ f)) = star f ⬝ᵥ ((Aᴴ * M * A) *ᵥ f) := by
  rw [star_mulVec, ← dotProduct_mulVec, mulVec_mulVec, mulVec_mulVec]

private lemma star_mulVec_dotProduct_self (A : Matrix n n ℂ) (f : n → ℂ) :
    star (A *ᵥ f) ⬝ᵥ (A *ᵥ f) = star f ⬝ᵥ ((Aᴴ * A) *ᵥ f) := by
  rw [star_mulVec, ← dotProduct_mulVec, mulVec_mulVec]

/-- The β-form transported by a matrix `A`: `Re ⟨A f, P A f⟩ = Re ⟨f, Aᴴ P A f⟩`. -/
theorem betaForm_mulVec (P A : Matrix n n ℂ) (f : n → ℂ) :
    betaForm P (A *ᵥ f) = (star f ⬝ᵥ ((Aᴴ * P * A) *ᵥ f)).re := by
  rw [betaForm, star_mulVec_dotProduct_mulVec]

private lemma re_dotProduct_star_self_nonneg (v : n → ℂ) : 0 ≤ (star v ⬝ᵥ v).re := by
  simpa using (Complex.le_def.mp (dotProduct_star_self_nonneg v)).1

private lemma re_dotProduct_star_self_pos {v : n → ℂ} (hv : v ≠ 0) : 0 < (star v ⬝ᵥ v).re := by
  simpa using (Complex.lt_def.mp (dotProduct_star_self_pos_iff.mpr hv)).1

variable [DecidableEq n]

/-- Node `lem:transfer#norm-bounds-beta-form`: for a Hermitian involution `P`,
`|Re ⟨g, P g⟩| ≤ ‖g‖²`. -/
theorem abs_betaForm_le {P : Matrix n n ℂ} (hP : P.IsHermitian) (hPP : P * P = 1)
    (g : n → ℂ) : |betaForm P g| ≤ (star g ⬝ᵥ g).re := by
  have hplus : 0 ≤ (star g ⬝ᵥ g).re + betaForm P g := by
    have h := re_dotProduct_star_self_nonneg ((1 + P) *ᵥ g)
    have e : (1 + P)ᴴ * (1 + P) = (1 + P) + (1 + P) := by
      rw [conjTranspose_add, conjTranspose_one, hP.eq,
        show (1 + P) * (1 + P) = 1 + P + P + P * P by noncomm_ring, hPP]
      abel
    rw [star_mulVec_dotProduct_self, e] at h
    simp only [add_mulVec, one_mulVec, dotProduct_add, Complex.add_re] at h
    unfold betaForm; linarith
  have hminus : 0 ≤ (star g ⬝ᵥ g).re - betaForm P g := by
    have h := re_dotProduct_star_self_nonneg ((1 - P) *ᵥ g)
    have e : (1 - P)ᴴ * (1 - P) = (1 - P) + (1 - P) := by
      rw [conjTranspose_sub, conjTranspose_one, hP.eq,
        show (1 - P) * (1 - P) = 1 - P - P + P * P by noncomm_ring, hPP]
      abel
    rw [star_mulVec_dotProduct_self, e] at h
    simp only [add_mulVec, sub_mulVec, one_mulVec, dotProduct_add, dotProduct_sub,
      Complex.add_re, Complex.sub_re] at h
    unfold betaForm; linarith
  exact abs_le.mpr ⟨by linarith, by linarith⟩

/-- Node `lem:transfer#kick-preserves-beta-form`: a kick `exp (i K)` with `K` Hermitian and
commuting with `P` leaves the β-form unchanged. -/
theorem betaForm_exp_kick {K P : Matrix n n ℂ} (hK : K.IsHermitian) (hKP : K * P = P * K)
    (f : n → ℂ) : betaForm P (NormedSpace.exp (Complex.I • K) *ᵥ f) = betaForm P f := by
  have hstar : (NormedSpace.exp (Complex.I • K))ᴴ = NormedSpace.exp (-(Complex.I • K)) := by
    rw [← Matrix.exp_conjTranspose, conjTranspose_smul, hK.eq, Complex.star_def, Complex.conj_I,
      neg_smul]
  have hcomm : Commute P (NormedSpace.exp (Complex.I • K)) :=
    ((show Commute K P from hKP).symm.smul_right Complex.I).exp_right
  have hUU : (NormedSpace.exp (Complex.I • K))ᴴ * NormedSpace.exp (Complex.I • K) = 1 := by
    rw [hstar, ← Matrix.exp_add_of_commute _ _ (Commute.refl (Complex.I • K)).neg_left,
      neg_add_cancel, NormedSpace.exp_zero]
  rw [betaForm_mulVec, Matrix.mul_assoc, hcomm.eq, ← Matrix.mul_assoc, hUU, Matrix.one_mul,
    betaForm]

omit [Fintype n] [DecidableEq n] in
private lemma neg_ofReal_smul (H : Matrix n n ℂ) (τ : ℝ) : -((τ : ℂ) • H) = τ • -H := by
  ext i j; simp [Complex.real_smul]

private lemma exp_mulVec_ne_zero (A : Matrix n n ℂ) {f : n → ℂ} (hf : f ≠ 0) :
    NormedSpace.exp A *ᵥ f ≠ 0 := by
  intro h
  apply hf
  have hinj := Matrix.mulVec_injective_iff_isUnit.mpr (Matrix.isUnit_exp A)
  exact hinj (by rw [h, mulVec_zero])

/-- The coercivity `H P + P H ≥ 2 m` read on a vector: `2 m ‖g‖² ≤ Re ⟨g, (H P + P H) g⟩`. -/
theorem two_mul_le_of_posSemidef {H P : Matrix n n ℂ} {m : ℝ}
    (hHP : (H * P + P * H - ((2 * m : ℝ) : ℂ) • (1 : Matrix n n ℂ)).PosSemidef) (g : n → ℂ) :
    2 * m * (star g ⬝ᵥ g).re ≤ (star g ⬝ᵥ ((H * P + P * H) *ᵥ g)).re := by
  have h := (Complex.le_def.mp (hHP.dotProduct_mulVec_nonneg g)).1
  simp only [sub_mulVec, smul_mulVec, one_mulVec, dotProduct_sub, dotProduct_smul,
    Complex.zero_re, Complex.sub_re, smul_eq_mul, Complex.re_ofReal_mul] at h
  linarith

end Algebra

section Analysis

variable {n : Type*} [Fintype n] [DecidableEq n]

private lemma conjTranspose_exp_smul_neg {H : Matrix n n ℂ} (hH : H.IsHermitian) (u : ℝ) :
    (NormedSpace.exp (u • -H))ᴴ = NormedSpace.exp (u • -H) := by
  rw [← Matrix.exp_conjTranspose]
  congr 1
  rw [conjTranspose_smul, conjTranspose_neg, hH.eq, star_trivial]

attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra

/-- The real-linear functional `M ↦ Re ⟨f, M f⟩` on matrices. -/
private noncomputable def quadCLM (f : n → ℂ) : Matrix n n ℂ →L[ℝ] ℝ :=
  LinearMap.toContinuousLinearMap
  { toFun := fun M => (star f ⬝ᵥ (M *ᵥ f)).re
    map_add' := fun M N => by simp [Matrix.add_mulVec, dotProduct_add]
    map_smul' := fun c M => by simp [Matrix.smul_mulVec, dotProduct_smul] }

/-- Equation `eq:beta-form` on one free step: along `g(u) = exp (u • -H) f`, the β-form has
derivative `-Re ⟨g, (H P + P H) g⟩`. -/
theorem hasDerivAt_betaForm_exp {H : Matrix n n ℂ} (hH : H.IsHermitian) (P : Matrix n n ℂ)
    (f : n → ℂ) (t : ℝ) :
    HasDerivAt (fun u : ℝ => betaForm P (NormedSpace.exp (u • -H) *ᵥ f))
      (-(star (NormedSpace.exp (t • -H) *ᵥ f) ⬝ᵥ
          ((H * P + P * H) *ᵥ (NormedSpace.exp (t • -H) *ᵥ f))).re) t := by
  have hE1 := hasDerivAt_exp_smul_const (𝕂 := ℝ) (-H) t
  have hE2 := hasDerivAt_exp_smul_const' (𝕂 := ℝ) (-H) t
  have hQ := (quadCLM f).hasFDerivAt.comp_hasDerivAt t ((hE1.mul_const P).mul hE2)
  have hfun : (fun u : ℝ => betaForm P (NormedSpace.exp (u • -H) *ᵥ f)) =
      fun u : ℝ => quadCLM f (NormedSpace.exp (u • -H) * P * NormedSpace.exp (u • -H)) := by
    funext u
    rw [betaForm_mulVec, conjTranspose_exp_smul_neg hH]
    rfl
  rw [hfun]
  convert hQ using 1
  · funext u; rfl
  rw [star_mulVec_dotProduct_mulVec, conjTranspose_exp_smul_neg hH]
  show _ = (star f ⬝ᵥ (_ *ᵥ f)).re
  rw [← Complex.neg_re, ← dotProduct_neg, ← neg_mulVec]
  congr 3
  noncomm_ring

end Analysis

section Gronwall

/-- Integrating factor: if `B' + c B ≤ 0` everywhere then `B τ ≤ e^{-c τ} B 0` for `τ ≥ 0`. -/
private lemma le_exp_mul_of_hasDerivAt {B B' : ℝ → ℝ} {c τ : ℝ}
    (hB : ∀ u, HasDerivAt B (B' u) u) (hle : ∀ u, B' u + c * B u ≤ 0) (hτ : 0 ≤ τ) :
    B τ ≤ Real.exp (-(c * τ)) * B 0 := by
  have hφ : ∀ u, HasDerivAt (fun u => Real.exp (c * u) * B u)
      (Real.exp (c * u) * c * B u + Real.exp (c * u) * B' u) u := by
    intro u
    have h1 : HasDerivAt (fun u => Real.exp (c * u)) (Real.exp (c * u) * c) u := by
      simpa using ((hasDerivAt_id u).const_mul c).exp
    exact h1.mul (hB u)
  have hanti := antitone_of_hasDerivAt_nonpos hφ (fun u => by
    have hpos := Real.exp_pos (c * u)
    have e : Real.exp (c * u) * c * B u + Real.exp (c * u) * B' u =
        Real.exp (c * u) * (B' u + c * B u) := by ring
    simp only [Pi.zero_apply]
    rw [e]
    exact mul_nonpos_of_nonneg_of_nonpos hpos.le (hle u))
  have h0 := hanti hτ
  simp only [mul_zero, Real.exp_zero, one_mul] at h0
  rw [Real.exp_neg, ← div_eq_inv_mul, le_div_iff₀' (Real.exp_pos _)]
  exact h0

end Gronwall

/-- Lemma 3.1, Gronwall steps on one free step: both `B(τ) ≤ e^{-2 m τ} B(0)` and
`B(τ) ≤ e^{2 m τ} B(0)`, with no sign condition on `B`. -/
theorem betaForm_exp_le {n : Type*} [Fintype n] [DecidableEq n] {H P : Matrix n n ℂ} {m τ : ℝ}
    (hH : H.IsHermitian) (hP : P.IsHermitian) (hPP : P * P = 1) (hm : 0 < m)
    (hHP : (H * P + P * H - ((2 * m : ℝ) : ℂ) • (1 : Matrix n n ℂ)).PosSemidef)
    (hτ : 0 ≤ τ) (f : n → ℂ) :
    betaForm P (NormedSpace.exp (-((τ : ℂ) • H)) *ᵥ f) ≤ Real.exp (-(2 * m * τ)) * betaForm P f ∧
      betaForm P (NormedSpace.exp (-((τ : ℂ) • H)) *ᵥ f) ≤ Real.exp (2 * m * τ) * betaForm P f := by
  rw [neg_ofReal_smul]
  have hB := hasDerivAt_betaForm_exp hH P f
  have hB0 : betaForm P (NormedSpace.exp ((0 : ℝ) • -H) *ᵥ f) = betaForm P f := by
    rw [zero_smul, NormedSpace.exp_zero, one_mulVec]
  have hD : ∀ u : ℝ, -(star (NormedSpace.exp (u • -H) *ᵥ f) ⬝ᵥ
      ((H * P + P * H) *ᵥ (NormedSpace.exp (u • -H) *ᵥ f))).re ≤
        -(2 * m * |betaForm P (NormedSpace.exp (u • -H) *ᵥ f)|) := by
    intro u
    have h1 := two_mul_le_of_posSemidef hHP (NormedSpace.exp (u • -H) *ᵥ f)
    have h2 := mul_le_mul_of_nonneg_left (abs_betaForm_le hP hPP (NormedSpace.exp (u • -H) *ᵥ f))
      (by linarith : (0 : ℝ) ≤ 2 * m)
    linarith
  constructor
  · have h := le_exp_mul_of_hasDerivAt (c := 2 * m) hB (fun u => by
      have h1 := hD u
      have h2 := mul_le_mul_of_nonneg_left
        (le_abs_self (betaForm P (NormedSpace.exp (u • -H) *ᵥ f))) (by linarith : (0 : ℝ) ≤ 2 * m)
      linarith) hτ
    rwa [hB0] at h
  · have h := le_exp_mul_of_hasDerivAt (c := -(2 * m)) hB (fun u => by
      have h1 := hD u
      have h2 := mul_le_mul_of_nonneg_left
        (neg_le_abs (betaForm P (NormedSpace.exp (u • -H) *ᵥ f))) (by linarith : (0 : ℝ) ≤ 2 * m)
      linarith) hτ
    rwa [hB0, neg_mul, neg_neg] at h

-- Strict decrease only uses `B' ≤ -2 m ‖g‖² < 0`: the involution hypotheses `hP`, `hPP` are
-- kept so that the statement matches the campaign interface, but the proof does not use them.
set_option linter.unusedVariables false in
/-- Lemma 3.1, strict decrease on one free step: for `f ≠ 0` and `τ > 0`, `B(τ) < B(0)`. -/
theorem betaForm_exp_lt {n : Type*} [Fintype n] [DecidableEq n] {H P : Matrix n n ℂ} {m τ : ℝ}
    (hH : H.IsHermitian) (hP : P.IsHermitian) (hPP : P * P = 1) (hm : 0 < m)
    (hHP : (H * P + P * H - ((2 * m : ℝ) : ℂ) • (1 : Matrix n n ℂ)).PosSemidef)
    (hτ : 0 < τ) {f : n → ℂ} (hf : f ≠ 0) :
    betaForm P (NormedSpace.exp (-((τ : ℂ) • H)) *ᵥ f) < betaForm P f := by
  rw [neg_ofReal_smul]
  have hB := hasDerivAt_betaForm_exp hH P f
  have hneg : ∀ u : ℝ, -(star (NormedSpace.exp (u • -H) *ᵥ f) ⬝ᵥ
      ((H * P + P * H) *ᵥ (NormedSpace.exp (u • -H) *ᵥ f))).re < 0 := by
    intro u
    have h1 := two_mul_le_of_posSemidef hHP (NormedSpace.exp (u • -H) *ᵥ f)
    have h2 := mul_pos (by linarith : (0 : ℝ) < 2 * m)
      (re_dotProduct_star_self_pos (exp_mulVec_ne_zero (u • -H) hf))
    linarith
  have h := strictAnti_of_hasDerivAt_neg hB hneg hτ
  simp only [zero_smul, NormedSpace.exp_zero, one_mulVec] at h
  exact h

end QEDCore.PaperA
