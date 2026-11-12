> **Further proof attempts completed.** Sections 13--16 now contain an ultraviolet
> counterexample, an exchange-driven vacuum instability, and a screened lattice
> many-body relative theorem. The PDF has 72 pages. See
> [NEXT_STEPS_REPORT.md](../history/NEXT_STEPS_REPORT.md) for the current status.
> The earlier account below is retained for provenance.

# Collaborating agents: technical audit reports

27 October 2026. These are user-facing findings and supporting arguments,
not private internal deliberations. The full mathematical arguments are
incorporated into the revised LaTeX paper. The initial reports remain in
Appendices A--C.

## Finite-cutoff and mean-field audit

The finite-cutoff reviewer supplied the analytic Ewald certificate
G_1 - 1/r < -1/20, the explicit partition yielding
c_* = 6 + 3 pi sqrt(6)/2 < 18, and the completed folding proof.
The revised mean-field theorem states its box-size restriction and distinguishes
mean-charge quasifree states from exact-charge Slater projectors.

Two Bessel inequalities improve the current estimate to
integral |j_Q|^2 <= 4 d_L Tr Q^2. At the one-loop static mass tuning, exact
neutral Slater rotations show that the magnetic-gain/kinetic ratio approaches
one. This disproves the proposed uniform strict kinetic-absorption estimate,
while leaving the correctly vacuum-subtracted mean-field question open.

## QED response and oscillator audit

The QED reviewer checked the Dirac-projector trace, the cosine-mode factor V/2,
the reduced free Hamiltonian inverse, the momentum parity argument, and
the even analytic perturbation expansion. The photon squeezing is derived
in real sine/cosine coordinates, with the original normal-ordering constant
included. The extensive theorem is explicitly a theorem for a positive
bare transverse-mass modification.

The reviewer also supplied a separate analytic proof of the negative periodic
self-image constant. The small-box counterexample therefore holds under both
specified nuclear self-energy conventions.

## Independent cross-check of the new mean-field proofs

A second reviewer independently found no substantive error in:

- the periodic IMS folding identity and coefficient 1/(2 pi^2);
- the remainder 3 sqrt(6)/L and the resulting c_*;
- the Ewald shell multiplicities and all six rational/Taylor comparisons;
- the exact neutral Slater construction, with kinetic term t^2 s_L,
  current term 2t s_L, and s_L = V chi_L(q)/2.

The review requested that the selected soft photon mode be explicitly retained,
2 pi/L <= Lambda_gamma. That condition was added.

## Relativistic literature audit

The literature reviewer checked the BBHS reference splitting and magnetic
formulation, the Hainzl--Lewin--Solovej periodic kernel and vacuum normalization,
and the scope of the Frank--Lieb--Seiringer theorem. No priority claim is made
for the finite-cutoff mean-field adaptation.

Bibliographic data and primary-source links were checked for the added
references, including journal volumes, pages, and DOIs. The revised discussion
separates lattice kinematic factorization from the Gauss-law physical space,
and separates reduced-BDF charge-renormalization formulas from full QED.
