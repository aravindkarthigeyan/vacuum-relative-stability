/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Data.Nat.Choose.Vandermonde
import Mathlib.Data.Finset.Powerset
import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic

namespace QEDCore
open scoped BigOperators

/-- Elementary symmetric coefficients, defined directly by subsets. -/
noncomputable def elementary {N : ℕ} (lam : Fin N → ℂ) (k : ℕ) : ℂ :=
  ∑ s ∈ (Finset.univ : Finset (Fin N)).powersetCard k, ∏ i ∈ s, lam i

theorem elementary_zero {N : ℕ} (lam : Fin N → ℂ) : elementary lam 0 = 1 := by
  simp [elementary]

theorem norm_elementary_le {N : ℕ} (lam : Fin N → ℂ) {r : ℝ}
    (hlam : ∀ i, ‖lam i‖ ≤ r) (k : ℕ) :
    ‖elementary lam k‖ ≤ (N.choose k : ℝ) * r ^ k := by
  unfold elementary
  calc
    ‖∑ s ∈ (Finset.univ : Finset (Fin N)).powersetCard k, ∏ i ∈ s, lam i‖
        ≤ ∑ s ∈ (Finset.univ : Finset (Fin N)).powersetCard k,
            ‖∏ i ∈ s, lam i‖ := norm_sum_le _ _
    _ ≤ ∑ s ∈ (Finset.univ : Finset (Fin N)).powersetCard k, r ^ k := by
      apply Finset.sum_le_sum
      intro s hs
      rw [norm_prod]
      have hc : s.card = k := (Finset.mem_powersetCard.mp hs).2
      calc
        ∏ i ∈ s, ‖lam i‖ ≤ ∏ i ∈ s, r :=
          Finset.prod_le_prod₀ (fun i _ => norm_nonneg _) (fun i _ => hlam i)
        _ = r ^ k := by simp [hc]
    _ = (N.choose k : ℝ) * r ^ k := by simp

/-- The coefficient of degree N+q in a polynomial times its reversed
conjugate, written as a finite antidiagonal sum. Identification with a
Fourier integral is not part of this definition or theorem. -/
noncomputable def correlation (N q : ℕ) (a : ℕ → ℂ) : ℂ :=
  ∑ ij ∈ Finset.antidiagonal (N + q),
    if ij.1 ≤ N ∧ ij.2 ≤ N then a ij.1 * star (a (N - ij.2)) else 0

noncomputable def vacuumWeight (N : ℕ) (a : ℕ → ℂ) : ℝ :=
  ∑ j ∈ Finset.range (N + 1), ‖a j‖ ^ 2

theorem correlation_zero (N : ℕ) (a : ℕ → ℂ) :
    correlation N 0 a = (vacuumWeight N a : ℂ) := by
  unfold correlation vacuumWeight
  rw [Nat.add_zero, Finset.Nat.sum_antidiagonal_eq_sum_range_succ_mk]
  push_cast
  apply Finset.sum_congr rfl
  intro j hj
  have hjN : j ≤ N := by have := Finset.mem_range.mp hj; omega
  have hsub : N - (N - j) = j := by omega
  simp only [hjN, Nat.sub_le, and_self, ite_true, hsub]
  rw [RCLike.star_def, Complex.mul_conj, Complex.normSq_eq_norm_sq]
  simp

theorem one_le_vacuumWeight {N : ℕ} {a : ℕ → ℂ} (ha : a 0 = 1) :
    1 ≤ vacuumWeight N a := by
  have hh := Finset.single_le_sum (fun j (_ : j ∈ Finset.range (N + 1)) =>
    sq_nonneg ‖a j‖) (show 0 ∈ Finset.range (N + 1) by simp)
  simpa [vacuumWeight, ha] using hh

