/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Fourier.TwistKick
import Core.PaperA.Fourier.Factorization

/-! Graph nodes `lem:fourier#factorization` (history level), `#constant-positive`,
`#coefficient-identification`, `#vacuum-real`, `#vacuum-lower-bound`, `#elementary-bound`,
`#vandermonde` and `#negative-q` (Paper A, transfer.tex L106-L130).

* History level of `#factorization`: if the transfer matrix `U` of a history has the eigenvalues
  `λ_1, …, λ_d` (nonzero) and their reflections `1 / conj λ_j`, then the centered trace of the
  history twisted by `e^{iφ}` is `F(φ) = C |P(e^{iφ})|²`, where
  `C = e^{½ Σ tr A} (∏_j conj λ_j)⁻¹` and `P(e^{iφ}) = Σ_k e_k(λ) e^{ikφ}`; the phase
  `e^{-idφ}` of `lem:fourier#twist-is-kick` cancels the phase `e^{idφ}` of the paired product.
  At `φ = 0` the twisted history has the centered trace of the untwisted one.
* `#constant-positive`: if `F(0) = C |P(1)|²` is real and positive, then `C` is a positive real.
* `#coefficient-identification`, `#vacuum-real`, `#negative-q`: `F_q = C · c_{|q|}` for `q ≥ 0`
  and `F_q = C · conj c_{|q|}` for `q < 0`, where `c_q = Σ_j e_{j+q} conj e_j`
  (`QEDCore.correlation`); in particular `F_0 = C Σ_j |e_j|²` is real.
* `#vacuum-lower-bound`, `#elementary-bound`, `#vandermonde`: with `|λ_j| ≤ s = e^{-t}`,
  `|c_q| ≤ binom(2d, d + q) s^q Σ_j |e_j|²` (`QEDCore.relative_correlation_bound`), hence
  `|F_q| ≤ binom(2d, d + |q|) e^{-t |q|} F_0`. -/

namespace QEDCore.PaperA

open scoped BigOperators

/-- A multiset of complex numbers of cardinality `n` is enumerated by `Fin n`. -/
theorem exists_fin_enum_of_card (S : Multiset ℂ) {n : ℕ} (h : Multiset.card S = n) :
    ∃ lam : Fin n → ℂ, (Finset.univ : Finset (Fin n)).val.map lam = S := by
  subst h
  exact exists_fin_enum S

/-! ### The history-level factorization -/

section History

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-- Graph node `lem:fourier#factorization` (history level, transfer.tex L106-L116): with the
paired eigenvalues `λ_j`, `1 / conj λ_j` of `U`, the twisted centered trace is
`F(φ) = e^{½ Σ tr A} (∏_j conj λ_j)⁻¹ |P(e^{iφ})|²`. -/
theorem centeredTrace_append_twist_eq_mul_normSq (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) {d : ℕ}
    (hd : 4 * Fintype.card ι = 2 * d) (lam : Fin d → ℂ) (hlam0 : ∀ j, lam j ≠ 0)
    (hroots : (transferMatrix α β hist).charpoly.roots =
      (Finset.univ : Finset (Fin d)).val.map lam +
        ((Finset.univ : Finset (Fin d)).val.map lam).map (fun z => (star z)⁻¹))
    (φ : ℝ) :
    centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)]) =
      (Complex.exp ((1 / 2 : ℂ) * (hist.map fun s => (s.generator α β).trace).sum) *
          (∏ j, star (lam j))⁻¹) *
        (trigPoly d (QEDCore.elementary lam) φ *
          star (trigPoly d (QEDCore.elementary lam) φ)) := by
  rw [centeredTrace_append_twist α β hist hd φ,
    det_one_add_exp_smul_of_paired lam hlam0 hroots φ]
  have he : Complex.exp (-((d : ℂ) * φ * Complex.I)) *
      Complex.exp ((d : ℂ) * φ * Complex.I) = 1 := by
    rw [← Complex.exp_add, neg_add_cancel, Complex.exp_zero]
  linear_combination
    (Complex.exp ((1 / 2 : ℂ) * (hist.map fun s => (s.generator α β).trace).sum) *
      (∏ j, star (lam j))⁻¹ *
        (trigPoly d (QEDCore.elementary lam) φ *
          star (trigPoly d (QEDCore.elementary lam) φ))) * he

