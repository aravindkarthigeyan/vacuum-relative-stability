# Round-three research status

29 October 2026. Response to CODEX_NEXT_TASKS_3.md. The original paper and
supplied scripts are preserved. The results below are new analytic
deductions and independent audits within the specified models; no
priority claim or continuum-QED theorem is made.

## Main outcome

A vacuum thermodynamic-limit proof is now available at every fixed
\(a>0,g^2>0,m\ge0,r\ge0\) for the existing compact Hamiltonian Wilson
model. The proposed full nonrelativistic reduction is not established:
a fixed-Wilson-parameter heavy-mass expansion needs kinetic-mass
matching, dynamical electric-field control, and a source-relative
remainder estimate. None of these follows merely from the charged
sector gap.

The static-link nonrelativistic problem does admit a rigorous useful
bound proportional to the number of added particles. This is an exact
starting theorem, not a substitute for the interacting gauge problem.

## Results and precise scope

### A. Vacuum thermodynamic limit: derived

[Full proof](THERMODYNAMIC_LIMIT_ROUND3.md).

Let \(E_0^{\rm per}(L)\) be the physical vacuum energy on \(L^3\) sites.
The existing positivity theorem identifies it with the unrestricted
auxiliary ground energy. Cut the auxiliary system into open cubes,
retain free electric rotors on the cut links, and bound only the
removed fermion links and plaquette multipliers.

With
\[
 B=(4r+2+8/g^2)/a,
\]
the cutting error is at most \(B\) times the number of cut links.
Almost additivity then proves
\[
 e_{\rm vac}=\lim_{L\to\infty}E_0^{\rm per}(L)/L^3,
 \qquad
 |e_{\rm vac}-E_0^{\rm per}(L)/L^3|\le6B/L
\]
for \(L\ge3\). The open-box Wilson diagonal must follow the graph degree.

This proof does not factor physical Hilbert spaces or assume that their
boundary electric fluxes can be freely glued. It uses the auxiliary
minimum comparison to avoid that issue.

### B. Fixed periodic nuclear cell: two-sided relative bounds derived

The same note gives a Gauss-law-respecting trial state for every fixed
connected cell that tiles the lattice, with \(V_c\) sites, \(K_c\) nuclei and total charge
\(Z_c\le2V_c\). Choose an internal integer screening flow \(F\) with
\(\mathcal F_c=\sum F_e^2\). Repeating the cell gives
\[
 0\le E_\nu-E_0-mZ_{\rm tot}\le C_{\rm cell}K,
\]
where
\[
 C_{\rm cell}=
 \frac{3rZ_c+(6+6r+3/g^2)V_c+(g^2/2)\mathcal F_c}{aK_c}.
\]
The coefficient depends on the cell and its density, not on the number
of repetitions. This is not a uniform dilute-nuclei bound and does not
yet prove a source thermodynamic limit or binding. Prescribed
self-energy subtraction simply shifts both sides by that subtraction.

### C. Frozen-link nonrelativistic theorem: derived

[Proof and physical matching audit](NR_FREE_AUDIT_ROUND3.md).

At a fixed classical link configuration write
\[
 h_W=\begin{pmatrix}m+R&S\\S&-m-R\end{pmatrix},
 \quad R\ge0,\quad\|R\|\le w=6r/a,\quad\|S\|\le s=3/a.
\]
For \(m>0\), the effective positive-band operator is
\[
 K=R+\frac{S^2}{2m}.
\]
If its eigenvalues are \(k_j\), and the positive Dirac eigenvalues are
\(m+e_j\), both increasingly ordered, then
\[
 0\le k_j-e_j\le\delta,
 \qquad
 \delta=\frac{s^2w}{2m^2}+\frac{s^4}{8m^3}.
\]
It follows that the source-free static-link Fock addition energy obeys
\[
 \left|[E_q(U)-E_0(U)]
       -\left(m|q|+\sum_{j=1}^{|q|}k_j\right)\right|
 \le |q|\delta .
\]
Here \(E_0(U)\) is the sea at that same fixed \(U\), and no dynamical
Gauss-constrained source sector is being asserted. The scalar
\(E_0(U)\) cannot be dropped when \(U\) is quantized.

