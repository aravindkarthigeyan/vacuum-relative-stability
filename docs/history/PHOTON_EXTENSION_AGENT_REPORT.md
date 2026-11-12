# Technical report: quantized-photon extension

The completed proof is saved at
`photon-free-relative-stability-paper/photon-extension.tex`.
The file was initially created in the historical paper directory, then
moved to the focused project at the coordinator's request. No other
historical files were changed. The coordinator now owns integration and
edits of that TeX file.

## Result established by the argument

For the specified finite-volume, fixed momentum-cutoff Hamiltonian with
full free-vacuum Wick ordering, the sufficient parameter restriction is

\[
m>\frac{13\alpha}{\pi^2}\Lambda_f.
\]

Under this restriction, canonical Gaussian domination extends from the
purely fermionic Hamiltonian to its exact coupling to finitely many
quantized transverse photon modes. The resulting energy comparison uses
the actual interacting neutral vacuum, not the free sea or a product-state
vacuum. No assumption of extensive vacuum energy is needed.

For one point nucleus of integer charge \(Z\), in its admissible exact
neutralizing sector, the derived bound is

\[
E_{\Lambda,L}(R,Z)-E^{\rm vac}_{\Lambda,L}
\ge-\frac{13\alpha}{\pi^2}\Lambda_f Z^2.
\]

It holds for every box size. For distinct point nuclei with
\(1\le Z_i\le Z_{\max}\), exact neutral capacity
\(Z_{\rm tot}\le2M_L\), and \(L\ge\Lambda_f^{-1}\), the explicit
many-source bound in the file is

\[
E_{\Lambda,L}(R,Z)-E^{\rm vac}_{\Lambda,L}
\ge-\alpha\Lambda_f
\left[20\pi(1+1/\pi)^3Z_{\max}
+\frac{13}{4\pi^{3/2}}Z_{\max}^2\right]K.
\]

The constants do not depend on the photon cutoff, although the proof
requires a finite photon cutoff at every intermediate finite-volume
construction. No photon-cutoff removal is proved.

## Algebra audited

1. The exact Wick rewrite retains the specified scalar constant and puts
   the Coulomb interaction into positive density squares plus the
   quadratic operator
   \[
   h_{\rm eff}=D_0-\frac\alpha{2V}\sum_{k\ne0}
   \frac{4\pi}{|k|^2}T_k\operatorname{sgn}(D_0)T_{-k}.
   \]
   Its mass coefficient satisfies
   \(M\ge m-\alpha\kappa_L/2\), where
   \(\kappa_L\le26\Lambda_f/\pi^2\). The direct sea contraction
   vanishes because the sea density is constant and the Coulomb zero
   mode is omitted.

2. The constant Hermitian unitary
   \(C_5=\mathsf a_1\mathsf a_2\mathsf a_3\mathsf b\) anticommutes
   with the quadratic Dirac matrices and commutes with every spin-scalar
   density kick. The exact centered determinant is real, including the
   phase needed for the canonical charge twist.

3. Positivity is stronger than reality. A hypothetical zero of the
   determinant gives an antiperiodic solution of the finite-dimensional
   Euclidean evolution equation. Multiplication by \(\mathsf b\),
   taking real parts, and integration gives the strictly positive mass
   form and a contradiction. This works for noncommuting spatial
   matrices; no commutation between kinetic coefficients and mass is
   assumed.

4. A real photon-coordinate history changes only the Hermitian
   coefficients multiplying the spatial Dirac matrices. It preserves
   both the \(C_5\) identity and the positive mass form. Thus it does
   not spoil the determinant argument.

5. Centered scalar kicks, including the charge twist, are indispensable.
   The identity
   \(\operatorname{Tr}(P_-F)=\operatorname{Tr}F/2\) holds for the
   spin-scalar matrices occurring here. It must not be silently extended
   to arbitrary spin-dependent matrices.

## Photon integration and limits

Pairing opposite photon momenta gives standing-wave oscillators in which
the vector potential is a real linear function of commuting coordinate
operators. The normal-ordered oscillator Hamiltonian includes its
\(-\omega/2\) constant. Its Mehler kernels remain positive. The
free-sea scalar in the current coupling vanishes in the specified
symmetric cutoff.

The proof first truncates the coordinate dependence of the vector
coupling by a real scalar function \(\chi_R\). The resulting matrix
potential is bounded and still has the same positive mass coefficient.
A trace-norm Trotter lemma is proved in the TeX file rather than assumed:
the bounded-perturbation Dyson expansion is controlled by Schatten
Hölder, and fixed-order product expansions converge to the time-ordered
integrals. Splitting the finitely many bounded density-square factors
adds an error tending to zero in trace norm.

At each finite product stage, scalar Hubbard--Stratonovich identities
are applied separately to the density squares. The photon weight is a
positive cyclic product of Mehler kernels. The remaining centered CAR
trace is positive for every oscillator configuration, scalar Gaussian
variable, and charge-twist angle. Removing the source and nonzero-charge
phases by the triangle inequality therefore compares the canonical
partition function to its exact neutral, zero-source counterpart.
The density operators need not commute.

After taking the zero-temperature limit, the coordinate truncation is
removed by

\[
|H-H_R|\le C|x|^2/R
\]

as a quadratic-form estimate. The oscillator controls \(|x|^2\), and
both Hamiltonians are bounded below by half the oscillator Hamiltonian
minus a constant independent of \(R\). The variational principle then
gives convergence of every fixed-charge ground energy. These constants
may depend on the fixed volume and regulators; uniformity of this
auxiliary convergence is unnecessary because the Gaussian domination
inequality has no \(R\)-dependent error before removal.

The proof does not assert a separate finite-temperature convergence
theorem for the untruncated photon interaction. It needs, and proves,
ground-energy convergence after the bounded-coordinate comparison.

## Many-nucleus comparison

The full source-free short-range density-square interaction is retained
when applying Gaussian domination to the long-range heat-kernel part.
Discarding it would change the vacuum being subtracted and invalidate
the argument.

The long-range source self-energy cancels the corresponding nuclear
cross terms, leaving individual long-range self-energies. The short-range
external term is controlled by the bounded cutoff density and the
integrable short-range kernel. The negative constant part of the
short-range nuclear interaction is controlled by exact neutral capacity.
This gives the coefficient \(20\pi\) in the displayed proof. Nuclear
repulsion is never Fourier truncated, and coincident point nuclei remain
excluded by their infinite mutual energy.

## Scope and limitations

- The proof is for the stated bare Hamiltonian, Wick prescription,
  sharp momentum cutoff, and omitted harmonic photon mode.
- It retains exact correlated fermionic states and quantized photons;
  it is neither a no-pair result nor a mean-field approximation.
- The positive effective-mass condition is sufficient. Its failure is
  a failure of this proof, not an established instability threshold.
- The result is compatible with superextensive raw vacuum energy. It
  does not establish ordinary extensive thermodynamics for that model.
- No ultraviolet limit, physical mass/charge matching, photon-cutoff
  removal, atomic binding theorem, or crystallization theorem follows.
- The many-nucleus statement requires the stated lower bound on box
  size; the one-nucleus estimate does not.
- No claim of priority is made. The operative finite-dimensional and
  analytic lemmas are proved explicitly; literature comparisons should
  still distinguish this deduction from established related methods.

The coordinator is adapting duplicate notation and historical
cross-references for the focused project. No additional external
citation is required to fill a gap in the supplied proof.