/-- Graph node `lem:fourier#apply-transfer` (transfer.tex L114-L115): the trivial twist
`φ = 0` leaves the centered trace unchanged, so `F(0)` is the centered trace of the history. -/
theorem centeredTrace_append_twist_zero (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) {d : ℕ}
    (hd : 4 * Fintype.card ι = 2 * d) :
    centeredTrace α β (hist ++ [Step.kick (((0 : ℝ) : ℂ) • 1)]) = centeredTrace α β hist := by
  rw [centeredTrace_append_twist α β hist hd 0]
  unfold centeredTrace
  simp

end History

/-! ### The Fourier coefficients of `C |P|²` -/

/-- Graph node `lem:fourier#constant-positive` (transfer.tex L115-L116): if
`z = C · (w · conj w)` is real and positive, then `C` is a positive real. -/
theorem exists_pos_eq_ofReal_of_mul_mul_star {C w z : ℂ} (hz : z = C * (w * star w))
    (hre : 0 < z.re) (him : z.im = 0) : ∃ c : ℝ, 0 < c ∧ C = (c : ℂ) := by
  rw [RCLike.star_def, Complex.mul_conj] at hz
  have hn : Complex.normSq w ≠ 0 := by
    intro h
    rw [h, Complex.ofReal_zero, mul_zero] at hz
    rw [hz, Complex.zero_re] at hre
    exact lt_irrefl 0 hre
  have hnpos : 0 < Complex.normSq w := lt_of_le_of_ne (Complex.normSq_nonneg w) (Ne.symm hn)
  refine ⟨z.re / Complex.normSq w, div_pos hre hnpos, ?_⟩
  have hzr : z = (z.re : ℂ) := Complex.ext (by simp) (by simp [him])
  rw [Complex.ofReal_div, ← hzr, hz, mul_div_assoc,
    div_self (Complex.ofReal_ne_zero.mpr hn), mul_one]

/-- Graph nodes `lem:fourier#coefficient-identification` and `#negative-q` (transfer.tex
L117-L130): the `p`-th Fourier coefficient of `|P|²`, for an integer `p`, has the modulus of
the correlation `c_{|p|}`; for `p < 0` it is `conj c_{|p|}`. -/
theorem norm_fourierCoeff_normSq_trigPoly (N : ℕ) (a : ℕ → ℂ) (p : ℤ) :
    ‖(2 * Real.pi : ℂ)⁻¹ * ∫ φ in (0 : ℝ)..2 * Real.pi,
        Complex.exp (-((p : ℂ) * φ * Complex.I)) * (trigPoly N a φ * star (trigPoly N a φ))‖ =
      ‖QEDCore.correlation N p.natAbs a‖ := by
  obtain ⟨n, rfl | rfl⟩ := Int.eq_nat_or_neg p
  · rw [Int.cast_natCast, Int.natAbs_natCast, fourierCoeff_normSq_trigPoly]
  · have h : ∀ φ : ℝ, -((((-(n : ℤ)) : ℤ) : ℂ) * φ * Complex.I) =
        (n : ℂ) * φ * Complex.I := by
      intro φ
      push_cast
      ring
    simp_rw [h]
    rw [Int.natAbs_neg, Int.natAbs_natCast, fourierCoeff_normSq_trigPoly_neg, norm_star]

/-- Graph nodes `lem:fourier#coefficient-identification` and `#vacuum-real` (transfer.tex
L117-L125): the mean of `|P|²` is the real number `Σ_j |a_j|²`. -/
theorem fourierCoeff_normSq_trigPoly_zero (N : ℕ) (a : ℕ → ℂ) :
    (2 * Real.pi : ℂ)⁻¹ * ∫ φ in (0 : ℝ)..2 * Real.pi,
        Complex.exp (-(((0 : ℤ) : ℂ) * φ * Complex.I)) *
          (trigPoly N a φ * star (trigPoly N a φ)) =
      (QEDCore.vacuumWeight N a : ℂ) := by
  rw [← QEDCore.correlation_zero, ← fourierCoeff_normSq_trigPoly N 0 a, Int.cast_zero,
    Nat.cast_zero]

