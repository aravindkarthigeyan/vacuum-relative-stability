import Lake
open Lake DSL

package qedCore where
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.35.0"

/-- The library: helper lemmas, the frozen Paper A definitions and the proofs. -/
@[default_target]
lean_lib Core

/-- Author-approved frozen statements (see `frozen-manifest.json`). Nothing in `Core`
imports them; while a statement's proof is `sorry` it is quarantined by
`scripts/check_frozen_anchors.py`. -/
@[default_target]
lean_lib Frozen where
  globs := #[.submodules `Frozen]
