# Task C: compact Hamiltonian lattice QED with exact Gauss law

**Status:** Complete direct proof for the specified compact U(1), spatial Wilson-fermion Hamiltonian. The main comparison is stronger than the task's proposed self-subtracted statement: **the raw physical-sector energy satisfies E(ν) ≥ E(0)+m|Σν|, because the electric self-energy is already in the Hamiltonian and the total induced fermion charge has a bare rest-energy cost.** Subtracting prescribed individual nuclear self-energies then gives a uniform linear lower bound. No priority claim is made. No continuum or renormalized-QED conclusion is asserted.

The complete LaTeX proof is in `vacuum-relative-stability-paper/lattice.tex`. It is a new owned fragment; no other paper sources were edited.

## Exact model and signs

The sites are X=(Z/nZ)^3, n≥2, spacing a>0, N=n³. There are 3N oriented links. The auxiliary Hilbert space is L²(U(1)^(3N), normalized Haar) tensor the finite CAR Fock space over l²(X) tensor C⁴. Each compact rotor is untruncated: U=e^{iφ}, E=−i∂φ, spectrum Z.

The Hamiltonian is

H = (g²/2a) Σ E² + (1/g²a) Σ_plaquettes (1−Re U_p) + dΓ(h_W(U)),

where T_j(U)f(x)=conj(U_xj) f(x+e_j), v_j=(T_j−T_j*)/(2ia), and

h_W(U)=Σ_j α_j v_j(U)+β M(U),

M(U)=m+(r/2a)Σ_j(2−T_j−T_j*) ≥ m I,

with bare m≥0, Wilson r≥0, and g²>0 arbitrary. The positive Wilson sign follows from 2−T−T*=(I−T)*(I−T), including complex link phases.

Let q_x=n_x−2, with n_x the four-spinor occupation. It counts electron excess; physical fermionic electric charge is −g q_x. For gauge functions g_x=e^{iθ_x}, links transform as U^g_xy=g_x U_xy conj(g_y). Then h_W(U^g)=g* h_W(U)g. The unitary W(g)=exp(iΣθ_x q_x) R_g, where R_gΨ(U)=Ψ(U^g), commutes with H. Its generators are G_x=div E_x+q_x. Thus the positive source sector G_x=ν_x has Gauss law div E=ν−q and total electron excess Σq=Σν. This sign convention was independently checked by the finite-cutoff agent.

The exact projection is P_ν=∫ dθ exp(−iθ·ν) W(e^{iθ}), with normalized torus Haar. Sources must be integer valued. For a connected graph, the sector is nonempty exactly when −2N≤Σν≤2N: choose admissible occupations with the required total and solve the residual zero-sum integer divergence with a spanning-tree flow. In particular positive nuclei require Z_total≤2N, with no pointwise bound on ν_x beyond the requested individual Z_i≤Z_max.

The physical Hilbert space does not factor into independent matter, longitudinal, and transverse pieces. We work on an auxiliary tensor product and impose every local Gauss constraint exactly.

## Rigorous comparison

At fixed finite lattice, H_E is a positive compact-torus Laplacian and all other terms are bounded continuous Hermitian matrix multipliers. Hence H is self-adjoint on D(H_E), has compact resolvent and trace-class heat semigroups; every physical sector is reducing. Set h_* = m+(3+6r)/a. The C5 spectral pairing gives H≥−2N h_*. A constant-link, two negative-β spinors per site trial state is in the vacuum Gauss sector and gives E_0≤−2N(m+3r/a)+3N/(g²a), so the vacuum is extensive already at this elementary level.

For arbitrary time-dependent links, h_W(U_t) has the same Dirac-matrix form with M(U_t)≥m. The positive centered determinant lemma applies to every one-particle propagator V_path and every local scalar gauge twist g:

z(g,V_path)=exp(−2iΣθ_x) det(I+g V_path)>0 for m>0.

The phase is essential and is exactly produced by q_x=n_x−2. It is single-valued because each site has four spin components. The proof uses C5=α1α2α3β pseudo-unitarity to make z real, and the antiperiodic β-form identity to exclude zeros. The mass may vary with time and need not commute with the spatial kinetic matrices. At m=0, approximation by m+ε makes the determinant nonnegative and preserves the final comparison.

No unbounded-potential or formal Trotter issue remains. The electric heat kernel is the positive wrapped Gaussian on each circle. For bounded matrix B(U)=H_B(U)+dΓ(h_W(U)), its Dyson series has a kth-order pointwise norm bound

K_b(U,V) (b ||B||)^k/k!.

