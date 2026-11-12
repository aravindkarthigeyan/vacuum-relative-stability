# Round-three validation and literature applicability
Date: 29 October 2026.

This is an audit of the supplied numerical checks and the proposed nonrelativistic route. Existing paper sources and supplied scripts were not changed. These results do not establish priority.

## 1. Both supplied lattice scripts reproduce

Environment: Python 3.12.14, NumPy 2.3.5; OPENBLAS_NUM_THREADS, MKL_NUM_THREADS, and OMP_NUM_THREADS set to 1 for these runs. Both scripts completed with exit code 0.

| Script | min(E_nu - E_0) | min(E_nu - E_0 - m abs(sum nu)) |
|---|---:|---:|
| claude_lattice_1d_gauss_check.py | 0.11137650412315825 | 0.11137650412315825 |
| claude_lattice_1d_scalar_control.py | -0.25120745409778333 | -1.6840305765244952 |

Complete captured output:
- numerics/claude_lattice_1d_gauss_check.round3.output.txt
- numerics/claude_lattice_1d_scalar_control.round3.output.txt

Original source SHA256:
- gauss_check: F711911F926A2C3F9C50FE3EC6C6998A1112B7B9F12F1FF52CA7CF344C2B2226
- scalar_control: B9F65AB3BB3F271128FF568A0B45F167603F2A8C0CBFE91C7DB97696F73F617A

The deterministic seed-7 sampling generates 316 admissible, nonzero source configurations for the first script, of which 273 have nonzero total source charge. The scalar control generates 323 such configurations, 280 with nonzero total charge. Both use 60 independent parameter draws with six source proposals per draw. The minimum reported by the script includes nonzero source configurations of total charge zero: it is not specifically the minimum over charged sectors.

### What is implemented

There are four sites, two fermion components per site, and eight fermionic modes. Full Fock space dimension is 256, but ground energies are diagonalized within sectors of total electron excess q, whose largest dimension is binomial(8,4) = 70.

The open chain has zero electric flux at both ends. Gauss's law fixes each interior flux to
E_l = sum_{x <= l}(nu_x - q_x).
The right boundary condition is imposed by choosing total fermionic charge equal to sum nu. Electric energy is therefore exactly (g^2/2a) sum_l E_l^2 on the retained sector. Gauge links on an open tree can be eliminated; there are no loop holonomies or independent transverse photon modes. The code has no plaquette term.

The Wilson matrix uses an open shift T, which is not unitary. Nevertheless 2I-T-T* is the positive Dirichlet chain Laplacian, so M >= m remains valid. This is a legitimate boundary variant, not the periodic three-dimensional model literally.

The scalar control adds a real, site-dependent multiple of the identity in spin space. That addition remains gauge invariant. It breaks the special Dirac/mass structure used for determinant positivity; gauge invariance alone is not the theorem's sufficient hypothesis. The negative values demonstrate failure of the comparison in that enlarged model. The control consumes extra random draws, so it is not a paired ablation using identical subsequent parameter/source tuples.

### What the checks do not prove

They do not prove the inequality beyond these finite systems. They also do not test the periodic 3D magnetic sector, Brownian bridge kernel arguments, neutral excitation gaps, nonrelativistic error estimates, the thermodynamic limit, screening, or a continuum limit. Their sampled ma is at most 3, so this is not a test of a ma >> 1 expansion.

The agreement is a useful independent diagnostic of the signs, centering convention, Gauss constraint and energy comparison. It should be recorded as such.

## 2. Bravyi–DiVincenzo–Loss: a useful method, not an available O(nuclei) theorem

