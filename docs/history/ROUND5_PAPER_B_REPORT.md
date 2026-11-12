# Paper B: faithful extraction and proof audit

Date: 29 October 2026.

## Deliverable

The self-contained review draft is saved in `paper-b-momentum/`:

- `main.tex` and its local input files;
- `paper-b-momentum.pdf`, 57 pages;
- `build.ps1`, which runs three `pdflatex` passes;
- `build-output.txt` and the final compiler files under `build/`;
- a consolidated local `references.tex` with 19 cited entries.

Title: **Vacuum-relative stability and regulator obstructions in momentum-cutoff QED: Canonical Gaussian domination, point nuclei, and the limitations of free-vacuum matching.**

Human author metadata is blank. The disclosure names **Opus 5.5 + Astra 6** as AI tools, states review-draft status, and makes no priority claim. No publication or external communication was performed.

The original 64-page manuscript and historical memorandum sources were preserved. All extraction edits were made in the new Paper B folder. No proof in B depends on a theorem number from Paper A or the companion notes.

## Included proof chain

### Exact model and canonical comparison

The complete momentum-cutoff model, free-sea Wick identity, effective-mass formula, centered determinant positivity, canonical charge projection, and finite-source Gaussian domination were extracted from `vacuum-relative-stability-paper/proof.tex`.

The model section explicitly retains:

- the finite sharp fermion band, its four-spinor dimension and exact charge capacity;
- the sea-to-electron/positron particle–hole representation and all pair terms;
- the Coulomb zero-mode omission and physical neutrality condition;
- exact continuum point nuclear positions and untruncated point nucleus–nucleus repulsion;
- subtraction of the entire individual periodic nuclear diagonal;
- the distinction between the band-compressed external potential and the exact point nuclear repulsion.

The full transverse-photon argument was extracted from `photon-extension.tex`, including standing-wave coordinates, positive centered CAR traces along varying real vector histories, componentwise Hubbard–Stratonovich integration, a trace-norm Trotter proof, and explicit two-sided form estimates removing the bounded-coordinate truncation. The harmonic transverse zero mode is expressly fixed and omitted; no additional fixed infrared decoupling or bare photon mass is used in that relative theorem.

The all-volume discrete mass estimate, resolved-mesh logarithmic estimate, coarse-box counterexample, annulus lemma, canonical Fourier coefficient estimate, and exact charge-gap strengthening were extracted from `mass-gap.tex`. Density-product ordering and closure at nonnegative effective mass are retained as distinct, precisely specified model statements. The old numerical-diagnostics subsection was omitted, because the analytic proofs are sufficient and that subsection depended on scripts outside the new paper.

### Absolute bounds needed by the historical counterexamples

`absolute-bounds.tex` supplies all dependencies of the historical transverse-mass theorem directly within Paper B:

- exact local density/current bounds;
- legitimate noncommutative photon square completion;
- the point-source heat decomposition;
- the finite operator cost of changing from density-product to four-field Wick ordering;
- the infrared-dependent absolute lower bound.

The conservative constants are made explicit. With `d_*=(1+1/pi)^3`,

\[
A_\Lambda=\alpha\Lambda_f
\left[24\pi d_* Z_{\max}+
\frac{13}{4\sqrt2\pi^{3/2}}Z_{\max}^2\right],
\qquad
B_\Lambda=\frac{364\alpha}{\pi^2}d_*\Lambda_f^4.
\]

The ordering norm bound follows from the existing exact Wick identity, a safe `28 M_L` bound per Coulomb mode, and `kappa <= 26 Lambda_f/pi^2`. No new physical approximation is used.

`vacuum-obstruction.tex` reproduces the full actual-model neutral-current proof of `E_vac <= -c L^5 + C L^3`. It includes exact Slater neutrality, identically zero mean charge density, the current trace estimate, the complete Wick Coulomb expectation, and coherent-photon optimization. The same obstruction for density-product ordering follows from its `O(V)` ordering difference. The wording consistently identifies the **bare model with massless photons**, with the Dirac mass still strictly positive.

