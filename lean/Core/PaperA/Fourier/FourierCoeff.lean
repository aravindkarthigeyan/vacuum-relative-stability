/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.Coefficients
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

/-! Graph node `lem:fourier#coefficient-identification` (Paper A, transfer.tex L117-L125): the
`q`-th Fourier coefficient of `|P(e^{iφ})|²`, for the trigonometric polynomial
`P(e^{iφ}) = Σ_{k ≤ N} a_k e^{ikφ}`, is the finite correlation `Σ_k a_{k+q} conj(a_k)`
(`QEDCore.correlation N q a`), and the `(-q)`-th coefficient is its conjugate. The paper states
the coefficient formula without derivation; here it is derived from the orthogonality
`∫_0^{2π} e^{inφ} dφ = 2π δ_{n0}` for integers `n`. -/

namespace QEDCore.PaperA

open scoped BigOperators

/-- `Σ_{k ≤ N} a_k e^{ikφ}`. -/
noncomputable def trigPoly (N : ℕ) (a : ℕ → ℂ) (φ : ℝ) : ℂ :=
  ∑ k ∈ Finset.range (N + 1), a k * Complex.exp (k * φ * Complex.I)

/-- Orthogonality of the exponentials: `∫_0^{2π} e^{inφ} dφ = 2π δ_{n0}` for an integer `n`. -/
lemma integral_exp_int_mul_I (n : ℤ) :
    ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp ((n : ℂ) * φ * Complex.I) =
      if n = 0 then (2 * Real.pi : ℂ) else 0 := by
  split_ifs with hn
  · subst hn
    simp
  · have hc : (n : ℂ) * Complex.I ≠ 0 :=
      mul_ne_zero (Int.cast_ne_zero.mpr hn) Complex.I_ne_zero
    have he : ∀ φ : ℝ, (n : ℂ) * φ * Complex.I = (n : ℂ) * Complex.I * φ := fun φ => by ring
    simp_rw [he]
    rw [integral_exp_mul_complex hc]
    have h1 : Complex.exp ((n : ℂ) * Complex.I * ((2 * Real.pi : ℝ) : ℂ)) = 1 := by
      rw [← Complex.exp_int_mul_two_pi_mul_I n]
      congr 1
      push_cast
      ring
    rw [h1]
    simp

/-- The conjugate of `e^{ikφ}`, for `k : ℕ` and real `φ`, is `e^{-ikφ}`. -/
private lemma star_exp_natCast_mul (k : ℕ) (φ : ℝ) :
    star (Complex.exp ((k : ℂ) * φ * Complex.I)) = Complex.exp (-((k : ℂ) * φ * Complex.I)) := by
  rw [RCLike.star_def, ← Complex.exp_conj]
  congr 1
  simp [map_mul, Complex.conj_ofReal]