This uses only positivity and convolution of the scalar electric kernels. Thus the matrix-valued Feynman–Kac kernel follows from an absolutely convergent bounded-perturbation series. The twisted trace is an integral of K_b(U^g,U) times a Brownian-bridge expectation of exp(−∫H_B) z(g,V_path). Every factor is nonnegative. Trace integrals can be justified with Hilbert–Schmidt half-semigroup factorization.

Consequently F_b(θ)=Tr(W(e^{iθ})e^(−bH))≥0 pointwise, and

0 < Z_ν(b) = ∫ exp(−iθ·ν) F_b(θ)dθ ≤ ∫ F_b(θ)dθ = Z_0(b)

for any admissible integer source. The ground-energy limit proves **E_ν≥E_0**. The complete auxiliary Hilbert space decomposes into the integer Gauss sectors, so its global ground energy is also E_0. This is the nontrivial result, as opposed to finite-volume boundedness below.

The full compact gauge dynamics is retained. In a particle–hole representation relative to h_W(1), the bilinear includes all off-diagonal positive/negative-energy blocks and hence electron–positron creation and annihilation. There is no no-pair restriction. The compact-link theory is a different UV regulator from a photon-Fock momentum cutoff; it is not silently identified with the latter at finite regulator.

### Charge-cost strengthening

After independently checking the transfer-annulus and Fourier lemmas in `mass-gap.tex`, I added the physical-lattice strengthening. Decompose the local Haar angles as θ_x=ϑ_x+φ with ϑ_root=0. The gauge-twisted link endpoint and its Brownian measure depend only on ϑ. At each fixed bridge and ϑ, the global angle φ is precisely the centered total-charge twist for the transfer history e^{iϑ}V_path. Its Wilson mass stays ≥m; the β-form argument therefore puts half the transfer eigenvalues in |λ|≤e^(−bm), with reciprocal-conjugate partners outside e^(bm).

Integrating the global angle first and using the canonical Fourier bound gives

Z_ν(b) ≤ binom(4N,2N+|Σν|) e^(−bm|Σν|) Z_0(b).

The relative source character has modulus one. The integral of the path's zeroth global Fourier coefficient over all relative twists is exactly the vacuum's full local-Gauss projection, so no physical constraint is discarded. The finite combinatorial prefactor disappears at zero temperature and proves **E_ν≥E_0+m|Σν|**. This is a total induced-charge cost, not a neutral-sector pair or photon gap. For m=0 it reduces to the first comparison.

## Self-energy and constants

Let D be the link incidence matrix, Δ=DD*, and G_n=Δ^+ the zero-mean inverse. On the physical sector, an exact commuting-operator quadratic-form identity is

H_E=(g²/2a)[(ν−q)*G_n(ν−q) + ||E−D*G_n(ν−q)||²].

The residual flux spectrum depends on charge and integer-flux constraints; this identity does not create an independent transverse Hilbert space.

The source-source part is (g²/2a)ν*G_nν, whose individual nuclear self-energy is

S_n=(g²/2a) G_n(0) Σ_i Z_i².

It is position independent, state independent, and fixed by the periodic Green-function normalization. Define E_sub=E_raw−S_n. Then

E_sub−E_vac ≥ −S_n ≥ −[13g²/(32a)] Z_max² K
             = −[13πα/(8a)] Z_max² K, with g²=4πα.

The charge-cost corollary strengthens the first right-hand side to m Σ_i Z_i−S_n for positive nuclei, and likewise adds m Σ_i Z_i to the coarser linear bound.

The diagonal estimate G_n(0)≤13/16 is elementary and uniform in n. On representatives |k_j|≤n/2, the eigenvalue 4Σsin²(πk_j/n)≥16|k|²/n². Shell max|k_j|=s has at most 24s²+2≤26s² points, giving G_n(0)≤26 floor(n/2)/(16n)≤13/16. This deliberately coarse constant is sufficient.

This clarifies the requested inequality: E_sub + S_n ≥ E_vac, or equivalently E_raw≥E_vac. Adding S_n to E_raw would double count. An independently prescribed infinite-lattice self-energy can also be subtracted, but changes the normalization explicitly.

If multiple labeled nuclei occupy the same site, subtract individual Z_i² self-energies and retain their mutual Z_i Z_j G_n(0) interaction. The theorem then still applies. Subtracting instead the square of the total site charge removes the mutual term and is a different model; with unlimited site occupancy that subtraction is not O(K). The proof does not deliver a linear bound for that alternative model. Lattice point sources resolve distance only down to a; they do not preserve the continuum collision singularity.

