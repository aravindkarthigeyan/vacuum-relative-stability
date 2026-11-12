# Round-four report: electric localization and pair denominators

Date: 29 October 2026. This report concerns the actual compact-link Wilson Hamiltonian in `vacuum-relative-stability-paper/lattice.tex`, on a periodic cubic graph with `n >= 3`, `N = n^3` sites, `3N` positive links, and finite parameters `a > 0`, `g^2 > 0`, `m,r >= 0`.

The proved supplementary section is saved as `vacuum-relative-stability-paper/electric-localization.tex`, with labels prefixed `flux4-`. No other manuscript source was edited. No new external theorem or bibliography entry is needed: the claims below are proved directly for the stated operator.

## Main conclusions

1. The proposed source-only electric-tail estimate is false, already in the actual `K=0` interacting vacuum. Every nonzero eigenvector has infinite support in the integer electric variables, so its **total** tail probability is positive at every finite threshold.
2. There is a valid electric-energy/tail bound containing an extensive volume term. Vacuum energy subtraction does not remove the vacuum electric fluctuations.
3. Smooth electric localization commutes with all local Gauss constraints. Its IMS error is quadratic in the inverse cutoff, `O(N/F^2)`, with a stronger local boundary-shell form estimate.
4. Sharp electric truncation converges by the variational principle at every fixed finite volume. Its boundary coupling does **not** tend to zero in operator norm: a uniform lower bound is `1/(2g^2 a)` already in the physical zero-source sector.
5. The mass-plus-electric reference admits a rigorously bounded first pair-elimination generator inside a finite electric cube. This is not a gap theorem for the full pair block or a completed Schrieffer–Wolff reduction.
6. Independent checking confirms the parent section's bare-sea obstruction and its volume-dependent excitation estimate. The bare excitation number also has nonzero interacting-vacuum expectation.

## 1. An actual-model vacuum counterexample, without a rotor surrogate

Use the electric Fourier representation `ell^2(Z^E)` and write a plaquette monomial as `U^{s_p}`. The plaquette vector has four entries `+/-1`, satisfies `div s_p = 0`, and has squared Euclidean norm `4`. Fermion hopping shifts exactly one electric coordinate by one.

The scalar magnetic coefficient of `U^{s_p}` is `-1/(2g^2 a)`. The linear functional `s_p . e` is maximized over all distinct Hamiltonian shifts uniquely at `s_p`: its value is `4` there, at most `1` on single-link shifts, and strictly less than `4` on any distinct plaquette shift. Repeated instances of an identical plaquette shift have scalar coefficients of the same sign.

Suppose an eigenvector had finite electric support. Perturb that linear functional slightly to select a unique largest support point `e_*`, while preserving the unique largest shift `s_p`. At electric configuration `e_* + s_p`, the eigenvalue equation then has exactly one nonzero contribution: the scalar plaquette coefficient times the nonzero fermion vector at `e_*`. The eigenvector itself has zero coefficient there. Contradiction.

Consequently, for every normalized vacuum ground vector `Omega` and every finite `F`,

\[
\left\langle\Omega,\sum_\ell 1_{\{|E_\ell|\ge F\}}\Omega\right\rangle>0.
\]

This does **not** assert a quantitative lower bound on the tail, or a positive tail for every specified individual link. It supplies exactly the total-tail statement needed to disprove the proposed estimate.

Indeed, a bound with right side `C'(Z_tot+K)/(cF^2)`, applied to a vacuum ground vector at `K=Z_tot=0`, has right side zero and left side strictly positive. Here `c=g^2/(2a)`.

## 2. Valid volume-dependent replacement

Let

\[
\mu=m+3r/a,\qquad h_*=m+(3+6r)/a.
\]

Because `H_B >= 0` and `dGamma(h_W) >= -2N h_*`, every normalized state with `energy <= E_0 + Delta` satisfies

\[
cF^2\left\langle\sum_\ell1_{\{|E_\ell|\ge F\}}\right\rangle
\le\langle H_E\rangle
\le E_0+\Delta+2Nh_*
\le\Delta+N\left[\frac{6(1+r)}a+\frac3{g^2a}\right].
\]

The last inequality uses the existing trial bound `E_0 <= -2N mu + 3N/(g^2 a)`. Thus the rest-mass term cancels from this coarse extensive upper bound, but the volume does not.

For integer `F >= 0`, with `P_F` the projection onto `|E_l| <= F` for every link,

\[
\|(1-P_F)\psi\|^2
\le\frac{\Delta+N[6(1+r)/a+3/(g^2a)]}{c(F+1)^2}.
\]

