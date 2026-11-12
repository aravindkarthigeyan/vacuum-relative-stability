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
| Paper A | 0 | 6 |
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
| 5 | Lemma 3.1, spectral pairing | Weaker: eigenvectors, not multiplicities | `inverse_eigenvector`, `adjoint_inverse_eigenvector` |
| 6 | Theorem 4.1, proof of (4.2) | Abstract measure, explicit integrability | `positive_measure_comparison`, `canonical_integral_comparison` |

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
   `d ↦ N`, `s = e^{-b m_*} ↦ r` with the added hypothesis `0 ≤ r ≤ 1`, and
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
   `B(T)`, the factor `t` (the paper's `|λ|²`), the strict drop `B(T) < B(0)` and the
   contraction `B(T) ≤ r B(0)` are real-number hypotheses. In the paper they come from
   the derivative identity (3.3) and Gronwall's inequality. Effect: the Lean lemmas
   are the scalar implications that follow the analysis (no unit factor, the sign of
   `B(0)`, and the division step), not the annulus bound (3.2).

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
   Dyson bound. Effect: the Lean statement is the abstract integration step; it does
   not define the physical measure or prove (4.2). See `canonical_integral_comparison`
   in [`Core/CanonicalComparison.lean`](../lean/Core/CanonicalComparison.lean).

## How the formal proof route differs

For the Vandermonde step of Lemma 3.2, the paper sums
`Σ_j binom(d, j+q) binom(d, j) s^{2j}` and bounds it by `binom(2d, d+q)`. The Lean
proof first bounds every antidiagonal term by `binom(N, i) binom(N, j) r^q`, using
`r^{2k} ≤ 1`, and then sums with Mathlib's Vandermonde identity `Nat.add_choose_eq`.
The two routes give the same bound.

## Outside the formalization

Everything in Paper A other than the steps above, in particular Lemma 2.1,
Lemmas 4.2 and 5.1, Corollary 4.3, Proposition 5.3, Theorems 4.1, 5.2 and 5.4 as
stated, and Hypothesis (BF), which Paper A states and does not prove. Paper B and the
companion notes are not formalized.
