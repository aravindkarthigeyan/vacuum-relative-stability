# Next tasks after the Gaussian-domination paper (Claude review, 28 Oct 2026)

## Review verdict on `photon-free-relative-stability-paper/`

I re-derived the photon-free core and checked it independently. The relevant pieces are Lemma 2.1 (Wick rewrite), Lemma 3.1 (positive centered trace) and Theorem 4.1 (canonical Gaussian domination, GD). I believe they are correct.

**Lemma 3.1.**
- C5 = a1a2a3b is Hermitian, squares to 1, anticommutes with every Dirac matrix, and commutes with the scalar kicks.
- Hence U†C5U = C5, so det(1+U) is real after the phase e^{iΣTrΦ/2}.
- With M > 0, the b-form strictly decreases along free intervals, so U has no unimodular eigenvalues and −1 is excluded.
- The C5-pseudo-unitary spectrum is paired as λ ↔ 1/λ̄. This gives a second way to see positivity: with no unimodular eigenvalues, det(1+U) = phase × Π|1+λ|²/λ̄.

**Theorem 4.1.** The HS identity is componentwise, the charge projection is a scalar kick, and the absolute-value bound is legitimate.

**Independent numerics** (`numerics2/claude_gd_random_check.py`).
- On random 8-mode instances (256-dim Fock space), E_q(η) − E_0(0) ≥ 0 held in every trial, across all sectors and sources.
- Adding a spin-scalar term to h breaks it (difference ≈ −0.91). The structural hypothesis is therefore essential, not cosmetic.

**Not yet independently checked:** the photon extension (Trotter with unbounded coordinates, truncation removal, form limit). It is the riskiest part and should get a line-by-line audit.

## Task A: harden and position the main theorem (do first)

1. Audit `photon-extension.tex` line by line, especially:
   - the trace-norm Trotter lemma;
   - uniformity of the coordinate truncation in the charge sectors;
   - the quadratic-form limit.
2. Restate the headline physically: *static nuclei, together with their own regularized Coulomb self-energy, can never lower the energy below the interacting vacuum.* The −C_Λ K is exactly the band self-energy (α/2)Z²κ plus the heat-kernel mismatch. Also state the corollary E_q ≥ E_0: the neutral vacuum is the global ground state over all charge sectors.
3. Literature positioning, with no priority claim on the mechanism, only on its application:
   - **Euclidean positivity:** for single-flavour QED with vector couplings the fermion determinant is positive. The Wilson-loop bound |⟨W⟩| ≤ 1 gives static-potential bounds (Seiler, PRD 18, 482 (1978)).
   - **Gaussian domination:** Fröhlich–Simon–Spencer; Miyao (already cited).
   - **Sign-problem-free QMC criteria:** Wei–Wu–Li–Zhang–Xiang, "Majorana positivity and the fermion sign problem", PRL 116, 250601 (2016), arXiv:1601.01994; Li–Jiang–Yao (2016).

   Lemma 3.1 is a pseudo-unitary (C5 / Krein-signature) positivity criterion of this family. Compare explicitly.

## Task B: enlarge or remove the cutoff window

The window 13αΛ < π²m comes from the crude bound m/E(r) ≤ 1 in M_eff (eq. 2.5).

