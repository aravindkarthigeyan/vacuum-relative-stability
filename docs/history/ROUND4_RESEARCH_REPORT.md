# Round-four research report — 29 October 2026

The primary paper is now **Vacuum-relative stability in Hamiltonian
lattice QED**, led by the compact gauge-invariant theorem. Round-three
results and the new round-four proofs are integrated with explicit
hypotheses. The incoming CODEX_NEXT_TASKS_4.md is preserved unchanged.

## Main outcomes

The proposed full dynamical nonrelativistic reduction is still not
proved. Two proposed source-relative inputs are false for their stated
bare observables. This round supplies counterexamples in the actual
compact model, valid replacements, and several additional theorems.

1. **Matching and static reduction.** The frozen-link Schur-complement
   theorem now has both a whole-band error and a sharper relative
   low-energy error. The target retains the Wilson Laplacian. Its
   kinetic mass is m/(1+rma), and its tree-level smooth-field spin
   factor is 2/(1+rma). These are not radiatively matched physical
   electron parameters.
2. **Magnetic improvement can preserve stability.** An explicitly
   defined bounded magnetic clover term gives a different Hamiltonian
   satisfying the same physical-sector vacuum comparison whenever
   its total beta-form mass remains nonnegative. The tree-level
   coefficient restoring g=2 obeys this condition in a useful heavy
   regime. Indefiniteness of the improvement term alone does not
   invalidate the comparison.
3. **Actual vacuum counterexamples.** Every eigenvector has infinite
   electric Fourier support. No vacuum eigenvector is the bare on-site
   Dirac sea, including after a nontrivial sharp electric compression.
   Thus a source-only budget with zero right side at K=0 cannot bound
   either observable.
4. **Restricted rigorous estimates.** Gauss-preserving smooth IMS
   localization has a quadratic inverse-cutoff error; sharp electric
   compression has explicit boundary terms and fixed-volume Galerkin
   convergence. A first pair-elimination equation is solved for the
   mass-plus-electric reference inside a finite flux cube. This is
   not a gap theorem for the full pair block.
5. **Thermodynamics.** The vacuum thermodynamic limit and fixed-cell
   relative bounds from round three are integrated. An additional
   open zero-boundary-flux source thermodynamic limit is proved for
   every admissible fixed periodic nuclear cell. Equality with the
   periodic-source limit remains conditional on the explicit (BF)
   boundary-flux comparison.

## Exact new estimates and qualifications

### Frozen links and the scaled Wilson parameter

For h = [[m+R,S],[S,-m-R]], R>=0, define K=R+S^2/(2m), w=||R||,
s=||S||. If m+e_j and k_j are the ordered positive Dirac energies
and target energies,

    0 <= k_j-e_j <= min{
        s^2 w/(2m^2) + s^4/(8m^3),
        k_j(w+k_j)/(2m)
    }.

At the same frozen link configuration the addition-energy error is
the sum over the added levels and is therefore proportional to charge.
Quantizing the links adds electric derivative connections and a
link-dependent sea energy; those are not discarded.

For x=ma and r=c/x, define the benchmark hydrogenic scales with
m_kin=m/(1+c). The explicit requirements

    x >= H > 1,
    a Z alpha m_kin <= epsilon_a,
    [(Z alpha)^2 m_kin/2] / [2cm/x^2] <= epsilon_d

are equivalent to

    H <= x <= min{
      epsilon_a(1+c)/(Z alpha),
      2 sqrt(epsilon_d c(1+c))/(Z alpha)
    }.

At c=0.1, alpha=1/137 and 10% tolerances the upper bound is 15.07
for Z=1 and about 0.580 for Z=26. Even unit tolerances give about
3.50 for the unscreened iron benchmark. These are scale diagnostics,
not an interacting no-go theorem. They rule out calling the proposed
hydrogenic “about 60” window a well-separated iron-inclusive regime.

### A sufficient compact clover condition

Use g=+sqrt(g^2), U=exp(-ig integral A.dl), and the explicitly
normalized four-plaquette magnetic clover. Its bound is

    ||Sigma.B_cl|| <= sqrt(3)/(g a^2).

For h_lambda=h_W+lambda beta Sigma.B_cl, the determinant mechanism
survives under

    m_cl=m-sqrt(3)|lambda|/(g a^2) >= 0.

The resulting raw physical energy obeys

    E_nu^(lambda) >= E_0^(lambda) + m_cl |sum nu|.

