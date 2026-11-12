# Round-four report: frozen-link reduction, matching, and magnetic improvement

29 October 2026. The complete manuscript fragment is `vacuum-relative-stability-paper/low-energy-matching.tex`. This task did not edit the main manuscript, bibliography, or other agents' files.

## Proven static result

For arbitrary fixed compact links, write the Wilson matrix as

`h = [[m+R,S],[S,-m-R]]`, with `R>=0`, `S=S*`, `w=||R||<=6r/a`, and `s=||S||<=3/a`.

If the positive energies are `m+e_j` and the ordered eigenvalues of `K=R+S^2/(2m)` are `k_j`, the full proof gives

`0 <= e_j <= k_j`,

`k_j-e_j <= min{s^2 w/(2m^2)+s^4/(8m^3), k_j(w+k_j)/(2m)}`.

The first bound integrates the round-three frozen-link theorem. The second is a useful stronger low-energy estimate established in this round. Neither requires `[R,S]=0` or smallness of the whole band. The Schur complement is

`A(e)=R+S(2m+R+e)^(-1)S`.

Its ordered eigenvalues cross the line e exactly once. The whole-band estimate follows from `0<=K-A(e)<=delta I`; the sharper estimate follows from `A(e)>=2m K/(2m+w+e)`.

In the quadratic CAR model at the **same** fixed links, subtraction of the filled negative band is exact:

`E_q^stat(U)-E_0^stat(U)=|q|m+sum_{j<=|q|} e_j`.

The corresponding target error is at most `|q| delta`. If every occupied target level is at most `E_*`, it is at most

`[(w+E_*)/(2m)] sum_{j<=|q|} k_j`.

This is genuinely charge-extensive and volume-uniform, but excludes quantized electric dynamics, nuclear scalar potentials, physical Gauss constraints, and differing source/vacuum gauge states. The same static quadratic problem has a neutral particle–hole threshold at least `2m`; this does not prove a neutral-pair gap in the full gauge theory.

## Kinetic and magnetic coefficients

The exact free dispersion is

`E(p)=sqrt{[m+(r/a)sum_j(1-cos ap_j)]^2+sum_j sin^2(ap_j)/a^2}`.

Its quadratic Taylor coefficient gives exactly

`m_kin=m/(1+rma)`.

The retained lattice Pauli operator is `R+S^2/(2m)`, including the leading Wilson Laplacian. For smooth periodic vector potentials, the manuscript makes the convention explicit:

`U_xj=exp(-ig integral A.dl)`, so `T=bar U times forward translation`, `Pi=p+gA`, and `[Pi_j,Pi_k]=-ig epsilon_jkl B_l`.

Then `S^2` has leading continuum term `Pi^2+g sigma.B`, and the target coefficients are

`Pi^2/(2m_kin) + g sigma.B/(2m)`.

Therefore `g_eff=2m_kin/m=2/(1+rma)`. This is a tree-level low-momentum/weak-field matching coefficient, not a nonperturbative prediction for the measured magnetic moment.

The paper proves consistency bounds on smooth continuum functions for the covariant difference operators before sampling. In particular,

`||(sin(a Pi_j)/a-Pi_j)f|| <= a^2 ||Pi_j^3 f||/6`,

and the Wilson-Laplacian remainder is at most `ra^3 sum ||Pi_j^4 f||/24`. An explicit mixed-derivative bound controls the squared spin operator. It keeps transport-dependent supremums because different covariant derivatives do not commute. No claim that point sampling is isometric or that these estimates already compare continuum and finite-lattice spectra is made.

## Scaled Wilson parameter and iron

Set `x=ma`, `r=c/x`, and use hydrogenic benchmark scales

`p_Z=Z alpha m/(1+c)`, `R_Z=(Z alpha)^2 m/[2(1+c)]`.

The exact free corner energies are `m+2kr/a`; the first corner offset is `Delta_d=2cm/x^2`. A stronger conservative statement about the free spectrum is that any momentum outside the central half of one coordinate has `E(p)-m>=r/a=Delta_d/2`. No assertion that every corner is a local minimum for arbitrary parameters is needed.

With explicit tolerances, `x>=H>1`, `a p_Z<=epsilon_a`, and `R_Z/Delta_d<=epsilon_d` are equivalent to

`H <= x <= min{epsilon_a(1+c)/(Z alpha), 2 sqrt(epsilon_d c(1+c))/(Z alpha)}`.

For target levels `k_j<=R_Z`, the static relative error is bounded by

`(k_j-e_j)/k_j <= 3c/x^2 + (Z alpha)^2/[4(1+c)]`.

This latter estimate does not make the interacting atomic assumptions true; it states the static error if the target spectral window is imposed.

At `c=0.1`, `alpha=1/137`:

- `g_eff=1.8181818...`, with fractional error `1/11` and absolute error `2/11` from 2.
- For hydrogen, `x=60` gives `a p_1=0.39814200398141997` and `R_1/Delta_d=0.43592190216943794`. Thus “around 60” is a crossover estimate, not a well-resolved hierarchy.
- With both tolerances equal to 0.1, the upper x bound is `15.07` for `Z=1`.
- For `Z=26`, even unit tolerances give `x<=3.495212279066845`; 10% tolerances give `x<=0.5796153846153848`, incompatible with `ma>1`.

