/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Mathlib.Analysis.Complex.Basic
import Mathlib.Data.Multiset.Filter

/-! Graph node `lem:transfer#eigenvalue-count` (Paper A, transfer.tex L70-71): a multiset of
nonzero complex numbers, invariant under `z ↦ (star z)⁻¹`, of cardinality `2 * d`, with no
element in the annulus `r < ‖z‖ < r⁻¹`, has exactly `d` elements in the disc `‖z‖ ≤ r`, and the
elements outside it are the reflections of those inside. -/

namespace QEDCore.PaperA

theorem annulus_split_of_pairing {S : Multiset ℂ} {r : ℝ} {d : ℕ}
    (hr0 : 0 < r) (hr1 : r < 1)
    (hcard : Multiset.card S = 2 * d)
    (h0 : (0 : ℂ) ∉ S)
    (hinv : S.map (fun z => (star z)⁻¹) = S)
    (hdich : ∀ z ∈ S, ‖z‖ ≤ r ∨ r⁻¹ ≤ ‖z‖) :
    (S.filter (fun z => ‖z‖ ≤ r)).card = d ∧
    S.filter (fun z => ¬ ‖z‖ ≤ r) = (S.filter (fun z => ‖z‖ ≤ r)).map (fun z => (star z)⁻¹) ∧
    ∀ z ∈ S, ¬ ‖z‖ ≤ r → r⁻¹ ≤ ‖z‖ := by
  have hr1' : 1 < r⁻¹ := (one_lt_inv₀ hr0).2 hr1
  have hn : ∀ z : ℂ, ‖(star z)⁻¹‖ = ‖z‖⁻¹ := fun z => by rw [norm_inv, norm_star]
  have key : ∀ z ∈ S, (‖(star z)⁻¹‖ ≤ r ↔ ¬ ‖z‖ ≤ r) := by
    intro z hz
    rw [hn]
    constructor
    · intro h h2
      have hz0 : 0 < ‖z‖ := norm_pos_iff.2 (fun h => h0 (h ▸ hz))
      have : r⁻¹ ≤ ‖z‖⁻¹ := inv_anti₀ hz0 h2
      linarith
    · intro h
      have h1 : r⁻¹ ≤ ‖z‖ := (hdich z hz).resolve_left h
      have := inv_anti₀ (inv_pos.2 hr0) h1
      simpa using this
  have key2 : ∀ z ∈ S, (¬ ‖(star z)⁻¹‖ ≤ r ↔ ‖z‖ ≤ r) := fun z hz => by
    rw [key z hz]; exact not_not
  have hsplit : S.filter (fun z => ¬ ‖z‖ ≤ r) =
      (S.filter (fun z => ‖z‖ ≤ r)).map (fun z => (star z)⁻¹) := by
    have h := congrArg (Multiset.filter (fun z => ¬ ‖z‖ ≤ r)) hinv
    rw [Multiset.filter_map] at h
    rw [← h]
    congr 1
    exact Multiset.filter_congr (fun z hz => key2 z hz)
  refine ⟨?_, hsplit, fun z hz h => (hdich z hz).resolve_left h⟩
  have h1 := Multiset.filter_add_not (fun z => ‖z‖ ≤ r) S
  have h2 := congrArg Multiset.card h1
  rw [Multiset.card_add, hsplit, Multiset.card_map, hcard] at h2
  omega

end QEDCore.PaperA