/-- Termwise product of a twisted pair of monomials. -/
private lemma twist_term (m : ℤ) (a : ℕ → ℂ) (j k : ℕ) (φ : ℝ) :
    Complex.exp ((m : ℂ) * φ * Complex.I) *
        (a j * Complex.exp (j * φ * Complex.I) * star (a k * Complex.exp (k * φ * Complex.I))) =
      a j * star (a k) * Complex.exp ((((j : ℤ) - k + m : ℤ) : ℂ) * φ * Complex.I) := by
  rw [star_mul', star_exp_natCast_mul]
  have h : (((j : ℤ) - k + m : ℤ) : ℂ) * φ * Complex.I =
      (m : ℂ) * φ * Complex.I + (j * φ * Complex.I) + -((k : ℂ) * φ * Complex.I) := by
    push_cast
    ring
  rw [h, Complex.exp_add, Complex.exp_add]
  ring

/-- The `m`-twisted mean of `|P|²` as a double sum over the coefficient pairs. -/
private lemma twisted_mean_normSq_trigPoly (N : ℕ) (a : ℕ → ℂ) (m : ℤ) :
    (2 * Real.pi : ℂ)⁻¹ * ∫ φ in (0 : ℝ)..2 * Real.pi,
        Complex.exp ((m : ℂ) * φ * Complex.I) * (trigPoly N a φ * star (trigPoly N a φ)) =
      ∑ j ∈ Finset.range (N + 1), ∑ k ∈ Finset.range (N + 1),
        if (j : ℤ) - k + m = 0 then a j * star (a k) else 0 := by
  have hexp : ∀ φ : ℝ,
      Complex.exp ((m : ℂ) * φ * Complex.I) * (trigPoly N a φ * star (trigPoly N a φ)) =
        ∑ j ∈ Finset.range (N + 1), ∑ k ∈ Finset.range (N + 1),
          a j * star (a k) * Complex.exp ((((j : ℤ) - k + m : ℤ) : ℂ) * φ * Complex.I) := by
    intro φ
    rw [trigPoly, star_sum, Finset.sum_mul_sum, Finset.mul_sum]
    refine Finset.sum_congr rfl fun j _ => ?_
    rw [Finset.mul_sum]
    exact Finset.sum_congr rfl fun k _ => twist_term m a j k φ
  simp_rw [hexp]
  have hpi : (2 * Real.pi : ℂ) ≠ 0 :=
    mul_ne_zero two_ne_zero (Complex.ofReal_ne_zero.mpr Real.pi_ne_zero)
  rw [intervalIntegral.integral_finsetSum fun j _ => by
    apply Continuous.intervalIntegrable
    fun_prop]
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [intervalIntegral.integral_finsetSum fun k _ => by
    apply Continuous.intervalIntegrable
    fun_prop]
  rw [Finset.mul_sum]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [intervalIntegral.integral_const_mul, integral_exp_int_mul_I]
  split_ifs
  · rw [mul_comm (a j * star (a k)), ← mul_assoc, inv_mul_cancel₀ hpi, one_mul]
  · simp

/-- The coefficient-pair double sum with `j - k = q` is the legacy antidiagonal correlation. -/
private lemma sum_sum_ite_eq_correlation (N q : ℕ) (a : ℕ → ℂ) :
    (∑ j ∈ Finset.range (N + 1), ∑ k ∈ Finset.range (N + 1),
        if (j : ℤ) - k + -(q : ℤ) = 0 then a j * star (a k) else 0) =
      QEDCore.correlation N q a := by
  unfold QEDCore.correlation
  rw [Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk,
    show (N + q).succ = (N + 1) + q by omega, Finset.sum_range_add _ (N + 1) q]
  dsimp only
  have htail : ∑ x ∈ Finset.range q,
      (if N + 1 + x ≤ N ∧ N + q - (N + 1 + x) ≤ N then
        a (N + 1 + x) * star (a (N - (N + q - (N + 1 + x)))) else 0) = 0 :=
    Finset.sum_eq_zero fun x _ => ite_eq_right (by omega)
  rw [htail, add_zero]
  refine Finset.sum_congr rfl fun j hj => ?_
  have hjN : j ≤ N := Nat.lt_succ_iff.mp (Finset.mem_range.mp hj)
  by_cases hqj : q ≤ j
  · have hc : j ≤ N ∧ N + q - j ≤ N := ⟨hjN, by omega⟩
    have h1 : (j : ℤ) - ((j - q : ℕ) : ℤ) + -(q : ℤ) = 0 := by omega
    rw [Finset.sum_eq_single (j - q), ite_eq_left hc, ite_eq_left h1,
      show N - (N + q - j) = j - q by omega]
    · intro k _ hk
      exact ite_eq_right (by omega)
    · intro h
      exact absurd (Finset.mem_range.mpr (by omega)) h
  · have hc : ¬ (j ≤ N ∧ N + q - j ≤ N) := by omega
    rw [ite_eq_right hc]
    exact Finset.sum_eq_zero fun k _ => ite_eq_right (by omega)

theorem fourierCoeff_normSq_trigPoly (N q : ℕ) (a : ℕ → ℂ) :
    (2 * Real.pi : ℂ)⁻¹ * ∫ φ in (0 : ℝ)..2 * Real.pi,
        Complex.exp (-((q : ℂ) * φ * Complex.I)) * (trigPoly N a φ * star (trigPoly N a φ)) =
      QEDCore.correlation N q a := by
  have h := twisted_mean_normSq_trigPoly N a (-(q : ℤ))
  simp only [Int.cast_neg, Int.cast_natCast, neg_mul] at h
  rw [h, sum_sum_ite_eq_correlation]

theorem fourierCoeff_normSq_trigPoly_neg (N q : ℕ) (a : ℕ → ℂ) :
    (2 * Real.pi : ℂ)⁻¹ * ∫ φ in (0 : ℝ)..2 * Real.pi,
        Complex.exp (((q : ℂ) * φ * Complex.I)) * (trigPoly N a φ * star (trigPoly N a φ)) =
      star (QEDCore.correlation N q a) := by
  have h := twisted_mean_normSq_trigPoly N a (q : ℤ)
  simp only [Int.cast_natCast] at h
  rw [h, ← sum_sum_ite_eq_correlation, star_sum, Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [star_sum]
  refine Finset.sum_congr rfl fun j _ => ?_
  by_cases hjk : (j : ℤ) - k + q = 0
  · have h2 : (k : ℤ) - j + -(q : ℤ) = 0 := by omega
    rw [ite_eq_left hjk, ite_eq_left h2, star_mul', star_star, mul_comm]
  · have h2 : ¬ ((k : ℤ) - j + -(q : ℤ) = 0) := by omega
    rw [ite_eq_right hjk, ite_eq_right h2, star_zero]

end QEDCore.PaperA