These are rigorous estimates in every physical source sector, with no claim that their constants or powers are optimal. Obtaining small discarded norm from them requires `F^2` large compared with `N` at fixed parameters. That requirement does not combine with a volume-independent upper cutoff on `F` coming from a positive pair denominator.

Subtracting the scalar `E_0` does not subtract `Omega`'s electric fluctuations. The difference of two electric-energy expectations is not automatically positive or bounded by the difference of the two total energies.

## 3. Gauss-preserving IMS localization

Write the Hamiltonian as

\[
H=H_E+C_0+\sum_s U^s A_s,
\qquad
\mathcal J:=\sum_s\|A_s\|
\le\frac{12N(1+r)}a+\frac{3N}{g^2a}.
\]

Each shift has maximum-coordinate norm `1`. This deliberately safe coefficient bound follows from singular-value decomposition of the four-spin hopping coefficient `(-i alpha_j-r beta)/(2a)` and the CAR; no fermion coefficients are assumed to commute.

Choose a Lipschitz angle `theta`, zero below `1`, equal to `pi/2` above `2`, with Lipschitz constant `L_theta`. Put `R(E)=max_l |E_l|` and

\[
f_0=\cos\theta(R/F),\qquad f_1=\sin\theta(R/F).
\]

Then `f_0^2+f_1^2=1`, each cutoff commutes with the Gauss operators and electric energy, and

\[
f_0Hf_0+f_1Hf_1=H+\mathcal R_F,
\qquad
\|\mathcal R_F\|\le\frac{L_\theta^2\mathcal J}{2F^2}.
\]

For a single shift the error coefficient is exactly

\[
\cos\{\theta(R(e+s)/F)-\theta(R(e)/F)\}-1.
\]

The estimate follows from `|R(e+s)-R(e)| <= 1` and `1-cos t <= t^2/2`. It is a genuine quadratic IMS error, despite a single commutator being only first order in `1/F`. The error is supported on `F-1 <= R(E) <= 2F+1` at both endpoints.

A product partition using the two cutoffs independently on every link gives the local form bound

\[
\left|\left\langle\sum_\sigma f_\sigma Hf_\sigma-H\right\rangle\right|
\le\frac{L_\theta^2}{2F^2}
\left[\frac{4(1+r)}a+\frac4{g^2a}\right]
\sum_\ell\left\langle1_{\{F-1\le|E_\ell|\le2F+1\}}\right\rangle.
\]

Its proof uses the product overlap `prod_l cos(d_l)`, the inequality `1-prod cos(d_l) <= sum_l d_l^2/2`, and Cauchy–Schwarz on the electric Fourier kernel. This partition retains branches with high-flux links; it does not authorize deleting them.

## 4. Sharp-cutoff boundary terms

For each shift define its outgoing boundary projector

\[
B_{s,F}=P_F1_{\{\exists\ell:|E_\ell+s_\ell|>F\}}.
\]

Then exactly

\[
(1-P_F)HP_F=\sum_sU^sA_sB_{s,F}.
\]

Weighted Cauchy–Schwarz bounds its squared action on a vector in `P_F` by

\[
\mathcal J\left[\frac{4(1+r)}a+\frac4{g^2a}\right]
\sum_\ell\langle P_F1_{\{|E_\ell|=F\}}\rangle.
\]

There is no uniform small operator norm as `F` grows. Choose electric flux `e=F s_p` and the onsite filled negative-beta sea. This is a zero-source physical state. Its outgoing Fourier component at `(F+1)s_p` has norm at least `1/(2g^2 a)`, supplied solely by the plaquette multiplier. Hence

\[
\|(1-P_F)HP_F\|_{\mathcal H_0}\ge\frac1{2g^2a}
\]

for every integer `F >= 0`.

Furthermore,

\[
[PAP,PBP]=P[A,B]P-PA(1-P)BP+PB(1-P)AP.
\]

Thus compression can create nonzero commutators from originally commuting multipliers. These terms matter in a truncated block-diagonalization calculation.

At each fixed volume, the compressed physical ground energies do converge monotonically down to the exact physical energy, because electric finite Fourier sums in the sector form a core. This gives convergence, but not a uniform source-relative error rate. Finite electric truncation also does not automatically preserve the heat-kernel positivity used in the manuscript's exact Gaussian-domination theorem.

## 5. Pair denominators: what is proved and what remains conditional

For the diagonal reference

\[
D=H_E+\mu N_{\rm exc}-2N\mu,
\]

