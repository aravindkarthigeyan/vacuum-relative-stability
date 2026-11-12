# Round-three audit: dynamical links and the heavy-mass reduction

Date: 29 October 2026. Independent analysis of Task 1 in `CODEX_NEXT_TASKS_3.md`, using the Hamiltonian in `vacuum-relative-stability-paper/lattice.tex`. Existing manuscript files were not modified.

## Verdict

The local mass gap supplies a useful starting point, but `ma >> 1` alone does **not** justify a uniform Schrieffer–Wolff elimination of pairs on the full, untruncated electric Hilbert space. Nor does ordinary locality turn a volume-sized remainder into a remainder proportional to the number of nuclei. These are separate theorems still to prove.

There are two precise positive results below: an exact pair threshold for the pair-preserving reference Hamiltonian, and a quadratic-form bound controlling the electric energy under a bounded fermionic dressing. They support an energy-restricted program. Neither is an interacting neutral-pair gap.

## 1. The electric commutator cannot be omitted

On one link let

\[
E=-i\partial_\varphi,\qquad U=e^{i\varphi},\qquad c=\frac{g^2}{2a}.
\]

On the trigonometric-polynomial core,

\[
[E,U]=U,\qquad [E^2,U]=U(2E+1),
\]

and

\[
[E^2,U^*]=U^*(-2E+1).
\]

Thus `[H_E,U]` is unbounded, although `U` and the fermion hopping are bounded. In the electric eigenbasis, raising a link flux from `L` to `L+1` costs `c(2L+1)`; lowering it costs `c(-2L+1)`.

Let `V_+` create one electron–hole pair in the on-site beta basis and `V_-=V_+^*`. For the bare mass term, `[H_m,V_+]=2m V_+`. The customary first generator

\[
S_0=\frac{V_+-V_-}{2m}
\]

is anti-Hermitian and obeys `[S_0,H_m]=-(V_++V_-)`. But the transformed Hamiltonian also contains `[S_0,H_E]`, which remains off-diagonal in pair number and is unbounded. Its size is not uniformly controlled by `1/(ma)` in operator norm. The magnetic plaquette multiplier commutes with such a link-multiplier/fermion generator; the electric term is the immediate problem.

Keeping the transformed electric term *exactly* is mathematically possible, but does not make it pair-preserving. That choice alone has not effected the advertised low-energy reduction.

## 2. Exact resonance of the mass-plus-electric reference

Consider a gauge-invariant derivative hop of the form

\[
A=t\,U_{xy}^*c_{x,+}^*c_{y,-}.
\]

Starting from the on-site filled negative sea, it creates an electron at `x`, a hole at `y`, and lowers the link electric flux by one. The changes in the two local Gauss operators cancel exactly. The total electron excess stays zero.

For initial link flux `L`, the change of `H_m+H_E` is

\[
\Delta=2m+c(1-2L).
\]

For every positive integer `L`, choose

\[
c=\frac{2m}{2L-1}.
\]

Then `Delta=0` and the hopping matrix element is nonzero. For example, `a=1`, `m=100`, `L=100`, `g^2=400/199` gives `ma=100` and exact resonance. An initial divergence-free electric flux around a lattice cycle makes both states physical in the zero-source Gauss sector.

This is an exact degeneracy for `H_m+H_E`; it is also an unperturbed degeneracy in the one-dimensional periodic compact model with no plaquette term and `r=0`. In three dimensions the magnetic term mixes electric basis vectors, so this calculation is not asserted to diagonalize the full reference `H_m+H_E+H_B`. Its implications are narrower and sufficient:

* No proof based solely on the mass denominator `2m` and `[H_m,H_E]=0` can work uniformly over all electric sectors.
* For the diagonal mass-plus-electric reference, the first SW equation has no solution on this resonant matrix element: `[S,H_m+H_E]_{ij}=0` whereas `V_{ij}` is nonzero.
* High electric energy can be converted into pair rest energy. A no-pair subspace containing *all* gauge excitations is not an isolated low-energy band.

This is **not** a counterexample to a low-energy ground-state reduction or to the existing charge-gap theorem. The displayed resonant states have large electric energy.

For a flux-restricted calculation, the elementary denominator has the lower bound

\[
2m-c(2F+1)>0\qquad (|E|\le F),
\]

before other terms are included. Such a cutoff is not invariant under hopping or plaquette evolution. It must be replaced by an energy-window estimate, a weighted norm argument, or a controlled cutoff-removal theorem.

## 3. An exact threshold for the pair-preserving reference

This part keeps the full Wilson mass term, not merely its on-site part. Choose the on-site beta basis and define electron operators from the positive beta components and hole operators by particle–hole transforming the negative beta components. Write their numbers as `N_e,N_p`. Then the centered charge is