theorem norm_correlation_le {N q : ℕ} {a : ℕ → ℂ} {r : ℝ}
    (hr0 : 0 ≤ r) (hr1 : r ≤ 1)
    (ha : ∀ k, ‖a k‖ ≤ (N.choose k : ℝ) * r ^ k) :
    ‖correlation N q a‖ ≤ ((N + N).choose (N + q) : ℝ) * r ^ q := by
  unfold correlation
  calc
    ‖∑ ij ∈ Finset.antidiagonal (N + q),
        if ij.1 ≤ N ∧ ij.2 ≤ N then a ij.1 * star (a (N - ij.2)) else 0‖
      ≤ ∑ ij ∈ Finset.antidiagonal (N + q),
        ‖if ij.1 ≤ N ∧ ij.2 ≤ N then a ij.1 * star (a (N - ij.2)) else 0‖ :=
      norm_sum_le _ _
    _ ≤ ∑ ij ∈ Finset.antidiagonal (N + q),
        ((N.choose ij.1 : ℝ) * (N.choose ij.2 : ℝ)) * r ^ q := by
      apply Finset.sum_le_sum
      intro ij hij
      have hadd : ij.1 + ij.2 = N + q := Finset.mem_antidiagonal.mp hij
      split_ifs with h
      · rw [norm_mul, norm_star]
        have he : ij.1 + (N - ij.2) = q + 2 * (N - ij.2) := by omega
        have hp : r ^ (ij.1 + (N - ij.2)) ≤ r ^ q := by
          rw [he, pow_add]
          exact mul_le_of_le_one_right (pow_nonneg hr0 _) (pow_le_one₀ hr0 hr1)
        calc
          ‖a ij.1‖ * ‖a (N - ij.2)‖
              ≤ ((N.choose ij.1 : ℝ) * r ^ ij.1) *
                ((N.choose (N - ij.2) : ℝ) * r ^ (N - ij.2)) :=
            mul_le_mul (ha _) (ha _) (norm_nonneg _) (by positivity)
          _ = ((N.choose ij.1 : ℝ) * (N.choose ij.2 : ℝ)) *
              r ^ (ij.1 + (N - ij.2)) := by rw [Nat.choose_symm h.2, pow_add]; ring
          _ ≤ ((N.choose ij.1 : ℝ) * (N.choose ij.2 : ℝ)) * r ^ q :=
            mul_le_mul_of_nonneg_left hp (by positivity)
      · simp only [norm_zero]
        positivity
    _ = ((N + N).choose (N + q) : ℝ) * r ^ q := by
      rw [← Finset.sum_mul]
      congr 1
      exact_mod_cast (Nat.add_choose_eq N N (N + q)).symm

theorem elementary_correlation_bound {N q : ℕ} (lam : Fin N → ℂ) {r : ℝ}
    (hr0 : 0 ≤ r) (hr1 : r ≤ 1) (hlam : ∀ i, ‖lam i‖ ≤ r) :
    ‖correlation N q (elementary lam)‖ ≤
      ((N + N).choose (N + q) : ℝ) * r ^ q :=
  norm_correlation_le hr0 hr1 (norm_elementary_le lam hlam)

/-- The denominator is derived from a_0=1, rather than assumed bounded below. -/
theorem relative_correlation_bound {N q : ℕ} (lam : Fin N → ℂ) {r : ℝ}
    (hr0 : 0 ≤ r) (hr1 : r ≤ 1) (hlam : ∀ i, ‖lam i‖ ≤ r) :
    ‖correlation N q (elementary lam)‖ ≤
      (((N + N).choose (N + q) : ℝ) * r ^ q) * vacuumWeight N (elementary lam) := by
  calc
    ‖correlation N q (elementary lam)‖ ≤
        ((N + N).choose (N + q) : ℝ) * r ^ q :=
      elementary_correlation_bound lam hr0 hr1 hlam
    _ ≤ (((N + N).choose (N + q) : ℝ) * r ^ q) *
        vacuumWeight N (elementary lam) :=
      le_mul_of_one_le_right (by positivity) (one_le_vacuumWeight (elementary_zero lam))

end QEDCore
