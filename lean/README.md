# Lean library `Core`: checked finite steps for Paper A

This is a **partial** formalization. It does not prove the lattice stability
theorem of Paper A. It proves Lemmas 3.1 and 3.2 for piecewise-constant histories: their
author-approved statements are frozen in `Frozen/`, their proofs are in `Core/PaperA/`,
and both are audited. The library also keeps older conditional lemmas for steps of
Lemma 3.1, Lemma 3.2 and Theorem 4.1. Time-dependent histories, the Hamiltonian
construction, the path measure and all limits remain proofs in the paper.

- [`../docs/CORRESPONDENCE.md`](../docs/CORRESPONDENCE.md): what each declaration
  checks and where the boundary to the paper lies.
- [`status.json`](status.json): the state of every numbered result of Paper A and the
  list of checked supporting lemmas. The README statistics are generated from it.

## Layout

| Path | Contents |
|---|---|
| `Core.lean`, `Core/` | The library (namespace `QEDCore`). `Core/PaperA/Defs/` holds the nine frozen definitions of the Paper A statements; `Core/PaperA/Provider/` will hold their proofs. |
| `Frozen/` | The frozen theorem statements (library `Frozen`, imported by nothing in `Core`). |
| `frozen-manifest.json` | Hashes, source ranges and states of every frozen file; checked by `../scripts/check_frozen_anchors.py`. |
| `scripts/Audit/AxiomAudit.lean` | Axiom and `sorry` audit of every declaration of `Core` and `Frozen`; admits `sorry` only in manifested `DRAFT_SORRY` statements; writes `.lake/axiom-audit.json`. |
| `scripts/PrintAxioms.lean` | `#print axioms` for each listed theorem, for human reading. |
| `Audit/` | Comparator restatements (empty stub; see [`Audit/README.md`](Audit/README.md)). Excluded from the audit. |
| `status.json` | Status manifest. |
| `lakefile.lean`, `lean-toolchain`, `lake-manifest.json` | Lean v4.35.0 and Mathlib v4.35.0, pinned. |

## Build and check

Install [elan](https://github.com/leanprover/elan); it reads `lean-toolchain`. Then,
in this directory:

```bash
lake exe cache get                     # Mathlib's prebuilt files
lake build                             # Lean checks every proof
lake env lean scripts/Audit/AxiomAudit.lean  # fails on unregistered sorry or non-standard axioms
lake env lean scripts/PrintAxioms.lean # optional: per-theorem report
```

Then, from the repository root,
`python3 -I scripts/check_frozen_anchors.py --root lean --manifest lean/frozen-manifest.json --allow-non-module`
checks the frozen files against the manifest, and
`python3 -I scripts/update_readme.py --check` checks
`status.json` against the audit report and the pinned Paper A sources, and that the
generated README sections are current. Avoid `lake update` and `lake clean` when
verifying this version.

## Retired Windows toolchain

Until November 2026 the project was pinned to a workspace-local Windows build of
Lean 4.19.0 and a vendored mathlib checkout (tag `v4.19.0`), installed by a custom
`setup.ps1`. Those scripts, the old manifests, source checksums and the original
build and audit logs are kept in
[`../docs/history/lean-core-v4.19/`](../docs/history/lean-core-v4.19). The downloaded
`tools/` and `vendor/` directories and the old build state `.lake-v4.19/` may still
be present locally; they are ignored by git and unused by the current build.