\[
Q=N_e-N_p.
\]

Let

\[
H_d=H_E+H_B+d\Gamma(\beta M(U)),\qquad H_g=H_E+H_B,
\]

with the same positive Wilson operator `M(U)>=m`. Since the spin multiplicity is two in each beta block,

\[
H_d=H_g-2\operatorname{Tr}_{\ell^2(X)}M(U)+T_e(U)+T_p(U).
\]

The hole hopping matrix is the transpose appropriate to the particle–hole transform. Both quadratic forms are positive and satisfy

\[
T_e\ge mN_e,\qquad T_p\ge mN_p.
\]

On the periodic lattice with no self-links,

\[
\operatorname{Tr}M=N(m+3r/a),
\]

independent of the links. Put `E_g=inf spec H_g` on the auxiliary gauge Hilbert space and

\[
E_{\rm ref}=E_g-2N(m+3r/a).
\]

It follows as a quadratic-form inequality that

\[
\boxed{H_d\ge E_{\rm ref}+m(N_e+N_p).}
\]

For fixed charge `Q=Z>=0`, this becomes

\[
\boxed{H_d\ge E_{\rm ref}+mZ+2mN_p.}
\]

Hence, with `P_pair` the restriction to `N_p>=1` in this charge sector,

\[
P_{\rm pair}H_dP_{\rm pair}\ge
(E_{\rm ref}+mZ+2m)P_{\rm pair}.
\]

For real `z<E_ref+mZ+2m`, the compressed reference resolvent exists and obeys

\[
\left\|(P_{\rm pair}H_dP_{\rm pair}-z)^{-1}\right\|
\le\frac1{E_{\rm ref}+mZ+2m-z}.
\]

All these bounds survive restriction to a compatible Gauss sector, since the number projections commute with local gauge transformations. In the zero-source sector the pure-gauge ground state can be chosen gauge invariant: the elliptic compact-group heat kernel is positivity improving, so its unique positive ground state is gauge invariant. Tensoring it with the filled on-site negative sea realizes `E_ref` for `H_d`.

What this does not prove:

1. `H_d` is not the full Hamiltonian: `dGamma(alpha.v)` mixes pair sectors.
2. The threshold is relative to `E_ref`, not the interacting vacuum energy.
3. If the charged no-pair ground energy is `E_ref+mZ+delta_nu`, its separation from the lower bound on the pair block is only `2m-delta_nu`. There is no automatic uniform global gap for arbitrarily many nuclei from this inequality.
4. The subspace containing all no-pair gauge excitations is unbounded above, so the inequality does not separate its entire spectrum from the pair spectrum.

The result is a concrete reference estimate for an energy-restricted Feshbach argument. Controlling the full pair block after virtual-pair dressing is still needed.

## 4. A useful exact bound for dressing the electric energy

Let `S` be a bounded anti-Hermitian operator, a finite sum of local fermion hoppings with link multipliers. Suppose `[S,E_l]` is bounded for every link, and put

\[
b_l=\|[S,E_l]\|.
\]

Then `e^S` preserves the form domain of the electric Hamiltonian and

\[
e^S E_l e^{-S}=E_l+B_l,
\qquad
B_l=\int_0^1e^{sS}[S,E_l]e^{-sS}\,ds,
\qquad \|B_l\|\le b_l.
\]

Therefore, for every `epsilon>0` and every vector in the electric form domain,

\[
\boxed{
\left|\langle\psi,(e^SH_Ee^{-S}-H_E)\psi\rangle\right|
\le \epsilon\langle\psi,H_E\psi\rangle
+c(1+\epsilon^{-1})\sum_l b_l^2\,\|\psi\|^2.
}
\]

Proof: expand `||E_l psi+B_l psi||^2-||E_l psi||^2` and use `2xy<=epsilon x^2+epsilon^{-1}y^2`, then sum links. The conjugation identity follows by integrating the commutator and is first checked on the smooth core. Bounded commutators extend it to the form domain.

For one pair hop `A=tUF` with `||F||<=1` and `S=(A-A^*)/(2m)`, one has `b_l<=|t|/m`. For a local sum, a bounded number of terms touches each link, so the same scale holds with a coordination constant.

This avoids a false operator-norm estimate and keeps the electric term under rigorous form control. Its scalar remainder is proportional to the **number of affected links**, which is volume-sized for a dressing applied throughout the vacuum. It does not establish a nucleus-sized error. Higher-order effective terms and the low-energy states' electric moments must still be controlled.

## 5. Why vacuum subtraction does not automatically remove the volume

Suppose an SW theorem establishes `|E_exact(nu)-E_eff(nu)|<=C N epsilon^(k+1)` and the corresponding vacuum estimate. Subtracting these inequalities gives at best

