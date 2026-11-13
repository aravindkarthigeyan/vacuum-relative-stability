/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core.PaperA.Defs.CenteredTrace
import Mathlib.Analysis.SpecialFunctions.Exponential

/-! Graph node `lem:fourier#twist-is-kick`: appending the global charge twist `exp (i φ)` to a
history is appending the kick with scalar generator `φ • 1`. The transfer matrix is multiplied on
the left by the scalar `exp (i φ)`, and the centered trace picks up the prefactor `exp (-d φ i)`,
where `4 * card ι = 2 d`. -/

namespace QEDCore.PaperA

open Matrix
open scoped Kronecker

variable {ι : Type*} [Fintype ι] [DecidableEq ι]

theorem transferMatrix_append_kick (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) (Θ : Matrix ι ι ℂ) :
    transferMatrix α β (hist ++ [Step.kick Θ]) =
      NormedSpace.exp (Complex.I • (Θ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ))) *
        transferMatrix α β hist := by
  simp [transferMatrix, Step.generator]

theorem exp_I_smul_kron_scalar (φ : ℝ) :
    NormedSpace.exp (Complex.I • (((φ : ℂ) • (1 : Matrix ι ι ℂ)) ⊗ₖ
        (1 : Matrix (Fin 4) (Fin 4) ℂ))) =
      Complex.exp (φ * Complex.I) • (1 : Matrix (ι × Fin 4) (ι × Fin 4) ℂ) := by
  have h : Complex.I • (((φ : ℂ) • (1 : Matrix ι ι ℂ)) ⊗ₖ
      (1 : Matrix (Fin 4) (Fin 4) ℂ)) =
      Matrix.diagonal (fun _ : ι × Fin 4 => (φ * Complex.I : ℂ)) := by
    rw [Matrix.smul_kronecker, Matrix.one_kronecker_one, Matrix.smul_one_eq_diagonal]
    rw [← Matrix.diagonal_smul]
    congr 1
    funext x
    simp [mul_comm]
  rw [h, Matrix.exp_diagonal, Matrix.smul_one_eq_diagonal]
  congr 1
  funext i
  rw [Pi.coe_exp, Complex.exp_eq_exp_ℂ]

theorem centeredTrace_append_twist (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) {d : ℕ}
    (hd : 4 * Fintype.card ι = 2 * d) (φ : ℝ) :
    centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)]) =
      Complex.exp (-((d : ℂ) * φ * Complex.I)) *
        (Complex.exp ((1 / 2 : ℂ) * (hist.map fun s => (s.generator α β).trace).sum) *
          (1 + Complex.exp (φ * Complex.I) • transferMatrix α β hist).det) := by
  have hd' : (4 * Fintype.card ι : ℂ) = 2 * d := by exact_mod_cast hd
  have htr : (Step.generator α β (Step.kick ((φ : ℂ) • (1 : Matrix ι ι ℂ)))).trace =
      -(2 * d * φ * Complex.I) := by
    simp only [Step.generator, Matrix.trace_neg, Matrix.trace_smul,
      Matrix.smul_kronecker, Matrix.one_kronecker_one, Matrix.trace_one, Matrix.trace_smul,
      smul_eq_mul, Fintype.card_fin, Fintype.card_prod]
    push_cast
    rw [show (Fintype.card ι : ℂ) * 4 = 2 * d by rw [mul_comm]; exact hd']
    ring
  unfold centeredTrace
  rw [transferMatrix_append_kick, exp_I_smul_kron_scalar, List.map_append, List.sum_append,
    List.map_singleton, List.sum_singleton, htr, smul_mul_assoc, one_mul]
  rw [← mul_assoc, ← Complex.exp_add]
  congr 3
  ring
