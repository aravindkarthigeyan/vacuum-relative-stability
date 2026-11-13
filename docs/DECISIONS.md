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
then; until then no `sorry` is admitted outside `Audit/`. *Superseded by D12 on
2026-11-12: the audit moved to `lean/scripts/Audit/AxiomAudit.lean` and admits
`sorryAx` only for manifested `DRAFT_SORRY` theorems.*

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

## D11. Rulings on the frozen statements of Lemmas 3.1 and 3.2 (author, 2026-11-12)

The author approved the proposed declarations v1 (archived byte for byte, with their
SHA-256, in [`audits/pilot/audited-draft-v1.lean.txt`](audits/pilot/audited-draft-v1.lean.txt))
with the words "Approve with R1(a)", which also accepted R2–R4 as proposed:

- **R1(a).** Lemmas 3.1 and 3.2 are frozen for finite piecewise-constant histories:
  free steps `exp(-τ h)` with `τ ≥ 0`, constant Hermitian `v_j` and constant
  `M ≥ m_* I`, and separate instantaneous spin-scalar kicks `exp(i Θ ⊗ 1)`. The
  time-dependent (continuous or bounded measurable) case is not covered; it would
  be a separately frozen approximation result, outside the current campaign. The
  alternative R1(b), an ODE carrier with coefficient paths, was declined.
- **R2.** The spatial factor is `ℓ²(ι)` for any finite type `ι` (empty allowed), with
  `d` a binder satisfying `4|ι| = 2d`, and any Hermitian 4×4 Clifford set.
- **R3.** In Lemma 3.2, `|F_q| ≤ … F_0` is stated as `Im F_0 = 0` together with
  `|F_q| ≤ … · Re F_0`.
- **R4.** Kicks are parameterized by a Hermitian generator `Θ`, with the centering
  phase computed from `Θ`.

Two independent statement audits (fresh sessions, refute-first) found no EXCESS
binder other than the history-class restriction that R1(a) rules on, and no false
or vacuous statement: [`audits/pilot/`](audits/pilot). The resulting deviations are
entries 7 and 8 in [ERRATA-AND-DEVIATIONS.md](ERRATA-AND-DEVIATIONS.md).

## D12. Frozen-anchor workflow (author brief; mechanics setup, 2026-11-12)

- **Files.** One declaration per file. The six definitions are in
  `lean/Core/PaperA/Defs/` and part of `Core`; the two theorems are in
  `lean/Frozen/PaperA/`, a separate library that nothing in `Core` imports. Each
  theorem imports its provider module `lean/Core/PaperA/Provider/…`, where the proof
  will be written; sealing replaces only `by sorry` by a short exact use of the
  provider's theorem. The declarations are byte-identical to the approved v1 text;
  the files add a copyright header, per-file imports, docstrings for the two
  theorems, and the proof-region markers. One import differs from the draft: the
  deprecated `Mathlib.Data.Complex.Basic` became `Mathlib.Basic.Complex.Basic`.
