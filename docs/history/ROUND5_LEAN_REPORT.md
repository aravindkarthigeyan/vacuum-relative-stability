# Round five: checked finite core

Date: 29 October 2026. Owned output: `lean-core/` and this report. No paper source was edited for this task.

## Result

An isolated Lean 4.19.0 + mathlib project was installed and built. It contains **23 compiler-checked theorems**, with a saved `#print axioms` audit of every theorem. The audit reports only Lean's standard `propext`, `Classical.choice`, and `Quot.sound`; no project-specific axiom or unfinished proof is used.

This is a meaningful **partial formalization**, not a formal proof of either paper's main theorem. Its strongest completed component is the exact finite binomial coefficient estimate and its integration against a positive measure, conditional on an explicitly supplied factored representation.

## What was actually proved in Lean

1. Ordered products preserve `U* C U=C` when each factor preserves it; an explicit right inverse gives `U*=C U^(-1) C` when `C^2=1`.
2. A strict beta-form endpoint drop rules out unit modulus after the endpoint relation is supplied. The endpoint sign and annulus conclusions follow from explicit scalar inequalities. Neither the differential inequality nor its integration is assumed covertly as an axiom: they are visibly outside the formal statements and must furnish hypotheses.
3. An eigenvector of `U` maps to the corresponding inverse eigenvector and, under form preservation, to an eigenvector of `U*`. Involution guarantees the mapped vector is nonzero. This is **not** a proof of multiplicities, characteristic-polynomial pairing, or exactly half the spectrum lying in each annulus component.
4. Define `e_k` directly as the elementary-symmetric subset sum. Lean derives `|e_k| <= binom(N,k) r^k` from `|lambda_i|<=r`. It derives `e_0=1`, the zero correlation coefficient `sum |e_j|^2`, and its lower bound 1. A proved antidiagonal term estimate followed by mathlib's Vandermonde identity derives
   `|corr_q| <= binom(2N,N+q) r^q sum |e_j|^2` for every natural `q`, `0<=r<=1`.
5. Lean checks the positive-prefactor/unit-modulus-phase bound and its positive-measure integral version. The denominator and numerator integrability, nonnegative prefactor, phase norm, and common eigenvalue bound are explicit hypotheses. The coefficient estimate is derived, not a hypothesis of the final comparison theorem.

The full theorem-to-paper map, exact definitions, all limitations, and reproduction instructions are in `lean-core/README.md`. The finite coefficient argument corresponds to Paper A's `transfer.tex`, Lemma `lem:fourier`; the product and endpoint arguments cover selected steps of Lemma `lem:transfer`.

## Remaining analytic and spectral work

The following are **not** certified by this project:

- Form preservation of the actual matrix exponentials/ODE propagators from the Dirac anticommutation and scalar-kick hypotheses.
- The beta-form derivative identity, strict integrated decrease, nonvanishing of a transported vector, Gronwall, and the substitution `r=exp(-b*m_*)`.
- Adjoint spectral conjugation with algebraic multiplicities, determinant identities, the exact stable-eigenvalue count, centered-trace reality and positivity along a homotopy, or defective-matrix determinant factorization.
- Identification of the defined subset coefficients and finite antidiagonal correlation with the determinant's actual Fourier integral, including negative-charge conjugation.
- Construction and positivity of the physical path measure, the Hubbard--Stratonovich identity, Mehler/Feynman--Kac kernels, local Gauss projection, Trotter/trace-norm limits, and the ground-energy/thermodynamic limits.
- Any Hamiltonian self-adjointness, stability, continuum limit, dynamical nonrelativistic reduction, or point-source estimate.

These are not hidden custom axioms: they are absent from the formalized statements or appear only as plainly stated generic hypotheses. A human still must verify the paper's mathematical proofs and connect the formal data to the physical operators.

## Toolchain and reproducibility

- Lean 4.19.0, compiler commit `6caaee842e94`, official Windows binary archive, installed only in `lean-core/tools/`.
- mathlib revision `c44e0c8ee63ca166450922a373c7409c5d26b00b`, corresponding to tag `v4.19.0`, checked out in `lean-core/vendor/mathlib/`.
- Exact transitive revisions are pinned in `lean-core/dependencies.json` and `lake-manifest.json` and checked by `setup.ps1`.
- Lean archive SHA256: `CF2EAB6EB2A688D07BACDFA7FB60751D93F959ACA04865EE5656523F6E885C8B`.
- Observed mathlib cache helper zip SHA256: `10848B49FAC091BC07BFEE0AB426319E121F1103193F499C17BBD4E9CE604614` (`leantar-0.1.15.exe.zip`).
- All 6,641 matching mathlib cache artifacts were downloaded successfully on first setup. The final build checks the project proof terms against those dependencies.
- No system installation, global PATH modification, registry edit, elan installation, or persistent environment change was made.

The source package should include everything in `lean-core/` except `tools/`, `vendor/`, `.lake/`, and `.cache/`. On fresh extraction, `setup.ps1` downloads the hash-checked Lean distribution, recreates the exact mathlib checkout and dependencies, and fetches matching caches. `build.ps1` performs the build and the explicit axiom audit. The scripts require ordinary Windows PowerShell/Git/curl/tar prerequisites and network access.

The trust base includes the Lean binary/kernel, standard classical axioms, and imported mathlib artifacts. This is not independent verification of the full compiler or dependency supply chain. The inspected official documentation is linked in the project README.

## Recommended status language

“A companion Lean project checks the finite product algebra, selected endpoint implications, an eigenvector-level inverse-adjoint correspondence, and the finite Vandermonde/canonical integration estimate. The analytic and full spectral arguments and the physical theorem remain outside the formalization.”

Avoid “the stability theorem is formally verified,” “the spectral-pairing lemma is fully formalized,” or “the ODE positivity proof is machine checked.”
