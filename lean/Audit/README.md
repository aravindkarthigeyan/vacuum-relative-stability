# Comparator restatements (stub)

This directory will hold Mathlib-only restatements of the headline results, checked by
Lean's comparator (`lake comparator`, bundled with the pinned toolchain) in the
[comparator workflow](../../.github/workflows/comparator.yml).

**It is empty on purpose.** No numbered result of Paper A has a proved Lean statement
yet (see [`../status.json`](../status.json)), and the conditional supporting lemmas in
`Core/` are not headline theorems. A comparator check of them would certify only
that they are what they say, which the build and the
[axiom audit](../scripts/Audit/AxiomAudit.lean) already do.

## When the first Paper A result is proved

1. `Audit/Challenge.lean`: imports only Mathlib. It repeats, verbatim, every
   definition the frozen statement uses and the statement itself, with proof `sorry`.
   This file is meant to be read against the paper.
2. `Audit/Solution.lean`: the same declarations, with the theorem proved from the
   library (`by exact QEDCore.<name>`).
3. `lean/comparator.json`:

   ```json
   {
     "challenge_module": "Audit.Challenge",
     "solution_module": "Audit.Solution",
     "theorem_names": ["QEDCore.<name>"],
     "definition_names": [],
     "permitted_axioms": ["propext", "Quot.sound", "Classical.choice"],
     "external_kernels": {"nanoda": ["nanoda_bin"]}
   }
   ```

4. Add `lean_lib Audit` to `lakefile.lean`, and push/pull-request triggers to the
   comparator workflow.

Files here are excluded from the axiom audit, which forbids `sorry` everywhere else.
Run the check locally (Linux, needs [bubblewrap](https://github.com/containers/bubblewrap)):

```bash
cd lean
lake exe cache get && lake build
PATH="$(lean --print-prefix)/bin:$PATH" lake comparator
```
