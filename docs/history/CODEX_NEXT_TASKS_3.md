# Next tasks after round two (Claude review, 29 Oct 2026)

## Review verdict on round two

**Charge gap (mass-gap.tex).** I re-derived the combinatorial step.
- For a centered twisted trace F(θ) = C·Π_j |1 + e^{iθ}λ_j|² with |λ_j| ≤ e^{−bm*}, the q-th Fourier coefficient is C·Σ_k e_{k+q} ē_k.
- Since |e_k| ≤ binom(N,k)·e^{−bm*k}, Vandermonde gives |F_q| ≤ binom(2N, N+q)·e^{−bm*q}·F_0.
- The prefactor does not depend on b, so E_q ≥ E_0 + m*|q| follows at zero temperature.

The proof is correct as written. The finite-temperature counterexample to the prefactor-free version is also correct.

**Gauge-invariant compact Wilson lattice theorem (lattice.tex).** All structural hypotheses check out:
- the Wilson term sits in M⊗β with M ≥ m, since 2 − T − T* = (I−T)*(I−T);
- the electric kernel is a positive wrapped Gaussian;
- the plaquette term is a real multiplier;
- the local Gauss projection acts through scalar site phases.

I also ran an **independent numerical check** of a 1+1D analogue (`numerics/claude_lattice_1d_gauss_check.py`). It uses an open Wilson chain with the Gauss law solved exactly and canonical charge sectors, over random a, m, r, g² and integer sources.
- E_ν − E_0 − m|Σν| ≥ 0 held in every nonzero-source case, with minimum margin 0.11.
- Control: adding a spin-scalar on-site potential breaks it (−1.68; script `claude_lattice_1d_scalar_control.py`).

I consider the lattice theorem the strongest result of the project. It answers the primary question (S) for a gauge-invariant regularization at **any** coupling, with no counterterm, no window and no L⁵ pathology. It also gives extensivity and a charge gap.

**Framing correction for the paper.** Lead with the lattice theorem. Present the momentum-cutoff results as the answer for the brief's literal regulator, with its ordering-dependent window and counterexamples. After subtracting the self-energy, the bound E_sub − E_vac ≥ mΣZ − S_n says "nuclei can recover at most their own regularized self-energy". The physically substantive statement is E_raw ≥ E_vac + mΣZ. Say this plainly.

## Task 1 (highest priority): low-energy reduction in the heavy-mass lattice regime

This is the largest unaddressed part of the original brief (effective Pauli–Fierz/Coulomb Hamiltonian with extensive error bounds, transferred back to QED). The lattice model makes it tractable.

- **Regime:** m·a ≫ 1, i.e. lattice spacing ≫ Compton wavelength. This is physically meaningful because atoms live on the Bohr scale a_B ≈ 137/m, so 1/m ≪ a ≪ a_B resolves atoms while staying nonrelativistic. Here the on-site β-mass term is a commuting, locally gapped Hamiltonian (local pair creation costs 2m + O(1/a)). The hopping (norm ~ 1/a, and ~ r/a for the Wilson part) is a small local perturbation relative to that gap. The electric and plaquette terms commute with the on-site mass term.
- **Tool:** a quasi-local Schrieffer–Wolff transformation with extensive error control. References: Datta–Fernández–Fröhlich–Rey-Bellet (1996), *Low-temperature phase diagrams of quantum lattice systems II*; Bravyi–DiVincenzo–Loss (2011), *Schrieffer–Wolff transformation for quantum many-body systems*, Ann. Phys. 326. The new feature is the unbounded electric term. It commutes with the unperturbed mass term but not with hopping, which carries link operators U. Check whether the SW generator can be built from fermion hopping only, keeping E² exact.
- **Target theorem:** for m·a ≥ M_0 (explicit), two-sided bounds
  | [E(ν) − E_vac] − [m·Z_tot + E_NR(ν)] | ≤ C·(ma)^{−1}·(Z_tot + K).
  Here E_NR is the ground energy of an explicit lattice nonrelativistic electron model: a Pauli-type kinetic term with Peierls links, the same compact gauge field, Gauss-law Coulomb, and spin–field terms at order 1/m. Virtual pairs enter as explicit effective operators at order (ma)^{−2}.
