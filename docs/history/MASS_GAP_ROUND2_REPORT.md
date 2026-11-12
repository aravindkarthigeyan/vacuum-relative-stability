# Round-two mass-window and charge-gap audit

This report records proved results and limits of the proofs. The accompanying manuscript fragment is `vacuum-relative-stability-paper/mass-gap.tex`; the diagnostic script is `numerics/round2_mass_gap_checks.py`. No other manuscript source was edited.

## Principal results

1. **The exact interacting charge-gap theorem is proved under a positive effective mass.** If every effective mass coefficient satisfies `M >= m_* I > 0`, then, including the finite set of quantized transverse photon modes,

   `E_q(eta) >= E_0(0) + m_* |q|`.

   Here `eta` is any real displacement of the positive density squares used in canonical Gaussian domination. In particular `E_q(0)-E_0(0) >= m_* |q|`. The source-free nonneutral sectors remain auxiliary zero-mode-deleted sectors, not physical nonneutral torus systems. This result does not imply a neutral pair-sector gap.

2. **The proposed prefactor-free finite-temperature comparison is false.** For four free modes with `h=m beta`, putting `r=exp(-b m)` gives

   `Z_1/Z_0 = (2r+2r^3)/(1+4r^2+r^4) > r`

   for sufficiently small positive `r`. At `r=0.01` the ratio is `0.019994002199180308`. The correct proved estimate has the beta-independent prefactor `binom(D,D/2+|q|)`; it disappears in the ground-energy limit.

3. **Density-product ordering has no cutoff window.** With the Coulomb interaction defined as the positive product of free-sea-centered densities, without an additional four-field Wick ordering, the effective one-body matrix is `D_0`, with mass exactly `m`. The existing photon and nuclear comparison proofs therefore hold for all finite cutoffs and all `alpha >= 0`. The charge gap uses `m_*=m`. This is a distinct ordering prescription, not an equivalent model obtained by a scalar vacuum subtraction.

4. **Semidefinite mass is covered by closure.** Replace `M>=0` with `M+epsilon I`, apply the proved comparison, and use a bounded perturbation of norm at most `epsilon D` at fixed regulators. A uniformly nonpositive mass is also covered after replacing the Dirac matrix beta by its negative. The genuinely indefinite case remains unresolved here.

5. **The original all-volume cutoff window improves from about 104 to about 5168 electron masses.** Let `h=2pi/L`. The proved all-volume estimate is

   `delta M(p) <= alpha h/(4pi^2) + 13 alpha m/(2pi^2) asinh(Lambda/m)`.

   If the band contains a nonzero momentum then `h<=Lambda`; otherwise the correction is exactly zero. Consequently positivity for every box follows from

   `alpha [(Lambda/m)/(4pi^2) + 13/(2pi^2) asinh(Lambda/m)] < 1`.

   At `alpha=1/137` the threshold is approximately `5168.214040868339`. The inequality itself, not this decimal, is the theorem.

6. **The continuum logarithmic coefficient can be recovered with a mass-resolving lattice.** For `h<=m`, a direct cubature proof gives

   `delta M(p)/(alpha m) <= asinh(Lambda/m)/pi + 34 h/m`.

   This is uniform in the external lattice momentum and cutoff. For a family `L>=L0>=2pi/m`, the mesh error is bounded by `68pi/(m L0)`. The extremely large exponential continuum window requires this separate infrared/mesh hypothesis.

7. **A purely logarithmic bound uniform over all boxes in the old theorem is false.** Set `L=2pi/Lambda` and choose `p=Lambda e1`. The `r=0` summand alone gives `delta M(p)>=alpha Lambda/(4pi^2)`. Hence the effective mass is negative if `Lambda/m>4pi^2/alpha`, approximately `5408.5432117969685` at physical alpha. These boxes satisfy the old condition `L>=Lambda^-1`. This is a counterexample to the uniform continuum extrapolation, not a counterexample to Gaussian domination at an indefinite mass.

## Quantitative transfer proof

For any one-particle transfer eigenvector `Uu=lambda u`, evolve it through the free intervals and scalar kicks. Write `B=<f,beta f>`. The kicks preserve B and free intervals obey

`B'=-2<f,Mf> <= -2m_* ||f||^2`.

The strict total decrease implies stable eigenvalues have `B(0)>0`, unstable eigenvalues `B(0)<0`, and none has modulus one. B keeps its sign throughout the trajectory. Gronwall then gives

`|lambda|<=exp(-b m_*)` or `|lambda|>=exp(b m_*)`.

