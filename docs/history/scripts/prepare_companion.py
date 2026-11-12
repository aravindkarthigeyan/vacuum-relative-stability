"""Extract the audited low-energy material without changing the consolidated draft."""
from pathlib import Path
import re

root = Path(__file__).resolve().parent
old = root / "vacuum-relative-stability-paper"
dest = root / "companion-notes"
main = (old / "main.tex").read_text(encoding="utf-8")
preamble = main[:main.index(r"\title{")]
preamble = preamble.replace(
    "pdftitle={Vacuum-relative stability in Hamiltonian lattice QED}",
    "pdftitle={Low-energy matching and vacuum obstructions in Hamiltonian lattice QED}")
opening = r"""
\title{\textbf{Low-energy matching and vacuum obstructions\\
in Hamiltonian lattice QED}\\[0.4em]
\large Companion notes to the vacuum-relative stability theorem}
\author{}
\date{Review draft, 29 October 2026}
\begin{document}
\maketitle
\begin{center}\small
Research-tool credits: Opus 5.5 + Astra 6\\
Human author metadata has not been supplied.
\end{center}
\begin{abstract}
These notes collect the proved static comparisons and failed estimates
that delimit a proposed nonrelativistic reduction of compact Hamiltonian
lattice QED. A frozen-link Schur-complement argument gives a
charge-extensive spectral error, with Wilson kinetic and magnetic
coefficients stated explicitly. A bounded clover correction preserves
the vacuum-relative positivity argument under a sufficient mass condition.
For dynamical links, Gauss-preserving electric localization is controlled,
but source-only bounds on bare electric tails and bare pair number
fail in the vacuum. We prove these obstructions, valid estimates with
volume terms, and the exact additional Schur-complement assumptions
needed for a dynamical reduction. No neutral pair gap, effective
many-electron Hamiltonian with source-relative error, or continuum
limit is claimed.
\end{abstract}
\noindent\textbf{Scope.}
This is the companion to Paper A~\cite{PaperA}; the full compact-link
source comparison is recalled with an explicit reference below.
The remaining results here reproduce the audited arguments of the
consolidated research draft. Internal checks are not external peer review,
and no priority claim is made.
\tableofcontents
\input{model}
\input{low-energy-matching}
\input{electric-localization}
\input{source-relative-remainders}
\input{scope}
\input{references}
\end{document}
"""
(dest / "main.tex").write_text(preamble + opening, encoding="utf-8")
for name in ("low-energy-matching", "electric-localization", "source-relative-remainders"):
    (dest / (name + ".tex")).write_bytes((old / (name + ".tex")).read_bytes())
refs = (old / "references.tex").read_text(encoding="utf-8")
entries = re.findall(r"\\bibitem\{([^}]+)\}([\s\S]*?)(?=\\bibitem|\\end\{thebibliography\})", refs)
selected = "\n".join(r"\bibitem{" + key + "}" + text
                     for key, text in entries if key in {"KogutSusskind", "Zache", "EKM", "BDL"})
references = r"""
\begin{thebibliography}{9}
\raggedright
\bibitem{PaperA}
\emph{Vacuum-relative stability and charge gaps in compact Hamiltonian lattice QED}.
Companion Paper A in this research package, review draft, October 2026.
Human author metadata pending; not an external publication.
""" + selected + "\n" + r"\end{thebibliography}" + "\n"
(dest / "references.tex").write_text(references, encoding="utf-8")
build = (old / "build.ps1").read_text(encoding="utf-8")
build = build.replace("vacuum-relative-stability", "companion-notes")
(dest / "build.ps1").write_text(build, encoding="utf-8")
print("Companion inputs prepared; model.tex and scope.tex are maintained separately.")
