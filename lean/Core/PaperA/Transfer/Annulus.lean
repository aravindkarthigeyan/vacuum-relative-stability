/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.StepFreeTime
import Core.PaperA.Transfer.History
import Core.PaperA.Transfer.BetaForm
import Core.PaperA.Transfer.RootCount
import Core.PaperA.Fourier.DetProd

/-! The eigenvalue dichotomy along a history and the transfer annulus of Paper A, Lemma 3.1
(transfer.tex L52–L73), for piecewise-constant histories.

Write `P = 1 ⊗ β` and `B(f) = Re ⟨f, P f⟩` (`betaForm`), `U` for the transfer matrix and `b`
for the total free time.

* Transport (`betaForm_transferMatrix_le`): by induction on the history with
  `transferMatrix_cons`, `U (s :: rest) f = U rest (E_s f)`. A free step `E_s = exp (-τ h)`
  satisfies both `B (E_s f) ≤ e^{∓ 2 m_* τ} B f` (`betaForm_exp_le`, with
  `h P + P h = 2 (M ⊗ 1) ≥ 2 m_*`); a kick `E_s = exp (i (Θ ⊗ 1))` leaves `B` unchanged
  (`betaForm_exp_kick`). Multiplying by the positive exponentials gives
  `B (U f) ≤ e^{-2 m_* b} B f` and `B (U f) ≤ e^{2 m_* b} B f`, with no sign condition.
* Strict decrease (`betaForm_transferMatrix_lt`): the two bounds give `B (U f) ≤ B f` for
  every history; a free step of positive duration decreases `B` strictly on `f ≠ 0`.
* Dichotomy (`norm_charpoly_root_dichotomy`): for an eigenvector `U v = z v`,
  `B (U v) = |z|² B v`. If `B v > 0` the first bound gives `|z| ≤ e^{-b m_*}`; if `B v < 0`
  the second gives `|z| ≥ e^{b m_*}`; `B v = 0` contradicts the strict decrease.
* Count (`transferMatrix_annulus`): `annulus_split_of_pairing` with `r = e^{-b m_*}`, the
  spectral pairing from form preservation with `C = 1 ⊗ C₅`, and invertibility of `U`.
* `det (I + U) ≠ 0` (`det_one_add_transferMatrix_ne_zero`): `det (I + U) = Π (1 + λ)` and
  `-1` is not an eigenvalue, since `e^{-b m_*} < 1 < e^{b m_*}`.

Graph nodes served: `lem:transfer#transport`, `#beta-form-monotone`, `#endpoint-relation`,
`#strict-decrease`, `#no-unit-modulus`, `#stable-gronwall`, `#unstable-gronwall`,
`#eigenvalue-count`, `#det-nonvanishing`.

Route: the per-step bounds of `BetaForm` hold without sign conditions, so the source's case
split on the sign of the trajectory (`#stable-trajectory`, `#unstable-trajectory`) is replaced
by a case split on the sign of `B v` at the end. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

variable {ι : Type*} [Fintype ι] [DecidableEq ι]
  {α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ} {β : Matrix (Fin 4) (Fin 4) ℂ}

omit [Fintype ι] [DecidableEq ι] in
private lemma isHermitian_kronecker_one' {Θ : Matrix ι ι ℂ} (hΘ : Θ.IsHermitian) :
    (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)).IsHermitian := by
  unfold Matrix.IsHermitian
  rw [conjTranspose_kronecker, hΘ.eq, conjTranspose_one]

/-- The coercivity `h P + P h - 2 m_* ≥ 0` of a free step, with `P = 1 ⊗ β`. -/
private lemma posSemidef_anticomm_sub (h : IsDiracClifford α β) {mStar : ℝ}
    (v : Fin 3 → Matrix ι ι ℂ) {M : Matrix ι ι ℂ}
    (hM : (M - (mStar : ℂ) • (1 : Matrix ι ι ℂ)).PosSemidef) :
    (diracOperator α β v M * ((1 : Matrix ι ι ℂ) ⊗ₖ β) +
        ((1 : Matrix ι ι ℂ) ⊗ₖ β) * diracOperator α β v M -
        ((2 * mStar : ℝ) : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ)).PosSemidef := by
  have e : diracOperator α β v M * ((1 : Matrix ι ι ℂ) ⊗ₖ β) +
        ((1 : Matrix ι ι ℂ) ⊗ₖ β) * diracOperator α β v M -
        ((2 * mStar : ℝ) : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) =
      (2 : ℂ) • (M ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ) -
        (mStar : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ)) := by
    rw [add_comm, h.one_kronecker_β_anticomm, smul_sub, smul_smul, Complex.ofReal_mul,
      Complex.ofReal_ofNat]
  rw [e]
  exact (posSemidef_kronecker_one_sub M mStar hM).smul (by norm_num)

