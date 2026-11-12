# Round-five Paper A extraction and validation

Date: 29 October 2026. Prepared by the relativistic-literature agent.

## Delivered artifact

**Title:** Vacuum-relative stability and charge gaps in compact Hamiltonian lattice QED.

The self-contained source project is `paper-a-lattice/`, with `main.tex`, four mathematical input files, `references.tex`, and `build.ps1`. Its output is `paper-a-lattice/paper-a-lattice.pdf`: 12 pages, 11-point type, one-inch margins, US letter. The shorter length is the result of removing historical research accretion; no typography was compressed to reach a page target. The parent approved this length.

Human author metadata and PDF author metadata are blank. The requested credit line, “Research-tool credits: Opus 5.5 + Astra 6”, remains. A separate disclosure states that significant portions of research development, proof drafts, exposition, and internal checking used generative-AI tools, and expressly distinguishes internal AI-assisted audits from external peer review. No priority claim is made.

## Extraction map and self-containment

| New file | Audited source material | Retained content |
|---|---|---|
| `main.tex` | Original lattice introduction and verified reference context | Exact scope, concise abstract, tool-use disclosure, carefully separated Seiler/FSS/positivity/Coulomb-thermodynamics context. |
| `model.tex` | `vacuum-relative-stability-paper/lattice.tex` | Compact untruncated link rotors; continuous-time spatial Wilson Hamiltonian; bare bilinear ordering; operator domain and trace class; exact local gauge action and source projector; total-charge capacity and constructive admissibility; pair terms after particle-hole transformation. |
| `transfer.tex` | Original `lattice.tex` and the determinant, annulus, and Fourier arguments in `mass-gap.tex` | Complete C5 pseudo-unitarity, determinant reality and sign, quantitative beta-form estimate, reciprocal-conjugate spectral pairing with algebraic multiplicity, and canonical Fourier/Vandermonde estimate. No forward dependency on the original paper remains. |
| `comparison.tex` | Original `lattice.tex` | Explicit rotor heat kernel, bounded-matrix Dyson/Feynman–Kac construction and trace justification, full local Gauss projection, global-angle extraction, charge-gap theorem, nonnegative-mass limit, exact electric self-energy decomposition, uniform lattice Green diagonal bound, and individual-nucleus subtraction. |
| `thermodynamics.tex` | Original `thermodynamics.tex` | Open graph-degree Wilson coefficient, bounded cut estimate with retained rotor factors, vacuum limit, fixed-cell relative/absolute budgets, open zero-exterior-flux periodic-source limit, periodic-box brackets, exact boundary-flux decomposition, conditional (BF) implication with cell averaging, and the inadmissibility example. |
| `references.tex` | Previously verified references in the original manuscript, with Seiler/FSS publisher metadata rechecked | Eight precisely scoped references; none substitutes for an unproved step in the paper. |

The important new labels are `lem:operator`, `lem:transfer`, `lem:fourier`, `thm:main`, `lem:green`, `cor:stability`, `lem:cut`, `thm:vacuum-limit`, `prop:cell`, `thm:open-source`, `eq:flux-decomposition`, and `eq:bf`. All references and mathematical inputs resolve inside this source directory. The original 64-page manuscript was not edited.

## Hypotheses and limitations retained

- Periodic lattices have side length at least three sites. This avoids importing unverified two-site multigraph/plaquette counting conventions.
- The theorem uses positive gauge coupling, fixed lattice spacing, nonnegative bare mass, nonnegative Wilson coefficient, four fermion components per site, exact local Gauss law, and full compact electric rotors. The positive bare Wilson mass coefficient is an essential proof hypothesis.
- The raw result includes the source electric self-energy: the physical sector energy is at least the vacuum energy plus the bare mass times the absolute total source charge. All fixed-source sectors satisfying the finite fermion capacity are covered; there is no extra harmonic-flux restriction.
- The self-energy-subtracted bound uses a stated individual-nucleus convention. If several nuclei occupy one lattice site, their cross terms remain; subtracting the square of an arbitrarily large combined site charge would be another convention. Lattice site charges do not retain a continuum point-Coulomb singularity.
- The gap concerns net charge. No neutral pair gap or photon gap is concluded.
- The cut set consists of all original links not internal to the chosen **open** blocks, including periodic closing links even if both endpoints belong to a single chosen block. Every retained cut rotor contributes a Hilbert factor and has ground energy zero.
- Vacuum thermodynamic limits for open and periodic boxes are proved. The source limit proved without an extra hypothesis is the open, zero-exterior-flux limit for compatible complete periodic cells. A periodic-boundary source limit remains conditional on the explicitly unproved (BF) comparison, or an equivalent screening/gluing input.
- The ultraviolet limit, renormalized mass/charge matching, binding, a Coulomb phase, neutral pair gaps, and crystalline order are not asserted. Constants proportional to inverse lattice spacing are displayed rather than described as cutoff-uniform.

## References and positioning