Primary source: [Schrieffer-Wolff transformation for quantum many-body systems](https://arxiv.org/html/1105.0675), Annals of Physics 326 (2011), 2793–2826. Relevant locations: §§4.1, 4.4; Theorems 1 and 3.

Their lattice theorem assumes finite-dimensional local spins, an unperturbed sum of on-site terms with a product ground space and a local gap, and bounded short-range perturbations. The local SW ground-energy remainder at fixed order n is O(N |epsilon|^(n+1)), where N is the number of sites. It is not O(number of defects, electrons, or nuclei).

Application judgment: untruncated compact electric rotors, retaining a whole gauge sector in the low block, and the Gauss-constrained physical subspace do not directly satisfy this setup. A derivation must establish suitable replacements for these hypotheses. The result is an excellent organizational template; it cannot be cited as already proving the desired reduction or its proposed relative error.

### Why volume errors do not automatically cancel

Suppose separate approximations give
|E_nu - E_nu_eff| <= C N epsilon^(n+1),
|E_0 - E_0_eff| <= C N epsilon^(n+1).
Then triangle inequality only gives
| (E_nu-E_0) - (E_nu_eff-E_0_eff) |
    <= 2 C N epsilon^(n+1).

Locality of each remainder term does not change that estimate by itself. One must prove a cancellation or a bound on the difference of its expectations in the two minimizing states. A source changes the Gauss sector and the electric field; distant gauge contributions are not known to coincide with their vacuum values. A sufficient new ingredient would be a uniform summability estimate for source-induced changes of local expectations, or a remainder form controlled by the matter number plus a source-relative gauge-energy quantity. Neither is supplied by the existing charge-gap theorem.

## 3. Datta–Fernandez–Frohlich–Rey-Bellet: hypotheses still matter

Primary full text: [author-hosted paper](https://webspace.science.uu.nl/~ferna107/papers/pert.pdf). Published in Helvetica Physica Acta 69 (1996), 752–820; [journal scan](https://www.e-periodica.ch/cntmng?pid=hpa-001%3A1996%3A69%3A%3A1214).

The perturbative lattice framework starts from a classical finite-range interaction diagonal in a product basis, with small local interactions controlled in specified exponentially weighted norms. Its infinite-dimensional perturbation discussion (§3.5) assumes an isolated finite collection of finite-multiplicity eigenvalues, separated by a positive gap, and relative boundedness. The lattice construction also needs its local low-energy/excitation separation.

Application judgment: citing its infinite-dimensional section does not justify retaining all electric-field energies as a uniformly separated matter band. Taking H_E exact introduces E-dependent transition energies; taking only the mass as H_0 leaves commutators with H_E to control. Treating the plaquette energy perturbatively also requires a coupling-dependent smallness condition. A mass gap on fermion sites alone does not check all these hypotheses. The method remains promising after an explicit low-energy restriction or appropriate weighted estimates.

## 4. Fry: important qualification to the proposed citation

Primary source: [Fry, Stability of QED, arXiv:1108.4345v2](https://arxiv.org/html/1108.4345), especially introduction Eq. (1.4) and §IV.

For a class of static magnetic fields, Fry obtains
lim_{e -> infinity} log det_ren / (e^2 log e)
    = T ||B||_2^2 / (24 pi^2).
His summary explicitly identifies two unproved assumptions: the relevant continuum limit of the lattice diamagnetic inequality, and asymptotic validity of the Pauli heat-kernel expansion. Field regularity and integrability conditions are also imposed, and zero-mode-supporting fields are excluded.

Thus this is conditional evidence about renormalized determinant growth in a specified static-field class. It is not an unconditional theorem proving QED instability, and it does not prove failure of a cutoff-independent vacuum-relative matter bound. The paper itself says stability of isolated QED is unresolved.

The finite-cutoff Hamiltonian comparison and Fry's renormalized Euclidean determinant address different objects and limits. They should not be identified as the same obstruction without an additional argument. The presently proved limitation is that this project's explicit Gaussian-domination self-energy estimate grows as 1/a.

## 5. Recommended accurate status language

- The two new diagnostics reproduce their stated margins.
- The existing charge-gap theorem bounds different total-charge sectors. It is not a neutral pair excitation gap.
- The proposed heavy-mass reduction is a research target. Neither cited local SW result directly provides its claimed nucleus-count error.
- Any full-matter low-energy theorem needs an explicitly defined low-energy space, dynamical electric-field control, and a relative-error cancellation estimate.
- Fry is relevant conditional background; it should not be used as a proved no-go theorem for the desired cutoff-uniform result.

