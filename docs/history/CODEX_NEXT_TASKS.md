# Next tasks (written 28 Oct 2026, after Sections 13–16)

Context: read `NEXT_STEPS_REPORT.md` first. These tasks are ordered by value per unit of effort.
Each one names a precise target and a proof route. Keep the honesty conventions used so far:
say what is proved, what is a counterexample, and what remains open.

## Assessment of where things stand

- **UV counterexample (Thm 13.1).** The lowering −c_α Λ is a *single-nucleus, configuration-independent*
  vacuum-polarization self-energy, of first order in the pair rotation. A per-species constant ε(Z;Λ) is
  the same kind of object as the nuclear Coulomb self-energy already removed in eq. (2), i.e. part of the
  static nucleus's physical mass. Holding "physical masses fixed" (stronger question A) therefore means
  subtracting it. This is neither state- nor configuration-dependent. The fixed-reference statement
  without the subtraction is correctly refuted. The renormalized statement has not been tested.
- **Screened lattice theorem (Thm 15.2).** It is correct, but it is a bounded-perturbation statement. Its
  constant is the ℓ¹ norm of the screened source potential, ~ 4π/μ² per unit charge. It uses no
  screening by electrons. Treat it as a scaffold, not as evidence for the Coulomb case.
- **Photon exchange result (Thm 14.5).** At the one-loop static tuning, the mean-field vacuum is not the
  free sea and may be an ordered state. This is another symptom of the gauge-noncovariant regulator.
- **Smallest unproved case of (S).** K = 1, uniformly in L, photon-free. Even this is open. The splitting
  H = (1−ε)H(0) + [εH(0) + nucleus] gives only an error of order √V, because concavity in the Coulomb
  coupling costs ε × (extensive vacuum Coulomb energy).

## Task 1 (highest priority): fixed-K, uniform-in-L relative bound, photon-free

Target: E(R,Z) − E_vac ≥ −C_Λ(K, Z_max) for all L ≥ L_0, first for K = 1. At this stage C may grow with K.

Key observation: H(ν) − H(0) = αD(ρ,ν) + U_nn exactly. This holds for *any* fermionic ordering, because
the Wick/density-product correction is ν-independent. So all extensive ordering terms cancel identically.

Route:
1. Split the nuclear potential φ_ν = φ_core + φ_tail with a smooth cutoff at radius R_0. The tail ~ Z/|x|
   has ‖∇φ_tail‖₂² ≲ Z²/R_0, which is finite and volume-independent.
2. **Lemma 1a (vacuum incompressibility, free sea).** For the quadratic Hamiltonian H_D + n(φ) on the
   neutral sector, prove H_D + n(φ) ≥ −C_Λ ‖∇φ‖₂² − (pair-creation-threshold term), with explicit
   conditions on ‖φ‖_∞ relative to m. The second-order kernel is
   Π(k) = V⁻¹ Σ_p tr[P₊(p+k)P₋(p)]/(E+E′) ≤ C_Λ k², because tr[P₊(p+k)P₋(p)] = O(k²/E²).
   For the nonperturbative statement, use the Bogoliubov lower bound for quadratic forms. (Compute Π(k)
   in closed form if possible; numerics welcome.)
3. **Lemma 1b (mean field).** Extend 1a to the HF functional, using Corollary 10.3.
4. **Lemma 1c (many-body, small α if needed).** Show H(0) + n(φ_tail) ≥ E_vac − C‖∇φ_tail‖₂² for the
   interacting vacuum. This is the "dielectric inequality". State any small-α or gap hypothesis
   explicitly. If it cannot be proved, isolate the minimal hypothesis on the interacting vacuum: a
   static charge-susceptibility bound χ_ρ(k) ≤ s k².
5. The core: the Z electrons in the charge sector plus φ_core form a localized neutral object. Use the
   canonical charge-sector Lipschitz estimate (Lemma 15.1 style) adapted to the continuum-cutoff model.
   This gives ‖[H, c†]‖ ≤ C_Λ, and needs a proof with the Coulomb term.

