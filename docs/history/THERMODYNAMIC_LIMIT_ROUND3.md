# Vacuum thermodynamic limit and periodic-source bounds

29 October 2026. New derivation for the compact Hamiltonian Wilson model in
`vacuum-relative-stability-paper/lattice.tex`. This is a proof within that
specified model, conditional on the already established finite-volume
comparison identifying the unrestricted periodic ground energy with the
physical zero-source ground energy. It is not a novelty claim.

## 1. Statement

Fix \(a>0,\ g^2>0,\ m\ge0,\ r\ge0\). Write \(E_0^{\rm per}(L)\)
for the physical vacuum ground energy on an \(L^3\) periodic lattice.
Then the finite limit
\[
 e_{\rm vac}=\lim_{L\to\infty}\frac{E_0^{\rm per}(L)}{L^3}
\]
exists. The electric rotors are untruncated. No weak-coupling or
neutral-pair-gap assumption is needed.

Define the unrestricted open-cube Hamiltonian by retaining all internal
links and internal plaquettes and using the **graph-degree Wilson
diagonal**, namely
\[
 M_{\rm op}=m+\frac r{2a}\sum_{\{x,y\}\ {\rm internal}}
 (|x\rangle-U_{xy}|y\rangle)
 (\langle x|-\bar U_{xy}\langle y|),
\]
with the same link convention as the main paper. Each link contributes the positive
two-site block with diagonal \(1,1\) and off-diagonals
\(-\bar U,-U\). At a boundary site the diagonal is
\(m+r\,\deg(x)/(2a)\), not the periodic value \(m+3r/a\).

Let \(E_{\rm op}(l)\) denote its unrestricted ground energy, and set
\[
 B=\frac{4r+2+8/g^2}{a}.
\]
Then
\[
 \left|e_{\rm vac}-\frac{E_{\rm op}(l)}{l^3}\right|
 \le \frac{3B}{l},
 \qquad
 \left|e_{\rm vac}-\frac{E_0^{\rm per}(l)}{l^3}\right|
 \le \frac{6B}{l}
\]
for integer \(l\ge3\). These constants are deliberately nonoptimal.
Physical energy per spatial volume is \(e_{\rm vac}/a^3\).

## 2. Why Gauss's law does not obstruct this proof

The physical Hilbert space does not factor over boxes. We do not
assume it does.

Instead, cut the **auxiliary** tensor-product Hilbert space, before
imposing Gauss's law. The finite-volume positivity theorem gives
\[
 \inf\sigma(H_{\rm per})=E_0^{\rm per}
\]
because the auxiliary space is the direct sum of Gauss sectors, every
source-sector ground energy is at least \(E_0^{\rm per}\), and the
vacuum sector is present. The theorem is used only on the periodic
lattices.

The open-box ground energies used for the comparison need not be
identified with any prescribed boundary-flux physical sector. This
avoids an unproved boundary-flux gluing step.

## 3. Cost of one removed link

Write the fermionic Hamiltonian as its on-site \(m\beta\) term plus
link contributions. On the eight-dimensional one-particle space of
the two endpoints, a link matrix \(h_e\) consists of:

* a Wilson block of norm \(r/a\);
* a Dirac hopping block of norm \(1/(2a)\).

Thus
\[
 \|h_e\|\le \frac{2r+1}{2a}.
\]
The constant spin matrix \(C_5\) anticommutes with \(h_e\). Its
eigenvalues therefore occur in opposite pairs, and the full Fock-space
second quantization obeys
\[
 \|d\Gamma(h_e)\|
 =\frac12\operatorname{Tr}|h_e|
 \le4\|h_e\|
 \le\frac{4r+2}{a}.
\]
There is no volume factor in this link estimate.

A plaquette multiplier has norm at most \(2/(g^2a)\).
Every link is incident to at most four plaquettes in three dimensions.
Consequently removing a set of \(n_c\) crossing links and every
plaquette touching those links changes the bounded part of the
Hamiltonian by norm at most \(Bn_c\). Counting a plaquette more than
once only enlarges this bound.

The electric term on a cut link is not discarded in the comparison:
it is retained as an independent free rotor
\(g^2E_e^2/(2a)\), whose ground energy is zero. Therefore cutting
does not require a norm bound on the unbounded electric operator.

All fermion Hamiltonians involved are even. Their operators on
disjoint boxes commute, and the Fock-space tensor decomposition makes
their unrestricted ground energies additive.

## 4. Almost additivity and the limit

If \(L=kl\), partition the open \(L\)-cube into \(k^3\) open \(l\)-cubes.
There are
\[
 n_c=3(k-1)L^2\le3L^3/l
\]
crossing links. The variational principle and the bounded comparison
give
\[
 \left|E_{\rm op}(L)-k^3E_{\rm op}(l)\right|
 \le3B L^3/l.
\]

