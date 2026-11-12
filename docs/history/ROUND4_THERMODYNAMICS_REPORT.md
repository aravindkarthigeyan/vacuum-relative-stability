# Round-four thermodynamic audit and new results

29 October 2026. Scope: the exact compact U(1), four-component spatial-Wilson Hamiltonian already defined in vacuum-relative-stability-paper/lattice.tex, at fixed a>0, g²>0, bare m≥0, r≥0. The new complete source file is vacuum-relative-stability-paper/thermodynamics.tex, with all new labels prefixed therm4- and section label therm4-section.

Only that new fragment and this report were authored in this task. The historical memorandum and existing paper sources were not edited. No new numerical tests or continuum claims are involved.

## Findings

1. **The round-three vacuum thermodynamic-limit proof is correct.** Its auxiliary-space cutting step retains every cut electric rotor as an independent free rotor. It does not estimate an unbounded electric operator in norm and does not factor the physical Gauss space. The physical-vacuum identification supplied by determinant domination is the decisive bridge.
2. **The round-three fixed-cell relative upper and lower bounds are correct**, including their displayed constant and the graph-degree Wilson boundary convention.
3. **A stronger unconditional result can be proved:** for each fixed admissible periodic source cell, the physical OPEN zero-exterior-flux energy density has a thermodynamic limit. One-sided almost-subadditivity is enough. This was not asserted in the round-three report.
4. **A periodic-source limit has not been proved here.** The exact constrained cutting identity exhibits an infimum over all integer cut fluxes. The periodic limsup is bounded above by the open limit; the reverse inequality remains a boundary-screening issue.
5. **The proposed boundary lemma is false without a zero-flux admissibility qualification.** There is an explicit period-two, charge-four example below. This does not refute the suitably restricted lemma on commensurate whole-cell boxes.
6. **Cut averaging is available rigorously, but does not itself repair Gauss sectors.** Any finite quadratic-flux coefficient in a valid boundary comparison would suffice; the brief's coefficient restriction is not needed after averaging. If direct absorption is used instead, the two incidences of each cut edge require a factor of two absent from the proposed restriction.

## Open Hamiltonian and boundary diagonal

For an internal edge e=(x,y=x+e_j), the one-particle contribution is

    h_e = α_j(conj(U_e)|x><y| − U_e|y><x|)/(2ia)
          + (rβ/2a)(|x>−U_e|y>)(<x|−conj(U_e)<y|).

The Wilson mass at boundary site x is m+r deg_Y(x)/(2a), not m+3r/a. Each Wilson edge block is positive in its spatial mass coefficient. Therefore M_Y≥m and the determinant/Gauss-projection theorem extends to every finite connected open rectangular graph:

    E_Y^op(η) ≥ E_Y^op(0) + m |Σ_Y η|,
    E_Y^op(0) = inf σ(H_Y^op on the auxiliary space).

An open sector is nonempty exactly when |Ση|≤2|Y|, because exterior electric flux is zero by this convention.

Set h_* = m+(3+6r)/a and B=(4r+2+8/g²)/a. An edge matrix has norm at most (2r+1)/(2a); its C5 pairing gives ||dΓ(h_e)||≤(4r+2)/a on the full fermion Fock space. Each edge meets at most four plaquettes, whose multipliers have norm at most 2/(g²a). Deleting n_c bounded edge/incident-plaquette interactions therefore costs at most B n_c in operator norm.

The associated electric terms c_E E_e², c_E=g²/(2a), are retained as independent L²(U(1)) rotor factors with ground energy zero. All block fermion Hamiltonians are even, so their unrestricted ground energies add under the graded tensor decomposition. This proves the bounded cutting lemma without an unjustified factorization of the physical space.

## Vacuum limit

Let e_op(n) be the auxiliary ground energy of an open n³ cube and E_0^per(n) the physical periodic vacuum energy. Cutting the open cube into ℓ³ cubes gives

    |e_op(kℓ) − k³ e_op(ℓ)| ≤ 3B(kℓ)³/ℓ.

For general n the remaining rectangles contain at most 3ℓ n² sites and satisfy uniform extensive energy bounds. Hence

    e_vac = lim e_op(n)/n³ = lim E_0^per(n)/n³

exists, is finite, and

    |e_vac − e_op(ℓ)/ℓ³| ≤ 3B/ℓ,
    |e_vac − E_0^per(ℓ)/ℓ³| ≤ 6B/ℓ.

