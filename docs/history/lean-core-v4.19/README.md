# Checked finite core for the QED stability project

This is a partial Lean formalization. It does **not** formalize the lattice or momentum-cutoff stability theorem. It checks 23 conditional algebraic, finite-coefficient, and integration lemmas used in those arguments. The ODE, full spectral pairing, determinant identification, Hamiltonian construction, and limiting arguments remain mathematical proofs in the papers.

## Reproduce on Windows

Requirements: PowerShell, Git, `curl.exe`, `tar.exe` with zstd support, and network access. From this directory run:

```powershell
./setup.ps1
./build.ps1
```

The setup uses a workspace-local binary distribution and mathlib checkout. It does not install elan, modify the registry, or change the persistent system/user PATH. All PATH changes are process-local. `tools/`, `vendor/`, `.lake/`, and `.cache/` are deliberately excluded from the source package; setup recreates them. The first setup downloads a 342,100,944-byte Lean archive and the matching mathlib compiled cache, and requires several GB of disk space.

The checked toolchain is Lean **4.19.0**, compiler commit `6caaee842e94`, with mathlib commit **`c44e0c8ee63ca166450922a373c7409c5d26b00b`** (tag `v4.19.0`). The choice is an explicit reproducibility pin, not a claim that this is the latest release. `setup.ps1` verifies the Lean archive SHA256, mathlib commit, and every transitive dependency revision in `dependencies.json`.

The official Lean Windows archive is:

`https://github.com/leanprover/lean4/releases/download/v4.19.0/lean-4.19.0-windows.tar.zst`

SHA256:

`CF2EAB6EB2A688D07BACDFA7FB60751D93F959ACA04865EE5656523F6E885C8B`

The cache helper downloaded by the pinned mathlib cache program is `leantar-0.1.15.exe.zip` (723,675 bytes), with observed SHA256:

`10848B49FAC091BC07BFEE0AB426319E121F1103193F499C17BBD4E9CE604614`

The helper hash is recorded for provenance; the helper is managed by mathlib's pinned cache program. It is not a proof axiom or a separately trusted mathematical oracle.

## Checked theorem-to-paper map

All names below have the prefix `QEDCore.`. Paper A references are to `paper-a-lattice/transfer.tex`; the same finite core is used in Paper B and in the combined paper's `mass-gap.tex`.

| Lean file and principal names | Checked content | Paper location / boundary |
|---|---|---|
| `Core/PseudoUnitary.lean`: `preservesForm_mul`, `preservesForm_list_prod` | If every factor satisfies `star U * C * U = C`, so does the ordered product. | Lemma `lem:transfer`, product algebra. Form preservation of each exponential/kick is an **input**, not established by this file. |
| `adjoint_eq_conjugate_inverse` | From `C*C=1`, `U*V=1`, and form preservation, derive `star U=C*V*C`. | The inverse-adjoint identity in Lemma `lem:transfer`; invertibility is supplied explicitly. |
| Five endpoint lemmas in `Core/PseudoUnitary.lean` | A strict beta-form drop and `BT=t*B0` exclude `t=1`, determine the sign of `B0`, and permit division of an assumed endpoint contraction inequality. | Consequences of equation `eq:beta-form`. The derivative formula, strict drop, Gronwall estimate, and identification `t=abs(lambda)^2` are **not** formalized. |
| `Core/Eigenvectors.lean`: `inverse_eigenvector`, `involution_mulVec_ne_zero`, `adjoint_inverse_eigenvector` | `Ux=lambda*x` implies `Vx=lambda^(-1)*x` for an explicit inverse; `Cx` is nonzero; `U* (Cx)=lambda^(-1)*(Cx)`. | Eigenvector-level inverse-adjoint correspondence only. No characteristic-polynomial conjugation, algebraic multiplicity statement, or exact count of stable eigenvalues is claimed. |
| `Core/Coefficients.lean`: `norm_elementary_le` | Subset products directly give `norm(e_k) <= choose(N,k)*r^k`. | Elementary-symmetric estimate in Lemma `lem:fourier`; the estimate is **derived**, not assumed. |
| `elementary_zero`, `correlation_zero`, `one_le_vacuumWeight` | Derive `e_0=1`, identify the zero antidiagonal coefficient with `sum norm(e_j)^2`, and derive its lower bound 1. | Vacuum coefficient normalization in Lemma `lem:fourier`. |
| `norm_correlation_le`, `elementary_correlation_bound`, `relative_correlation_bound` | For `0<=r<=1` and all `norm(lambda_i)<=r`, derive the exact binomial bound `choose(2N,N+q)*r^q`, including the vacuum-weight denominator. | Finite coefficient calculation in `eq:fourier-bound`, for natural `q`. Formal identification with the determinant's Fourier integral and negative-charge conjugation is still outside the project. |
| `Core/PositiveMeasure.lean` | Norm of an integrable complex integral is bounded by a positive-measure integral majorant; unit-modulus phases preserve bounds. | Absolute-value and positive-measure step in the canonical argument. Both numerator and weight integrability are explicit hypotheses. |
| `Core/CanonicalComparison.lean`: `scaled_coefficient_comparison`, `canonical_integral_comparison` | Combines the derived finite coefficient estimate with a nonnegative prefactor, unit-modulus phase, and positive measure. | Conditional canonical comparison. The physical determinant representation, positivity of its prefactor, Hubbard--Stratonovich/Mehler/Gauss representations, and all limits are **inputs still to be supplied**. |

