# Comparator restatements (stub)

This directory will hold Mathlib-only restatements of the headline results, checked by
Lean's comparator (`lake comparator`, bundled with the pinned toolchain) in the
[comparator workflow](../../.github/workflows/comparator.yml).

**It is still empty.** Lemmas 3.1 and 3.2 are now proved and audited (see
[`../status.json`](../status.json)). A comparator restatement of them, following the
steps below, is a pending step. Until then their statements are protected by the
frozen-anchor manifest and checker, the axiom audit and a `leanchecker` kernel replay
([`../../docs/audits/seal/`](../../docs/audits/seal)).

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
