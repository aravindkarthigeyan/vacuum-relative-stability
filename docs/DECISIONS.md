# Decisions

Decisions on the repository, the Lean toolchain and the status policy, with who made
them. "Author" is Aravind Karthigeyan. "Setup" marks choices made by the coding agent
while turning the research folder into this repository, within the author's
instructions; each can be revisited.

## D1. Repository layout (author, 2026-11-12)

The unversioned research folder was reorganized into `paper-a/`, `paper-b/`,
`companion-notes/`, `drafts/`, `lean/`, `numerics/`, `figures/`, `scripts/` and
`docs/` (with `docs/audits/` and `docs/history/`). Every move was non-overwriting and
nothing was deleted; paper `.tex` sources were moved with their folders and not edited.
[`docs/history/MOVES.md`](history/MOVES.md) lists every move.

- Backups, review bundles and source packages (`*.zip`) were moved to `archives/` and
  are ignored by git; their manifests are tracked in `docs/history/packages/`.
- MiKTeX console logs (`build-output.txt` and similar) are ignored because they record
  local absolute paths. LaTeX `build/` and `tmp/` directories are ignored.
- `LEAN_FORMALIZATION_PROMPTS.md` stays at the root, untracked.
- Relative links in the live documents (`docs/CURRENT_RESEARCH_REPORT.md` and two
  audit reports) were updated to the new paths (setup). Files in `docs/history/` are
  kept verbatim; their links refer to the old layout.

## D2. Toolchain: elan and Lake, Lean v4.35.0, Mathlib v4.35.0 (author request; version choice setup)

The Lean project was pinned to a workspace-local Windows build of Lean 4.19.0 and a
vendored mathlib checkout installed by a custom `setup.ps1`. It is now a standard Lake
project that `elan` and `lake exe cache get` build on any platform, including GitHub's
Ubuntu runners. The pin is the latest stable release on 2026-11-12: Lean `v4.35.0`
and Mathlib tag `v4.35.0` (`lake-manifest.json` records the exact revisions). The
`v4.36.0` release candidates were not used.

Migration changes, all proof-preserving; every theorem kept its name and statement:

1. `Mathlib.Data.Matrix.ConjTranspose` no longer exists; `Core/PseudoUnitary.lean` now
   imports `Mathlib.LinearAlgebra.Matrix.ConjTranspose`.
2. In current Mathlib, `Finset.prod_le_prod` is the ordered-monoid lemma; the
   ordered-semiring version with nonnegativity hypotheses is `Finset.prod_le_prod₀`.
   `norm_elementary_le` now calls `Finset.prod_le_prod₀` with the same arguments.
3. In `correlation_zero`, the deprecated `if_true` became `ite_true`, and the unused
   simp arguments `Prod.fst`, `Prod.snd` were dropped.

The per-theorem axiom sets printed by `scripts/PrintAxioms.lean` are identical to the
original Lean 4.19 audit log in
[`history/lean-core-v4.19/logs/axioms.log`](history/lean-core-v4.19/logs/axioms.log).
The old `tools/`, `vendor/` and build state (renamed `.lake-v4.19/`) remain in `lean/`
locally, ignored by git; the old scripts, manifests, checksums and logs are in
[`history/lean-core-v4.19/`](history/lean-core-v4.19).

## D3. The Lean module system is not adopted (setup)

Mathlib v4.35.0 is written in Lean's module system, so Lake prints a notice for each
Mathlib import of a non-module file. The library is small and has no consumers; it was
kept as ordinary Lean files to keep the migration minimal and to keep the axiom audit,
which runs from a non-module script with full access to proof bodies, simple. Porting
is a mechanical change (a `module` header, `public import`, `public section`,
`@[expose]` on the definitions) and should precede any registry submission.

## D4. Status vocabulary and policy (author vocabulary; policy setup)

Each numbered result of Paper A, identified by its LaTeX label, has one state in
[`lean/status.json`](../lean/status.json): `NOT_STARTED`, `FROZEN_UNPROVED`, `PROVED`
or `AUDITED`.

- A result is `FROZEN_UNPROVED` only when the author has approved an exact Lean
  statement of the result itself, and `PROVED` only when that statement is proved.
  `AUDITED` additionally needs a statement audit by a reviewer who did not write it.
- The checked lemmas in `lean/Core` are conditional statements about single proof
  steps. They are listed separately as supporting lemmas and never change a result's
  state. With this policy all ten results are `NOT_STARTED`.
- `status.json` pins the Paper A LaTeX files by SHA-256. If Paper A changes, the README
  check fails until the manifest has been compared with the new text and the hashes
  updated.

## D5. Axiom and `sorry` audit (author)

[`lean/scripts/AxiomAudit.lean`](../lean/scripts/AxiomAudit.lean) computes, for every
declaration of the library roots (currently `Core`), the axioms it depends on. It fails
on `sorryAx`, on any axiom other than `propext`, `Classical.choice` and `Quot.sound`,
and on any axiom declared in the project. `lean/Audit/` is excluded. The README check
fails if a Lean file outside `Audit/` and `scripts/` is not covered by the audit, or if
the comment-stripped sources contain `sorry`, `admit` or an `axiom` declaration.

The audit was tested on a temporary module containing a `sorry`, a custom axiom and a
`native_decide` proof; it reported all three and failed (setup).

When the first `FROZEN_UNPROVED` statement is added, its `by sorry` will fail this
audit by design. The exemption for registered frozen statements has to be decided
then; until then no `sorry` is admitted outside `Audit/`.

## D6. CI (author request; trigger choice setup)

[`build.yml`](../.github/workflows/build.yml) runs `lake exe cache get`, `lake build`,
the axiom audit, the per-theorem report and `scripts/update_readme.py --check` on every
push and pull request to `main`. It is not kept as a manual-dispatch draft because the
repository starts private and the README badge should reflect real runs.
[`comparator.yml`](../.github/workflows/comparator.yml) is a manual-dispatch stub: no
Paper A result has a proved Lean statement to restate (see
[`lean/Audit/README.md`](../lean/Audit/README.md)).

## D7. Generated README (author)

Every number in `README.md`, and the count table in
[ERRATA-AND-DEVIATIONS.md](ERRATA-AND-DEVIATIONS.md), comes from
[`scripts/update_readme.py`](../scripts/update_readme.py), which reads `status.json`,
the audit report, the Lean sources, the pinned Paper A sources and the errata record.
The Lean statements in the README are pasted verbatim between
`<!-- BEGIN verbatim -->` and `<!-- END verbatim -->`. CI fails if the committed README
differs from what the script generates.

## D8. Names (setup)

The library keeps its root `Core` and namespace `QEDCore`, so that all declaration
names of the original project are unchanged.

## D9. License (author)

The code (`lean/`, `scripts/`, `numerics/`, `.github/`) is released under the Apache
License 2.0. The papers, their LaTeX sources, the figures and the documentation are not
licensed yet.

## D10. Not done in this setup

No remote was created and nothing was pushed. No independent review of the release
tree, the errata record or the statement correspondence has been made; the
`lean-public-release` checklist (forbidden-reference scrub, fresh-checkout build,
independent review) remains to be completed before the repository is made public.