- **Key point:** errors must be relative (vacuum terms cancel locally), not extensive in volume. Local SW gives a sum of local terms, so the vacuum part should cancel site by site away from electrons. Make this precise.
- **Payoff:**
  - lattice NR stability, E_NR ≥ −C(Z_tot+K), transfers back with errors O(K);
  - a neutral pair-sector gap emerges in this regime;
  - this is exactly the Feshbach input the memo said was missing.

## Task 2: thermodynamic limit on the lattice

- **(a) Vacuum energy density.** Prove lim E_vac/N exists for compact Wilson QED. H is a sum of local terms plus local Gauss constraints, and H ≥ −2N·h* and the upper bound are already proved. Use subadditivity, keeping the boundary electric-flux sectors when gluing (Donnelly 2014).
- **(b) Relative energy per nucleus** for periodic nuclear arrays: two-sided bounds first (lower from GD plus the charge gap, upper from trial states), then existence via Lieb–Lebowitz-type subadditivity with neutrality and screening. State honestly whether the Gauss-law Coulomb tail blocks subadditivity.

## Task 3: priority and literature check, then external review

The mechanism (C5-pseudo-unitary determinant positivity plus Gaussian domination plus a Gauss/charge-twist character bound) is close to several literatures. Check each explicitly before any novelty statement:
- **Sign-problem-free QMC criteria:** Wu–Zhang (2005, time-reversal); Wang–Liu–Iazzi–Troyer–Harcos (2015, split orthogonal group); Wei–Wu–Li–Zhang–Xiang (2016, Majorana positivity); Li–Jiang–Yao (2016).
- **Lieb's flux-phase / reflection-positivity papers** for fermions coupled to gauge fields.
- **Static-charge positivity bounds in lattice gauge theory** (Wilson and Polyakov loops). Note that single-flavour *Euclidean* Wilson-fermion determinants can be negative (Aoki-phase issues). This Hamiltonian spatial-Wilson version avoids that, and the difference should be stated.
- **Continuum fermion-determinant positivity and stability of QED:** M. P. Fry, "Stability of QED" (arXiv:1108.4345), where 0 < det(QED₃) ≤ 1 and the 4D renormalized determinant grows like e² ln e in strong B. This is the continuum version of the obstruction behind the cutoff-uniform question.

Then circulate the lattice and momentum-cutoff theorems to experts for review (stability of matter or BDF people, and lattice constructive QFT people). Specialist review of the photon Trotter/truncation section is still worth having.

## Task 4 (long term): cutoff-uniform renormalized bounds

The Gaussian-domination cost is the unscreened regularized self-energy (~α/a or αΛ per nucleus). A spacing-uniform bound for E_sub − E_vac needs electron screening (Lieb–Yau kinetic energy), which Gaussian domination consumes entirely. Record this as a proved limitation of the method. A hybrid would apply Gaussian domination to the vacuum part and Lieb–Yau to the electrons localized near nuclei, which needs a local splitting of the Fock space. That is natural on the lattice, so attempt it there first. Expect that Zα ≤ 2/π-type conditions must reappear.

## Deprioritize
- Mixed-sign effective mass: no longer needed, since the lattice model and density-product ordering avoid it.
- Further enlarging the momentum-cutoff window: 5168 m is already far above the electron scale, and the density-product ordering has no window.
- Crystals: only after thermodynamic limit and binding.

## Housekeeping
- Restructure the 38-page paper around the lattice theorem (see the framing correction above).
- Add my two 1+1D lattice check scripts to the verification record (diagnostics only).