### Static matching, positive photon-mass deformation, and mean-field obstructions

The audited `continuation-photons.tex` was extracted as `static-response.tex`. It retains the exact finite-volume susceptibility criterion, trace factors and parity, the soft limit, the distinction between static curvature and a physical photon pole, the torus-holonomy qualification, finite oscillator squeezing and its normal-ordering scalar, and the extensive lower bound for an explicitly modified positive bare transverse `A^2` model.

The analytic Madelung sign proof is retained, including its rational Gaussian-tail bounds. The small-box counterexample is stated for both specified nuclear self-energy conventions, not for arbitrary possible finite counterterms.

The audited `continuation-meanfield.tex` was extracted as `mean-field.tex`. In particular, the entire periodic Kato proof is included: analytic Ewald bounds, the rational certificates, the exact fractional torus quadratic-form normalization, the folding identity, and the localization remainder. No sampled sign, numerical maximum, or unproved periodic comparison replaces that proof. The Euclidean Coulomb–Kato form inequality is explicitly identified and cited to Herbst.

The mean-field theorem retains its `alpha < 4/pi`, lower box-size, exact-neutrality versus mean-charge, and fixed free-Wick-ordering hypotheses. Its free-sea vacuum conclusion is confined to that particular photon-free functional. The sufficiently large bare photon-mass product-state theorem and the failure of strict kinetic absorption at static matching remain correctly scoped. The historical numerical coefficient comparison with an unaudited version was removed.

`next-uv.tex` and `next-photon-vacuum.tex` were extracted as `ultraviolet-obstruction.tex` and `exchange-instability.tex`, with all their construction and remainder proofs. The former includes the high-momentum packet constants, exact-charge spectator electron, all direct/exchange contributions, and fixed-box ultraviolet threshold. The latter includes exact all-parameter charge cancellation, the sharp-cutoff susceptibility cusp, the strictly positive exchange limit, volume-uniform Taylor remainders, and the exchange-shifted necessary bare-mass threshold.

Finally, `free-dielectric.tex` is reproduced as a self-contained appendix, including the threshold condition and the alternative negative-trace penalty.

## Scope checks and historical statements not reprinted as current claims

1. **The L^5 trial is an absolute-vacuum obstruction.** It does not refute the exact vacuum-relative source inequality. Historical statements calling the unscreened positive-effective-mass comparison wholly open were not reprinted as present status; the canonical proof now supplies it.
2. **Static susceptibility is not a pole mass.** The relevant finite-box criterion contains `chi_L(q)`, not merely `chi(0)`. The leading static matching `delta_mu^2=2e^2 chi(0)` is not a nonperturbative Ward identity or a physical masslessness theorem.
3. **The positive A^2 theorem changes the Hamiltonian.** It is not a proof of renormalized massless QED. Its squeezing constant, domain, fixed positive coefficient, and lack of uniformity as that coefficient vanishes are retained.
4. **The ultraviolet counterexample is mean-field and fixed-reference.** Its comparison vacuum is the photon-free Hartree–Fock vacuum, equal to zero under the stated conditions. It does not determine the unrestricted correlated vacuum subtraction and is not presented as a counterexample to every renormalized or calibrated model.
5. **Exchange disproves free-sea minimality, not relative stability.** The matched product-state vacuum lies below the free-sea value by `cV`. The necessary larger bare-mass threshold is not a sufficient condition, a mass-renormalization prescription, or an existence theorem for the interacting mean-field minimizer.
6. **The point-source cross-kernel mismatch remains explicit.** Gaussian domination completes a collective band source square. Its cross terms do not equal the exact point nucleus–nucleus terms. Paper B includes the precise formula and the small-box counterexample to the unqualified individual-self-energy slogan.
7. **A logarithmic cutoff window is not uniform over arbitrary coarse boxes.** The discrete correction and counterexample are preserved. General effective mass with both signs remains unresolved; uniformly negative sign can be handled by changing the Dirac beta convention, as stated in the extracted proof.
8. **No nonrelativistic many-body theorem was inferred.** Charge gaps, mean-field bounds, and stable candidate effective Hamiltonians do not establish the full pair-block resolvent or source-relative errors.

