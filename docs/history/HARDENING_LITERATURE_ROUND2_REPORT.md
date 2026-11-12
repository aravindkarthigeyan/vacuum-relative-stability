# Round-two audit: quantized photons, source self-energies, and positivity literature

Date: 29 October 2026. Scope: Task A of `CODEX_NEXT_TASKS_2.md`. The current `photon-extension.tex` was read in full, including its revised explicit photon regulator and standing-wave transformation. This report concerns the stated finite-cutoff model. It does not certify a continuum construction or assert priority.

## Verdict

No new mathematical gap was found in the positive-mass photon extension. The trace-norm product argument and the coordinate-truncation removal are valid. The same form bounds hold on the whole Hilbert space and hence on every charge sector. The two substantive corrections concern interpretation and attribution:

1. The exact source comparison contains the collective band Coulomb self-energy. For the original untruncated nuclear repulsion, adding only individual band self-energies leaves a signed cross-kernel mismatch. The unqualified physical slogan in Task A is false across all box sizes.
2. Seiler, Physical Review D 18, 482 (1978), is a paper on an upper bound for color-confining potentials. Its verified theorem should not be presented as the source of the single-flavour determinant-positivity argument.

The accompanying `vacuum-relative-stability-paper/positioning.tex` gives the corrected statements and concise primary-source comparisons. No other paper source was changed in this audit.

## 1. Photon regulator and the coordinate representation

The photon set is finite at every fixed box and ultraviolet cutoff:
\(0<|k|\leq\Lambda_\gamma\), with two transverse polarizations and frequency \(|k|\). The harmonic transverse zero mode is explicitly omitted. This is additional to Coulomb gauge. There is no fixed positive lower cutoff on nonzero photon momentum.

Choosing equal real polarizations at \(k\) and \(-k\), the unitary transformations

\[
b_c=(a_k+a_{-k})/\sqrt2,\qquad b_s=i(a_k-a_{-k})/\sqrt2
\]

put the vector potential into a real standing-wave expansion involving only commuting coordinates. Equal frequencies preserve \(H_\gamma\). This avoids confusing a traveling-wave sine quadrature with a position variable. In the coordinate representation,

\[
A:=H_\gamma=\frac12\sum_r(-\partial_{x_r}^2+\omega_r^2x_r^2-\omega_r)\geq0.
\]

Its Mehler kernel is positive. The subtracted zero-point constant is common to all sources and charge sectors. The free-sea trace of the current matrix vanishes, so no omitted scalar linear in photon coordinates appears in the interaction.

## 2. Varying photon histories preserve the determinant lemma

At each coordinate value, the one-particle matrix has form

\[
h(x)=\sum_i\mathsf a_iP_i(x)+\mathsf bM,
\qquad P_i(x)=P_i(x)^*,\qquad M\geq m_*I>0.
\]

All spatial coefficients commute with Dirac matrices. Photon coordinates change only the vector coefficients. Scalar HS kicks are unitary spin-scalar matrices. Consequently the ordered one-particle propagator remains \(C_5\)-pseudo-unitary. The centered determinant is real, and an eigenvalue \(-1\) would produce an antiperiodic ODE solution satisfying

\[
0=\operatorname{Re}\int f^*\mathsf b(\partial_t+c(t)h(t)+i\Phi(t))f
=\int c(t)f^*Mf>0,
\]

a contradiction. The same argument excludes every unit-modulus eigenvalue. Deformation to a constant positive mass fixes the sign. It applies to arbitrary coordinate histories at finite Trotter index, including the canonical charge twist.

The centered phase is essential. It is supplied by the finite CAR trace and cannot be replaced with an unspecified square-root branch of a determinant. Integer charge \(Q=N-2M_L\) makes the canonical Fourier projector exactly periodic.

## 3. Why trace-norm Trotter convergence is sufficient and valid

For a bounded coordinate truncation \(\chi_R\), all terms other than the oscillator are bounded self-adjoint operators. Componentwise density-square Trotter factors are necessary because projected densities need not commute.

For one bounded perturbation \(B\), the Dyson integrands satisfy

