# Technical audit: finite-band Gaussian domination and its photon extension

This report records a mathematical audit of the model developed in `photon-free-relative-stability-paper`. Sections 1–7 concern the photon-free argument; Section 8 audits its subsequently completed extension to quantized transverse photons. The conclusions are deductions for the explicitly regulated model. They are not attributed to an existing full-QED stability theorem, and no novelty claim is made. The report checks the determinant mechanism, charge projection, ordering corrections, and the scope of the resulting source comparison.

## 1. Exact ordering correction and its usable regime

Let the scalar momentum set be

\[
\Gamma_f=(2\pi/L)\mathbb Z^3\cap\{|p|\leq\Lambda_f\},\qquad
M_L=|\Gamma_f|,\quad V=L^3.
\]

The one-particle spinor space has dimension \(4M_L\). Write
\(D_0(p)=\boldsymbol\alpha\cdot p+\beta m\),
\(E(p)=\sqrt{|p|^2+m^2}\), and
\(P_-(p)=(1-D_0(p)/E(p))/2\).
The sea has rank \(2M_L\), and the conserved electron-minus-positron charge is \(q=N-2M_L\).

Fully normal ordering the Coulomb quartic interaction relative to this fixed free sea, and then expressing it as a density product, gives the exact form

\[
H_0=C+d\Gamma(h_{\rm eff})+
\frac{\alpha}{2V}\sum_{k\ne0}\frac{4\pi}{|k|^2}\rho(-k)\rho(k),
\]

where the scalar \(C\) is fixed by the chosen ordering and

\[
h_{\rm eff}(p)=D_0(p)-\frac{\alpha}{2V}
\sum_{r\in\Gamma_f,\ r\ne p}
\frac{4\pi}{|p-r|^2}\frac{D_0(r)}{E(r)}.
\]

This is an algebraic rewrite, not a new counterterm or a Hartree--Fock approximation. Its coefficient of \(\beta\), denoted by \(M_{\rm eff}\), obeys

\[
M_{\rm eff}\geq m-\frac\alpha2\kappa_{\Lambda_f,L},\qquad
\kappa_{\Lambda_f,L}=\frac1V\sum_{0<|k|\leq2\Lambda_f}\frac{4\pi}{|k|^2}
\leq\frac{26}{\pi^2}\Lambda_f.
\]

For the last inequality put \(k=(2\pi/L)n\), group by \(|n|_\infty=j\), and use the exact shell count \(24j^2+2\), with \(|n|\geq j\). Each shell contributes at most 26 to \(\sum|n|^{-2}\); there are at most \(\lfloor\Lambda_f L/\pi\rfloor\) shells. Empty sums cause no exception. Consequently

\[
13\alpha\Lambda_f<\pi^2m
\]

is a sufficient, volume-independent strict-positivity condition. It is conservative and is not a condition allowing arbitrary ultraviolet removal.

For every Hermitian spatial matrix \(T\) scalar in the Dirac indices,

\[
\operatorname{Tr}(P_-T)=\tfrac12\operatorname{Tr}T.
\]

This follows directly from \(\operatorname{tr}_{\mathbb C^4}P_-(p)=2\). Thus the charge is exactly centered at half filling even for projected, nonlocal scalar potentials.

## 2. Finite-dimensional determinant positivity

Consider a Hermitian matrix

\[
h=\sum_{i=1}^3\alpha_i P_i+\beta M,
\qquad M\geq m_*I>0,
\]

where all \(P_i,M\) are Hermitian spatial matrices and hence commute with the Dirac matrices. They need not commute with each other. Let \(\Phi(t)\) be a piecewise constant Hermitian spatial matrix, scalar in Dirac indices. Every ordered product of free factors \(e^{-s_jh}\) and kicks \(e^{-i\Phi_j}\) can be represented by

\[
U'(t)=-A(t)U(t),\qquad A(t)=c(t)h+i\Phi(t),
\]

where \(c\geq0\), \(\int c>0\); on kick intervals set \(c=0\). A terminal charge twist is another scalar kick. This representation is exact; it introduces no temporal regularization determinant.

