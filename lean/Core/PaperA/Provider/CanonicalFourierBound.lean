/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Core.PaperA.Defs.StepFreeTime
import Core.PaperA.Fourier.Bound
import Core.PaperA.Transfer.History
import Frozen.PaperA.PositivityAndTransferAnnulus
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.MeasureTheory.Integral.IntervalIntegral.Basic
import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic

/-!
# Provider for Paper A, Lemma 3.2 (`lem:fourier`)

`QEDCore.PaperA.Provider.canonical_fourier_bound` has exactly the statement of the frozen
anchor `Frozen/PaperA/CanonicalFourierBound.lean` (manifest entry `lem_fourier_v1`), copied
verbatim, and proves it from the graph nodes landed in `Core/PaperA/Fourier/`:

* `lem:fourier#apply-transfer`: the sealed Lemma 3.1
  (`QEDCore.PaperA.positivity_and_transfer_annulus`), applied once to the untwisted history,
  gives `F(0) = F > 0` real, the multiset `S` of the `d` roots of modulus `≤ e^{-b m_*}`, and
  the remaining roots `S.map (1 / conj ·)`; the roots are nonzero since `U` is invertible.
* `lem:fourier#twist-is-kick` and `#factorization`: `F(φ) = C |P(e^{iφ})|²`
  (`centeredTrace_append_twist_eq_mul_normSq`), with `S` enumerated as `λ_1, …, λ_d`.
* `#constant-positive`, `#coefficient-identification`, `#vacuum-real`, `#vacuum-lower-bound`,
  `#elementary-bound`, `#vandermonde`, `#negative-q`: `fourier_bound_of_factorization` with
  `t = b m_*`.

The anchor is sealed by `by exact` of this theorem applied to its own binders. This module
imports the sealed Lemma 3.1 anchor, never the Lemma 3.2 anchor.
-/

namespace QEDCore.PaperA.Provider

open Matrix
open scoped Kronecker ComplexOrder

-- The frozen hypothesis `hq : |q| ≤ d` is kept verbatim but is not needed: the bound holds
-- for every integer `q` (for `|q| > d` both sides vanish).
set_option linter.unusedVariables false in
/-- Proof of Paper A, Lemma 3.2 for piecewise-constant histories; see the frozen anchor. -/
theorem canonical_fourier_bound
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b)
    (q : ℤ) (hq : |q| ≤ d) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    (Fhat 0).im = 0 ∧
      ‖Fhat q‖ ≤ ((2 * d).choose (d + q.natAbs) : ℝ) *
        Real.exp (-(b * mStar * |(q : ℝ)|)) * (Fhat 0).re := by
  intro F Fhat
  -- `lem:fourier#apply-transfer`: Lemma 3.1 for the untwisted history.
  obtain ⟨⟨hre, him⟩, hcard, hpair, -⟩ :=
    QEDCore.PaperA.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
      hαβ_anti d hd mStar b hm hb hist hfree hkick htime
  obtain ⟨lam, hlam⟩ := exists_fin_enum_of_card _ hcard
  have hroots : (transferMatrix α β hist).charpoly.roots =
      (Finset.univ : Finset (Fin d)).val.map lam +
        ((Finset.univ : Finset (Fin d)).val.map lam).map (fun z => (star z)⁻¹) := by
    rw [hlam, ← hpair, Multiset.filter_add_not]
  have hmem : ∀ j, lam j ∈ (transferMatrix α β hist).charpoly.roots.filter
      (fun z => ‖z‖ ≤ Real.exp (-(b * mStar))) := fun j =>
    hlam ▸ Multiset.mem_map_of_mem lam (Finset.mem_univ_val j)
  obtain ⟨V, hUV⟩ := (isUnit_transferMatrix (α := α) (β := β) hist).exists_right_inv
  have hlam0 : ∀ j, lam j ≠ 0 := fun j h0 =>
    zero_not_mem_charpoly_roots hUV (h0 ▸ Multiset.mem_of_mem_filter (hmem j))
  have hlamr : ∀ j, ‖lam j‖ ≤ Real.exp (-(b * mStar)) := fun j =>
    (Multiset.mem_filter.mp (hmem j)).2
  have hF0 : F 0 = centeredTrace α β hist := centeredTrace_append_twist_zero α β hist hd
  -- `#factorization`, then the abstract Fourier bound with `t = b m_*`.
  exact fourier_bound_of_factorization lam (mul_pos hb hm).le hlamr F
    (centeredTrace_append_twist_eq_mul_normSq α β hist hd lam hlam0 hroots)
    (by rw [hF0]; exact hre) (by rw [hF0]; exact him) Fhat (fun _ => rfl) q

end QEDCore.PaperA.Provider
