Figure: "The system" -- compact U(1) Hamiltonian lattice QED with Wilson fermions and static nuclei.

Files
  lattice-qed-system.pdf   vector figure for the paper (use this in LaTeX)
  lattice-qed-system.png   300 dpi raster (slides, web)
  lattice-qed-system.svg   vector, editable
  fig.tex                  standalone TikZ source (pdflatex fig.tex)
  gen.py                   regenerates the 3D lattice drawing (lattice_body.tex, anchors.tex):
                           camera angles az/el, perspective distance Dcam, lattice size n,
                           and the Gauss-law-consistent configuration are set at the top.

The depicted configuration satisfies Gauss's law div E = nu - q exactly at every site:
nucleus nu=+2 with two outgoing flux units ending on two electrons (q=+1 each);
a positron (q=-1) / electron (q=+1) pair joined by one flux unit; one divergence-free
flux loop; total electron excess = total nuclear charge = 2.

Usage in the paper:
  \begin{figure*}[t]\centering
  \includegraphics[width=\textwidth]{lattice-qed-system.pdf}
  \caption{...}\end{figure*}

Suggested caption:
  The model. (a) Compact U(1) Hamiltonian lattice QED on a periodic cubic lattice with
  spacing a. Each site carries four Dirac modes (filled Dirac sea: grey); electrons (blue)
  and positrons (orange) are excitations of the sea. Each link carries a quantum rotor
  with integer electric flux (arrows); plaquettes carry magnetic flux. A static point
  nucleus (here Z=2) enters only through Gauss's law, div E = nu - q, which the depicted
  configuration satisfies exactly: flux leaves the nucleus and ends on the two screening
  electrons, a virtual pair is joined by one flux unit, and a closed flux loop is a
  transverse photon. (b)-(d) Local structure: Gauss's law, link rotors, Wilson hopping
  with M(U) >= m. (e) Mechanism of the main theorem: positivity of imaginary-time fermion
  determinants.
