/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.WilsonHopping
import Core.PaperA.Defs.WilsonMass
import Core.PaperA.Wilson.Shift
import Core.PaperA.Wilson.TwistSplit
import Frozen.PaperA.PositivityAndTransferAnnulus
import Frozen.PaperA.CanonicalFourierBound
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-!
# Provider for a proof step of Paper A, Theorem 4.1 (`thm:main`)

This module proves `QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound`, whose
statement is exactly that of the frozen anchor `Frozen/PaperA/WilsonTwistedTraceBound.lean`
(manifest entry `main_twisted_integrand_v1`). The anchor is sealed by replacing its placeholder
proof with an exact use of that theorem.

Proof (comparison.tex L70–L89). The history is `links.map (free step) ++ [kick]` on
`ι = (ℤ/nℤ)³`, so `4 |ι| = 2 d` with `d = 2 n³`, and its free time is `b`.

* `thm:main#wilson-history`: the free steps have Hermitian `v_j(U) = wilsonHopping n a U j`
  (`isHermitian_wilsonHopping`, node `thm:main#wilson-hopping-hermitian`), and
  `M(U) - m 1 ⪰ 0` (`posSemidef_wilsonMass_sub`, node `eq:mass-bound#mass-lower-bound`), with
  `τ ≥ 0`. The kick generator `diag θ` is Hermitian for real `θ`.
* `thm:main#apply-transfer`: for each `φ`, the sealed Lemma 3.1
  (`QEDCore.PaperA.positivity_and_transfer_annulus`, with `mStar = m` and the kick
  `diag (ϑ + φ)`) gives `0 < Re F(φ)` and `Im F(φ) = 0`.
* `thm:main#twist-split`: `F(φ)` is the centered trace of the history ending in the relative
  kick `diag ϑ`, followed by Lemma 3.2's global twist `φ • 1`
  (`centeredTrace_free_append_diagonal_add_eq`).
* `thm:main#apply-fourier`: the sealed Lemma 3.2 (`QEDCore.PaperA.canonical_fourier_bound`)
  applies to that history with `mStar = m`, `d = 2 n³` and `q = Q`, `|Q| ≤ 2 n³`. Its binomial
  `binom(2 d, d + |Q|)` is `binom(4 n³, 2 n³ + |Q|)`.
* `thm:main#integrand-centered-trace` is definitional under ruling R8: the frozen statement
  defines the integrand as this centered trace.

The hypothesis `hn : 3 ≤ n` is not needed.
-/

namespace QEDCore.PaperA.Provider

open Matrix
open scoped Kronecker ComplexOrder

set_option linter.unusedVariables false in
/-- **Paper A, Theorem 4.1, proof step: the twisted Wilson integrand** (provider of
`main_twisted_integrand_v1`). `F(φ)` is real and positive, `F_0` is real, and
`|F_Q| ≤ binom(4N, 2N + |Q|) e^{-bm|Q|} F_0` for `|Q| ≤ 2N`, `N = n³`. -/
theorem wilson_twisted_trace_pos_and_fourier_bound
    {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (a m r : ℝ) (ha : 0 < a) (hm : 0 < m) (hr : 0 ≤ r)
    (links : List (ℝ × ((Fin 3 → ZMod n) → Fin 3 → ℂ)))
    (hlinks : ∀ p ∈ links, 0 ≤ p.1 ∧ ∀ x j, ‖p.2 x j‖ = 1)
    (b : ℝ) (hb : 0 < b) (htime : (links.map Prod.fst).sum = b)
    (ϑ : (Fin 3 → ZMod n) → ℝ) (Q : ℤ) (hQ : |Q| ≤ 2 * (n : ℤ) ^ 3) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β
      (links.map (fun p => Step.free p.1 (wilsonHopping n a p.2) (wilsonMass n a m r p.2)) ++
        [Step.kick (Matrix.diagonal fun x => ((ϑ x + φ : ℝ) : ℂ))])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    (∀ φ : ℝ, 0 < (F φ).re ∧ (F φ).im = 0) ∧ (Fhat 0).im = 0 ∧
      ‖Fhat Q‖ ≤ ((4 * n ^ 3).choose (2 * n ^ 3 + Q.natAbs) : ℝ) *
        Real.exp (-(b * m * |(Q : ℝ)|)) * (Fhat 0).re := by
  intro F Fhat
  -- `thm:main#wilson-history`: dimension `d = 2 n³`, mass `m_* = m`, Hermitian data.
  have hd : 4 * Fintype.card (Fin 3 → ZMod n) = 2 * (2 * n ^ 3) :=
    QEDCore.PaperA.four_mul_card_fin_three_zmod n
  have hl : ∀ p ∈ links, 0 ≤ p.1 ∧ (∀ j, (wilsonHopping n a p.2 j).IsHermitian) ∧
      (wilsonMass n a m r p.2 - (m : ℂ) • 1).PosSemidef := fun p hp =>
    ⟨(hlinks p hp).1, QEDCore.PaperA.isHermitian_wilsonHopping a p.2,
      QEDCore.PaperA.posSemidef_wilsonMass_sub a m r ha hr p.2 (hlinks p hp).2⟩
  refine ⟨fun φ => ?_, ?_⟩
  · -- `thm:main#apply-transfer`: Lemma 3.1 for the history ending in `diag (ϑ + φ)`.
    exact (QEDCore.PaperA.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq
      hα_anti hαβ_anti (2 * n ^ 3) hd m b hm hb
      (links.map (fun p => Step.free p.1 (wilsonHopping n a p.2) (wilsonMass n a m r p.2)) ++
        [Step.kick (Matrix.diagonal fun x => ((ϑ x + φ : ℝ) : ℂ))])
      (QEDCore.PaperA.free_mem_map_append_kick _ hl)
      (QEDCore.PaperA.kick_mem_map_append_kick
        (QEDCore.PaperA.isHermitian_diagonal_ofReal fun x => ϑ x + φ))
      ((QEDCore.PaperA.freeTime_sum_map_free_append_kick _ _ _ _).trans htime)).1
  · -- `thm:main#apply-fourier`: Lemma 3.2 for the history ending in `diag ϑ`, with `q = Q`.
    have H32 := QEDCore.PaperA.canonical_fourier_bound α β hα_herm hβ_herm hα_sq hβ_sq
      hα_anti hαβ_anti (2 * n ^ 3) hd m b hm hb
      (links.map (fun p => Step.free p.1 (wilsonHopping n a p.2) (wilsonMass n a m r p.2)) ++
        [Step.kick (Matrix.diagonal fun x => ((ϑ x : ℝ) : ℂ))])
      (QEDCore.PaperA.free_mem_map_append_kick _ hl)
      (QEDCore.PaperA.kick_mem_map_append_kick (QEDCore.PaperA.isHermitian_diagonal_ofReal ϑ))
      ((QEDCore.PaperA.freeTime_sum_map_free_append_kick _ _ _ _).trans htime) Q
      (QEDCore.PaperA.abs_le_natCast_two_mul_pow_three hQ)
    -- `thm:main#twist-split`: `F` is Lemma 3.2's twisted centered trace.
    have hF : F = _ := QEDCore.PaperA.centeredTrace_free_append_diagonal_add_eq α β links
      (wilsonHopping n a) (wilsonMass n a m r) ϑ
    simp only [Fhat, hF]
    rw [← QEDCore.PaperA.choose_two_mul_two_mul_pow_three]
    exact H32

end QEDCore.PaperA.Provider
