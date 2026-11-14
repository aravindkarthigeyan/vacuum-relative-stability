/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Fourier.TwistKick
import Core.PaperA.Defs.StepFreeTime
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Data.ZMod.Defs
import Mathlib.Data.Fintype.BigOperators

/-! Graph node `thm:main#twist-split` (Paper A, comparison.tex L82–L88): the kick
`exp (i (Θ + φ) ⊗ 1)` at the end of a history is the kick `exp (i Θ ⊗ 1)` followed by Lemma 3.2's
global twist `exp (i φ)`. The two kicks commute (`φ • 1` is central), so the transfer matrices
agree, and their generators add, so the centering factors multiply. No part of Lemma 3.1's
hypotheses is needed.

Wilson-independent plumbing for the nodes `thm:main#wilson-history`, `thm:main#apply-transfer`
and `thm:main#apply-fourier`, for histories of the shape
`links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++ [Step.kick Θ]`:

* the dimension count `4 |(ℤ/nℤ)³| = 2 (2 n³)` (so `d = 2 n³`) and the casts it produces;
* `diag (ϑ + φ) = diag ϑ + φ • 1`, and `diag c` is Hermitian for real `c`;
* the free-time sum of such a history is `Σ τ_k`;
* its free steps come from `links` and its only kick is `Θ`, packaged as the hypotheses
  `hfree`/`hkick` of the frozen Lemmas 3.1 and 3.2;
* the twisted integrand `F (φ)` is Lemma 3.2's twisted centered trace of the history ending in
  the relative kick `diag ϑ`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker ComplexOrder

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

/-! ### The twist split -/

