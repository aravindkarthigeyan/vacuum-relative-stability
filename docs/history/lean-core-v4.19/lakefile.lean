import Lake
open Lake DSL

package qedCore where
  leanOptions := #[⟨`autoImplicit, false⟩]

require mathlib from "vendor/mathlib"

@[default_target]
lean_lib Core