an elementary gauge-invariant pair-creation hop `A=t U_l^sigma B_+`, with `sigma=+/-1` and `[N_exc,B_+]=2B_+`, obeys

\[
[D,A]=A[2\mu+c(2\sigma E_\ell+1)].
\]

The initial-flux convention is explicit. For an internal transition in `|E_l| <= F`, its minimum pair-creation difference is

\[
\delta_F=2\mu-c(2F-1),\qquad F\in\mathbb N,\ F\ge1.
\]

The brief's `2mu-c(2F+1)>0` is a valid more conservative sufficient hypothesis. If `delta_F>0`, define `A_F=P_FAP_F`,

\[
T_F=A_F[2\mu+c(2\sigma E_\ell+1)]^{-1},\qquad S_F=T_F-T_F^*.
\]

The inverse is only on the finite cube. Then

\[
[S_F,D_F]=-(A_F+A_F^*),\qquad
\|S_F\|\le2|t|/\delta_F.
\]

This is an exact bounded first homological equation and respects Gauss's law. It omits `H_B` and the pair-preserving Wilson hopping from its reference. Its electric-dependent denominator need not commute with plaquette terms. The resulting residual commutators and compression boundaries must be retained.

A pair Feshbach reduction of the full `H_F` at energy `z` requires the independent block inequality

\[
Q_{\rm pair}H_FQ_{\rm pair}-zQ_{\rm pair}\ge d_{\rm pair}Q_{\rm pair}>0.
\]

Positive elementary transition differences do not establish this spectral inequality, and a charge gap does not establish a neutral-pair gap.

For the *flux* complement, a concrete sufficient Schur hypothesis is available:

\[
(1-P_F)H(1-P_F)-z\ge
[c(F+1)^2-2Nh_*-z](1-P_F)>0.
\]

The exact correction to `P_FHP_F-z` is then `B^*(C-z)^{-1}B`, bounded by `B^*B/d_flux`. The displayed sufficient gap is explicitly volume dependent; it is not claimed necessary. This identifies a genuine conditional operator theorem rather than an assumed global gap.

## 6. Independent check of the bare-excitation obstruction

This proof and the corresponding manuscript subsection are owned by the parent agent and are cross-referenced rather than duplicated in the new section.

For `n>=3`, the derivative pair-creation matrix `K(U)` satisfies pointwise

\[
\operatorname{Tr}K(U)^*K(U)=3N/a^2.
\]

The two orientations of each positive link produce distinct endpoint particle–hole states, each with two spin channels. Consequently the derivative term acting on an arbitrary link wavefunction times the onsite sea has squared norm exactly `(3N/a^2)` times that wavefunction's squared norm. No full-Hamiltonian eigenvector lies in the bare sea.

For `V=A+A^*`, `A=b^*Kd^*`, Cauchy–Schwarz and the CAR give

\[
|\langle A\rangle|
\le\sqrt{3N/a^2}\sqrt{\min(\langle N_e\rangle,\langle N_p\rangle)}.
\]

Thus, for every `eta>0`,

\[
|\langle V\rangle|
\le\eta\langle N_{\rm exc}\rangle+\frac{3N}{2\eta a^2}.
\]

Combining the exact pair-preserving reference inequality `H_d >= E_ref+mN_exc` with `E_0 <= E_ref` and choosing `eta=m/2` gives

\[
\langle N_{\rm exc}\rangle
\le\frac{2\Delta}{m}+\frac{6N}{(ma)^2},
\qquad \langle H\rangle\le E_0+\Delta,
\]

for `m>0`. The coefficient and normalization are independently confirmed. Removing the extensive vacuum term would contradict the nonzero bare pair content of an interacting vacuum. A dressed excitation operator can be a useful target, but its coercivity, its relation to the exact vacuum, and the source dependence of the dressing require new estimates.

## 7. Interpretation near nuclei

Gauss's law is not an upper bound on the link flux near a nucleus. At a site with `nu_x >= 2`, using `q_x <= 2` gives

\[
\sum_{\ell\ni x}E_\ell^2\ge(\nu_x-2)^2/6.
\]

For `nu_x=26` this is `96`, with at least one incident magnitude at least `4` in each electric–occupation basis vector. It is a lower bound. Arbitrarily large divergence-free integer circulations preserve the same source and charge sector. Calling the threshold exclusion physically harmless therefore needs a low-energy probability estimate, rather than the assertion that all relevant fluxes are bounded by `Z/6`.

The new results neither contradict the existing vacuum-relative stability theorem nor prove a nonrelativistic many-body reduction. They isolate exactly which proposed intermediate assertions fail and provide replacements with their genuine volume dependence.