Set \(C_5=\alpha_1\alpha_2\alpha_3\beta\). The four anticommuting Hermitian factors give \(C_5^*=C_5\), \(C_5^2=I\), and \(C_5\) anticommutes with every \(\alpha_i\) and with \(\beta\). Therefore

\[
A^*C_5+C_5A=0,\qquad U(T)^*C_5U(T)=C_5.
\]

It follows that

\[
\overline{\det(I+U)}=\det(U)^{-1}\det(I+U),
\qquad \det U=\exp\left(-\int\operatorname{Tr}A\right).
\]

Since \(\operatorname{Tr}h=0\), the centered trace

\[
\mathcal F=\exp\left(\tfrac12\int\operatorname{Tr}A\right)\det(I+U)
\]

is real. It equals the appropriate centered finite-CAR Fock trace by \(\operatorname{Tr}_{\mathcal F}\Gamma(U)=\det(I+U)\). Retaining the explicit centering phase, rather than choosing an arbitrary square-root branch of \(\det U\), is essential.

It cannot vanish. Otherwise \(U(T)v=-v\) for a nonzero vector, and \(f(t)=U(t)v\) solves \(f'+Af=0\) with antiperiodic endpoint condition. Multiplication by \(\beta\), integration, and taking the real part gives

\[
0=\int c(t)\langle f(t),Mf(t)\rangle\,dt>0.
\]

Here \(\beta\partial_t\) has zero real quadratic form under the antiperiodic condition; \(\beta\alpha_iP_i\) and \(i\beta\Phi\) are anti-Hermitian. The strict inequality uses the invertibility of the ODE propagator, \(M\geq m_*I\), and positive total free time. Scaling all kicks continuously to zero keeps the centered trace real and nonzero. At zero kicks it is positive. Therefore \(\mathcal F>0\) for arbitrary scalar kicks and arbitrary real charge twists. Spatial nonlocality does not invalidate this proof.

## 3. Noncommuting charges and canonical projection

Decompose the finite positive Coulomb quadratic form into real Hermitian components \(\frac12\sum_a u_aR_a^2\), \(u_a>0\). The matrices underlying different \(R_a\) may fail to commute. Apply the scalar Gaussian identity to one square at a time inside a Trotter product:

\[
e^{-\delta u_a(R_a-h_a)^2/2}
=\int\frac{e^{-z^2/2}dz}{\sqrt{2\pi}}
e^{i\sqrt{\delta u_a}zR_a}e^{-i\sqrt{\delta u_a}zh_a}.
\]

Each kick is a projected spin-scalar potential. The preceding determinant lemma applies to the ordered product. The source enters only through modulus-one scalar phases.

Because \(q=N-2M_L\) has integral spectrum, its canonical projection is the ordinary Fourier integral over \(\theta\in[0,2\pi]\). At a finite Trotter index the partition function has the form

\[
Z_{q,n}(h)=\frac1{2\pi}\int d\theta\,d\mu(z)
e^{-iq\theta}e^{-i\ell_h(z)}\mathcal F_n(z,\theta),
\qquad \mathcal F_n(z,\theta)>0.
\]

Taking absolute values yields \(|Z_{q,n}(h)|\leq Z_{0,n}(0)\). In finite fermion dimension the Trotter convergence is in operator norm. After passage to the genuine canonical partition functions, and then to zero temperature,

\[
E_q\!\left(H_0+\alpha D(\rho,\nu)
+\tfrac\alpha2D_{\rm band}(\nu,\nu)\right)
\geq E_0(H_0)
\]

for every admissible charge sector and every real source on the finite charge-mode band. This is stronger than a susceptibility estimate at zero source and resolves the change of charge sector between the nucleus-free vacuum and neutral matter. The centering constants and fixed Wick scalar must be retained on both sides; they then cancel.

The proof is not an application of a classical electrostatic inequality to operator-valued charges. In particular, it does not prove a new operator Graf--Schenker localization theorem.

## 4. Point-source comparison: checked dependencies

For \(\nu=\sum_iZ_i\delta_{R_i}\), use \(\nu_s=e^{s\Delta}\nu\) only as a comparison source. The physical Hamiltonian retains its point nuclei and unmodified pairwise nuclear repulsion. The periodic Green function has zero average, and

\[
G-G_t=4\pi\int_0^t(h_u-V^{-1})\,du,
\quad \|G-G_t\|_1\leq8\pi t,
\quad G-G_t\geq-4\pi t/V.
\]

The band-projected density obeys \(\|\rho(x)\|\leq2d_L\), \(d_L=M_L/V\). Therefore replacing the source by \(\nu_s\) costs at most \(16\pi\alpha d_Ls\sum_iZ_i\). Gaussian domination bounds the smoothed source energy by minus its classical self-energy; the full positive Fourier sum can replace the smaller band sum in that lower bound.

Combining the smoothed source self-energy with the original nuclear repulsion leaves

\[
\alpha\sum_{i<j}Z_iZ_j(G-G_{2s})(R_i-R_j)
-\frac\alpha2G_{2s}(0)\sum_iZ_i^2.
\]

The first term has lower bound \(-4\pi\alpha s(\sum_iZ_i)^2/V\). In the neutral sector, finite capacity gives \(\sum_iZ_i\leq2M_L=2d_LV\), so this term is extensive in total nuclear charge. The bound \(G_{2s}(0)\leq C s^{-1/2}\), together with \(s=\Lambda_f^{-2}\), \(L\geq\Lambda_f^{-1}\), and \(d_L\leq C\Lambda_f^3\), produces an order-\(\alpha\Lambda_f K\) bound at fixed maximum nuclear charge. The nuclear self-energy divergence itself is removed by the fixed individual classical prescription specified in the main model, not by this comparison.

These estimates do not by themselves justify unrestricted \(L\downarrow0\). The stated lower restriction on \(L\) matters, especially because the periodic Green function has a volume-dependent finite regular part.

## 5. Screened comparison and response limitations

The supplementary `context.tex` records two independent safeguards. First, if \(H_C=\widetilde H_Y+R\), \(R\geq0\), then

\[
\langle R\rangle_C\leq E_C-E_Y\leq\langle R\rangle_Y.
\]

An upper bound at the Coulomb endpoint has the wrong direction for controlling the subtracted vacuum-energy difference. All Wick quadratic and scalar corrections belong in the exact auxiliary Hamiltonian \(\widetilde H_Y\).

Second, equal-time structure factors and inverse-energy-weighted susceptibilities are distinct. With a simple translation-invariant ground state, \(S^2\leq\chi F\), where \(F\) is the positive energy-weighted spectral moment. A susceptibility bound requires an additional moment estimate to imply the small-momentum structure-factor bound needed by screened-energy arguments. A lower spectral gap supplies the reverse comparison. Finite-source Gaussian domination established above bypasses this response route in its own regime; it does not retroactively validate that route outside the regime.

## 6. Limits of the audit

The positivity criterion is a sufficient condition on bare finite-cutoff parameters. It is not an ultraviolet renormalization theorem. The proof in Sections 1–3 has no transverse photons; its extension is audited separately in Section 8 below. The argument includes all correlated fermionic states and pair creation, but the finite band limits the total number of fermion modes in any one volume. It makes no independent assertion of atomic binding, a thermodynamic limit, or a controlled nonrelativistic effective Hamiltonian.

A separately calibrated constant for each nuclear species would change the energy reference and must be stated as a further model choice. Such constants cannot depend on the volume, the configuration, or the state. They are not used in this theorem, and one-nucleus calibration alone would not control many-nucleus cross terms.

## 7. Verified primary bibliography and citation keys

- **Miyao:** Tadahiro Miyao, *Upper bounds on the charge susceptibility of many-electron systems coupled to the quantized radiation field*, Letters in Mathematical Physics **105** (2015), 1119–1133. DOI [10.1007/s11005-015-0775-9](https://doi.org/10.1007/s11005-015-0775-9); [arXiv:1405.0112](https://arxiv.org/abs/1405.0112). The finite-source result is Theorem 3.4; the thermodynamic susceptibility result is Theorem 1.2. Publication metadata are also listed on [the author's publication page](https://sites.google.com/view/tadahiromiyaosite/curriculum-vitae/publications).
- **HLS:** Christian Hainzl, Mathieu Lewin, and Éric Séré, *Existence of a Stable Polarized Vacuum in the Bogoliubov–Dirac–Fock Approximation*, Communications in Mathematical Physics **257** (2005), 515–562. DOI [10.1007/s00220-005-1343-4](https://doi.org/10.1007/s00220-005-1343-4); [arXiv:math-ph/0403005](https://arxiv.org/abs/math-ph/0403005). This is a no-photon mean-field vacuum result.
- **GLS:** Philippe Gravejat, Mathieu Lewin, and Éric Séré, *Renormalization and asymptotic expansion of Dirac's polarized vacuum*, Communications in Mathematical Physics **306** (2011), 1–33. DOI [10.1007/s00220-011-1271-4](https://doi.org/10.1007/s00220-011-1271-4); [arXiv:1004.1734](https://arxiv.org/abs/1004.1734). Its charge-renormalization analysis concerns the reduced BDF model.
- **GHLS:** Philippe Gravejat, Christian Hainzl, Mathieu Lewin, and Éric Séré, *Construction of the Pauli–Villars-Regulated Dirac Vacuum in Electromagnetic Fields*, Archive for Rational Mechanics and Analysis **208** (2013), 603–665. DOI [10.1007/s00205-012-0609-1](https://doi.org/10.1007/s00205-012-0609-1); [arXiv:1204.2893](https://arxiv.org/abs/1204.2893). The electromagnetic field in this construction is classical.

The bibliography supports the methodological and model-scope discussion. The determinant and canonical Gaussian-domination proofs in Sections 1–3 of this report are the finite-dimensional deductions audited here, rather than consequences imported from those citations.

## 8. Completed extension to quantized transverse photons

The separate source `photon-extension.tex` was read in full. Its determinant, trace convergence, coordinate-truncation removal, and improved heat splitting were checked. No substantive gap was found in these steps under its explicit finite-cutoff and positive-effective-mass assumptions.

The original photon convention is \(H_\gamma=\sum_{k,\lambda}|k|a_{k,\lambda}^\dagger a_{k,\lambda}\), with \(0<|k|\leq\Lambda_\gamma\). Choose equal real transverse polarizations at \(k\) and \(-k\), and mix the corresponding annihilation operators unitarily into cosine and sine modes. Their equal frequencies preserve the free photon Hamiltonian. In this standing-wave basis the vector potential depends only on real oscillator coordinates, and

\[
H_\gamma=\frac12\sum_r(-\partial_{X_r}^2+\omega_r^2X_r^2-\omega_r).
\]

This unitary mixing matters: a single traveling-wave quadrature expression can contain oscillator momenta in its sine part. The normal-ordering constant \(-\frac12\sum_r\omega_r\) is source independent and remains in the common heat-kernel normalization.

The current term has no extra sea scalar. Indeed, \(\operatorname{Tr}(P_-P_f\boldsymbol\alpha\cdot A P_f)=0\): nonzero photon momentum makes the momentum diagonal vanish, and the symmetric cutoff also makes the constant-field sea current vanish. Thus the coupling is exactly the ordinary-CAR second quantization of the vector matrix. Adding any real photon-coordinate history changes the Hermitian coefficients of the \(\alpha_i\) only. It preserves both anticommutation with \(C_5\) and the positive \(\beta\)-mass coercivity used in Section 2.

To justify photon integration, the proof first replaces the linear matrix potential \(V(X)\) by \(\chi_R(X)V(X)\), with \(0\leq\chi_R\leq1\) and compact coordinate support. At fixed \(R\) all matrix potentials are bounded. The oscillator heat kernel is positive; its cyclic product integrates to the finite oscillator partition function. Componentwise Hubbard–Stratonovich integration and charge projection then have the same positive fermionic integrand as before.

The needed Trotter limit is trace-norm convergence, not merely strong convergence. For a bounded perturbation \(B\) of the nonnegative oscillator operator \(A\), each Dyson integrand satisfies

\[
\|e^{-s_0A}Be^{-s_1A}\cdots Be^{-s_jA}\|_1
\leq\|B\|^j\operatorname{Tr}(e^{-bA}),\qquad \sum_i s_i=b.
\]

This follows from Schatten Hölder with exponents \(b/s_i\). It controls the series tails and the boundary strips of the time simplex; fixed-order Riemann sums give convergence. Additional bounded factors are handled by a telescoping product estimate with error \(O(n^{-1})\) in trace norm. Thus the canonical partition-function comparison at fixed \(R\) is justified.

Finally, \(\|V(X)\|\leq C|X|\) and

\[
|\langle\Psi,(H_R-H)\Psi\rangle|
\leq C R^{-1}\langle\Psi,|X|^2\Psi\rangle
\leq\varepsilon_R\langle\Psi,(H_\gamma+c)\Psi\rangle,
\qquad\varepsilon_R\longrightarrow0.
\]

Uniform bounds \(H_R,H\geq H_\gamma/2-C'\) give two-sided comparisons of \(H_R\) and \(H\) with vanishing relative and scalar errors. Ground energies therefore converge in each charge sector. All constants in this removal step may depend on the fixed box and photon cutoff: the Gaussian-domination inequality is exact before the limit, so no uniform truncation error remains in the final theorem.

The revised many-source estimate splits the positive source-free Coulomb squares into short and long pieces, retaining both pieces while shifting only the long ones. This improves the earlier heat-smearing constants. The resulting bound is

\[
E_\nu-E^{\rm vac}\geq
-20\pi\alpha d_Ls Z_{\rm tot}
-\frac{13\alpha}{4\pi^{3/2}\sqrt{s}}\sum_iZ_i^2.
\]

The short source term contributes \(-16\pi\alpha d_LsZ_{\rm tot}\); the short nuclear term contributes at worst \(-4\pi\alpha d_LsZ_{\rm tot}\), using charge capacity. The long nuclear diagonals give the remaining term. This comparison uses the same full interacting photon vacuum throughout.

The all-nucleus theorem retains \(L\geq\Lambda_f^{-1}\); the one-nucleus estimate permits every admissible \(L>0\). There is no fixed positive photon infrared cutoff and no added photon mass. The harmonic transverse zero mode is fixed explicitly, and the sharp fermion momentum cutoff is not gauge covariant. The bare mass condition and finite regulators remain essential assumptions. In particular, the result is compatible with the raw vacuum upper bound \(E^{\rm vac}_{\Lambda,L}\leq-cL^5\); a vacuum-relative source bound does not make that absolute vacuum energy extensive.

Two further references used in the updated context are:

- **LS:** Elliott H. Lieb and Heinz Siedentop, *Renormalization of the Regularized Relativistic Electron-Positron Field*, Communications in Mathematical Physics **213** (2000), 673–683. DOI [10.1007/s002200000265](https://doi.org/10.1007/s002200000265); [arXiv:math-ph/0003001](https://arxiv.org/abs/math-ph/0003001). Its self-consistent ordering analysis is distinct from the fixed free-sea prescription here.
- **BBHS:** Volker Bach, Jean-Marie Barbaroux, Bernard Helffer, and Heinz Siedentop, *Stability of Matter for the Hartree-Fock Functional of the Relativistic Electron-Positron Field*, Documenta Mathematica **3** (1998), 353–364. DOI [10.4171/DM/51](https://doi.org/10.4171/DM/51); [publisher's original paper](https://ems.press/content/serial-article-files/25831?nt=1). The original paper's author order is used here. Its variational class is Hartree–Fock and its magnetic field is classical.
