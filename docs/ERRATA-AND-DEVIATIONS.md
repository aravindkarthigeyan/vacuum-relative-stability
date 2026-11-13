# Errata and deviations

This record lists every known defect in the formalized source (errata) and every way
the Lean statements differ from the printed ones (deviations). An erratum is a printed
assertion that is false or a printed step that does not follow; a supplied argument
for a true step is not an erratum. Repairs of the project's own intermediate Lean
statements and open proof obligations are neither, and are not listed.

The source is Paper A, *Vacuum-relative stability and charge gaps in compact
Hamiltonian lattice QED*, in the version whose LaTeX files are pinned by SHA-256 in
[`lean/status.json`](../lean/status.json) (draft of 29 October 2026). Locations use
the theorem and equation numbers of that version's PDF,
[`paper-a/paper-a-lattice.pdf`](../paper-a/paper-a-lattice.pdf), together with the
LaTeX labels. Entries are counted once each, not per occurrence.

Only finite steps of three results are formalized (see
[CORRESPONDENCE.md](CORRESPONDENCE.md)), so the absence of errata below is weak
evidence about the paper as a whole.

<!-- BEGIN counts -->
| Source | Errata | Deviations |
|---|---|---|
| Paper A | 0 | 8 |
<!-- END counts -->

## Paper A

### Errata

None.

### Deviations

| # | Location | Kind | Lean statements |
|---|---|---|---|
| 1 | Lemma 3.2, (3.4) | Range of `q` | `norm_correlation_le`, `elementary_correlation_bound`, `relative_correlation_bound` |
| 2 | Lemma 3.2, proof | Reformulation as a finite coefficient bound | the same, and `correlation`, `vacuumWeight` |
| 3 | Lemma 3.1, proof | Generalization; inverse supplied | `preservesForm_mul`, `preservesForm_list_prod`, `adjoint_eq_conjugate_inverse` |
| 4 | Lemma 3.1, proof after (3.3) | Endpoint step as scalar implications | the five endpoint lemmas in `Core/PseudoUnitary.lean` |
| 5 | Lemma 3.1, spectral pairing | Weaker: eigenvectors, not multiplicities | `inverse_eigenvector`, `involution_mulVec_ne_zero`, `adjoint_inverse_eigenvector` |
| 6 | Theorem 4.1, proof of (4.2) | Abstract measure, explicit integrability | `positive_measure_comparison`, `canonical_integral_comparison` |
| 7 | Lemmas 3.1 and 3.2, class of histories | Specialization: piecewise-constant histories (ruling R1(a)) | `PaperA.positivity_and_transfer_annulus`, `PaperA.canonical_fourier_bound`, `PaperA.Step` |
| 8 | Lemmas 3.1 and 3.2, spatial factor | Generalization: any finite spatial index (ruling R2) | the same |

1. **Lemma 3.2 (`lem:fourier`), inequality (3.4).** Printed for integers `|q| ≤ d`.
   The Lean bounds hold for every natural number `q`, including `q > d`, where both
   sides are zero. Negative `q`, which the paper obtains by complex conjugation, is not
   stated. Effect: for `q ≥ 0` the Lean finite bound is slightly more general; there is
   no Lean statement for `q < 0`. See `relative_correlation_bound` in
   [`Core/Coefficients.lean`](../lean/Core/Coefficients.lean).

2. **Lemma 3.2 (`lem:fourier`), proof.** The paper bounds the Fourier coefficient
   `F_q` of a centered trace. Lean bounds the finite lag-`q` autocorrelation
   `correlation N q (elementary λ)` of the elementary symmetric coefficients, relative
   to `vacuumWeight N (elementary λ) = Σ_j |e_j|²`. Paper notation corresponds as
   `d ↦ N` (Lean's `N` is the paper's `d`, not its number of sites `N = n³`),
   `s = e^{-b m_*} ↦ r`, where Lean allows any `r` with `0 ≤ r ≤ 1` (the paper's `s`
   lies in `(0, 1)` because `b, m_* > 0`), and
   `F_q / C ↦ correlation`, `F_0 / C ↦ vacuumWeight`. The bound `|λ_j| ≤ e^{-b m_*}`,
   which the paper takes from Lemma 3.1, is a hypothesis. Effect: the Lean statements
   are the finite inequality inside the proof, not (3.4); the identification
   `F(φ) = C ∏_j |1 + e^{iφ} λ_j|²` is not formalized.

