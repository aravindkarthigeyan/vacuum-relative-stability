# Current mathematical status — round-five review split, 29 October 2026

The first-review document is [Paper A](../paper-a/paper-a-lattice.pdf);
[Paper B](../paper-b/paper-b-momentum.pdf) treats the momentum
regulator, and [companion notes](../companion-notes/companion-notes.pdf)
collect the low-energy results and obstructions. The mathematical
conclusions below are unchanged by this editorial split.
The consolidated 64-page draft remains intact.
The detailed mathematical continuation is in
[ROUND4_RESEARCH_REPORT.md](history/ROUND4_RESEARCH_REPORT.md); exact machine-checking
coverage and the review handoff are in [ROUND5_REVIEW_HANDOFF.md](history/ROUND5_REVIEW_HANDOFF.md).

## Compact gauge-invariant model

The model has one four-component Wilson field on a periodic cubic
lattice, spacing a>0, nonnegative bare m,r, gauge coupling g^2>0,
untruncated compact U(1) rotors, and every local Gauss constraint.
Integer sources are admissible exactly when |sum nu|<=2N.

The raw energy, including source electric self-energy, obeys

    E_nu >= E_0 + m |sum nu|.

With the specified individual periodic-diagonal subtraction,

    E_nu^sub - E_0 >= m sum Z_i
                     - (13 pi alpha/(8a)) Z_max^2 K.

An explicitly volume-independent infinite-lattice diagonal convention
is also proved. No arbitrary configuration-dependent subtraction is used.
The Hamiltonian has a separate extensive absolute lower bound.

A bounded magnetic clover term preserves the source comparison when
m_cl=m-sqrt(3)|lambda|/(g a^2)>=0. In the explicit electron convention,
lambda=g r a/2 restores the smooth-field tree-level spin coefficient
with the correct kinetic mass. This is a distinct improved Hamiltonian;
electric and radiative matching are not thereby established.

## Thermodynamics

At fixed a,g^2,m,r, the physical vacuum density has a limit. The explicit
periodic finite-size error is at most 6B/n, with
B=(4r+2+8/g^2)/a. Auxiliary-space cutting avoids physical-space
factorization.

For every admissible fixed periodic source cell, a screening-flow
trial state gives two-sided relative bounds with a cell-dependent
constant. Physical zero-boundary-flux open boxes also have a source
energy-density limit, proved by one-sided almost-subadditivity.

The periodic-source density is bounded between the vacuum-plus-rest
density and the open-source density. Equality with the open limit is
conditional on the stated boundary-flux comparison (BF). Cut averaging
is proved; it does not itself compare different block Gauss sectors.

## Low-energy reduction: proved scope and obstructions

At fixed classical links, the target is K=R+S^2/(2m), including the
Wilson Laplacian. Its ordered energies approximate the positive
Dirac bands with a charge-extensive error and a sharper low-energy
relative error. The kinetic and tree-level magnetic coefficients are

    m_kin=m/(1+rma),    g_eff=2/(1+rma).

The scaled choice r=c/(ma) has explicitly quantified, Z-dependent
resolution and doubler-separation conditions. The hydrogenic “about
60” crossover is not a strong scale separation and is not an
iron-inclusive window for the unscreened inner-shell benchmark.

The full quantized-link reduction is unproved. On periodic lattices
with n>=3, the following exact facts prevent the proposed shortcuts:

- Every eigenvector has infinite electric Fourier support, so the
  K=0 interacting vacuum has positive total tails at every finite F.
- No vacuum eigenvector is the bare on-site sea, including in any
  nontrivial sharp |E|<=F compression, F>=1.
- Therefore the proposed source-only bounds for those bare observables
  fail at K=0.
- For m>0, a valid excitation bound for energy <= E0+Delta is
  <N_exc> <= 2Delta/m + 6N/(ma)^2.
- Smooth Gauss-preserving electric IMS has an O(N/F^2) error and a
  local boundary-shell refinement. Sharp-cutoff boundary coupling
  does not tend to zero in operator norm.
- Positive elementary pair denominators solve a first homological
  equation for the mass-plus-electric reference, not a full pair-block
  spectral gap.

A local remainder annihilating the local sea is bounded as a quadratic
form by epsilon N_exc. Turning that into a source-sized error requires
a genuinely dressed coercivity theorem and control of any retained
gauge-vacuum operator. The exact conditional Schur hypotheses are stated.

## Separate momentum-cutoff model

The paper retains the continuum point-nucleus model with finite fermion
and transverse-photon cutoffs, prescribed free-sea Wick ordering, zero
Coulomb mode omitted, and harmonic photon zero mode fixed/omitted.
Physical neutrality requires q=sum Z_i<=2M_L.

When the effective mass is at least m_*>0, the one-nucleus comparison is

    E_Z-E_vac >= m_* Z -13 alpha Lambda_f Z^2/pi^2

for every admissible box. For arbitrary distinct nuclei and
L>=1/Lambda_f,

    E(R,Z)-E_vac >= m_* sum Z_i - alpha Lambda_f *
      [20 pi(1+1/pi)^3 Z_max
       +13/(4 pi^(3/2)) Z_max^2] K.

The photon-coordinate truncation limit is proved at fixed mode cutoffs.
A volume-uniform sufficient mass criterion
allows Lambda_f/m<5168.21 at alpha=1/137. The sharper logarithmic
criterion has a mesh error, and a coarse-box counterexample prevents
using its exponential window for all L. Density-product ordering,
a different specified Hamiltonian, needs no such cutoff/mass window.
General mixed-sign effective mass remains unresolved.

These regulator-dependent results do not construct renormalized
continuum QED or furnish ultraviolet-uniform constants at fixed physical
parameters. A charge gap is not a neutral pair-production gap.

## Files and review status

The consolidated paper integrates round three and round four, and the
bibliography distinguishes no-pair, mean-field, static-field, and
full correlated-field results. Fry's strong-field determinant result
is presented with its stated unproved assumptions.

The round-five review bundle includes the split papers, consolidated
and historical sources, technical reports, briefs, and numerical records.
Each separate clean TeX archive is checked by compilation from a fresh
extraction. The Lean project makes only the explicitly documented
partial machine-verification claims; it is not a formalization of the
full QED theorem. No paper has been uploaded as a publication.

The supplied credits Opus 5.5 + Astra 6 are recorded as AI-tool credits.
Human authorship and a publication license are unset. No human
specialist recipient was provided; the review request is prepared
but unsent. Independent internal audits do not replace external review.