/-- The Fourier bound of Lemma 3.2 for any function `F(φ) = C |P(e^{iφ})|²` with
`P(e^{iφ}) = Σ_k e_k(λ) e^{ikφ}`, `|λ_j| ≤ e^{-t}`, `t ≥ 0`, and `F(0)` real and positive
(graph nodes `lem:fourier#constant-positive`, `#coefficient-identification`, `#vacuum-real`,
`#vacuum-lower-bound`, `#elementary-bound`, `#vandermonde`, `#negative-q`; transfer.tex
L115-L130): `F_0` is real and `|F_q| ≤ binom(2d, d + |q|) e^{-t |q|} F_0`. -/
theorem fourier_bound_of_factorization {d : ℕ} (lam : Fin d → ℂ) {t : ℝ} (ht : 0 ≤ t)
    (hlam : ∀ j, ‖lam j‖ ≤ Real.exp (-t)) (F : ℝ → ℂ) {C : ℂ}
    (hF : ∀ φ : ℝ, F φ = C * (trigPoly d (QEDCore.elementary lam) φ *
      star (trigPoly d (QEDCore.elementary lam) φ)))
    (hF0 : 0 < (F 0).re) (hF0im : (F 0).im = 0) (Fhat : ℤ → ℂ)
    (hFhat : ∀ p : ℤ, Fhat p = (2 * Real.pi : ℂ)⁻¹ *
      ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ)
    (q : ℤ) :
    (Fhat 0).im = 0 ∧
      ‖Fhat q‖ ≤ ((2 * d).choose (d + q.natAbs) : ℝ) * Real.exp (-(t * |(q : ℝ)|)) *
        (Fhat 0).re := by
  obtain ⟨c, hc, hC⟩ := exists_pos_eq_ofReal_of_mul_mul_star (hF 0) hF0 hF0im
  have hFhat' : ∀ p : ℤ, Fhat p = (c : ℂ) * ((2 * Real.pi : ℂ)⁻¹ *
      ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-((p : ℂ) * φ * Complex.I)) *
        (trigPoly d (QEDCore.elementary lam) φ *
          star (trigPoly d (QEDCore.elementary lam) φ))) := by
    intro p
    have h1 : (fun φ : ℝ => Complex.exp (-((p : ℂ) * φ * Complex.I)) * F φ) =
        fun φ : ℝ => (c : ℂ) * (Complex.exp (-((p : ℂ) * φ * Complex.I)) *
          (trigPoly d (QEDCore.elementary lam) φ *
            star (trigPoly d (QEDCore.elementary lam) φ))) := by
      funext φ
      rw [hF, hC]
      ring
    rw [hFhat, h1, intervalIntegral.integral_const_mul]
    ring
  have h0 : Fhat 0 = ((c * QEDCore.vacuumWeight d (QEDCore.elementary lam) : ℝ) : ℂ) := by
    rw [hFhat', fourierCoeff_normSq_trigPoly_zero, Complex.ofReal_mul]
  refine ⟨by rw [h0, Complex.ofReal_im], ?_⟩
  rw [h0, Complex.ofReal_re, hFhat', norm_mul, norm_fourierCoeff_normSq_trigPoly,
    Complex.norm_of_nonneg hc.le]
  have hr0 : 0 ≤ Real.exp (-t) := (Real.exp_pos _).le
  have hr1 : Real.exp (-t) ≤ 1 := Real.exp_le_one_iff.mpr (neg_nonpos.mpr ht)
  have hb := QEDCore.relative_correlation_bound (q := q.natAbs) lam hr0 hr1 hlam
  have hexp : Real.exp (-t) ^ q.natAbs = Real.exp (-(t * |(q : ℝ)|)) := by
    rw [← Real.exp_nat_mul, Nat.cast_natAbs, Int.cast_abs]
    congr 1
    ring
  rw [hexp, show d + d = 2 * d by ring] at hb
  calc c * ‖QEDCore.correlation d q.natAbs (QEDCore.elementary lam)‖
      ≤ c * ((((2 * d).choose (d + q.natAbs) : ℝ) * Real.exp (-(t * |(q : ℝ)|))) *
          QEDCore.vacuumWeight d (QEDCore.elementary lam)) :=
        mul_le_mul_of_nonneg_left hb hc.le
    _ = ((2 * d).choose (d + q.natAbs) : ℝ) * Real.exp (-(t * |(q : ℝ)|)) *
          (c * QEDCore.vacuumWeight d (QEDCore.elementary lam)) := by ring

end QEDCore.PaperA