For arbitrary \(L\), tile by full \(l\)-cubes and the remaining rectangular
boundary boxes. At fixed \(l\), the remaining boxes contain \(O(lL^2)\)
sites. Their unrestricted energies have uniform extensive bounds.
For example, with
\(h_*=m+(3+6r)/a\),
\[
 -2h_*|X|\le E_{\rm op}(X)\le3|X|/(g^2a).
\]
The upper estimate uses zero electric flux and the two occupied
negative-\(\beta\) spinors at every site; discarding its negative
fermion expectation only weakens the estimate.
Hence the remainder divided by \(L^3\) vanishes as \(L\to\infty\).
The number of crossing links is still at most
\(3L^3/l+O(L^2)\). Therefore, for every fixed \(l\),
\[
 \frac{E_{\rm op}(l)}{l^3}-\frac{3B}{l}
 \le\liminf_{L\to\infty}\frac{E_{\rm op}(L)}{L^3}
 \le\limsup_{L\to\infty}\frac{E_{\rm op}(L)}{L^3}
 \le\frac{E_{\rm op}(l)}{l^3}+\frac{3B}{l}.
\]
The limsup-liminf difference is at most \(6B/l\) for every \(l\),
and therefore vanishes.

Closing an open cube periodically adds \(3L^2\) links and the
plaquettes incident to them. Applying exactly the same comparison,
with free rotors first added on the closing links, yields
\[
 |E_{\rm aux}^{\rm per}(L)-E_{\rm op}(L)|\le3BL^2.
\]
The physical periodic vacuum has energy
\(E_0^{\rm per}(L)=E_{\rm aux}^{\rm per}(L)\). This completes the
proof, including the finite-size estimates in Section 1.

## 5. Two-sided relative bounds for a fixed periodic nuclear cell

This is weaker than existence of a source thermodynamic limit, but
settles the preliminary two-sided extensivity question for any fixed
admissible cell.

Let a connected finite cell, whose replicas tile the periodic cubic lattice
(for example a rectangular supercell), have \(V_c\) sites, \(K_c\ge1\) labeled
nuclei, total positive nuclear charge \(Z_c\le2V_c\), and integer
source \(\nu_x\). Choose \(q_x\in\{0,1,2\}\) with
\(\sum q_x=Z_c\). Choose an integer flow \(F\) on internal cell links
with
\[
 \operatorname{div}F=\nu-q,\qquad
 \mathcal F_c=\sum_{e\ {\rm internal}}F_e^2.
\]
Such a flow exists by routing the zero-sum integer divergence on a
spanning tree. It has no flux through the cell boundary.

Repeat the cell \(N_c\) times and put every inter-cell link in the
zero-electric-flux state. Occupy the two negative-\(\beta\) spinors
at each site and \(q_x\) positive-\(\beta\) spinors. This product
state satisfies every Gauss constraint exactly. Hopping expectations
vanish. On a periodic cubic lattice set
\(\mu=m+3r/a\). The trial energy satisfies
\[
 E_\nu\le-2\mu N+\mu Z_{\rm tot}
       +\frac{g^2}{2a}N_c\mathcal F_c
       +\frac{3N}{g^2a},
 \qquad N=V_cN_c,\quad Z_{\rm tot}=Z_cN_c.
\]
Combining with \(E_0\ge-2Nh_*\) and the existing charge-cost theorem gives
\[
 0\le E_\nu-E_0-mZ_{\rm tot}\le C_{\rm cell}K,
 \qquad K=K_cN_c,
\]
where
\[
 C_{\rm cell}=
 \frac{3rZ_c+(6+6r+3/g^2)V_c+(g^2/2)\mathcal F_c}{aK_c}.
\]
This upper constant is independent of the number of repeated cells,
but depends on the chosen cell, its density and its screening flow.
It is not a uniform estimate over arbitrary dilute configurations.

For the prescribed infinite-lattice self-energy subtraction
\[
 S_\infty=N_c\frac{g^2G_\infty(0)}{2a}\sum_{i\ {\rm in\ cell}}Z_i^2,
\]
subtract \(S_\infty\) from both sides of the relative inequalities.
This gives explicit two-sided per-nucleus bounds at fixed cell.

## 6. What remains open

The proof above does not establish existence of
\((E_\nu-E_0)/K\) for periodic nuclear arrays. In a source sector,
cutting into cells leaves correlated boundary electric fluxes and
charges. The auxiliary minimum is the vacuum, so replacing a
constrained block by its unrestricted minimum would lose the desired
source comparison. A controlled gluing/screening argument is still
required.

No statement here is uniform as \(a\to0\), nor does it establish
binding, a neutral-pair gap, a Coulomb phase, or a Pauli--Fierz
low-energy reduction.