With lambda_tree=g r a/2, the smooth-field tree-level spin factor
becomes 2 and the sufficient condition is m>=sqrt(3)r/(2a).
This does not match electric, Darwin, spin-orbit, or radiative terms.
It changes the Hamiltonian and must not be silently assigned to the
unimproved Wilson model.

### Electric flux, pair number, and the failed source-relative bounds

The scalar plaquette Fourier shift is an exposed extreme shift of the
Hamiltonian. The largest coefficient of a hypothetically finitely
supported eigenvector cannot cancel in the eigenvalue equation.
Therefore the total high-flux tail is positive at every finite F,
including in the source-free interacting vacuum.

A valid energy budget for a state with energy <= E0+Delta is

    c F^2 <sum_links 1_{|E|>=F}>
      <= <H_E>
      <= Delta + N[6(1+r)/a + 3/(g^2 a)],
    c=g^2/(2a).

Gauss's law supplies no upper flux bound Z/6. For a charge-26 site
it instead implies sum_incident E^2>=96, and a divergence-free
circulation can increase flux arbitrarily without changing Gauss law.

For the bare excitation number N_exc=Ne+Np, n>=3,

    ||dGamma(alpha.v)(f Omega_bare)||^2=(3N/a^2)||f||^2.

No eigenvector can therefore lie in its zero eigenspace. The sharp
|E|<=F compression, F>=1, retains a lower bound 3N/(2a^2).
For the compressed statement the vacuum reference is its own E0,F.
The proposed bare-number coercivity fails at K=0 in both cases.

There is nevertheless a rigorous uniform excitation-density bound:

    <N_exc> <= 2 Delta/m + 6N/(ma)^2.

Its proof uses the exact on-site pair decomposition and a two-mode
singular-value inequality. It controls heavy virtual-pair density
but retains a volume term.

If every bounded self-adjoint local remainder R_X annihilates its
local sea, then the valid quadratic-form conclusion is

    -epsilon N_exc <= sum_X R_X <= epsilon N_exc,
    epsilon=sup_x sum_{X containing x} ||R_X||.

That algebraic design principle is sound. It does not prove the
missing coercivity for a dressed excitation number, nor does it
cancel a source-independent but nonconstant gauge operator.

The internal elementary pair denominator on |E|<=F is bounded by
2mu-c(2F-1), mu=m+3r/a. Its positivity allows the first restricted
homological equation to be solved. The full pair-block resolvent
and the source-relative Schur correction are additional, unproved
operator hypotheses.

### Open versus periodic source thermodynamics

Auxiliary cutting proves the vacuum density limit with error
6B/n for periodic cubes, B=(4r+2+8/g^2)/a.
For an admissible fixed source cell, physical zero-flux open-block
ground states can be glued by adjoining zero-flux rotors. One-sided
almost-subadditivity and extensive bounds then prove the open
source density limit, without any boundary-flux theorem.

Cutting a periodic source state instead produces a direct sum of
shifted block Gauss sectors. The exact variational formula includes
their energies and the cut electric energy. An unrestricted comparison
with zero-flux block energies is false when that block sector is
empty; the paper gives a charge-four layered counterexample.

For commensurate admissible blocks, the stated (BF) comparison remains
open. Averaging cuts by whole source cells controls exposed electric
energy by O(N/ell). Any finite coefficient C_f in a valid (BF) estimate
would then suffice for the periodic limit. Without averaging, direct
absorption counts every cut edge twice and requires 2C_f<=g^2/(2a).
Averaging does not itself change or compare the block Gauss sectors.

## Literature, review, and publication scope

The paper integrates the conditional status of Fry's strong-field
determinant calculation, the volume scaling and hypotheses of the
Bravyi–DiVincenzo–Loss theorem, and the fact that the supplied
spin-scalar numerical control remains gauge invariant. Required
relativistic and QED stability references are distinguished by their
degrees of freedom; no no-pair theorem is applied to the full field.

Three technical reports and independent cross-audits accompany the
paper. These are AI-assisted internal checks, not external specialist
review. The project-owner credits “Opus 5.5 + Astra 6” appear as tool
credits and disclosure. Human author metadata is unset. No specialist
recipient was supplied, and no message was sent.

The arXiv-format source package is prepared locally with required TeX
inputs and ancillary code/data. It is not an uploaded submission.
Human authorship, license selection, and external review remain for
the responsible submitter. No priority claim is made.