/-- One admissible step: both Gronwall bounds `B (E f) ≤ e^{∓ 2 m_* τ} B f`. -/
theorem betaForm_exp_generator_le (h : IsDiracClifford α β) {mStar : ℝ} (hm : 0 < mStar)
    {s : Step ι} (hs : s.IsAdmissible mStar) (f : ι × Fin 4 → ℂ) :
    betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (NormedSpace.exp (-(s.generator α β)) *ᵥ f) ≤
        Real.exp (-(2 * mStar * s.freeTime)) * betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f ∧
      betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (NormedSpace.exp (-(s.generator α β)) *ᵥ f) ≤
        Real.exp (2 * mStar * s.freeTime) * betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
  cases s with
  | free τ v M =>
    have hH := hs.isHermitianData
    obtain ⟨hτ, -, hM⟩ := hs
    simp only [Step.generator, Step.freeTime]
    exact betaForm_exp_le (h.isHermitian_diracOperator hH.1 hH.2) h.isHermitian_one_kronecker_β
      h.one_kronecker_β_mul_self hm (posSemidef_anticomm_sub h v hM) hτ f
  | kick Θ =>
    have hk : betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β)
        (NormedSpace.exp (-((Step.kick Θ : Step ι).generator α β)) *ᵥ f) =
          betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
      simp only [Step.generator, neg_neg]
      exact betaForm_exp_kick (isHermitian_kronecker_one' (show Θ.IsHermitian from hs))
        (one_kronecker_mul_kronecker_one Θ β).symm f
    simp [Step.freeTime, hk]

/-- One admissible step of positive duration strictly decreases `B` on nonzero vectors. -/
theorem betaForm_exp_generator_lt (h : IsDiracClifford α β) {mStar : ℝ} (hm : 0 < mStar)
    {s : Step ι} (hs : s.IsAdmissible mStar) (hτ : 0 < s.freeTime) {f : ι × Fin 4 → ℂ}
    (hf : f ≠ 0) :
    betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (NormedSpace.exp (-(s.generator α β)) *ᵥ f) <
      betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
  cases s with
  | free τ v M =>
    have hH := hs.isHermitianData
    obtain ⟨-, -, hM⟩ := hs
    simp only [Step.generator, Step.freeTime] at hτ ⊢
    exact betaForm_exp_lt (h.isHermitian_diracOperator hH.1 hH.2) h.isHermitian_one_kronecker_β
      h.one_kronecker_β_mul_self hm (posSemidef_anticomm_sub h v hM) hτ hf
  | kick Θ => simp [Step.freeTime] at hτ

private lemma freeTime_nonneg {mStar : ℝ} {s : Step ι} (hs : s.IsAdmissible mStar) :
    0 ≤ s.freeTime := by
  cases s with
  | free τ v M => exact hs.1
  | kick Θ => simp [Step.freeTime]

private lemma sum_freeTime_nonneg {mStar : ℝ} {hist : List (Step ι)}
    (hadm : ∀ s ∈ hist, s.IsAdmissible mStar) : 0 ≤ (hist.map Step.freeTime).sum :=
  List.sum_nonneg (fun x hx => by
    obtain ⟨s, hs, rfl⟩ := List.mem_map.mp hx
    exact freeTime_nonneg (hadm s hs))

/-- Two Gronwall bounds `y ≤ e^{-T} x` and `y ≤ e^{T} x` with `T ≥ 0` give `y ≤ x`. -/
private lemma le_of_two_bounds {x y T : ℝ} (hT : 0 ≤ T) (h1 : y ≤ Real.exp (-T) * x)
    (h2 : y ≤ Real.exp T * x) : y ≤ x := by
  rcases le_or_gt 0 x with hx | hx
  · have : Real.exp (-T) ≤ 1 := Real.exp_le_one_iff.mpr (by linarith)
    nlinarith
  · have : 1 ≤ Real.exp T := Real.one_le_exp hT
    nlinarith

/-- Graph nodes `lem:transfer#transport`, `#stable-gronwall`, `#unstable-gronwall` (history
level): `B (U f) ≤ e^{-2 m_* b} B f` and `B (U f) ≤ e^{2 m_* b} B f`, with no sign
condition on `B`. -/
theorem betaForm_transferMatrix_le (h : IsDiracClifford α β) {mStar : ℝ} (hm : 0 < mStar)
    {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar) (f : ι × Fin 4 → ℂ) :
    betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (transferMatrix α β hist *ᵥ f) ≤
        Real.exp (-(2 * mStar * (hist.map Step.freeTime).sum)) *
          betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f ∧
      betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (transferMatrix α β hist *ᵥ f) ≤
        Real.exp (2 * mStar * (hist.map Step.freeTime).sum) *
          betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
  induction hist generalizing f with
  | nil => simp [transferMatrix_nil]
  | cons s rest ih =>
    have hs := hadm s (by simp)
    have hrest : ∀ t ∈ rest, t.IsAdmissible mStar := fun t ht => hadm t (by simp [ht])
    obtain ⟨h1, h2⟩ := betaForm_exp_generator_le h hm hs f
    obtain ⟨h3, h4⟩ := ih hrest (NormedSpace.exp (-(s.generator α β)) *ᵥ f)
    rw [transferMatrix_cons, ← mulVec_mulVec, List.map_cons, List.sum_cons]
    have e1 : Real.exp (-(2 * mStar * (s.freeTime + (rest.map Step.freeTime).sum))) =
        Real.exp (-(2 * mStar * (rest.map Step.freeTime).sum)) *
          Real.exp (-(2 * mStar * s.freeTime)) := by
      rw [← Real.exp_add]; congr 1; ring
    have e2 : Real.exp (2 * mStar * (s.freeTime + (rest.map Step.freeTime).sum)) =
        Real.exp (2 * mStar * (rest.map Step.freeTime).sum) *
          Real.exp (2 * mStar * s.freeTime) := by
      rw [← Real.exp_add]; congr 1; ring
    refine ⟨?_, ?_⟩
    · rw [e1, mul_assoc]
      exact h3.trans (mul_le_mul_of_nonneg_left h1 (Real.exp_pos _).le)
    · rw [e2, mul_assoc]
      exact h4.trans (mul_le_mul_of_nonneg_left h2 (Real.exp_pos _).le)

/-- Graph node `lem:transfer#beta-form-monotone`: `B (U f) ≤ B f`. -/
theorem betaForm_transferMatrix_le_self (h : IsDiracClifford α β) {mStar : ℝ} (hm : 0 < mStar)
    {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar) (f : ι × Fin 4 → ℂ) :
    betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (transferMatrix α β hist *ᵥ f) ≤
      betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
  obtain ⟨h1, h2⟩ := betaForm_transferMatrix_le h hm hadm f
  exact le_of_two_bounds (mul_nonneg (by linarith) (sum_freeTime_nonneg hadm)) h1 h2

private lemma exp_mulVec_ne_zero' {n : Type*} [Fintype n] [DecidableEq n]
    (A : Matrix n n ℂ) {f : n → ℂ} (hf : f ≠ 0) : NormedSpace.exp A *ᵥ f ≠ 0 := by
  intro h
  apply hf
  have hinj := Matrix.mulVec_injective_iff_isUnit.mpr (Matrix.isUnit_exp A)
  exact hinj (by rw [h, mulVec_zero])

/-- Graph node `lem:transfer#strict-decrease` (history level): for positive total free time
and `f ≠ 0`, `B (U f) < B f`. -/
theorem betaForm_transferMatrix_lt (h : IsDiracClifford α β) {mStar : ℝ} (hm : 0 < mStar)
    {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar)
    (hb : 0 < (hist.map Step.freeTime).sum) {f : ι × Fin 4 → ℂ} (hf : f ≠ 0) :
    betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) (transferMatrix α β hist *ᵥ f) <
      betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
  induction hist generalizing f with
  | nil => simp at hb
  | cons s rest ih =>
    have hs := hadm s (by simp)
    have hrest : ∀ t ∈ rest, t.IsAdmissible mStar := fun t ht => hadm t (by simp [ht])
    rw [List.map_cons, List.sum_cons] at hb
    rw [transferMatrix_cons, ← mulVec_mulVec]
    have hEf := exp_mulVec_ne_zero' (-(s.generator α β)) hf
    rcases lt_or_ge 0 s.freeTime with hτ | hτ
    · exact (betaForm_transferMatrix_le_self h hm hrest _).trans_lt
        (betaForm_exp_generator_lt h hm hs hτ hf)
    · have hT : 0 < (rest.map Step.freeTime).sum := by linarith
      have hstep : betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β)
          (NormedSpace.exp (-(s.generator α β)) *ᵥ f) ≤ betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) f := by
        obtain ⟨h1, h2⟩ := betaForm_exp_generator_le h hm hs f
        exact le_of_two_bounds (mul_nonneg (by linarith) (freeTime_nonneg hs)) h1 h2
      exact (ih hrest hT hEf).trans_le hstep