## Scope limitations and checks

- No extra flux/winding restriction, electric θ shift, or electric-field cutoff is imposed. The full link torus and all its harmonic coordinates are integrated. Additional projection characters can destroy the positive comparison measure. With dynamical charged matter, some global electric flux restrictions do not even reduce H.
- A nonintegral background electric shift makes the heat kernel potentially complex; the theorem does not cover it. A finite electric-field cutoff need not preserve the positive wrapped-Gaussian kernel.
- The bare mass is nonnegative and the Wilson sign is positive. No smallness of g, α, or a^(−1)/m is needed. This does not establish that a continuum renormalization trajectory at fixed physical mass stays in this bare parameter range.
- Both extensivity and vacuum-relative stability hold at fixed lattice spacing. The exact total-charge cost is proved as above. A thermodynamic limit, binding, atom/molecule eigenstates, crystal order, and a gap for neutral pair or photon excitations require new arguments.
- The self-subtracted constant diverges as a^(−1). This is not a renormalized-QED theorem or a cutoff-uniform stability estimate.
- The proof has been written explicitly rather than as an application of an incorrectly matched staggered-fermion or Euclidean-action theorem. The elementary determinant and character-bound mechanism has substantial prior context; no novelty claim is justified by this audit.

## Primary sources checked

1. John Kogut and Leonard Susskind, “Hamiltonian formulation of Wilson's lattice gauge theories,” **Physical Review D 11** (1975), 395–408. DOI: [10.1103/PhysRevD.11.395](https://doi.org/10.1103/PhysRevD.11.395). Canonical compact-link/rotor framework. The title's “Wilson” is not itself a claim that it proves the present four-component spatial-Wilson-fermion theorem.

2. T. V. Zache, F. Hebenstreit, F. Jendrzejewski, M. K. Oberthaler, J. Berges, and P. Hauke, “Quantum simulation of lattice gauge theories using Wilson fermions,” **Quantum Science and Technology 3** (2018), 034010. DOI: [10.1088/2058-9565/aac33b](https://doi.org/10.1088/2058-9565/aac33b); [arXiv:1802.06704](https://arxiv.org/abs/1802.06704). Eq. (3) gives the direct d-spatial-dimensional Wilson Hamiltonian, with onsite mass m+dr/a and Wilson hopping. Their quantum-simulation examples specialize to 1+1 dimensions; no stability theorem is imported from them.

3. Erez Zohar and Michele Burrello, “A Formulation of Lattice Gauge Theories for Quantum Simulations,” **Physical Review D 91** (2015), 054506. DOI: [10.1103/PhysRevD.91.054506](https://doi.org/10.1103/PhysRevD.91.054506); [arXiv:1409.3085](https://arxiv.org/abs/1409.3085). Source for compact-group configuration/representation bases, Fock matter, and local Gauss-law implementation. It is not cited as proving the present determinant comparison.

4. Belal E. Baaquie, “Lattice gauge theory: Hamiltonian, Wilson fermions, and action,” **Physical Review D 33** (1986), first page 2367. DOI: [10.1103/PhysRevD.33.2367](https://doi.org/10.1103/PhysRevD.33.2367). Its abstract explicitly distinguishes a Hamiltonian derived from the fully discretized Euclidean Wilson action, noncanonical equal-time anticommutation, and a nonlocal canonical form. This is why the present report defines the continuous-time spatial-Wilson Hamiltonian directly rather than asserting identity with every Wilson transfer matrix. Full page range was not verified and is not guessed.

5. Takis Angelides, Lena Funcke, Karl Jansen, and Stefan Kühn, “Mass Renormalization of the Schwinger Model with Wilson and Staggered Fermions in the Hamiltonian Lattice Formulation,” Lattice 2022 proceedings, [arXiv:2211.12169](https://arxiv.org/abs/2211.12169), version 3 (2023). Direct Hamiltonian Wilson construction and additive bare-mass renormalization in a 1+1-dimensional model. The latter is a scope warning, not a claimed computation of the 3+1-dimensional QED critical mass.

6. Erhard Seiler, “Upper bound on the color-confining potential,” **Physical Review D 18** (1978), first page 482. DOI: [10.1103/PhysRevD.18.482](https://doi.org/10.1103/PhysRevD.18.482). The primary abstract states an upper bound on the growth of the static potential, using a positive Hamiltonian and Euclidean rotation invariance. This should not be misidentified without inspecting its full proof as exactly the present source-sector lower bound. The comparison here is proved directly.