\[
|[E_{\rm exact}(\nu)-E_{\rm exact}(0)]
-[E_{\rm eff}(\nu)-E_{\rm eff}(0)]|
\le 2CN\epsilon^{k+1}.
\]

Locality of the remainder by itself does not improve the factor `N` to `Z+K`. Virtual pairs occur throughout the vacuum. Moreover a source-independent local gauge operator is not necessarily a scalar: its expectation can change in the sourced ground state, so its energetic contribution does not cancel merely because the operator is the same.

A sufficient useful target would be a dressed relative form estimate of the type

\[
|R_{\rm matter}|\le\eta N_e
\]

on a no-positron effective sector, with the gauge-vacuum remainder retained or separately controlled in *differences* of sourced and unsourced energies. Since `N_e=Z` there, this genuinely gives a charge-sized error. Establishing this requires more than the standard linked-cluster statement: one must control the source dependence of the omitted vacuum/gauge terms or prove a defect/relative-energy cluster theorem.

The mass does not gap the photon sector. At couplings in a Coulomb phase, uniform exponential clustering of the entire gauge vacuum cannot simply be assumed. Conversely, a strong-coupling globally gapped expansion is not automatically the atomic Coulomb regime.

## 6. What the cited SW results actually supply

Bravyi–DiVincenzo–Loss formulate their lattice result for finite-dimensional local Hilbert spaces, on-site unperturbed terms and bounded local perturbations. Their Theorem 3 gives a truncation energy error `O(N |epsilon|^(n+1))`, with `N` the number of spins/sites. It is not an `O(number of nuclei)` theorem and is not directly a theorem for untruncated compact electric rotors. See Sections 4.1 and 4.4 of [arXiv:1105.0675](https://arxiv.org/pdf/1105.0675).

Datta–Fernandez–Frohlich–Rey-Bellet do develop perturbative block diagonalization for highly degenerate lattice ground spaces. That is relevant methodology, not a verification of the present gauge constraints or remainder. The accessible author manuscript is [Low-Temperature Phase Diagrams II](https://webspace.science.uu.nl/~ferna107/papers/pert.pdf), Helv. Phys. Acta 69 (1996), 752–820.

For unbounded interactions, a closer technical reference is Del Vecchio–Frohlich–Pizzo, [arXiv:2108.13907](https://arxiv.org/abs/2108.13907). Their framework uses weighted norms and a gapped on-site reference with sufficiently small relatively bounded interactions. Those hypotheses need a new check here, particularly if the plaquette/gauge dynamics are retained exactly. This citation does not supply the missing theorem automatically.

## 7. Recommended next theorem

First specify the intended energy window and the effective gauge vacuum, keep the positive Wilson block exactly, and distinguish electron number from the total number of excitations. Prove a relative form estimate using the electric dressing bound above. Only then claim an effective Pauli Hamiltonian with an `O(Z+K)` comparison. Until this is done, the strongest defensible statement is a formal local heavy-mass expansion plus the exact reference threshold and weighted first-step control proved here.

The target error in the brief must also carry an energy scale. `(ma)^(-1)(Z+K)` is dimensionless in natural units; either state the energy units or include the appropriate prefactor.

## 8. Additional audit: vacuum thermodynamic-limit argument

The parent's proposed auxiliary-space cutting argument is sound at fixed `a,m,r,g^2`, with the following conventions:

* Open graphs use the graph-degree Wilson diagonal; cutting a link removes both its Wilson diagonal contribution and its hopping.
* Keep crossing-link electric rotors as independent factors, with ground energy zero. Remove crossing plaquettes.
* A two-site link acts on eight one-particle modes. Its norm is at most `r/a+1/(2a)`, and C5 pairing gives a second-quantized norm bound `(4r+2)/a`. Each link touches at most four plaquettes, each of norm at most `2/(g^2 a)`.

Thus a safe cost per cut link is

\[
B=(4r+2+8/g^2)/a.
\]

Tiling a large cube by side-`l` cubes cuts at most `3L^3/l` links, up to a boundary remainder. Bounded fixed-parameter energy density controls the remainder. Consequently the auxiliary open-box limit exists and obeys

\[
|e_\infty-E_{\rm open}(l)/l^3|\le 3B/l.
\]

Closing the outer periodic boundary costs at most `3B L^2`. The existing equality of periodic auxiliary and physical zero-source ground energies therefore transfers this same density limit to the physical periodic vacuum. No factorization of Gauss-constrained Hilbert spaces is used; auxiliary factorization is sufficient. This argument concerns vacuum energy density, not the thermodynamic limit of a finite-density nuclear energy difference.