/-- `B (z v) = |z|² B v`. -/
private lemma betaForm_smul {n : Type*} [Fintype n] (P : Matrix n n ℂ) (z : ℂ) (v : n → ℂ) :
    betaForm P (z • v) = ‖z‖ ^ 2 * betaForm P v := by
  unfold betaForm
  rw [star_smul, mulVec_smul, dotProduct_smul, smul_dotProduct, smul_eq_mul, smul_eq_mul,
    ← mul_assoc, Complex.star_def, Complex.mul_conj', ← Complex.ofReal_pow,
    Complex.re_ofReal_mul]

/-- Graph nodes `lem:transfer#endpoint-relation`, `#no-unit-modulus`: every eigenvalue of `U`
lies in the disc `|z| ≤ e^{-b m_*}` or outside the disc `|z| < e^{b m_*}`. -/
theorem norm_charpoly_root_dichotomy (h : IsDiracClifford α β) {mStar b : ℝ} (hm : 0 < mStar)
    {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar)
    (htime : (hist.map Step.freeTime).sum = b) (hb : 0 < b) {z : ℂ}
    (hz : z ∈ (transferMatrix α β hist).charpoly.roots) :
    ‖z‖ ≤ Real.exp (-(b * mStar)) ∨ Real.exp (b * mStar) ≤ ‖z‖ := by
  obtain ⟨v, hv0, hUv⟩ := exists_eigenvector_of_mem_charpoly_roots hz
  obtain ⟨hle1, hle2⟩ := betaForm_transferMatrix_le h hm hadm v
  have hlt := betaForm_transferMatrix_lt h hm hadm (htime ▸ hb) hv0
  rw [hUv, betaForm_smul] at hle1 hle2 hlt
  rw [htime] at hle1 hle2
  have e1 : Real.exp (-(2 * mStar * b)) =
      Real.exp (-(b * mStar)) * Real.exp (-(b * mStar)) := by
    rw [← Real.exp_add]; congr 1; ring
  have e2 : Real.exp (2 * mStar * b) = Real.exp (b * mStar) * Real.exp (b * mStar) := by
    rw [← Real.exp_add]; congr 1; ring
  rw [e1] at hle1
  rw [e2] at hle2
  have hn := norm_nonneg z
  rcases lt_trichotomy (betaForm ((1 : Matrix ι ι ℂ) ⊗ₖ β) v) 0 with hB | hB | hB
  · right
    have h1 := (mul_le_mul_right_of_neg hB).mp hle2
    have hp := Real.exp_pos (b * mStar)
    nlinarith
  · rw [hB] at hlt
    simp at hlt
  · left
    have h1 := le_of_mul_le_mul_right hle1 hB
    have hp := Real.exp_pos (-(b * mStar))
    nlinarith