- **Manifest.** [`lean/frozen-manifest.json`](../lean/frozen-manifest.json), in the
  schema of the `lean-orchestrator` skill: per anchor the source range and revision,
  approval, whole-file hash (definitions) or prefix and suffix hashes around the
  proof body (theorems), the definition closure with hashes, and `abi_sha256`, the
  SHA-256 of the elaborated signature that the axiom audit prints (a theorem's type;
  a definition's type and value; an inductive type and its constructors). The
  manifest was generated once by an untracked script; there is deliberately no
  tracked rebaseline command.
- **Checks.** [`scripts/check_frozen_anchors.py`](../scripts/check_frozen_anchors.py)
  (the skill's checker with four documented adaptations: it skips the retired
  `vendor/`, `tools/` and `.lake*` directories, accepts a literal `inductive` as a
  definition anchor, lets an allowlisted audit file reach a draft's provider through
  the draft's own import, and compares paths in POSIX form) verifies every frozen
  byte, the exact `by sorry` body of each draft, the import quarantine and the
  absence of any other `sorry` or `axiom`. The axiom audit, now
  `lean/scripts/Audit/AxiomAudit.lean` because the checker allows a draft to be
  imported only from an `Audit` directory, admits `sorryAx` only for manifested
  `DRAFT_SORRY` theorems and reports the elaborated signatures;
  `scripts/update_readme.py --check` compares their hashes with the manifest and
  accepts a `sorry` only in a draft's file. CI runs all three. The checker was
  mutation-tested on 2026-11-12: a stray `sorry`, a one-byte change to a frozen
  definition, `Core` importing a provider, an ordinary module importing a draft, and
  an altered draft body each fail it.
- **Module system.** The frozen files follow D3 (no module system), so the checker
  runs with `--allow-non-module`. A later port moves their bytes and must be recorded
  as a semantics-neutral hash change.

## D13. GitHub repository (author request, 2026-11-12)

The repository is published as the **private** GitHub repository
`aravindkarthigeyan/vacuum-relative-stability`, the name the README badges already
used, with `main` as the default branch. D6's CI runs on every push. Making it public
still requires the `lean-public-release` checklist of D10.

## D14. Source dependency graph (author brief step 3; mechanics setup, 2026-11-12)

The source-level dependency graph of the two frozen roots is
[`graph/DEPGRAPH.md`](graph/DEPGRAPH.md), with the coverage inventory
[`graph/DEPGRAPH_COVERAGE.md`](graph/DEPGRAPH_COVERAGE.md), in the schema of the
`build-proof-dependency-graph` skill. It binds its eight frozen nodes to
`lean/frozen-manifest.json` by anchor ID, path, export, contract and ABI hash, and
pins the manifest by SHA-256, so a manifest change fails the graph check.

- **Extraction.** The corpus is small (transfer.tex and 17 lines of model.tex), so it
  was extracted as one slice by the orchestrator, which is also the single writer.
  Every node was reviewed by a fresh agent, and the root closure by a second, distinct
  fresh agent; their reports are in [`audits/graph/`](audits/graph).
- **Source gaps.** A step the paper asserts without an argument beyond naming a
  method is a node whose `NOTE` starts with `SOURCE_GAP:`, graded `[minor]` or
  `[substantive]`. A gap is a place where a proof must supply an argument; it is not
  an erratum unless the asserted step is false.
- **Linter.** [`scripts/proof_depgraph.py`](../scripts/proof_depgraph.py) is the
  skill's linter with one adaptation: a frozen file is resolved relative to the
  manifest's directory (`lean/`), since the manifest's Lean paths are relative to
  `lean/` while source locators are relative to the repository root. CI runs it with
  `--require-reviewed --require-complete-coverage --require-initial-lean-status
  --require-all-reachable --check`.
- **Maintenance.** After publication, structural corrections are append-only `AMEND`
  records with an independent reviewer; a frozen node's source fields never change.

## D15. Proof campaign mechanics (author brief step 4; setup, 2026-11-12)

- **Compile gate.** [`scripts/lean-gate.sh`](../scripts/lean-gate.sh) allows at most two
  Lean or Lake commands at once on the machine, as the author requires for this laptop.
  The `lean-orchestrator` skill's gate needs `flock` and replaces the `lean` binary; Git
  Bash on Windows has no `flock`, so the repository gate uses atomic `mkdir` slots
  (recording the owner's PID and reclaimed when it dies) and wraps commands instead.
  Every worker and orchestrator command of the campaign runs through it.
- **Workers.** Bounded briefs with exact target statements, owned files, one validation
  command and a stop condition. Workers report an API gap or a false target instead of
  adding a hypothesis. Sonnet does Mathlib search and routine lemmas; Opus does the matrix
  exponential, the β-form calculus, the spectral pairing, the Fourier integral and the
  homotopy. The board is [`campaign/TASKS.md`](campaign/TASKS.md).
- **Helper modules.** Helpers are sorry-free and live in `lean/Core/PaperA/Transfer/` and
  `lean/Core/PaperA/Fourier/`. They are imported by `Core.lean` and covered by the axiom
  audit once landed. A helper may take premises: the provider discharges them at the
  frozen statement, whose binders never change. The helper predicates `IsDiracClifford`
  (the six Clifford hypotheses of the frozen statements) and `Step.IsHermitianData` are
  conveniences for these internal lemmas, not source-facing definitions.
- **Route.** The β-form estimate is formalized per free step as two unconditional bounds
  plus a strict drop, which replaces the source's trajectory-sign case split
  (campaign/TASKS.md). The source graph is unchanged.