omit [Fintype ι] [DecidableEq ι] in
/-- The generator of a kick is additive in the kick generator. -/
theorem Step.generator_kick_add (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (Θ Θ' : Matrix ι ι ℂ) :
    (Step.kick (Θ + Θ')).generator α β =
      (Step.kick Θ).generator α β + (Step.kick Θ').generator α β := by
  simp only [Step.generator, Matrix.add_kronecker, smul_add, neg_add]

/-- The kick `exp (i (Θ + φ) ⊗ 1)` factors as the global twist `exp (i φ)` after
`exp (i Θ ⊗ 1)`: the summand `φ • 1` is central. -/
theorem exp_I_smul_kron_add_smul_one (Θ : Matrix ι ι ℂ) (φ : ℝ) :
    NormedSpace.exp (Complex.I • ((Θ + (φ : ℂ) • 1) ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ))) =
      NormedSpace.exp (Complex.I • (((φ : ℂ) • (1 : Matrix ι ι ℂ)) ⊗ₖ
          (1 : Matrix (Fin 4) (Fin 4) ℂ))) *
        NormedSpace.exp (Complex.I • (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ))) := by
  have hc : ((φ : ℂ) • (1 : Matrix ι ι ℂ)) ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ) =
      (φ : ℂ) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) := by
    rw [Matrix.smul_kronecker, Matrix.one_kronecker_one]
  rw [Matrix.add_kronecker, smul_add, add_comm, Matrix.exp_add_of_commute]
  rw [hc, smul_smul]
  exact (Commute.one_left _).smul_left _

/-- **Twist split** (`thm:main#twist-split`). The centered trace of a history followed by the
kick `Θ + φ • 1` is that of the history followed by the kick `Θ` and then Lemma 3.2's global
twist `φ • 1`. -/
theorem centeredTrace_append_kick_add_smul_one (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) (Θ : Matrix ι ι ℂ) (φ : ℝ) :
    centeredTrace α β (hist ++ [Step.kick (Θ + (φ : ℂ) • 1)]) =
      centeredTrace α β (hist ++ [Step.kick Θ] ++ [Step.kick ((φ : ℂ) • 1)]) := by
  unfold centeredTrace
  rw [transferMatrix_append_kick, transferMatrix_append_kick, transferMatrix_append_kick,
    exp_I_smul_kron_add_smul_one, mul_assoc]
  simp only [List.map_append, List.map_cons, List.map_nil, List.sum_append, List.sum_cons,
    List.sum_nil, add_zero, Step.generator_kick_add, Matrix.trace_add, add_assoc]

/-! ### Diagonal kicks -/

omit [Fintype ι] in
/-- `diag (ϑ + φ) = diag ϑ + φ • 1`. -/
theorem diagonal_ofReal_add_eq (ϑ : ι → ℝ) (φ : ℝ) :
    Matrix.diagonal (fun x => ((ϑ x + φ : ℝ) : ℂ)) =
      Matrix.diagonal (fun x => ((ϑ x : ℝ) : ℂ)) + (φ : ℂ) • (1 : Matrix ι ι ℂ) := by
  rw [Matrix.smul_one_eq_diagonal, Matrix.diagonal_add]
  congr 1
  funext x
  simp only [Complex.ofReal_add]

omit [Fintype ι] in
/-- A real diagonal kick generator is Hermitian. -/
theorem isHermitian_diagonal_ofReal (c : ι → ℝ) :
    (Matrix.diagonal fun x => ((c x : ℝ) : ℂ)).IsHermitian :=
  Matrix.isHermitian_diagonal_iff.mpr fun x => by
    rw [isSelfAdjoint_iff, Complex.star_def, Complex.conj_ofReal]

/-- The twist split for the diagonal kick `diag (ϑ + φ)`. -/
theorem centeredTrace_append_diagonal_add (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) (ϑ : ι → ℝ) (φ : ℝ) :
    centeredTrace α β (hist ++ [Step.kick (Matrix.diagonal fun x => ((ϑ x + φ : ℝ) : ℂ))]) =
      centeredTrace α β (hist ++ [Step.kick (Matrix.diagonal fun x => ((ϑ x : ℝ) : ℂ))] ++
        [Step.kick ((φ : ℂ) • 1)]) := by
  rw [diagonal_ofReal_add_eq, centeredTrace_append_kick_add_smul_one]

/-- The twisted integrand `F` of a history of free steps followed by `diag (ϑ + φ)` is
Lemma 3.2's twisted centered trace of the history ending in the relative kick `diag ϑ`. -/
theorem centeredTrace_free_append_diagonal_add_eq {L : Type*}
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (links : List (ℝ × L)) (v : L → Fin 3 → Matrix ι ι ℂ) (M : L → Matrix ι ι ℂ)
    (ϑ : ι → ℝ) :
    (fun φ : ℝ => centeredTrace α β (links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++
        [Step.kick (Matrix.diagonal fun x => ((ϑ x + φ : ℝ) : ℂ))])) =
      fun φ : ℝ => centeredTrace α β ((links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++
        [Step.kick (Matrix.diagonal fun x => ((ϑ x : ℝ) : ℂ))]) ++
          [Step.kick ((φ : ℂ) • 1)]) := by
  funext φ
  exact centeredTrace_append_diagonal_add α β _ ϑ φ

/-! ### Histories of free steps followed by one kick -/

omit [Fintype ι] [DecidableEq ι] in
/-- The free time of a history of free steps followed by a kick is the sum of the step
durations. -/
theorem freeTime_sum_map_free_append_kick {L : Type*} (links : List (ℝ × L))
    (v : L → Fin 3 → Matrix ι ι ℂ) (M : L → Matrix ι ι ℂ) (Θ : Matrix ι ι ℂ) :
    ((links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++ [Step.kick Θ]).map
        Step.freeTime).sum = (links.map Prod.fst).sum := by
  simp only [List.map_append, List.map_map, List.map_cons, List.map_nil, List.sum_append,
    List.sum_cons, List.sum_nil, Step.freeTime, add_zero]
  rfl

omit [Fintype ι] [DecidableEq ι] in
/-- A free step of a history of free steps followed by a kick comes from a link. -/
theorem exists_mem_of_free_mem_map_append_kick {L : Type*} {links : List (ℝ × L)}
    {v : L → Fin 3 → Matrix ι ι ℂ} {M : L → Matrix ι ι ℂ} {Θ : Matrix ι ι ℂ} {τ : ℝ}
    {w : Fin 3 → Matrix ι ι ℂ} {N : Matrix ι ι ℂ}
    (h : Step.free τ w N ∈ links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++
      [Step.kick Θ]) :
    ∃ p ∈ links, τ = p.1 ∧ w = v p.2 ∧ N = M p.2 := by
  rw [List.mem_append, List.mem_map, List.mem_singleton] at h
  rcases h with ⟨p, hp, hs⟩ | h
  · simp only [Step.free.injEq] at hs
    exact ⟨p, hp, hs.1.symm, hs.2.1.symm, hs.2.2.symm⟩
  · cases h

omit [Fintype ι] [DecidableEq ι] in
/-- The only kick of a history of free steps followed by the kick `Θ` is `Θ`. -/
theorem eq_of_kick_mem_map_append_kick {L : Type*} {links : List (ℝ × L)}
    {v : L → Fin 3 → Matrix ι ι ℂ} {M : L → Matrix ι ι ℂ} {Θ Θ' : Matrix ι ι ℂ}
    (h : Step.kick Θ' ∈ links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++
      [Step.kick Θ]) :
    Θ' = Θ := by
  rw [List.mem_append, List.mem_map, List.mem_singleton] at h
  rcases h with ⟨p, -, hs⟩ | h
  · cases hs
  · simpa only [Step.kick.injEq] using h

omit [Fintype ι] in
/-- Hypothesis `hfree` of Lemmas 3.1 and 3.2 for a history of free steps followed by a kick,
from the corresponding per-link facts. -/
theorem free_mem_map_append_kick {mStar : ℝ} {L : Type*} {links : List (ℝ × L)}
    {v : L → Fin 3 → Matrix ι ι ℂ} {M : L → Matrix ι ι ℂ} (Θ : Matrix ι ι ℂ)
    (hlinks : ∀ p ∈ links, 0 ≤ p.1 ∧ (∀ j, (v p.2 j).IsHermitian) ∧
      (M p.2 - (mStar : ℂ) • 1).PosSemidef) :
    ∀ τ w N, Step.free τ w N ∈ links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++
        [Step.kick Θ] →
      0 ≤ τ ∧ (∀ j, (w j).IsHermitian) ∧ (N - (mStar : ℂ) • 1).PosSemidef := by
  intro τ w N h
  obtain ⟨p, hp, rfl, rfl, rfl⟩ := exists_mem_of_free_mem_map_append_kick h
  exact hlinks p hp

omit [Fintype ι] [DecidableEq ι] in
/-- Hypothesis `hkick` of Lemmas 3.1 and 3.2 for a history of free steps followed by a
Hermitian kick. -/
theorem kick_mem_map_append_kick {L : Type*} {links : List (ℝ × L)}
    {v : L → Fin 3 → Matrix ι ι ℂ} {M : L → Matrix ι ι ℂ} {Θ : Matrix ι ι ℂ}
    (hΘ : Θ.IsHermitian) :
    ∀ Θ', Step.kick Θ' ∈ links.map (fun p => Step.free p.1 (v p.2) (M p.2)) ++
        [Step.kick Θ] → Θ'.IsHermitian := by
  intro Θ' h
  rw [eq_of_kick_mem_map_append_kick h]
  exact hΘ

/-! ### Dimension count on the torus `(ℤ/nℤ)³` -/

/-- `|(ℤ/nℤ)³| = n³`. -/
theorem card_fin_three_zmod (n : ℕ) [NeZero n] : Fintype.card (Fin 3 → ZMod n) = n ^ 3 := by
  rw [Fintype.card_fun, ZMod.card, Fintype.card_fin]

/-- The dimension hypothesis `4 * card ι = 2 * d` of Lemmas 3.1 and 3.2 on `ι = (ℤ/nℤ)³`,
with `d = 2 n³`. -/
theorem four_mul_card_fin_three_zmod (n : ℕ) [NeZero n] :
    4 * Fintype.card (Fin 3 → ZMod n) = 2 * (2 * n ^ 3) := by
  rw [card_fin_three_zmod]
  ring

/-- `d = 2 n³` as an integer. -/
theorem natCast_two_mul_pow_three (n : ℕ) : ((2 * n ^ 3 : ℕ) : ℤ) = 2 * (n : ℤ) ^ 3 := by
  push_cast
  ring

/-- The charge range `|Q| ≤ 2 n³` in the form `|q| ≤ d` of Lemma 3.2. -/
theorem abs_le_natCast_two_mul_pow_three {n : ℕ} {Q : ℤ} (hQ : |Q| ≤ 2 * (n : ℤ) ^ 3) :
    |Q| ≤ ((2 * n ^ 3 : ℕ) : ℤ) := by
  rwa [natCast_two_mul_pow_three]

/-- Lemma 3.2's binomial `binom(2d, d + k)` with `d = 2 n³` is `binom(4 n³, 2 n³ + k)`. -/
theorem choose_two_mul_two_mul_pow_three (n k : ℕ) :
    (2 * (2 * n ^ 3)).choose (2 * n ^ 3 + k) = (4 * n ^ 3).choose (2 * n ^ 3 + k) := by
  rw [← mul_assoc]
  norm_num

end QEDCore.PaperA