/-- Conjuncts 2–4 of Lemma 3.1 (graph node `lem:transfer#eigenvalue-count`): exactly `d`
eigenvalues lie in `|z| ≤ e^{-b m_*}`, the others are their partners `1 / conj z`, of modulus
at least `e^{b m_*}`. -/
theorem transferMatrix_annulus (h : IsDiracClifford α β) {d : ℕ}
    (hd : 4 * Fintype.card ι = 2 * d)
    {mStar b : ℝ} (hm : 0 < mStar) (hb : 0 < b) {hist : List (Step ι)}
    (hadm : ∀ s ∈ hist, s.IsAdmissible mStar) (htime : (hist.map Step.freeTime).sum = b) :
    ((transferMatrix α β hist).charpoly.roots.filter
        (fun z => ‖z‖ ≤ Real.exp (-(b * mStar)))).card = d ∧
    (transferMatrix α β hist).charpoly.roots.filter
        (fun z => ¬ ‖z‖ ≤ Real.exp (-(b * mStar))) =
      ((transferMatrix α β hist).charpoly.roots.filter
        (fun z => ‖z‖ ≤ Real.exp (-(b * mStar)))).map (fun z => (star z)⁻¹) ∧
    ∀ z ∈ (transferMatrix α β hist).charpoly.roots,
      ¬ ‖z‖ ≤ Real.exp (-(b * mStar)) → Real.exp (b * mStar) ≤ ‖z‖ := by
  have hunit : IsUnit (transferMatrix α β hist).det :=
    (Matrix.isUnit_iff_isUnit_det _).mp (isUnit_transferMatrix hist)
  have hUV : transferMatrix α β hist * (transferMatrix α β hist)⁻¹ = 1 :=
    Matrix.mul_nonsing_inv _ hunit
  have hform := transferMatrix_preservesForm h (fun s hs => (hadm s hs).isHermitianData)
  have hinv := charpoly_roots_map_star_inv hUV h.one_kronecker_c5_mul_self hform
  have hpos : 0 < b * mStar := mul_pos hb hm
  have hr0 : 0 < Real.exp (-(b * mStar)) := Real.exp_pos _
  have hr1 : Real.exp (-(b * mStar)) < 1 := Real.exp_lt_one_iff.mpr (by linarith)
  have hinvr : (Real.exp (-(b * mStar)))⁻¹ = Real.exp (b * mStar) := by
    rw [Real.exp_neg, inv_inv]
  have hcard : Multiset.card (transferMatrix α β hist).charpoly.roots = 2 * d := by
    rw [card_charpoly_roots, Fintype.card_prod, Fintype.card_fin]
    omega
  have hdich : ∀ z ∈ (transferMatrix α β hist).charpoly.roots,
      ‖z‖ ≤ Real.exp (-(b * mStar)) ∨ (Real.exp (-(b * mStar)))⁻¹ ≤ ‖z‖ := by
    intro z hz
    rw [hinvr]
    exact norm_charpoly_root_dichotomy h hm hadm htime hb hz
  obtain ⟨h1, h2, h3⟩ := annulus_split_of_pairing hr0 hr1 hcard
    (zero_not_mem_charpoly_roots hUV) hinv hdich
  refine ⟨h1, h2, fun z hz hn => ?_⟩
  rw [← hinvr]
  exact h3 z hz hn

