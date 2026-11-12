# Technical reports from the further proof attempts

These are the collaborating agents' delivered findings and independent
checks. Their complete mathematical arguments are included in the paper.

## Finite-cutoff reviewer: ultraviolet point-source construction

The reviewer constructed normalized packets in opposite free-energy
subspaces, using a finite momentum cube and the Hermitian grading
C = -i a1 a2 a3. The off-diagonal point-Coulomb matrix element has the
explicit lower bound

    Re <u,G_L v> >= Lambda/(21600 sqrt(3) pi^2).

Spatial inversion makes the diagonal nuclear matrix elements equal.
A sea rotation and a zero-momentum electron form an exactly neutral
Slater determinant. Periodic Coulomb--Kato estimates bound the complete
direct and exchange energies; the spectator exchange term is estimated
separately. Optimizing the angle proves Theorem 13.1.

An independent reviewer checked the spinor bounds, lattice counting,
matrix-element constant, nuclear cancellation, spectator term, kinetic
bound, and angle optimization. No substantive flaw was found. The primary
agent checked these estimates as well and added the comparison showing
that the linear cutoff order is sharp.

## QED reviewer: exchange and the photon reference vacuum

The reviewer proved exact pointwise charge cancellation under the distinct
grading C5 = a1 a2 a3 b. The soft-direction exchange energy per volume
converges to X_Lambda/2, with X_Lambda strictly positive. The proof handles
the integrable momentum-diagonal singularity by a uniform lattice-shell
estimate and uses the real-space Coulomb expression for positivity.

Operator-norm and Hilbert--Schmidt Taylor bounds give remainders of order
V |t|^3. This yields an extensive lowering below the free-sea squeezed
vacuum at static one-loop matching. The reviewer also derived the
susceptibility cusp and checked and added the primary agent's proposed
exchange-dependent necessary bare-mass threshold.

The independent audit checked the grading, the exchange factor 1/2,
the singular Riemann-sum limit, the uniform remainders, and the cusp
angular integrals. No substantive flaw was found.

## Lattice reviewer: exact-charge relative energy and correlation

The reviewer proved a canonical-sector Lipschitz estimate for bounded
local number-preserving CAR Hamiltonians. The weighted creation and
annihilation commutator bounds handle completely occupied or empty
local sectors. Creation and contraction preserve Slater decomposability,
so the same comparison applies to the Slater variational class.

Combining this lemma with a source-potential norm proportional to total
nuclear charge gives two-sided source-energy comparisons and a two-sided
relative correlation bound. A Wilson-band Yukawa lattice model makes
all constants explicit and retains particle-hole pair terms.

The independent audit checked the local block inequalities, sector
endpoints, Slater preservation, interaction counting, kinetic constants,
and use of the exact neutral vacuum sector. It requested a narrower
description of the Coulomb obstruction: the divergence defeats the
absolute-row-sum estimate, rather than every conceivable density-based
argument. That clarification was incorporated.

## Shared limitations

The new ultraviolet theorem concerns a fixed bare-parameter, fixed-reference
mean-field model. The photon result is a variational upper bound in a
modified bare-mass model. The correlated-state theorem concerns a
screened lattice model. None of the reports claims to have proved
unscreened continuum QED stability or a controlled nonrelativistic
reduction of that theory.