3. **Lemma 3.1 (`lem:transfer`), proof.** The relations `U* C_5 U = C_5` for a product
   and `U* = C_5 U^{-1} C_5` are stated in any monoid with a star-multiplication rather
   than for complex matrices, with `C_5² = 1` and an explicit right inverse `V` of `U`
   as hypotheses. Form preservation of each factor is a hypothesis. Effect: the Lean
   statements generalize the algebra; invertibility of the propagator and form
   preservation of each free evolution and kick are inputs. See
   [`Core/PseudoUnitary.lean`](../lean/Core/PseudoUnitary.lean).

4. **Lemma 3.1 (`lem:transfer`), the argument after (3.3).** The values `B(0)`,
   `B(T)`, the factor `t` (the paper's `|λ|²`), the endpoint relation
   `B(T) = t B(0)`, the strict drop `B(T) < B(0)` and the integrated bound
   `B(T) ≤ r B(0)` are real-number hypotheses. In the paper the endpoint relation
   comes from transporting a transfer eigenvector, the strict drop from (3.3) with
   `b > 0` and the non-vanishing of nonzero solutions, and the integrated bound from
   integrating (3.3) (Gronwall's inequality), with `r = e^{-2bm_*}` when `|λ| < 1`
   and `r = e^{2bm_*}` when `|λ| > 1`. Effect: the Lean lemmas are the scalar
   implications that follow the analysis (no unit factor, the sign of `B(0)`, and the
   division step giving `t ≤ r` or `r ≤ t`), not the annulus bound (3.2). See
   [`Core/PseudoUnitary.lean`](../lean/Core/PseudoUnitary.lean).

5. **Lemma 3.1 (`lem:transfer`), spectral pairing.** The paper pairs the transfer
   spectrum under `λ ↦ 1/conj(λ)` with algebraic multiplicities and counts exactly `d`
   eigenvalues in each region. Lean proves only that if `U x = λ x` with `x ≠ 0` and
   `λ ≠ 0`, then `C x ≠ 0` and `U* (C x) = λ^{-1} (C x)`, given a two-sided inverse
   and form preservation. Effect: the Lean statement is weaker than the printed
   pairing; no multiplicity or counting statement is formalized. See
   [`Core/Eigenvectors.lean`](../lean/Core/Eigenvectors.lean).

6. **Theorem 4.1 (`thm:main`), proof of (4.2).** The final step integrates the
   coefficient bound against the path and gauge-angle measure. Lean states it for an
   arbitrary measure on a measurable space, with a nonnegative real prefactor, a
   unit-modulus phase and eigenvalue data at each point, and with integrability of
   both integrands as explicit hypotheses; in the paper integrability follows from the
   Dyson bound. Lean's `N` is the paper's `d = 2N` here, so `binom(N + N, N + q)` is
   the `binom(4N, 2N + |Q_ν|)` of (4.2). Effect: the Lean statement is the abstract
   integration step; it does not define the physical measure or prove (4.2). See
   `canonical_integral_comparison` in
   [`Core/CanonicalComparison.lean`](../lean/Core/CanonicalComparison.lean).

Deviations 1–6 describe the older supporting lemmas in `lean/Core/*.lean`, which remain in the
library as helpers. Since 2026-11-12 Lemmas 3.1 and 3.2 are proved as frozen statements
(`QEDCore.PaperA.positivity_and_transfer_annulus`, `QEDCore.PaperA.canonical_fourier_bound`):
the spectral pairing with algebraic multiplicities, the exact count, the positivity of the
centered trace and the Fourier bound for integer `q` are now stated and proved, so deviations
1, 2, 4 and 5 no longer describe how those results stand in Lean. Deviations 7 and 8 describe
how the frozen statements differ from the printed lemmas.

7. **Lemmas 3.1 and 3.2 (`lem:transfer`, `lem:fourier`), class of histories.** The
   lemmas allow time-dependent coefficients `v_j(t)`, `M(t)` on the free intervals
   (transfer.tex lines 4–5 and 13; bounded measurable histories, lines 78–80), and
   Theorem 4.1 applies them to continuous Brownian-bridge paths (comparison.tex
   lines 70–89). The frozen Lean statements, by author ruling R1(a) of 2026-11-12
   ([DECISIONS.md](DECISIONS.md), D11), cover finite piecewise-constant histories: a
   list of free steps `exp(-τ h)` with `τ ≥ 0`, constant Hermitian `v_j` and constant
   `M ≥ m_* I`, and separate instantaneous spin-scalar kicks `exp(i Θ ⊗ 1)` with `Θ`
   Hermitian, the centering phase computed from `Θ` (ruling R4). A step on which free
   evolution and a kick act simultaneously is not a step of this class. Effect: the
   Lean statements are a special case of the printed lemmas. The conclusions pass to
   limits of step approximations (the annulus bounds are closed, the count `d`
   survives because no eigenvalue lies in the open gap `e^{-bm_*} < |λ| < e^{bm_*}`,
   and `F > 0` follows from `F ≥ 0` with `det(I + U) ≠ 0`), but that approximation is
   not formalized. See [`Step`](../lean/Core/PaperA/Defs/Step.lean) and the frozen
   statements in [`lean/Frozen/PaperA/`](../lean/Frozen/PaperA).

8. **Lemmas 3.1 and 3.2, spatial factor.** Section 3 states the lemmas abstractly for
   one-particle dimension `D = 2d` with the four-component Dirac structure; the
   application takes `ℓ²(X)` with `X` the lattice torus. The frozen statements take
   `ℓ²(ι) ⊗ ℂ⁴` for any finite type `ι`, the empty one included, with `d` a binder
   satisfying `4|ι| = 2d`, and any Hermitian 4×4 Clifford set `α_1, α_2, α_3, β`
   (author ruling R2). Effect: a harmless generalization; the lattice case is the
   instance `ι = X`. In Lemma 3.2 the inequality `|F_q| ≤ … F_0`, whose right side the
   paper treats as real, is stated as `Im F_0 = 0` together with `|F_q| ≤ … · Re F_0`
   (ruling R3); this makes the paper's implicit claim explicit and is not a deviation.

## How the formal proof route differs

For the Vandermonde step of Lemma 3.2, the paper sums
`Σ_j binom(d, j+q) binom(d, j) s^{2j}` and bounds it by `binom(2d, d+q)`. The Lean
proof first bounds every antidiagonal term by `binom(N, i) binom(N, j) r^q`, using
`r^{2k} ≤ 1`, and then sums with Mathlib's Vandermonde identity `Nat.add_choose_eq`.
The two routes give the same bound.

For `U* C_5 U = C_5` in Lemma 3.1, the paper derives the relation for the whole
propagator from `A* C_5 + C_5 A = 0` along the auxiliary ODE `U' = -A U`, which
includes the kicks. The Lean library instead composes form preservation of the
individual factors (`preservesForm_list_prod`); form preservation of each factor is
a hypothesis.

## Outside the formalization

Everything in Paper A other than the steps above. Lemmas 3.1 and 3.2 are proved for
piecewise-constant histories and any finite spatial index (deviations 7 and 8); their
time-dependent versions are not formalized. Theorem 4.1 is not formalized as stated; Lemma 2.1, Lemma 4.2, Corollary 4.3,
Lemma 5.1, Theorem 5.2, Proposition 5.3 and Theorem 5.4 have nothing in Lean.
Hypothesis (BF) is stated in Paper A and not proved there. Paper B and the companion
notes are not formalized.