## Exact finite quantity checked

For `lambda : Fin N -> Complex`, `elementary lambda k` is the sum of products over all `k`-element subsets. For an arbitrary coefficient sequence `a`, the project defines

```text
correlation N q a =
  sum_{i+j=N+q, i<=N, j<=N} a_i * conjugate(a_{N-j}),
vacuumWeight N a = sum_{j=0}^N norm(a_j)^2.
```

The antidiagonal expression is the algebraic coefficient of degree `N+q` in a polynomial times its reversed conjugate. The Lean definition is the explicit finite sum: the polynomial-coefficient and Fourier-integral identifications are not silently inserted as axioms. For natural `q`, the final finite bound is

```text
norm(correlation N q (elementary lambda))
  <= choose(2N,N+q) * r^q * vacuumWeight N (elementary lambda).
```

The binomial coefficient is obtained by the existing mathlib Vandermonde theorem, after a proved termwise estimate; it is not supplied as a hypothesis. The result also covers `q>N`, where both the binomial bound and the correlation vanish.

## Verification and trust boundary

`lake build` checks all imported project proofs. `Audit.lean` runs `#print axioms` on all 23 theorems. `build.ps1` rejects `sorryAx` or any reported axiom outside `propext`, `Classical.choice`, and `Quot.sound`. The current log reports only these standard Lean foundations. There are no project-specific axiom declarations, unfinished proof placeholders, or native-decision proof oracles.

The trust base includes the downloaded Lean executable/kernel, standard axioms, and matching mathlib artifacts. A build with precompiled dependency caches is the normal Lean workflow; this deliverable does not claim to independently recheck every mathlib dependency with a separate kernel implementation or to validate the compiler supply chain. The project proofs themselves are elaborated and checked by Lean in the saved build.

The mathematical truth and relevance of the statements still require a reader to inspect the formal hypotheses and their identification with the paper. Compilation does not validate the unformalized physics or prove that an informal theorem has been faithfully encoded.

## Primary documentation used

- [Official Lean installation documentation](https://lean-lang.org/install/).
- [Lean's account of its standard axioms](https://lean-lang.org/theorem_proving_in_lean4/Axioms-and-Computation/).
- [Lean community project and cache instructions](https://leanprover-community.github.io/install/project.html).
- Pinned mathlib source was inspected locally for `Finset.mem_powersetCard`, `Finset.card_powersetCard`, `Nat.add_choose_eq`, `Matrix.mulVec_mulVec`, and `MeasureTheory.integral_mono_ae`; the exact dependency revision is recorded above.

See `logs/build.log`, `logs/axioms.log`, `logs/setup.log`, `logs/cache.log`, `dependencies.json`, and `lake-manifest.json` for reproducibility evidence. Earlier development logs are retained separately and do not replace the final build/audit logs.
