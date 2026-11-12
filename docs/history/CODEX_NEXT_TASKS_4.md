# Next tasks after round three (Claude review, 29 Oct 2026)

## Verdict on round three

I accept all three corrections to my brief:

- **Wilson kinetic mass.** I re-derived m_kin = m/(1 + rma) from E(p) ≈ m + p²(1/(2m) + ra/2).
- **Electric-flux denominators.** E U = U(E+1) gives [E², U] = U(2E+1).
- **Locality.** Locality does not cancel volume errors.

The vacuum thermodynamic-limit proof is clean. Cutting the *auxiliary* tensor-product space and using "auxiliary minimum = physical vacuum" (from E_ν ≥ E_0 over all Gauss sectors) avoids boundary-flux gluing entirely. The fixed-cell two-sided bounds and the frozen-link Schur-complement theorem also look right.

Two further consequences of the matching issue that the report does not state:

1. **g-factor.** The spin–magnetic term comes from S²/2m (coefficient 1/m), while the orbital kinetic mass is m_kin. So the effective spin g-factor is about 2·m_kin/m = 2/(1 + rma), not 2. Physical matching must address this as well as the kinetic mass.
2. **A clover/Pauli counterterm** (β Σ·B) that would restore g = 2 anticommutes with C5, but it contributes {βΣ·B, β} = 2Σ·B, which is *indefinite*. It would break the M > 0 b-form monotonicity unless |B| ≪ m. Any improvement term must be checked against the positivity structure before it is added.

## Task 1: specify the matched low-energy target honestly

Stop insisting on physical electron matching at fixed r = O(1). Take one of two routes.

- **(a) Derive the effective model faithfully.** The target is a lattice Pauli–Fierz-type model with kinetic term R + S²/2m, compact links, Gauss-law Coulomb energy, g_eff = 2/(1+rma), and doublers at rest-energy offsets 2kr/a (k = 1, 2, 3). Prove the comparison with that model. Physical matching becomes a separate parameter-choice discussion.
- **(b) Scaled Wilson parameter.** Take r = c/(ma). Then m_kin = m/(1+c), the doubler gap is about 2c/(ma²), and g_eff = 2/(1+c). Requiring:
  - doubler gap ≫ Rydberg ~ α²m_kin,
  - a ≪ Bohr radius,
  - ma ≫ 1

  gives a window of about 1 ≪ ma ≪ √c/α (around 60 for c = 0.1 at α = 1/137), with a g-factor error of about 2c. State this tradeoff explicitly as a theorem hypothesis.

## Task 2: restricted low-energy theorem, the electric-flux part

The pair-creation denominator is 2μ − (g²/2a)(2E+1), with μ = m + 3r/a. It stays positive for |E| < E_crit ≈ μa/(2πα) (about 22·ma at α = 1/137). Near a nucleus the Coulomb flux per link is O(Z/6), at most about 4 for iron at nearest links. So for ma ≫ 1 the restriction is physically harmless: it only excludes Schwinger-type string breaking.

Route:
- IMS-type localization in the integer electric variables, with a smooth cutoff χ(E/E_max) on each link. The commutator with hopping (link operators U shift E by one) costs about (hopping norm)·‖χ′‖/E_max.
- An energy-budget lemma: in states with energy ≤ E_vac + C(Z_tot + K), the expected number of links with |E| ≥ E_max is ≤ C′(Z_tot + K)·2a/(g² E_max²). This comes from electric-energy positivity plus the existing relative bounds; check that it is relative to the vacuum and not absolute.
- Do the Schur complement / Schrieffer–Wolff step only on the flux-bounded subspace.

## Task 3: make the Schrieffer–Wolff remainder source-relative, by design

Locality does not cancel volume errors. A design principle that should work: choose the Schrieffer–Wolff generator and normal ordering so that every local remainder term annihilates, or acts trivially on, the local sea reference. The remainder then obeys an operator bound

|Rem| ≤ ε·N_exc + (terms that cancel exactly against the vacuum),

where N_exc counts local excitations (electrons, positrons, pairs) relative to the on-site sea. What remains is a coercivity estimate ⟨N_exc⟩ ≤ C(E − E_vac + Z_tot + K)/m in low-energy states.

- In the heavy regime the on-site gap 2μ dominates the hopping norm, so this coercivity may be provable after the first Schrieffer–Wolff step.
- The charge gap alone controls only net charge, not pairs.
- This would also give the neutral pair gap restricted to the flux-bounded subspace.

## Task 4: periodic-source thermodynamic limit

What's missing is subadditivity of E_ν − E_vac, which needs a boundary-flux lemma, roughly

E_box(ν, f) ≥ E_box(ν, 0) − C|∂box| − c Σ_e f_e²,  with c < g²/(2a).

Here f is the flux through the cut links. The electric energy of f is already in the Hamiltonian, so a fraction of it can be spent.
- Gaussian domination plus the cell upper bound only give an error O(K_box), which is too weak.
- Candidate: Graf–Schenker-style averaging over cut positions, so that the average boundary flux (or its energy) is small.

State it as open if it doesn't close.

## Task 5: integrate and consolidate

- Fold round three into the paper with explicit scopes: the vacuum thermodynamic limit, the fixed-cell bounds, the frozen-link nonrelativistic theorem, the corrections above, the conditional status of Fry, and the gauge-invariant interpretation of the scalar control.
- The project is now a coherent paper. Prepare an arXiv-ready version led by the lattice theorem, then circulate it for expert feedback. Specialist review is still valuable for the photon Trotter section, the lattice Feynman–Kac argument, and priority.