1. **Density-product ordering has no window.** If the Coulomb term is the positive density-product form (Lieb–Siedentop's "physically motivated" choice), then h_eff = D_0. GD then holds for all α, Λ, L, and Theorem 2.1/2.2 follow without any mass condition (only the constants change). Write this as a corollary. It answers "physical α unless smallness is necessary": for that ordering, no smallness is needed.
2. **Sharp window for free-sea Wick ordering.** The deficit is (α/2V)Σ 4π/|p−r|² · m/E(r). Its continuum value at p = 0 is (α m/π)·arcsinh(Λ/m), and by Riesz rearrangement p = 0 is the maximum. Lattice sums (`numerics2/claude_meff_lattice_sum.py`) give deficit/(αm) ≈ 0.83, 0.98, 1.01 at p = 0 for Λ/m = 10, 30, 100 (at L = 36π/Λ), versus the crude 13Λ/π² = 13, 40, 132.
   - Prove a lattice Riemann-sum bound for this singular convolution, uniform in L.
   - Result: the window becomes (α/π)·arcsinh(Λ/m) + O(lattice error) < 1, i.e. Λ ≲ ½ m e^{π/α} ≈ 10^186 m at α = 1/137.
   - Physically, this is the scale where the instantaneous-Coulomb mass renormalization flips the sign of the mass.
3. **Conjecture: the mass condition is unnecessary.** In random tests GD never failed with M = 0 or with M indefinite (`numerics2/claude_gd_indefinite_mass.py`; minimum margin ≈ +0.6). Only spin-scalar terms broke it.
   - Try to prove that GD survives unimodular eigenvalues. Candidate routes: a Krein-signature argument that det(1+U) cannot change sign; or limits of strictly massive cases plus continuity of ground energies (GD is a closed condition in the parameters).
   - Taking M → 0⁺ would already give M ≥ 0. Indefinite M needs more.

## Task C (highest new value): port GD to gauge-invariant Hamiltonian lattice QED

The sharp momentum cutoff breaks gauge invariance (the L⁵ and Ward pathology, Sections 9 and 14 of the memo). On a Kogut–Susskind lattice with Wilson fermions, every structural hypothesis of Lemma 3.1 appears to hold:

| Ingredient | Why it fits Lemma 3.1 |
|---|---|
| Wilson term | ψ†b(m + r·Σ(1 − Re U-hopping))ψ is part of M⊗b, and M ≥ m because the covariant lattice Laplacian is ≥ 0. No window. |
| Link hopping | ψ†a_j U_xy ψ_y gives Hermitian spatial coefficients v_j(U). |
| Gauss-law projection with static charges | ∫Π dθ_x e^{iθ_x(G_x − ν_x)}: the θ_x are local scalar kicks (the A₀ field). |
| Electric energy | E²/2 has a positive heat kernel in the link-variable representation (on U(1) or R). |
| Magnetic plaquette term | A real function of the link variables, so a positive weight. |

Expected theorem: for gauge-invariant lattice QED with Wilson fermions, point nuclei at sites, exact Gauss law and any coupling,

E(ν) + Σ_i (lattice self-energy of nucleus i) ≥ E_vac.

Hence E(ν) − E_vac ≥ −C K with C ≈ (α/2)Z_max²·G_lat(0)/a. In this setting:
- H ≥ −C·(number of sites) is elementary, so extensivity and relative stability hold together in a gauge-covariant model;
- there is no photon-mass counterterm and no window.

Check carefully:
- the Gauss-law sector bookkeeping, with temporal gauge and boundary-flux sectors on the torus;
- reality of the determinant with complex link phases (C5 commutes with the scalar U(1) phases, so it should go through);
- positivity of the full path-integral weight in the U-representation.

## Task D: a charge-gap theorem (feeds the Feshbach program)

Conjecture: E_q(0) − E_0(0) ≥ (inf M_eff)·|q|. Adding charge to the interacting vacuum costs at least the effective mass per unit charge.
- Toy numerics (`numerics2/claude_charge_gap_toy.py`): min (E_q − E_0)/(m|q|) ≈ 1.77 > 1 over 40 random instances.
- Route: make the b-contraction quantitative. Each free interval contracts the b-form by at least e^{−2M_min s}. Combine this with the e^{iθQ} projection to get Tr_{Q=q} e^{−βH} ≤ e^{−β m|q|}·Tr_{Q=0} e^{−βH}.
- A charge gap is not yet a pair-sector gap, but it is the first uniform spectral statement about the interacting vacuum. That is exactly what the memo's Feshbach section lacks.

## Task E: then
- Thermodynamic limit of E(R,Z) − E_vac per nucleus for periodic nuclear arrays: subadditivity plus matching upper bounds. Note that E_vac itself has no density in the sharp-cutoff massless model; on the lattice (Task C) it does.
- Atoms: binding and ionization bounds, using E_q ≥ E_0 and GD with sources.
- Cutoff-uniform constants: GD's cost is the unscreened band self-energy, so a Λ-uniform renormalized theorem needs electron screening (Lieb–Yau). GD alone cannot give it. Record this as a proved limitation of the method.

## Housekeeping
- Make `photon-free-relative-stability-paper` the primary document. Mark the superseded "open" statements in the 72-page memo.
- Folder name: the new paper includes photons, so the "photon-free" folder name is misleading.