The Z=26 calculation is a scale diagnostic for unscreened inner electrons. It does not prove an interacting no-go theorem, nor does it rule out a better matched regulator. It prevents the hydrogenic “60” estimate from being presented as a uniform iron-inclusive physical matching result. Screening of valence electrons does not remove the need to handle the inner-shell scale in such a theorem.

## Clover audit: a useful positive result

The brief's algebraic assertion is correct: with `Sigma_l=-i alpha_j alpha_k` for cyclic indices,

`[C5,Sigma_l]=0` and `{C5,beta Sigma_l}=0`.

A magnetic term `lambda beta Sigma.B` **preserves** C5 anticommutation. It changes the operator in the beta-form derivative:

`{beta,h_lambda}/2 = M + lambda Sigma.B`.

This contribution is indefinite by itself, but does not necessarily destroy positivity.

For an explicitly defined Abelian four-plaquette clover

`B_l^cl(x)=-(4ga^2)^(-1) sum_{four adjacent oriented plaquettes} Im U_p`,

each component is bounded by `1/(ga^2)` and `||Sigma.B^cl||<=sqrt(3)/(ga^2)` for **every** compact link configuration. Thus

`m_cl=m-sqrt(3)|lambda|/(ga^2)>=0`

is a sufficient global condition. The existing determinant mechanism needs only C5 anticommutation, tracelessness, scalar kicks preserving beta and C5, and `{beta,h}/2>=m_cl I`; it does not require this last operator to be spin-scalar. The manuscript proves the generalized criterion and applies the positive matrix Feynman–Kac/local Gauss projection argument. The resulting distinct clover Hamiltonian satisfies

`E_nu^(lambda) >= E_0^(lambda) + m_cl |sum nu|`.

The same specified nuclear self-energy subtraction gives the linear nuclear stability bound. All link configurations remain included.

With the explicit sign convention above, the tree-level choice restoring `g_eff=2` is

`lambda_tree=g r a/2`.

It requires only `m>=sqrt(3)r/(2a)` for this sufficient positivity proof. With `r=c/(ma)`, this is `x^2>=sqrt(3)c/2`. For c=0.1 the threshold is approximately x=0.2943, so the heavy regime readily satisfies it. Under the opposite convention `U=exp(+ig integral A.dl)`, both the Pauli sign and the improvement sign reverse; the norm condition is unchanged.

This is a magnetic improvement only. It does not match electric, Darwin, spin–orbit, radiative, or doubler effects. Electric-rotor improvement terms need a different domain and positivity analysis. The clover theorem is for the explicitly modified bare Hamiltonian and must not be silently ascribed to the original Wilson Hamiltonian.

## Why the full quantized-link reduction remains open

The frozen sea energy `-sum_j[m+e_j(U)]` becomes a link-dependent multiplication operator when links are quantized. Source and vacuum states need not give it the same expectation. Also any smooth local band transformation `mathcal U(U)` changes the electric derivative by

`mathcal U E_l mathcal U* = E_l + i(partial_l mathcal U) mathcal U*`.

The induced connection and off-band terms are part of the transformed electric energy. They are not estimated by a frozen eigenvalue comparison. Consequently no interacting Pauli–Fierz/nuclear reduction, source-relative SW remainder, or physical mass/g matching theorem is claimed.

## Primary-source verification and bibliography request

1. **El-Khadra–Kronfeld–Mackenzie:** A. X. El-Khadra, A. S. Kronfeld, P. B. Mackenzie, *Massive Fermions in Lattice Gauge Theory*, Physical Review D **55** (1997), 3933–3957. [Publisher](https://doi.org/10.1103/PhysRevD.55.3933), [primary preprint PDF](https://arxiv.org/pdf/hep-lat/9604004).

   Verified the actual PDF. Equation (2.12), printed page 8, defines the four-leaf clover; Section 5.1, especially (5.12)–(5.13), places the magnetic improvement in the mass block and distinguishes electric transfer-matrix issues; Equation (9.1) and Section 9, printed pages 33–36, distinguish rest, kinetic, and magnetic masses and discuss their matching. Their spacetime lattice action is not identical to this project's continuous-time Hamiltonian; the formulas proved here are derived independently.

   Requested bibliography key: `EKM`.

2. **Zache et al.:** T. V. Zache et al., *Quantum simulation of lattice gauge theories using Wilson fermions*, Quantum Science and Technology **3** (2018), 034010. [Publisher](https://doi.org/10.1088/2058-9565/aac33b), [primary preprint PDF](https://arxiv.org/pdf/1802.06704).

   Verified Section II and Equation (3), which specify a continuous-time Hamiltonian with the Wilson spatial Laplacian; the discussion explains the naive spatial species count. Existing bibliography key `Zache` is sufficient. The source is used for context, not as a theorem proving this task's interacting reduction.

The original Sheikholeslami–Wohlert paper was identified, but its primary PDF could not be opened through the web tool. No result depends on an unverified reading of it; the verified EKM primary paper supplies the clover definition and matching context needed here.

## Validation and manuscript scope

All inequalities and model changes are proved or explicitly scoped in the manuscript fragment. The scale numbers were directly evaluated from the displayed exact algebra. No additional numerical script was needed: no numerical experiment is being used as evidence for a universal theorem. The parent task owns compilation and final integration.