The bibliography contains Kogut–Susskind (1975), Zache et al. (2018), Wei et al. (2016), Miyao (2015), Hainzl–Lewin–Solovej thermodynamics Parts I–II (2009), Fröhlich–Simon–Spencer (1976), and Seiler (1978).

The new introductory paragraphs carefully separate the modulus-one source-character step from a complete static-energy theorem. Seiler's paper concerns an upper bound on the growth of the color-confining potential based on Hamiltonian positivity and Euclidean rotations; it is not presented as this paper's Gauss-sector comparison. Fröhlich–Simon–Spencer Section 2 concerns shifted-bond Gaussian domination for classical ferromagnets; it is methodological context, not an applicable replacement theorem. No conclusion concerning novelty or historical priority is inferred.

Primary metadata checks for those added contextual references:

- Seiler, *Upper bound on the color-confining potential*, Physical Review D **18** (1978), 482–483, DOI [10.1103/PhysRevD.18.482](https://journals.aps.org/prd/abstract/10.1103/PhysRevD.18.482).
- Fröhlich, Simon, and Spencer, *Infrared bounds, phase transitions and continuous symmetry breaking*, Communications in Mathematical Physics **50** (1976), 79–95, DOI [10.1007/BF01608557](https://link.springer.com/article/10.1007/BF01608557).

## Build and layout validation

The project-local PowerShell build script locates pdflatex, creates `build/`, runs three passes with halt-on-error, and copies the result to `paper-a-lattice.pdf`. The completed run exited successfully. The final log has no undefined references, LaTeX warnings, overfull boxes, or underfull boxes. MiKTeX separately prints its routine notice that updates have not been checked; it did not affect compilation.

PDF metadata confirms the title, blank author, twelve letter-size pages, and a file size of 415,085 bytes for the compiled version checked here. Independently rendered and visually inspected page 1 and page 11: both have legible text/equations, normal margins, and no clipping or collisions. Their PNGs are in `paper-a-lattice/build/qa-title.png` and `qa-thermo.png`. The parent is performing full-document visual QA and final packaging.

## Independent read-only audit of Paper B's absolute bounds and vacuum obstruction

At the parent's request I also checked `paper-b-momentum/absolute-bounds.tex` and `vacuum-obstruction.tex` against the conventions in `proof.tex` and `photon-extension.tex`. No substantive error was found. No Paper B file was edited.

Specific checks:

1. At a fixed spatial point the four normalized band field components satisfy CAR; density and each current have norm at most twice the scalar mode density. The sum-of-current-squares bound uses three separate operator norm bounds, without assuming that currents commute.
2. The oscillator square-completion identity has the correct subtraction and uses only commutation between fermion and photon factors. The shifted operators are expressly not assumed to be canonical oscillators.
3. In the heat-kernel Coulomb split, the core coefficient is 16 pi, and the nuclear short-range term uses neutrality capacity to add 8 pi, yielding 24 pi. The diagonal coefficient and the factor of one half in the Coulomb energy are consistent. The ordering difference bound is 28 times the scalar mode count per Fourier mode; the prefactor alpha/2 and the shell bound 26 Lambda/pi-squared produce the stated coefficient 364.
4. Photon square completion has coefficient e-squared/(2V), and Parseval with the local bound gives the displayed inverse-frequency-squared loss. At the smallest nonzero torus frequency this is of order volume times L-squared, namely L to the fifth power.
5. The vacuum trial matrix is a projection of rank twice the scalar mode count, hence its Slater state has exact total charge zero. The spin trace gives zero charge density pointwise. The sign choice on the cosine operator's zero eigenspace preserves both facts.
6. The current identity is twice the trace of the absolute compressed cosine. Twice the trace of its square equals the number of retained one-step momentum pairs. An interior cutoff ball supplies a positive constant times volume for all large boxes.
7. The full Wick expectation has zero direct term but retains exchange and charge fluctuations. The Hilbert–Schmidt bound gives a Coulomb contribution of order volume. The kinetic bound is also of order volume.
8. For the real transverse coherent mean field, the classical magnetic energy is V q-squared a-squared/4 and the interaction is e a J. Their minimum is minus e-squared J-squared/(V q-squared), giving the asserted negative L-to-the-fifth contribution with the correct sign and normalization. Photon occupation is finite at each fixed volume, so the states lie in the declared domain.
9. A fixed mass counterterm, fixed vacuum-energy density, or the stated change of Coulomb ordering contributes only order volume to these trial states. A nonzero fixed charge rescaling changes the coefficient rather than the power of L.
10. The text correctly distinguishes this failure of absolute extensivity from vacuum-relative source stability. Subtracting the same interacting finite-volume vacuum can cancel a common superextensive contribution; separate absolute lower bounds cannot supply that relative comparison. The trial upper bound also correctly excludes a finite ordinary vacuum-energy density in this bare regulator.

This is an internal algebraic and mathematical audit, not independent human peer review or a formal proof-assistant verification.