\[
\left\|e^{-s_0A}Be^{-s_1A}\cdots Be^{-s_jA}\right\|_1
\leq\|B\|^j\operatorname{Tr}(e^{-bA}),\qquad \sum_i s_i=b.
\]

Schatten Hölder uses exponents \(b/s_i\), with infinity when \(s_i=0\). It follows that the Dyson tails are bounded by the exponential series. At fixed order, distinct product times give Riemann sums of the trace-norm-continuous interior integrand; the uniform bound controls boundary strips. Terms with repeated times have vanishing total weight. Thus the one-perturbation product converges in trace norm.

For finitely many bounded perturbations, the bounded-exponential splitting error at one time step is \(O(n^{-2})\). In the telescoping sum each term still contains total oscillator time \(b\). The same Schatten estimate, with bounded factors placed between the heat factors, gives a total trace-norm error \(O(n^{-1})\). This is stronger than strong convergence and justifies convergence of all canonical traces.

At finite product index, the cyclic Mehler kernel weight is positive and integrates to \(\operatorname{Tr}(e^{-bA})\). The HS kicks and charge twist are unitary. The absolute value of the fermion trace is bounded by its finite dimension times a fixed exponential in the norm of the bounded matrix potential. Fubini integration is therefore valid. The source and canonical-charge factors are phases multiplying an otherwise positive integrand, so the triangle inequality gives the claimed canonical comparison.

## 4. Explicit removal of the coordinate truncation

Write \(c_\gamma=\frac12\sum_r\omega_r\), and let \(\omega_{\min}>0\) be the smallest retained frequency. If the photon set is empty, no truncation argument is needed. Otherwise

\[
|x|^2\leq\frac{2}{\omega_{\min}^2}(A+c_\gamma)
\]

as quadratic forms. For a coupling matrix bounded by \(C_1|x|\), with \(\chi_R=1\) on \(|x|\leq R\),

\[
|H_R-H|\leq\varepsilon_R(A+c_\gamma),\qquad
\varepsilon_R=\frac{2C_1}{R\omega_{\min}^2}\longrightarrow0.
\]

These are common-domain form inequalities. Completing the elementary oscillator quadratic bound for the linear coupling gives

\[
H_R,H\geq\tfrac12A-C_2
\]

with \(C_2\) independent of \(R\) and of the charge sector. The shifted Coulomb squares are positive, so they cause no adverse lower-bound dependence. Using \(A\leq2(H+C_2)\), for \(2\varepsilon_R<1\) one obtains

\[
(1-2\varepsilon_R)H-\varepsilon_R(2C_2+c_\gamma)
\leq H_R\leq
(1+2\varepsilon_R)H+\varepsilon_R(2C_2+c_\gamma).
\]

Taking sector infima proves convergence of the ground energies. The constants are finite at fixed regulators and work simultaneously for every admissible sector. They need not be uniform as \(L\to\infty\), because the comparison has zero error before taking \(R\to\infty\) in each fixed box.

The same form-domain coercivity gives compact embedding and compact resolvent. Min–max then bounds eigenvalues from below by those of \(A/2-C_2\), with the finite fermion multiplicity included. Thus the required thermal traces exist, and taking inverse temperature to infinity is legitimate. No interchange of the box limit with either the Trotter or coordinate limit is used.

## 5. Correct source interpretation and counterexample to the stronger slogan

The proved inequality is

\[
E_\nu(q)-U_{\rm nn}+\frac\alpha2D_L^{\rm band}(\nu,\nu)\geq E^{\rm vac}.
\]

Equivalently,

\[
E_\nu(q)+\frac\alpha2\kappa_{\Lambda,L}\sum_iZ_i^2
\geq E^{\rm vac}+\alpha\sum_{i<j}Z_iZ_j
[G_L-G_L^{\rm band}](R_i-R_j).
\]

The rightmost term has no fixed sign: the kernel has zero mean and a positive Coulomb singularity. The simpler nonnegative energy shift with individual band self-energies is therefore established for one nucleus or for consistently band-regularized nuclear repulsion. The original point-nuclear model requires the heat comparison, whose source-free short and long Coulomb pieces are both retained.