### D. The proposed heavy-mass matching needs repair

Already at \(U=1\),
\[
 E(p)=\sqrt{\left[m+\frac r a\sum_j(1-\cos ap_j)\right]^2
              +\frac1{a^2}\sum_j\sin^2(ap_j)},
\]
and therefore
\[
 E(p)-m=\frac12(1/m+ra)|p|^2+O(|p|^4),\qquad
 m_{\rm kin}=\frac{m}{1+rma}.
\]
For fixed \(r\) of order one and \(ma\gg1\), the bare mass is not the
kinetic mass. Resolving the radius \(1/(\alpha m)\) alone does not
supply physical electron matching. One must keep the Wilson kinetic
term in the target model and calibrate the mass, tune \(r\), or change
the improved discretization. The report derives the associated
doubler-energy tradeoff.

### E. Dynamical electric fields and pair elimination: obstruction identified

[Detailed analysis](NR_SW_OBSTRUCTIONS_ROUND3.md).

For \(c=g^2/(2a)\),
\[
 [cE^2,U]=cU(2E+1).
\]
A pair-changing hop can therefore have an unperturbed energy
difference \(2\mu+c(2E+1)\), with the on-site mass
\(\mu=m+3r/a\) when the Wilson diagonal is included. Large flux can
cancel the mass cost. A mass-only SW generator has an unbounded
commutator with \(H_E\). Conversely, treating \(H_E\) exactly does
not give a uniformly separated matter band over every electric state.

This obstructs a full-Hilbert-space mass-only argument. It does not
disprove an appropriately restricted low-energy theorem. Retaining
the full even Wilson block yields a useful atomic-reference threshold
for the pair subspace, recorded in the report, but not the desired
neutral excitation gap above the interacting vacuum.

### F. Locality alone does not make the error proportional to nuclei

[Primary-literature audit](VALIDATION_LITERATURE_ROUND3.md).

The cited Bravyi--DiVincenzo--Loss local SW estimate scales with the
number of sites. Subtracting two separately controlled ground energies
still leaves a volume error by the triangle inequality. A new estimate
on source-induced changes of local remainder expectations, or a
source-relative quadratic-form bound, is necessary.

Datta et al.'s infinite-dimensional treatment also has spectral and
relative-boundedness hypotheses; it does not remove the electric-field
problem automatically.

## Verification

The two supplied scripts were rerun without changing their sources.

* Ordinary model: minimum reported charge-adjusted margin
  \(0.11137650412315825\).
* Scalar-potential control: minimum charge-adjusted margin
  \(-1.6840305765244952\).

The control is still gauge invariant. It violates the extra Dirac
positivity structure used by the theorem. These are finite open
four-site, two-component, one-dimensional checks with Gauss law solved
exactly; they do not test transverse photons or the heavy-mass limit.

Complete outputs and script hashes are in
[the validation report](VALIDATION_LITERATURE_ROUND3.md).

## Literature correction

[Fry's Stability of QED](https://arxiv.org/html/1108.4345) is relevant
but explicitly states two unproved inputs for its strong-field
conclusion in Section IV. It cannot be used here as a proved obstruction
to cutoff-independent vacuum-relative stability. The verified
limitation of the present estimate is its explicit self-energy
constant growing as \(1/a\).

## Next theorem to target

Specify the dynamical low-energy subspace and the physical matching
of the Wilson kinetic mass first. Then prove a bound on electric
energy in the relevant pair-changing denominators and on the
source-relative SW remainder. The target is a restricted energy
comparison, not uniform block diagonalization over all electric
excitations.

For thermodynamics, the remaining task is the periodic-source energy
limit. The vacuum limit and fixed-cell two-sided bounds are now
available. The source limit still requires a boundary-flux
gluing/screening argument.

The 38-page paper has not been silently reclassified as proving these
new statements. These addenda should be incorporated only with their
explicit hypotheses and scope. No external expert messages were sent.