/-- Graph node `lem:transfer#det-nonvanishing`: `det (I + U) ≠ 0`, since `-1` is not an
eigenvalue of `U`. -/
theorem det_one_add_transferMatrix_ne_zero (h : IsDiracClifford α β) {mStar : ℝ}
    (hm : 0 < mStar) {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar)
    (hb : 0 < (hist.map Step.freeTime).sum) :
    (1 + transferMatrix α β hist).det ≠ 0 := by
  have hprod := det_one_add_smul_eq_prod_roots (transferMatrix α β hist) 1
  rw [one_smul] at hprod
  rw [hprod]
  refine Multiset.prod_ne_zero fun h0 => ?_
  obtain ⟨μ, hμ, hμ0⟩ := Multiset.mem_map.mp h0
  have hμ1 : μ = -1 := by linear_combination hμ0
  have hd := norm_charpoly_root_dichotomy h hm hadm rfl hb hμ
  rw [hμ1, norm_neg, norm_one] at hd
  have hpos : 0 < (hist.map Step.freeTime).sum * mStar := mul_pos hb hm
  rcases hd with hd | hd
  · have := Real.exp_lt_one_iff.mpr (show -((hist.map Step.freeTime).sum * mStar) < 0 by
      linarith)
    linarith
  · have := Real.one_lt_exp_iff.mpr hpos
    linarith

/-- The centered trace does not vanish: `F = exp (½ Σ tr A) det (I + U) ≠ 0`. -/
theorem centeredTrace_ne_zero (h : IsDiracClifford α β) {mStar : ℝ} (hm : 0 < mStar)
    {hist : List (Step ι)} (hadm : ∀ s ∈ hist, s.IsAdmissible mStar)
    (hb : 0 < (hist.map Step.freeTime).sum) :
    centeredTrace α β hist ≠ 0 := by
  unfold centeredTrace
  exact mul_ne_zero (Complex.exp_ne_zero _) (det_one_add_transferMatrix_ne_zero h hm hadm hb)

end QEDCore.PaperA