All requested historical results were safe to include after these distinctions. Obsolete open-status text, unsupported extrapolations, and external numerical-script dependencies were excluded or rewritten. No new speculative physics section was added.

## Literature treatment

The local bibliography consolidates the primary manuscript's and historical memorandum's already checked primary references. The interpretation section distinguishes Lieb–Yau, Lieb–Loss, Lieb's review, Jäkel–Wreszinski, Lieb–Siedentop, BDF and Hartree–Fock results, Miyao's finite-source theorem, Euclidean determinant positivity, and the Majorana positivity criteria. These references provide model-specific precedents rather than an unverified shortcut to the present theorem. Point Dirac–Coulomb extension theory is not substituted for the finite-band proof.

## Verification and companion audit

- Ran the local build script through three passes after the final text changes.
- The final PDF contains 57 pages.
- The final log has no undefined citations or references, multiply defined labels, missing characters, overfull boxes, underfull boxes, or LaTeX warnings.
- The compiler prints its routine MiKTeX update reminder; compilation itself succeeds.
- A source-level label/citation scan found no missing or duplicate labels; all cited bibliography keys are local.
- Visual PDF QA and packaging are assigned to the parent task and are not claimed completed by this report.

Read-only audit of `companion-notes/model.tex` and `companion-notes/scope.tex` found no cross-paper mismatch. The model correctly recalls Paper A's exact Gauss-sector comparison with its self-energy convention. The scope correctly states that the frozen-link theorem implies `|h_W(U)| >= m`, that dropping a noncommuting square term would be an invalid proof shortcut, and that this does not furnish a dynamical neutral-pair gap. It also correctly avoids claiming a positive volume-uniform lower density of bare virtual pairs or flux tails from the finite-volume obstruction proofs.

## Independent Paper A audit addendum

Read `paper-a-lattice/transfer.tex`, `comparison.tex`, and `thermodynamics.tex` in full after their shortening. No substantive gap or lost hypothesis was found.

The finite-dimensional proof retains bounded Hermitian spatial histories, positive mass, total free time `b` distinct from auxiliary kick time, exact centering phases, algebraic-multiplicity spectral pairing, and the finite binomial factor through the thermal limit. The beta-form argument correctly handles both signs of its value on a transfer eigenvector. The local Gauss projection and separation of the global charge angle retain every relative gauge angle, rather than replacing local constraints by total neutrality.

The thermodynamic argument keeps the graph-degree Wilson diagonal on open boundaries and preserves the unbounded electric energy on cut-link rotors. Its cut set correctly includes periodic closing links even if both endpoints lie in one nominal block. The stated constant follows from the paired eight-mode edge spectrum and the at-most-four-plaquette incidence bound. Auxiliary-space cutting proves the vacuum limit without assuming physical tensor factorization.

The open-source proof uses whole admissible cells, a specified zero-exterior-flux convention, physical product trial states with newly joined rotors at zero flux, and one-sided almost-subadditivity. Its infimum formula follows from the stated upper inequality and the definition of that infimum; no unproved reverse source comparison is needed. The cell trial and its extensive electric budget have the stated coefficients.

For periodic sources, the exact direct sum over cut fluxes is retained. Hypothesis (BF) is explicitly unproved. The factor two in its flux penalty reflects boundary-link incidences in both adjacent blocks, and the grid average gives the displayed coefficient `(2 C_f-c_E)_+ p A_c/(c_E ell)`. Whole-cell remainders have controlled volume and require no false zero-flux comparison for their shifted source sectors. The odd-cube source-capacity counterexample correctly explains why arbitrary block admissibility cannot be dropped. Thus the shortened paper preserves the distinction between the proved open limit and the still conditional periodic-source limit.
