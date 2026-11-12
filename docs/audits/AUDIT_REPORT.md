> **Further proof attempts completed.** Sections 13--16 now contain an ultraviolet
> counterexample, an exchange-driven vacuum instability, and a screened lattice
> many-body relative theorem. The PDF has 72 pages. See
> [NEXT_STEPS_REPORT.md](../history/NEXT_STEPS_REPORT.md) for the current status.
> The earlier account below is retained for provenance.

# Audit of the supplied continuation

27 October 2026. This report supersedes the unverified claims in the original
handoff. The pre-audit source and PDF are preserved in
audit-backup-before-continuation-review.zip.

## Results

1. **The periodic Coulomb--Kato proof is completed.** The torus fractional
   quadratic form has coefficient 1/(2 pi^2). Folding and an explicit
   Lipschitz partition give c_* = 6 + 3 pi sqrt(6)/2 < 18. An analytic Ewald
   estimate proves G_1(x) - 1/|x| < -1/20 throughout the centered unit cell.
   Neither its sign nor the theorem depends on locating a numerical maximum.
   The finite rational comparisons are reproduced by numerics/audit_constants.py.

2. **The photon-free mean-field theorem survives with explicit hypotheses.**
   Theorem 10.4 applies to the fully free-Wick-ordered finite-cutoff model,
   alpha < 4/pi, L >= 1/Lambda_f, and
   L > alpha c_*/[2m(1-alpha pi/4)]. It gives
   E_HF(R,Z) - E_HF,vac >= -C alpha Lambda_f (Z_max + Z_max^2) K.
   The free sea is the Hartree--Fock vacuum for this particular Hamiltonian.
   Mixed quasifree density matrices impose charge only in expectation.
   Exact neutrality is obtained by restricting to the appropriate Slater
   projectors; the bound holds on both classes without identifying their infima.

3. **The static susceptibility calculation is validated and qualified.**
   chi(0) = Lambda_f^3/[6 pi^2 sqrt(Lambda_f^2+m^2)] is correct. The finite
   cosine response has coefficient -e^2 a^2 V chi_L(q)/2. The perturbative
   inverse acts on the orthogonal complement of the vacuum, parity is handled
   correctly, and translation symmetry improves the remainder to O(a^4).
   The actual finite-box negative-curvature criterion uses chi_L(q), not
   chi(0). The estimate L_* ~ 113/Lambda_f is not a sharp threshold theorem.
   Static curvature is not a derivation of a physical photon pole mass.

4. **The positive-photon-mass theorem is valid for an explicitly modified model.**
   The finite oscillator squeezing, its normal-ordering constant, and the
   noncommutative completion of squares have been checked. Any fixed positive
   bare transverse A^2 coefficient gives an extensive lower bound while
   retaining the original nonzero current couplings. Matching the static
   coefficient at leading order does not establish the Ward identities,
   renormalized masslessness, or equivalence to physical QED.

5. **The proposed strict absorption route is false.**
   Proposition 10.7 constructs exactly neutral Slater rotations for which,
   at delta mu^2 = 2e^2 chi(0), the magnetic-gain/kinetic-energy ratio approaches
   one as the box grows. Consequently a uniform coefficient below one,
   including the coefficient proposed in the old Remark 10.7, cannot work.
   This does not disprove the vacuum-relative theorem for the full functional.
   The sufficient large-bare-mass estimate is also improved: its coefficient
   is 2 e^2 d_L/(m delta mu^2), rather than 24 e^2 d_L/(m delta mu^2).

6. **The small-box obstruction is independent of the two specified conventions.**
   An analytic Ewald argument proves the sign of the retained self-image term.
   Both full nuclear-diagonal subtraction and subtraction of only the
   Euclidean divergence give the stated negative small-box sequence.
   No claim is made about arbitrary additional finite counterterms.

7. **The many-body correlation condition is sufficient, not equivalent.**
   The energy identity is exact. Bounding the increase in correlation energy
   by C K suffices for the photon-free primary bound. It is not necessary
   merely by that identity, because a positive Hartree--Fock source energy
   could compensate a larger correlation difference. The condition remains open.

## Literature and research-program corrections

- BBHS (1998) already treats point nuclei and pairs in generalized
  Hartree--Fock theory, with classical magnetic fields and a reference splitting
  adapted to an effective nuclear potential. It is not the fixed free-sea
  normal ordering used here. The present paper makes no novelty claim.
- Hainzl--Lewin--Solovej (2007) already contains a periodic Kato estimate.
  Its nonnegative periodic Coulomb convention, symmetrized charge, interacting
  mean-field vacuum, and regular external-density assumptions are distinguished.
- The added bibliography metadata and DOI links were checked against primary
  records. Donnelly (2014) and Gravejat--Lewin--Sere (2009) were added for
  Gauss-law factorization and reduced-BDF charge renormalization.
- A kinematic lattice tensor product is not a factorization of the constrained
  physical Hilbert space. Gluing must account for boundary electric flux.
- A source-free gap-persistence theorem does not supply uniform pair-sector
  gaps under arbitrary point-nucleus configurations or extensive Feshbach errors.
- Global neutrality alone does not produce controlled local dipoles. The
  infrared summability of a dipole tail is not ultraviolet charge renormalization.
- A proposed exponential cutoff window is a research target, not an established
  full-QED theorem.

## Files and verification

The corrected Sections 9--12 are in continuation-photons.tex,
continuation-meanfield.tex, and continuation-program.tex; paper-part-three.tex
includes them in that order. The original three agent appendices are retained.
AUDIT_AGENT_REPORTS.md records the additional user-facing audit findings.

The PDF is built by three pdflatex passes and checked with the Codex LaTeX
compiler. Every page is rendered for visual inspection; verification.json
records the final page count, unresolved-reference check, and compiler warnings.
Numerical scripts are supporting computations, not substitutes for the proofs.
This is a mathematical audit and proof attempt, not a formal proof-assistant
verification or a solution of the full physical-QED stability problem.