The closing-links comparison adds only 3n² bounded link costs after adjoining free rotors. The equality of the auxiliary periodic minimum with the physical vacuum minimum is explicit. Physical energy density is e_vac/a³.

## Fixed-cell bounds and the absolute electric budget

Take a cubic cell of side p, volume V_c=p³, K_c labeled positive nuclei and charge Z_c≤2V_c. Rectangular periods can be replaced by a cubic supercell. Pick q_x^(c)∈{0,1,2} of total Z_c and an integer internal flow F with div F=ν−q^(c). A spanning tree constructs F. Write F_c=Σ F_e², μ=m+3r/a, ρ=Z_c/V_c.

Repeat the exact Gauss-compatible product trial state, putting every intercell link in its zero-electric state. For N_c repeated cells,

    E_ν^per ≤ −2μN + μZ_tot + c_E N_c F_c + 3N/(g²a),
    N=V_c N_c.

Consequently

    0 ≤ E_ν^per−E_0^per−mZ_tot ≤ C_cell K,
    C_cell = [3r Z_c +(6+6r+3/g²)V_c +(g²/2)F_c]/(a K_c).

The constant depends on the fixed cell, its density, and its chosen screening flow. It is not uniform over arbitrary isolated or dilute defects.

Every periodic source ground state has the **absolute**, extensive budget

    <H_E> ≤ A_c N,
    A_c = 2(h_*−μ)+μρ+c_E F_c/V_c+3/(g²a).

This follows from H_B≥0 and dΓ(h_W)≥−2h_*N, together with the trial upper bound. It is not a vacuum-relative estimate of electric excitations.

## New open-source thermodynamic limit

Let E_ν^op(n) mean the source energy in an open n³ cube with zero exterior flux, for n divisible by p. Take products of physical block ground states and put every added link in E=0. The product obeys all Gauss constraints in the joined box. Then

    E_ν^op(kℓ) ≤ k³ E_ν^op(ℓ)+3B(kℓ)³/ℓ.

For n and ℓ divisible by p, the boundary remainders are unions of full admissible cells; their trial energies are uniformly extensive. Thus

    limsup_n E_ν^op(n)/n³ ≤ E_ν^op(ℓ)/ℓ³+3B/ℓ

for every fixed compatible ℓ. Let γ be the infimum of the right side over compatible ℓ≥3. Its definition also gives E_ν^op(n)/n³+3B/n≥γ. Hence

    e_ν^op = lim E_ν^op(n)/n³
           = inf_ℓ [E_ν^op(ℓ)/ℓ³+3B/ℓ].

One-sided almost-subadditivity suffices; no flux gluing estimate is used. No two-sided finite-size rate is asserted for this source sequence.

Closing an open box with E=0 links gives the unconditional bracket

    e_vac+mρ ≤ liminf E_ν^per(n)/n³
              ≤ limsup E_ν^per(n)/n³ ≤ e_ν^op.

Thus the OPEN relative energy per nucleus has limit (V_c/K_c)(e_ν^op−e_vac). A fixed infinite-lattice species self-energy simply shifts the limit. The periodic Green diagonal also converges to its infinite-lattice value: singular Fourier Riemann sums have a uniform O(δ) bound within |k|≤δn, with ordinary Riemann convergence outside.

## Exact flux-sector decomposition and counterexample

For cut edges C with assigned orientation, let f∈Z^C and b_B(f) be the signed outgoing flux function at each block boundary site. The exact cut-Hamiltonian minimum in the original physical source sector is

    inf_f [ Σ_B E_B^op(ν|_B−b_B(f)) + c_E Σ_(e∈C) f_e² ].

The original source minimum differs by at most B|C|. Inadmissible block-sector energies are +∞. Diagonalizing the retained free cut rotors and imposing Gauss law at each fixed flux proves the formula. It is stronger than replacing each block by its unrestricted vacuum.

Counterexample: ν_x=4 on even x_1 layers and 0 on odd layers. An even torus has admissible mean charge 2/site. An odd ℓ-cube starting on an even layer has source total 2ℓ³+2ℓ², so its zero-flux sector is empty. Nevertheless q_x=2 everywhere and internal E_(x,1)=(-1)^(x_1), E_(x,2)=E_(x,3)=0 define a finite-energy state with outward flux +1 on both x_1 faces. Hence E_B^op(ν−b(f)) is finite but E_B^op(ν)=+∞. No finite area-plus-flux-square error can give the unrestricted comparison. Nuclear charge four lies within the requested range.

