# Round-five plan (Claude review, 29 Oct 2026)

## Verdict on round four

I accept the corrections to my round-four brief:
- **Gauss's-law flux estimate.** A charge-26 site with at most two local electrons forces Σ_incident E² ≥ 24²/6 = 96, and circulations can raise flux arbitrarily. My "flux ≈ Z/6" heuristic was not an upper bound.
- **Window.** The "about 60" window was hydrogenic. For iron, both a ≪ 1/(Zα m) and a doubler gap ≫ (Zα)²m are needed, and that window is empty. Iron's K shell is not in a nonrelativistic lattice regime with ma ≫ 1.
- **The two counterexamples.** The bare flux-tail and bare pair-number budgets fail already at K = 0, because the vacuum has extensive virtual pairs and flux tails. Relative statements need dressed observables.

I also checked the new clover condition. C5 anticommutes with βΣ_j, since Σ_j is a product of two α's. The b-form derivative becomes −2⟨f,(M + λΣ·B)f⟩, so m_cl = m − ‖λΣ·B‖ ≥ 0 suffices. The argument is correct.

## Assessment

The program has reached a natural first-paper boundary. The proved core is:
- the lattice relative theorem with a charge gap;
- vacuum and open-source thermodynamic limits;
- the momentum-cutoff results and counterexamples.

What remains open is a dressed pair gap, a source-relative effective remainder, (BF), and cutoff-uniform screening. These are research problems with no estimate in sight. More rounds of the same kind will mostly add hedged sections.

## Priority 1: make the core machine-checkable (Lean 4 + mathlib)

The decisive lemmas are finite-dimensional linear algebra:
1. **C5 pseudo-unitarity.** U†C5U = C5 for products of e^{−sh} and scalar unitaries, where h anticommutes with C5.
2. **β-form monotonicity.** For M ≥ m* > 0, the β-form strictly decreases, so U has no unimodular eigenvalues and the annulus property follows (Gronwall).
3. **Spectral pairing.** λ ↔ 1/λ̄, with N stable eigenvalues.
4. **Fourier/Vandermonde bound.** |F_q| ≤ binom(2N, N+q) e^{−bm*|q|} F_0.
5. **Canonical comparison.** The absolute-value step Z_q ≤ binom·e^{−bm*|q|}·Z_0 in finite dimensions, with the Hubbard–Stratonovich identity stated as a hypothesis on a positive measure.

Formalizing 1–4 (and the finite-dimensional part of 5) is realistic and would add a lot of credibility for referees. Leave the Feynman–Kac and Trotter limits informal.

## Priority 2: split the 64-page draft

- **Paper A (about 15–20 pages, submit first):** the compact Wilson lattice theorem, E_ν ≥ E_0 + m|Σν| at every coupling, with the self-energy-subtracted O(K) bound, the vacuum thermodynamic limit, and the open zero-flux source limit. It should be crisp and self-contained.
- **Paper B:** the sharp-momentum-cutoff model. Include the L⁵ / Ward diagnosis, the counterterm theorem, the point-source UV counterexample, the exchange instability, Gaussian domination with photons and its windows, and density-product ordering.
- **Notes / companion:** the low-energy matching attempts, the clover condition, the frozen-link Schur theorem, and the obstructions. Useful, but not yet a theorem about dynamical QED.

## Priority 3: human steps (cannot be done by the agents)

- **Authorship.** arXiv's policy is that generative-AI tools cannot be authors. Human authors take full responsibility and should disclose tool use. A human must be the author and understand every claim; keep the tool-credit line as a disclosure.
- **External review.** Send Paper A to one or two specialists before posting. Pick people whose work it touches:
  - stability of matter and BDF: e.g. Lewin, Séré, Solovej, Frank, Seiringer, Siedentop;
  - Gaussian domination with photons: Miyao;
  - lattice and constructive QFT: Fröhlich, Seiler, Dimock;
  - sign-problem-free fermion positivity: Z.-X. Li, H. Yao.
- **Priority search by a human with library access**, focused on Hamiltonian lattice gauge theory static-charge bounds and the sign-free QMC positivity literature.

## Optional mathematics (only if continuing)

- **(BF)** in its weakest useful form: any finite C_f suffices after cell averaging. Try Gaussian domination on blocks with the boundary flux treated as an extra source.
- **A dressed pair gap for frozen links without Coulomb,** relative to the Dirac sea of h_W(U). First check whether |h_W(U)| ≥ m holds for arbitrary U; note that the cross term is [A,M]β, which is nonzero when M is not constant.
- **Cutoff-uniform screening:** the Gaussian-domination plus Lieb–Yau hybrid on the lattice. This is long-term.