For a concrete failure of the unrestricted slogan, choose \(G_1(y)<0\), take two unit nuclei at \(0,Ly\), and decrease \(L\) below both the nonzero fermion/charge-mode and photon thresholds. Then the neutral sector is admissible, \(\kappa=0\), \(E^{\rm vac}=0\), and

\[
E_\nu(2)=2m+\alpha G_1(y)/L\longrightarrow-\infty.
\]

This respects the exact individual periodic self-energy removal in the model. It lies outside the theorem's many-nucleus box restriction and hence is not a counterexample to that theorem.

At zero source, the proved corollary is \(E_q\geq E_0\). It concerns the auxiliary algebraic charge sectors of the same zero-mode-deleted Hamiltonian. Only the appropriately neutral sector satisfies physical periodic Gauss law for a given background. The corollary does not prove uniqueness or a charge gap.

The subsequently added `mass-gap.tex` proves the stronger charge-gap statement by an additional transfer-spectrum argument, audited in Section 9 below. Thus the last observation concerns the elementary comparison alone, not the full set of results now established.

## 6. Verified bibliography and limits of the comparison

The full substantive literature comparisons are in `positioning.tex`; only identifying data and audit cautions are repeated here.

- **FSS:** Jürg Fröhlich, Barry Simon, and Thomas Spencer, *Infrared bounds, phase transitions and continuous symmetry breaking*, Communications in Mathematical Physics **50** (1976), 79–95. DOI [10.1007/BF01608557](https://doi.org/10.1007/BF01608557). [Author-hosted primary paper](https://math.caltech.edu/SimonPapers/65.pdf), Section 2, especially Theorem 2.1 and the shifted-square formulation. This is classical lattice Gaussian domination, not the fermionic theorem here.
- **Seiler:** Erhard Seiler, *Upper bound on the color-confining potential*, Physical Review D **18** (1978), 482–483. DOI [10.1103/PhysRevD.18.482](https://doi.org/10.1103/PhysRevD.18.482). [Primary publisher abstract](https://journals.aps.org/prd/abstract/10.1103/PhysRevD.18.482). The verified abstract establishes the at-most-linear growth scope; the publisher PDF required access credentials, so no unverified claim about its detailed proof is used.
- **Wei:** Z. C. Wei, Congjun Wu, Yi Li, Shiwei Zhang, and T. Xiang, *Majorana Positivity and the Fermion Sign Problem of Quantum Monte Carlo Simulations*, Physical Review Letters **116** (2016), 250601. DOI [10.1103/PhysRevLett.116.250601](https://doi.org/10.1103/PhysRevLett.116.250601); [primary preprint](https://arxiv.org/abs/1601.01994), Theorems 1 and 2. A common factor-level positivity representation must be verified before importing either criterion.
- **LiJiangYao:** Zi-Xiang Li, Yi-Fan Jiang, and Hong Yao, *Majorana-Time-Reversal Symmetries: A Fundamental Principle for Sign-Problem-Free Quantum Monte Carlo Simulations*, Physical Review Letters **117** (2016), 267002. DOI [10.1103/PhysRevLett.117.267002](https://doi.org/10.1103/PhysRevLett.117.267002); [primary preprint](https://arxiv.org/abs/1601.05780). The classification is within its specified antiunitary-symmetry framework.
- **VafaWitten:** Cumrun Vafa and Edward Witten, *Restrictions on symmetry breaking in vector-like gauge theories*, Nuclear Physics B **234** (1984), 173–188. DOI [10.1016/0550-3213(84)90230-X](https://doi.org/10.1016/0550-3213(84)90230-X). [Primary paper copy](https://hep.physics.uoc.gr/Erasmus-IP-2013/files/lectures/chiral-symmetry/vafa-witten.pdf), equation (1), supplies a precise citation for the positive-mass Euclidean spectral-pairing observation.

The present centered-trace proof was checked directly and does not require identifying it with a particular Majorana classification theorem. Its positive-mass condition supplies more than reality from pseudo-unitarity: it prevents crossings through zero. No priority claim for this general mechanism is supported by this search. No cited theorem automatically supplies the point-source comparison, gauge covariance of the sharp regulator, ultraviolet removal, or extensivity of the raw interacting vacuum.

## 7. Numerical checks

No numerical script was rerun by this agent in this round; the root agent is coordinating the supplied scripts. Numerical tests may detect errors in finite examples but are not substitutes for the determinant, trace-class, and source-kernel arguments audited above.

## 8. Additional obstruction to a logarithmic mass window uniform in every box

The continuum convolution estimate proposed in Task B cannot have a uniformly small lattice error over the full box range \(L\geq\Lambda_f^{-1}\). There is a simple exact counterexample to that proposed uniform approximation.

Set \(L=2\pi/\Lambda_f\), so the momentum set contains \(r=0\) and \(p=\Lambda_f e_1\). The single \(r=0\) term in the effective-mass deficit at this nonzero \(p\) equals

\[
\frac{\alpha}{2V}\frac{4\pi}{|p|^2}\frac{m}{E(0)}
=\frac{\alpha\Lambda_f}{4\pi^2}.
\]

Every other term in the deficit is nonnegative. Therefore

\[
M_{\rm eff}(\Lambda_f e_1)
\leq m-\frac{\alpha\Lambda_f}{4\pi^2}.
\]

At \(\Lambda_f>4\pi^2m/\alpha\) the mass is negative in this allowed box. For \(\alpha=1/137\), the threshold is approximately \(5408.54m\), far below the proposed exponential cutoff scale. The box satisfies \(L\geq\Lambda_f^{-1}\). If a convention excludes boundary momenta, the same construction with \(p=c\Lambda_f e_1\), \(0<c<1\), gives the corresponding linear obstruction.

There is no contradiction with a logarithmic continuum convolution: the lattice samples the narrow factor \(m/E(r)\) at its peak \(r=0\) with a cell volume comparable to \(\Lambda_f^3\). At \(p=0\), that term is omitted, so computations testing only the origin can miss the obstruction. A logarithmic bound may still be useful with an explicit mesh condition, for example a lower bound on \(mL\), but the error must retain the volume dependence. This obstruction concerns the effective-mass criterion, not a demonstrated instability of the Hamiltonian when the criterion fails.

## 9. Independent check of the improved cubature and charge-gap proofs

The subsequently saved `mass-gap.tex` was read in full. The lattice layer-cake proof is valid after filling the omitted kernel value with \(K(0)=h^{-2}\): all superlevel sets are concentric lattice balls, and the overlap of any translated pair has cardinality at most the overlap at zero. The resulting estimate correctly retains the origin-cell term \(\alpha h/(4\pi^2)\).

For the resolved-mesh bound, \(h\leq m\), the claimed error \(34h/m\) was independently checked term by term. Each strict radius-\(2h\) lattice ball contains 27 points. Removing the two balls costs at most \(54h/m\). On remaining midpoint cubes, the distance and relativistic-energy factors are bounded below by \(b=1-\sqrt3/4>9/16\) times their central values. The Hessian bound

\[
\|\nabla^2F_p\|\leq b^{-5}\left(8/(s^4E)+4/(s^2E^3)\right)
\]

follows from the product rule and the arithmetic–geometric mean inequality. The cube second moment is \(h^5/4\), giving midpoint error \(h^5/8\) times the Hessian bound. The two lattice estimates are less than \(43/h\) and \(62/m^3\); their Cauchy–Schwarz combination is less than \(52/(h^{1/2}m^{3/2})\). Hence the remaining-cube error is bounded by \(18(43+26)h/m=1242h/m\). Enlarging the integration ball costs less than \(11h/m\). The total is \(1307h/m\), and \(1307/(4\pi^2)<34\). The continuum convolution maximum at zero follows from continuous layer-cake overlap. This proves the displayed coefficient under its stated mesh hypothesis; it does not erase the coarse-box obstruction.

The charge-gap argument also checks out. For a transfer eigenvector, the transported \(\beta\)-form is strictly decreasing. Its endpoint relation \(B(b)=|\lambda|^2B(0)\) makes it positive throughout a contracting trajectory and negative throughout an expanding trajectory. The inequalities \(B'\leq-2m_*B\) in the first case and \(B'\leq2m_*B\) in the second yield

\[
|\lambda|\leq e^{-bm_*}\quad\hbox{or}\quad |\lambda|\geq e^{bm_*}.
\]

The sign reversal when dividing by a negative initial form is handled correctly. Pseudo-unitarity pairs eigenvalues with algebraic multiplicities, so defective transfer matrices cause no problem.

Writing the centered twist trace as \(C\prod_{j=1}^{D/2}|1+e^{i\theta}\lambda_j|^2\), the positivity lemma fixes \(C>0\). Its zero Fourier coefficient is \(C\sum_j|e_j|^2\geq C\). Bounds on elementary symmetric polynomials and Vandermonde's identity give the stated finite combinatorial prefactor. This factor cannot generally be omitted at finite temperature, as the explicit four-mode example correctly demonstrates. It disappears in the ground-energy limit and establishes \(E_q-E_0\geq m_*|q|\). The argument also accommodates source phases because these are independent of the global charge angle.

## 10. Independent check of compact Hamiltonian lattice QED

The current `lattice.tex` was also read in full. The gauge signs and projection are consistent. With \((T_j(U)f)(x)=\overline U_{xj}f(x+e_j)\), one has \(h_W(U^g)=g^*h_W(U)g\). Pullback \(R_g\) changes a multiplier to its value at \(U^g\), and fermionic conjugation by \(\Gamma(g)\) cancels that change. Its centered phase makes the generator \(G=\operatorname{div}E+q\), so the physical constraint is \(\operatorname{div}E=\nu-q\). The integer-flow construction proves sector admissibility exactly when the total source charge fits the fermionic capacity.

The local gauge twist changes the first heat-kernel argument to \(U^g\). Thus the twisted trace correctly contains the bridge from \(U\) to \(U^g\), the factor \(e^{-2i\sum_x\theta_x}\), and \(\det(1+gV_\omega)\). Arbitrary complex link variables still give Hermitian spatial coefficients and a Wilson mass bounded below by the bare mass. The finite-dimensional determinant lemma therefore applies path by path. The positive compact-rotor kernel and the bounded matrix Dyson expansion justify the integration. The same argument applies to all integer local Gauss characters, not only to the constant gauge transformation.

The longitudinal splitting of electric energy is an exact form identity in the joint electric/occupation eigenbasis. It does not assume independent longitudinal and transverse physical tensor factors. The periodic diagonal estimate \(\mathcal G_n(0)\leq13/16\) follows from \(\sin(\pi|k_j|/n)\geq2|k_j|/n\) and the same cubic-shell count; its use gives the stated coefficient \(13g^2/(32a)\). Colliding labeled nuclear sources retain their mutual lattice term when only individual diagonals are subtracted.

No substantive error was found. Two literal `mathbb` typesetting omissions in the bridge expectations were reported to the author and were subsequently corrected.

The final global-charge-gap addition, Corollary `lat-rest-energy`, was then read and checked. Fixing a root site and writing \(\theta_x=\vartheta_x+\phi\), with the root relative angle zero, is an invertible measure-preserving torus coordinate change. Constant gauge transformations do not move the link variables, so the bridge and its scalar weights are independent of \(\phi\). The source character contributes \(e^{-i\phi\sum_x\nu_x}\), and the centered fermion trace has precisely the global charge convention needed by the Fourier lemma. The remaining local twist commutes with the Dirac matrices and does not alter the annulus argument. After bounding its \(\sum_x\nu_x\) coefficient, the integral of the zeroth coefficient over relative angles and bridges is exactly the fully Gauss-projected vacuum partition function. This establishes the stated thermal prefactor and \(E_\nu\geq E_0+m|\sum_x\nu_x|\) without a new unproved positivity assumption. It remains a total-charge energy estimate, not a neutral-sector excitation gap.