## Averaging and the remaining conditional step

For complete-cell boxes, assume

    E_B^op(ν−b(f)) ≥ E_B^op(ν)
       − C_boundary |boundary-link incidences|
       − C_f Σ_boundary-incidences f_e²,

with constants independent of side and boundary flux, when the left sector is admissible. This is hypothesis (BF), not a proved property.

Average cut grids over translations by whole cells. For n divisible by ℓ, each link is cut with probability at most p/ℓ. The electric budget gives a grid with

    <Σ_cut E_e²> ≤ p A_c n³/(c_E ℓ).

Every cut edge occurs twice in the block boundary sums. Therefore

    E_ν^per(n)/n³ ≥ E_ν^op(ℓ)/ℓ³
       − (3B+6C_boundary)/ℓ
       − (2C_f−c_E)_+ p A_c/(c_E ℓ).

For general compatible n, remainders contain O(ℓn²) sites; averaging the global origin gives cut probability ≤p/ℓ+p/n. Apply (BF) only to full cubes and the absolute lower bound to remainders. The same liminf bound results as n→∞ at fixed ℓ. Sending ℓ→∞ would prove the periodic limit equals the open limit.

Thus **any finite C_f suffices after averaging**. Direct absorption instead requires 2C_f≤c_E with this incidence convention, not merely C_f<c_E. The squared cut flux is counted twice.

The averaging estimate is proved; (BF) is not. Existing Gaussian domination plus the cell upper bound only gives an O(block volume) substitute, which does not close the argument. No claim is made that (BF) fails on the admissible commensurate class; it remains an unresolved screening input.

## Primary sources and applicability

- Christian Hainzl, Mathieu Lewin, and Jan Philip Solovej, *The Thermodynamic Limit of Quantum Coulomb Systems. Part I. General Theory*, **Advances in Mathematics 221** (2009), 454–487. [DOI 10.1016/j.aim.2008.12.010](https://doi.org/10.1016/j.aim.2008.12.010), [arXiv:0806.1708](https://arxiv.org/abs/0806.1708).
- The same authors, *Part II. Applications*, **Advances in Mathematics 221** (2009), 488–546. [DOI 10.1016/j.aim.2008.12.011](https://doi.org/10.1016/j.aim.2008.12.011), [arXiv:0806.1709](https://arxiv.org/abs/0806.1709). Theorem 2 states the Graf–Schenker averaged Coulomb inequality. Its crystal application concerns nonrelativistic quantum electrons and classical nuclei; it does not resolve compact integer Gauss sectors.
- Gian Michele Graf and Daniel Schenker, *On the molecular limit of Coulomb gases*, **Communications in Mathematical Physics 174** (1995), 215–227. Metadata verified in Hainzl–Lewin–Solovej's primary reference list and Graf's institutional publication list. Coulomb localization motivates averaging but is not itself hypothesis (BF).
- Sergey Bravyi, David DiVincenzo, and Daniel Loss, *Schrieffer-Wolff transformation for quantum many-body systems*, **Annals of Physics 326**, no. 10 (2011), 2793–2826. [DOI 10.1016/j.aop.2011.06.004](https://doi.org/10.1016/j.aop.2011.06.004), [arXiv:1105.0675](https://arxiv.org/abs/1105.0675). Verified metadata; its local spin-lattice perturbation theorem does not already give an untruncated-rotor, source-relative reduction.
- M. P. Fry, *Stability of QED*, **Physical Review D 84** (2011), 065021, published 19 September 2011. [DOI 10.1103/PhysRevD.84.065021](https://doi.org/10.1103/PhysRevD.84.065021), [arXiv:1108.4345v2](https://arxiv.org/abs/1108.4345), revised 11 June 2012. Section IV explicitly identifies the assumed continuum diamagnetic limit and assumed asymptotic Pauli heat-kernel expansion. This is conditional determinant-growth evidence in a restricted static-field class, not a no-go theorem for the present Hamiltonian bound.

No source is used to claim novelty. The new fragment contains deductions in the specified lattice model. In particular the open-source result and conditional periodic statement are not attributed as existing theorems for the cited Coulomb models.
