# Round-five review handoff

This round stops the mathematical expansion and separates the existing
results for review. The consolidated 64-page draft and the historical
memorandum are preserved. No paper has been submitted and no reviewer
has been contacted.
All 32 TeX/PDF files of those two earlier projects were compared with
the preserved round-four archive and are byte-identical.

## The three documents

| Document | Pages | Purpose |
|---|---:|---|
| Paper A | 12 | Compact Wilson Hamiltonian, exact Gauss sectors, centered determinant, transfer annulus, canonical charge gap, individual nuclear subtraction, vacuum limit, and open zero-flux source limit. |
| Paper B | 57 | Momentum-cutoff relative bounds, photons, ordering windows, absolute vacuum obstruction, positive photon-mass deformation, point-source ultraviolet and exchange counterexamples. |
| Companion notes | 20 | Frozen-link matching, clover correction, electric localization, bare-vacuum obstructions, and exact remaining conditions for a dynamical reduction. |

Paper A uses standard 11-point type and one-inch margins. Its proofs fit
in twelve pages without shrinking the typography or omitting the annulus
and Fourier arguments. It has not been padded to the suggested fifteen
to twenty pages. Paper B retains lengthy proofs because its role is to
preserve the regulator comparisons and counterexamples.

Paper A is the first-review document. Its proof chain is self-contained;
the companion explicitly cites Paper A for the general gauge-sector
comparison and proves its separate static and obstruction statements.
Paper B has its own definitions, proof dependencies, and bibliography.

## What Lean checks, and what it does not

The project in lean-core pins Lean 4.19.0 and a matching mathlib commit.
Its README and ROUND5_LEAN_REPORT.md are the authoritative theorem and
hypothesis map. Downloaded tools and dependency caches are local only;
the review archive carries source, configuration, setup/build scripts,
dependency identifiers, and verification logs.

The checked subset includes:

- Preservation of the C5 form under products, conditional on preservation
  by each factor, and the inverse-adjoint algebraic identity.
- Consequences of strict beta-form decrease at eigenvector endpoints,
  conditional on the analytic endpoint and contraction estimates.
- Eigenvector-level inverse/adjoint correspondence with explicit
  inverse and nonzero-eigenvalue hypotheses.
- The elementary-symmetric coefficient bound derived from subset products,
  the finite Vandermonde correlation bound, its zero-coefficient identity
  and lower bound, and the resulting normalized coefficient estimate.
- Integration of the coefficient bound against a supplied positive
  measure with its stated integrability and phase hypotheses.

The following bridges are not formalized:

1. Deriving form preservation for exponential/ODE histories from the
   generator relations, and the differential inequality/Gronwall step.
2. Algebraic spectral multiplicities and the exact number of stable
   eigenvalues.
3. Identifying the factored determinant and its Fourier integrals with
   the formalized finite coefficient expression.
4. Constructing the Hubbard-Stratonovich or gauge-path representation,
   proving the physical trace identities, and taking the field and
   ground-energy limits.

Consequently the package is **partial machine verification**, not a
machine proof of Paper A or of QED stability. Standard Lean foundational
axioms are distinguished from unproved mathematical hypotheses and
proof holes in the project's audit.

The final project has 23 checked theorems. A separate root rerun of the
build and all 23 axiom checks succeeded. The delivery check also verifies
the source checksum list and that every project theorem appears in the
audit. Only propext, Classical.choice, and Quot.sound are reported.

## Document and source checks

All three PDFs compile without LaTeX warnings, unresolved references,
overfull/underfull boxes, or missing characters. Every page was rendered
and visually inspected. Each clean TeX archive was extracted into a fresh
directory and compiled for three passes; the result reproduced the
corresponding review PDF's extracted text. The external manifests record
file hashes, page counts, and clean-build results.

The desktop editor compiler separately succeeded for all three projects.
The first Paper A attempt returned stale-project while its final input
was being updated; the completed-input retry succeeded.

Internal cross-audits checked the shortened Paper A proof, Paper B's
absolute Coulomb/photon bounds and exact-neutral L5 trial, and the
companion's model/scope. Their findings are in the separate agent reports.
These checks are not external peer review or evidence of novelty.

## Small wording corrections retained

The vacuum counterexamples establish positive total bare pair number
and nonzero electric tails. They do not establish a positive lower
density uniformly in volume. The iron benchmark excludes the particular
simultaneously heavy, resolved, small-Wilson-parameter hierarchy at the
stated tolerances, rather than every nonrelativistic treatment of iron.
The fixed-link bound |h_W(U)|>=m was already proved by the Schur argument;
the unproved issue is transferring it to quantized electric dynamics.

## Human decisions and review

The requested credits Opus 5.5 + Astra 6 remain research-tool disclosures.
Human authorship, affiliation, and a publication license are unset.
The responsible human author must check and take responsibility for the
mathematics; no identity has been inferred from the computer account.

SPECIALIST_REVIEW_REQUEST.md is an unsent draft focused on Paper A.
It records the suggested areas of expertise without assuming that any
named person is available or has agreed to review. The human priority
search should especially examine Hamiltonian static-charge character
bounds and determinant/sign-free positivity. Existing citations establish
context, not a claim of priority.

The neutral dynamical pair gap, source-relative effective remainder,
periodic-source boundary-flux estimate (BF), and cutoff-uniform screening
remain open. They are not required to state the present first-paper
result, and this handoff does not propose another expansion round.