Deliverable: a theorem for K = 1, or a precise identification of which of 1a–1c fails, with a
counterexample if one exists.

## Task 2: renormalized UV question (per-species self-energy)

Define ε(Z;Λ,L) := E(single nucleus Z) − E_vac. Use mean field first, and also the polarized bare
nucleus in sector 0 as an alternative reference.

Target (mean field):
E^HF(R,Z) − E^HF_vac − Σ_i ε^HF(Z_i) ≥ −C K, with C independent of Λ, under Z_max α ≤ 2/π
(or a Brown–Ravenhall-type condition).

Route:
- Lieb–Yau electrostatics.
- Tix/Brown–Ravenhall positivity for the electron block.
- Control of ρ_{Q₊₋} through Tr(|D₀|Q₊₋Q₋₊).

Test first, numerically and analytically: is the two-nucleus cross term
ε(Z₁+Z₂) − ε(Z₁) − ε(Z₂) dominated by nuclear repulsion αZ₁Z₂/|R₁₂| at short distance? It is
expected to be ~ α²Z₁Z₂Λ at |R₁₂| ≲ 1/Λ, versus repulsion ≥ αZ₁Z₂Λ. If not, that is a new
counterexample worth recording.

## Task 3: the tool both 1 and 2 need for many nuclei

Lieb–Yau and Graf–Schenker electrostatic inequalities are configuration-space (pointwise)
inequalities. In the cutoff Fock space, the projected densities ρ(x) do not commute (Schwinger terms)
and contain pair-creation parts, so those inequalities do not apply directly.

Goal: an operator electrostatic inequality for noncommuting densities, with errors controlled by H_D,
for example:
- positivity D(ρ − σ, ρ − σ) ≥ 0 with σ an operator-valued smeared comparison density built from local
  number operators; or
- a Graf–Schenker tetrahedron average applied to the density-product operator.

First check whether the mean-field version (classical ρ_Q) already gives the Lieb–Yau bound
uniformly. This is the step that would turn Task 1 (fixed K) into extensive K.

## Task 4: make the screened theorem μ-uniform (equivalent to the core problem)

Decompose 4π/k² = 4π/(k²+μ²) + W_μ(k), where W_μ = 4πμ²/(k²(k²+μ²)) is positive definite.

Facts to state:
- Dropping (α/2)D_W(ρ+ν,ρ+ν) ≥ 0 costs only (α/2)W_μ(0)ΣZ_i² on the source side.
- On the vacuum side it costs ⟨(α/2)D_W(ρ,ρ)⟩_vac ~ μ²V.
- Hence an O(K) result needs μ² ≲ K/V *and* a screened constant independent of μ.

So Task 4 reduces to Task 3, but it gives a clean quantitative criterion. Write it as a proposition.

## Task 5: photons (decide the regulator)

Stop extending the sharp-cutoff + counterterm route at mean field beyond recording results. Either:
- (a) numerically compute the small-box HF + coherent-photon vacuum at δμ² = 2e²χ(0), and determine
  whether it breaks translation or rotation invariance (current order); or
- (b) set up Hamiltonian lattice QED (Wilson fermions, noncompact U(1), Kogut–Susskind), and prove
  χᵀ(0) = 0 (the Ward identity) and the extensive bound there. Keep Gauss-law boundary-flux sectors in
  any gluing (Donnelly 2014).

Option (b) is the long-term framework.

## Task 6: consolidate the write-up

The 72-page document has accreted. Propose a split:
- **Paper I, "Regulator obstructions in cutoff QED with pairs":** L⁵ instability, Ward diagnosis,
  counterterm theorem, UV point-source counterexample, exchange instability, small-box obstruction.
- **Paper II, "Mean-field vacuum-relative stability with point nuclei":** Lemma 10.2, Theorem 10.4,
  the photon heavy-mass proposition, and the reduction (Prop. 11.1).
- Keep the research log and agent reports as an appendix or a separate notes file.