C5 pseudo-unitarity pairs the spectrum, including algebraic multiplicities, as `lambda` and `1/conj(lambda)`. There are exactly `N=D/2` stable eigenvalues. No diagonalizability is required. The centered charge-twist trace becomes

`F(theta)=C product_j |1+exp(i theta) lambda_j|^2`, with `C>0`.

If `e_j` are elementary symmetric polynomials, then `F_0=C sum |e_j|^2 >= C` and `|e_j|<=binom(N,j) exp(-b m_* j)`. Vandermonde's identity yields

`|F_q| <= binom(2N,N+|q|) exp(-b m_* |q|) F_0`.

Integrate over positive HS and photon-history measures. The density-source phase has unit modulus and is independent of the charge angle. The existing trace-norm Trotter theorem applies first at fixed photon-coordinate cutoff. Take inverse temperature to infinity, then remove the coordinate cutoff using the established sector form comparison. This proves the stated energy inequality, also with density-square shifts. Nuclear-neutral lower bounds consequently acquire the additional positive term `m_* Z_tot`.

## Discrete convolution proof and constants

Fill the omitted Coulomb kernel value with `K(0)=h^-2`, keep `K(k)=|k|^-2` through `2Lambda`, and set it to zero afterwards. Its superlevel sets and those of `1_{|r|<=Lambda}/sqrt(m^2+|r|^2)` are concentric lattice balls. An intersection after any lattice translation has cardinality at most the smaller ball, attained at zero translation. Integrating the two layer-cake decompositions therefore bounds the convolution at every p by the filled convolution at zero. Cubic shells contain `24j^2+2<=26j^2` points, and a decreasing Riemann-sum bound gives the explicit asinh estimate above. This argument does not claim that the original kernel with its diagonal removed is maximized at p=0.

For the sharper estimate, let `F_p(x)=|x-p|^-2 (m^2+|x|^2)^-1/2`. Remove centers with `|r|<2h` or `|r-p|<2h`; there are at most 54, each contributing at most `h/m` to the discrete cubature sum. On the other cubes, distances and energies are at least `b=1-sqrt(3)/4>9/16` times their center values. The Hessian bound is

`||Hess F_p|| <= b^-5 [8/(s^4 E)+4/(s^2 E^3)]`.

The midpoint error is at most `h^5/8` times this bound. Cubic shells prove

`sum h^3 s^-4 <43/h`, and `sum h^3 E^-6 <62/m^3` for `h<=m`.

The second follows by splitting at `a=m/h`: the zero term, shells `j<=a`, and shells `j>a` are bounded by `1`, `26`, and `104/3` times `m^-3`, totaling `185/3<62`. Cauchy--Schwarz gives `sum h^3 s^-2 E^-3 <52/(h^1/2 m^3/2)`. Since `b^-5<18`, the far-cube error is at most `1242 h/m`. The near centers cost 54, and enlarging the integration ball by the cell radius costs less than 11. The continuum integral is bounded at p=0 by the continuous version of the same layer-cake argument. Thus the total error is `1307 h/m`, and `1307/(4pi^2)<34`. These constants are proved analytically in the manuscript; the script additionally checks the arithmetic.

## Audit of supplied numerical claims

- `claude_meff_lattice_sum.py` reproduces the quoted p=0 values `0.831,0.977,1.013`. Its scaling fixes `Lambda L=36pi`, hence fixes the momentum-shell count and sends `m/h` to zero as Lambda grows. It does not approach the continuum limit. The tested momentum `0.99 Lambda e1` equals `17.82 h e1` and is always off-lattice for that scaling; it is not an admissible matrix entry. The momentum `Lambda e1/2=9h e1` is admissible.
- The other supplied random scripts correctly test the indicated finite matrices, but finite random samples cannot establish universal Gaussian domination or a charge gap. In particular their absence of an indefinite-mass failure does not supply the missing proof.
- The new deterministic-seed transfer search checked 20,000 eight-mode histories with mass eigenvalues `[-1,1]`, noncommuting Dirac-vector coefficients, and scalar unitary kicks. It found no negative centered determinant. This is explicitly inconclusive. Even a negative path determinant would refute pointwise positivity only; a separate argument would be required to refute the integrated ground-energy comparison.

## Verification performed

Executed `python numerics/claude_meff_lattice_sum.py` and `python numerics/round2_mass_gap_checks.py --indefinite-search`. The latter checks the finite-temperature counterexample, all cubature constants, and a coarse-box instance at `Lambda/m=6000`, for which `delta M/m=1.1097720337847732` and its r=0 term is `1.1093560252810706`. These numerical checks are diagnostic only. Compilation and integration of the new manuscript fragment are left to the parent task, which owns the main document.
