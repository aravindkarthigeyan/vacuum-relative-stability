# Results of the next proof attempts

The revised paper contains complete proofs in Sections 13--16. These results
supersede the research questions in the original handoff where explicitly stated.
The preceding 54-page version is preserved in
research-backup-before-next-steps.zip.

## 1. The proposed ultraviolet-uniform mean-field theorem is false

Theorem 13.1 treats the same fully free-Wick-ordered photon-free model,
at fixed mass, bare coupling 0 < alpha < 4/pi, and a fixed box satisfying
the earlier mean-field coercivity condition. A single unit point nucleus
has exactly neutral Slater trial states satisfying

    E_HF(Lambda,L;0,1) - E_HF,vac(Lambda,L) <= m - c_alpha Lambda,
    c_alpha > 0.

The free Hartree--Fock vacuum energy is zero in this model. The construction
uses opposite-energy Fourier packets and one coherent pair rotation, plus
a zero-momentum electron to enforce exact neutrality. Every direct, exchange,
and spectator interaction is included in the estimate.

The argument is entirely in finite Fourier sums. Explicit packet, coupling,
and cutoff-threshold constants are given. Together with the existing lower
bound, it proves that linear cutoff dependence is necessary for this
one-nucleus problem. Physical alpha and Z=1 are covered.

This refutes the suggested cutoff-independent strengthening for the stated
reference and point-source convention. It does not refute a separately
renormalized model, or the many-body comparison after subtracting the
actual interacting many-body vacuum.

## 2. Exchange destabilizes the statically matched free sea

Theorem 14.5 strengthens the previous failed-absorption result. At the
bare transverse mass delta_mu^2 = 2 e^2 chi(0), exactly neutral Slater
determinants tensored with squeezed coherent photon states give

    E_vac <= E_product,vac <= E_gamma - c L^3

for sufficiently large boxes at fixed positive mass, cutoffs, and coupling.
The grading C5 = a1 a2 a3 b proves that the trial charge density vanishes
pointwise for every rotation parameter. The direct Coulomb term therefore
vanishes exactly. Kinetic and photon quadratic terms cancel in the soft
limit, while exchange retains a strictly negative quadratic energy density.
Uniform Taylor remainder bounds make the lowering extensive.

The paper also proves the sharp-cutoff susceptibility cusp and an
exchange-dependent necessary bare-mass threshold (Corollary 14.6):

    delta_mu^2 >= 2 e^2 chi(0) / (1-r_Lambda),
    r_Lambda = alpha X_Lambda / (2 chi(0)),
    0 < r_Lambda <= alpha pi/4 < 1.

This condition is necessary for free-sea minimality, not sufficient and
not a physical photon-mass renormalization prescription. The actual
mean-field reference vacuum is nontrivial at the one-loop static tuning.

## 3. A screened lattice many-body relative theorem is proved

Theorem 15.2 compares exact source-charge sectors with the actual
interacting neutral vacuum, for all correlated states as well as Slater
determinants:

    E_nu - E_0,vac >= -C_mu Z_max K,
    |c_nu - c_0| <= 2 C_mu Z_max K.

For local number-preserving CAR Hamiltonians with bounded interaction norm J,
the key lemma is the uniform canonical energy estimate

    |E(N') - E(N)| <= 2 J |N'-N|.

It is proved by creation and annihilation trial states, including sectors
near empty and full occupancy. A separate argument verifies that these
operations preserve the Slater class when nonzero.

The concrete example uses Wilson Dirac bands and the positive discrete
Yukawa resolvent, retaining its zero mode. The exact kernel row sum is
4 pi/mu^2. Particle-hole pair terms are retained. The theorem needs no
small-coupling or spectral-gap assumption, and is uniform in volume and
source configuration.

This is a screened, photon-free lattice theorem. Its constants diverge
when screening is removed; the Coulomb absolute-row-sum estimate grows
quadratically with box side. No continuum or unscreened QED theorem follows.

## What remains open

The unscreened continuum many-body vacuum-relative comparison remains open.
The next useful estimates must address the nonsummable Coulomb tail and
the actual interacting vacuum, rather than the now-disproved ultraviolet
strengthening or free-sea minimality at the one-loop static tuning.
No configuration-uniform pair-sector gap or extensive Feshbach correction
has been proved. Section 16 states these limitations explicitly.

## Verification and files

The three new proof files are next-uv.tex, next-photon-vacuum.tex,
and next-screened-lattice.tex. next-conclusions.tex gives the resulting
research status. Each new argument received a separate agent audit;
the primary agent also checked the constructions and constants.
NEXT_STEPS_AGENT_REPORTS.md records those technical findings.

The PDF has 72 pages. It was compiled through three local pdflatex passes
and checked with the Codex LaTeX compiler. Final compiler and rendered-page
checks are recorded in stability-qed-paper/verification.json.
The mathematical checks are not a formal proof-assistant verification,
and no claim of literature priority is made.
