# Seal audit 1: `lem_fourier_v1` (Paper A, Lemma 3.2)

Independent, refute-first audit of the sealed frozen theorem
`QEDCore.PaperA.canonical_fourier_bound`, with emphasis on statement fidelity and seal
integrity. The auditor did not write any of the audited code. Dates 2026-11-12/13;
repository HEAD `422b189` (working tree clean throughout); Lean v4.35.0, Mathlib v4.35.0.

All Lean checks were transient files under `lean/.lake/scratch/audit3/`, compiled through
`bash ../scripts/lean-gate.sh lake env lean <file>` from `lean/`, and deleted after the run.
No tracked file other than this report was touched; no state-changing git command was run.

## 1. Pinned target and recomputed hashes

Manifest `lean/frozen-manifest.json` (SHA-256
`40c3c09f12a467fc0bb84ad0e8ed0b42343b9f58844179b44e596e190e65cbda`), entry `lem_fourier_v1`:

| Field | Manifest | Recomputed / observed |
|---|---|---|
| kind / state | theorem / SEALED | theorem / SEALED |
| path | `Frozen/PaperA/CanonicalFourierBound.lean` | exists; 2740 bytes, LF line endings, no BOM; working copy = `HEAD` blob (`1eed1f5f5788f835f4ee528373c8db0a0e2cc73534f395d68682b4b774a4c2d6`) |
| export | `QEDCore.PaperA.canonical_fourier_bound` | the only declaration in the file |
| implementation | `Core.PaperA.Provider.CanonicalFourierBound` / `QEDCore.PaperA.Provider.canonical_fourier_bound` | declared exactly once in that module (its only declaration) |
| source | transfer.tex `b2dcc793…c698cf`, range 93–130 | `b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf` |
| contract / split | `paper-a.lem:fourier` v1 / NOT_SPLIT, `docs/DECISIONS.md#d11` | consistent with D11 |
| `prefix_sha256` | `5fd81d9cdc86adbc4906ecedce0cf4235927467d2f90c8f25e4a78d91e5bbb8d` | **MATCH** |
| `suffix_sha256` | `a76b93d165dbe18cb2e511588d18edbea48f51c3b0ebc1f430f611de2436f9aa` | **MATCH** |
| `abi_sha256` | `7e2b22d01f60c80db633656f9f12a19b5b7429d6656300750f12cbcdf3e388aa` | **MATCH** (recomputed in the post-seal environment, §6) |
| approval | Aravind Karthigeyan, 2026-11-12, `docs/DECISIONS.md#d11`, v1 | D11 present |
| `draft_allowlist` | frozen_paths `[]`, audit_paths `[scripts/Audit/AxiomAudit.lean]` | file exists |

Prefix and suffix were computed exactly as `scripts/check_frozen_anchors.py`
(`check_theorem_region`) defines them: prefix = every character up to and including the
newline that ends the `-- FROZEN_ANCHOR_PROOF_BEGIN` line; suffix = everything from the start
of the `-- FROZEN_ANCHOR_PROOF_END` line to the end of the file; each UTF-8 encoded and
hashed. The same two hashes were obtained for the freeze-commit version of the file
(`git show 6e68e3a:…`), whose body was `  by sorry`.

Definition closure (whole-file SHA-256). Each equals the closure entry of `lem_fourier_v1`
and the `full_file_sha256` of its own SEALED definition anchor; the ABI column is the
elaborated-signature hash recomputed in the post-seal environment (§6, Probe 2):

| File | SHA-256 | closure | own anchor | ABI |
|---|---|---|---|---|
| `Core/PaperA/Defs/Step.lean` | `599e912a79908055bd6b40919aa06a9d885823470b3aedcb5a297b736e0ce1b2` | MATCH | `def_step_v1` MATCH | MATCH |
| `Core/PaperA/Defs/DiracOperator.lean` | `75ec4f635a0872f7bb25cfb593a07e3674fdd5e87d142780bac8fe01cd8caf68` | MATCH | `def_dirac_operator_v1` MATCH | MATCH |
| `Core/PaperA/Defs/StepGenerator.lean` | `f2204d490751508e616a9aaccc09b8b8d919b2df00eaafddf5779cdd9a05d89e` | MATCH | `def_step_generator_v1` MATCH | MATCH |
| `Core/PaperA/Defs/StepFreeTime.lean` | `1ed87b1ce3052d1fe0a798cefe5601c3d1272cb91a95dc6784197a0f8522e613` | MATCH | `def_step_free_time_v1` MATCH | MATCH |
| `Core/PaperA/Defs/TransferMatrix.lean` | `4a15618f6c2a8f08d96906d4759d6afc4527cb089b614552b77a5404d65e4e96` | MATCH | `def_transfer_matrix_v1` MATCH | MATCH |
| `Core/PaperA/Defs/CenteredTrace.lean` | `edd9450999f0e874e59d79caf986b54be37d6df67f0a9b0666aaea9b7dea2261` | MATCH | `def_centered_trace_v1` MATCH | MATCH |

Source pins (`lean/status.json`, `source.pinned_sha256`): all six Paper A files recomputed
and equal; in particular transfer.tex `b2dcc793…c698cf` and model.tex
`2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e`.

Checker (`scripts/check_frozen_anchors.py`, SHA-256
`8a190ea73b28da3b786f7f30835939cb6d9b8d9db9fa197d6cb70451de9256bb`), from the repository root:

```
$ python -I scripts/check_frozen_anchors.py --root lean --manifest lean/frozen-manifest.json --allow-non-module
FROZEN-ANCHOR GUARD OK
exit=0
```

`lake build Frozen.PaperA.CanonicalFourierBound` (through the gate): `Build completed
successfully (3691 jobs)`; only the Mathlib module-system import warnings.

## 2. Identity with the author-approved text

Approved draft `docs/audits/pilot/audited-draft-v1.lean.txt`: SHA-256
`13952055e164b3a4eefd8ba22b225368184640d194474c8986f9fd10ad883d91` (**MATCH** with D11 and
with the `HEAD` blob).

Byte comparison (script): the span from `theorem canonical_fourier_bound` through
`(Fhat 0).re :=` is 1230 bytes with SHA-256
`e709021d0bfbd542fa43e049de603e2e85f4efbab45807efb26df71643fbaee8` in **all three** of the
approved draft (block T2), the frozen file, and the provider. The surrounding context is the
same in draft and frozen file: `namespace QEDCore.PaperA`, `open Matrix`,
`open scoped Kronecker ComplexOrder` (the `ComplexOrder` scope is load-bearing: it supplies
the order on `ℂ` that `Matrix.PosSemidef` needs). The frozen file differs from the draft only
in the copyright header, its per-file imports (provider, `Defs.CenteredTrace`,
`Defs.StepFreeTime`, and three Mathlib modules), the module docstring, the theorem docstring,
and the five proof-region markers. The draft's trailing `#check`/`#print` lines are not
declarations. The elaborated statement is pinned independently by the ABI hash (§6).

History (`git log -p -- lean/Frozen/PaperA/CanonicalFourierBound.lean`): two commits.
`6e68e3a` (freeze, DRAFT_SORRY) created the file with body `  by sorry`; `422b189` (seal)
changed exactly the body:

```diff
 -- FROZEN_ANCHOR_PROOF_BEGIN
-  by sorry
+  by exact QEDCore.PaperA.Provider.canonical_fourier_bound α β hα_herm hβ_herm hα_sq hβ_sq
+      hα_anti hαβ_anti d hd mStar b hm hb hist hfree hkick htime q hq
 -- FROZEN_ANCHOR_PROOF_END
```

`lean/Core/PaperA/Defs/` has no commit after `6e68e3a`. The manifest's history for this
entry is creation in `6e68e3a` and the single line `"state": "DRAFT_SORRY"` → `"SEALED"` in
`422b189`; its hashes, ABI and closure are unchanged since the freeze.

## 3. Source reconstruction (independent)

Read from paper-a/transfer.tex L6–L7, L9–L26 (the histories of Lemma 3.1), L83–L88 (kick
centering), L93–L104 (the statement), L105–L130 (the proof, for meaning only), and
paper-a/model.tex L27–L28, with D11 (R1(a)–R4) and deviations 7–8.

Premises. One-particle space of dimension `D = 2d` with the four-component Dirac structure
(L6–L7): `α_1, α_2, α_3, β` Hermitian 4×4, squaring to one, pairwise anticommuting (model
L27–L28). A history of Lemma 3.1 (L11–L26): ordered free evolutions generated by
`h = Σ_j α_j v_j + β M` with `M ≥ m_* I > 0` and bounded Hermitian `v_j`, free time
`∫ c = b > 0` with `c ≥ 0`, interspersed with spin-scalar unitary kicks `e^{iΦ}`, `Φ`
Hermitian; R1(a) restricts this to finite lists of constant free steps (`τ ≥ 0`) and separate
kicks, R4 parameterizes kicks by a Hermitian generator `Θ`, R2 takes the spatial factor
`ℓ²(ι)` for any finite `ι` with `4|ι| = 2d`. Then: append the global twist `e^{iφQ}`,
`Q = dΓ(I) − d` (L95–L96); `F(φ)` is the centered trace (3.1) of the extended history (L97);
`F_q = (2π)⁻¹ ∫_0^{2π} e^{−iqφ} F(φ) dφ` for integers `q` (L98).

Conclusion. For integers `|q| ≤ d`: `|F_q| ≤ binom(2d, d+|q|) e^{−b m_* |q|} F_0` (3.4),
where the right side is real (the proof shows `F_0 = C Σ|e_j|² > 0`, L120); by R3 this is
`Im F_0 = 0 ∧ |F_q| ≤ binom(2d, d+|q|) e^{−b m_* |q|} · Re F_0`. All quantifiers are
universal; there are no existential witnesses, and the constants `binom(2d, d+|q|)` and
`e^{−b m_* |q|}` are explicit in `d, b, m_*, q`.

## 4. Five-bin binder test

All 23 binders of the elaborated type, in order (binder infos and names read from the
elaborated `ConstantInfo.type`, §6). There is no project-owned Prop alias or bundle: the
binder types use only Mathlib notions (`IsHermitian`, `PosSemidef`, `Fintype.card`,
`List.Mem`, `List.sum`) and the frozen definitions `Step`, `Step.free`, `Step.kick`,
`Step.freeTime` (P3 in §6 lists every project constant in the type). The conjunction `hfree`
is expanded into its three conjuncts, giving 25 logical inputs.

| # | Binder | Lean type (abridged) | Bin | Citation |
|---|---|---|---|---|
| 1 | `ι` (implicit) | `Type u_1` | RULED | R2 (spatial factor `ℓ²(ι)`, any finite type; source: `ℓ²(X)`, model L9, transfer L6) |
| 2 | `[Fintype ι]` | instance | RULED | R2 ("any finite type") |
| 3 | `[DecidableEq ι]` | instance | TYPING | needed to form `1 : Matrix ι ι ℂ` and `det`; no mathematical content |
| 4 | `α` | `Fin 3 → Matrix (Fin 4) (Fin 4) ℂ` | STANDING | model L27; transfer L6–L7 ("same four-component Dirac structure") |
| 5 | `β` | `Matrix (Fin 4) (Fin 4) ℂ` | STANDING | model L27 |
| 6 | `hα_herm` | `∀ j, (α j).IsHermitian` | STANDING | model L27 ("Hermitian") |
| 7 | `hβ_herm` | `β.IsHermitian` | STANDING | model L27 |
| 8 | `hα_sq` | `∀ j, α j * α j = 1` | STANDING | model L27–L28 ("square to one") |
| 9 | `hβ_sq` | `β * β = 1` | STANDING | model L27–L28 |
| 10 | `hα_anti` | `∀ j k, j ≠ k → α j α k + α k α j = 0` | STANDING | model L28 ("anticommute pairwise") |
| 11 | `hαβ_anti` | `∀ j, α j β + β α j = 0` | STANDING | model L28 |
| 12 | `d` | `ℕ` | SOURCE | transfer L6 (`D = 2d`), L96, L99, L101 |
| 13 | `hd` | `4 * Fintype.card ι = 2 * d` | RULED | R2 (`4|ι| = 2d`; source `D = 2d`, L6) |
| 14 | `mStar` | `ℝ` | SOURCE | L13 (`m_*`) |
| 15 | `b` | `ℝ` | SOURCE | L15 (total free time `b`) |
| 16 | `hm` | `0 < mStar` | SOURCE | L13 (`M ≥ m_* I > 0`) |
| 17 | `hb` | `0 < b` | SOURCE | L15 (`b > 0`) |
| 18 | `hist` | `List (Step ι)` | RULED | R1(a) (a history of Lemma 3.1, L95, as a finite list of constant free steps and separate kicks) |
| 19a | `hfree`, conjunct 1 | `0 ≤ τ` for each free step | RULED | R1(a) (`τ ≥ 0`; source `c ≥ 0`, L25) |
| 19b | `hfree`, conjunct 2 | `∀ j, (v j).IsHermitian` | SOURCE | L15 ("Hermitian spatial coefficients"; boundedness automatic in finite dimension) |
| 19c | `hfree`, conjunct 3 | `(M - (mStar : ℂ) • 1).PosSemidef` | SOURCE | L13 (`M ≥ m_* I`; Loewner order, includes `M` Hermitian) |
| 20 | `hkick` | `∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian` | RULED | R4 (Hermitian generator; source `Φ` Hermitian, L26; spin-scalar by construction `Θ ⊗ 1` in `Step.generator`) |
| 21 | `htime` | `(hist.map Step.freeTime).sum = b` | SOURCE | L15, L25 (`∫ c = b`) |
| 22 | `q` | `ℤ` | SOURCE | L98–L99 (integer Fourier index) |
| 23 | `hq` | `|q| ≤ ↑d` | SOURCE | L99 ("For `|q| ≤ d`") |

Counts (25 expanded inputs from 23 binders): **SOURCE 10** (12, 14, 15, 16, 17, 19b, 19c,
21, 22, 23), **STANDING 8** (4–11), **TYPING 1** (3), **RULED 6** (1, 2, 13, 18, 19a, 20),
**EXCESS 0**.

Missing-premise check (the other direction): every source premise is present. The source's
"spin-scalar" and "commute with Dirac matrices" conditions are built into the carriers
(`v j ⊗ₖ α j`, `M ⊗ₖ β`, `Θ ⊗ₖ 1` in the frozen definitions); "bounded" is automatic in finite
dimension; the time-dependent and simultaneous free-plus-kick cases are excluded only by
R1(a) (deviation 7). Order and scope: all binders are universal and precede the conclusion;
no constant depends on a binder it should not.

## 5. Semantics of the conclusion

Conclusion as elaborated (the `let`s are part of the type):

```lean
let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
let Fhat : ℤ → ℂ := fun p =>
  (2 * Real.pi : ℂ)⁻¹ * ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
(Fhat 0).im = 0 ∧
  ‖Fhat q‖ ≤ ((2 * d).choose (d + q.natAbs) : ℝ) * Real.exp (-(b * mStar * |(q : ℝ)|)) * (Fhat 0).re
```

| Item | Lean | Source (printed / proof) | Verdict |
|---|---|---|---|
| Twist as a step | `hist ++ [Step.kick ((φ : ℂ) • 1)]`, appended last | "Append to a history … a global charge twist `e^{iφQ}`" (L95–L96) | MATCH. `Step.generator` of this kick is `-(I • ((φ•1) ⊗ₖ 1)) = −iφ·I_D`, so its propagator is `e^{iφ} I_D` (the one-particle image of `e^{iφ dΓ(I)}`); being scalar, its position in the product is immaterial. |
| Centering of the twist | `exp(½ Σ tr gen)` in `centeredTrace` gets the factor `exp(½·(−iφ·4|ι|)) = e^{−idφ}` | `Q = dΓ(I) − d`; kick centering `e^{−(i/2) Tr Θ}` (L83–L84); "including the phase `e^{−idφ}`" (L108) | MATCH. Checked in Lean via the sorry-free helper `centeredTrace_append_twist` (P5a): `F(φ) = e^{−i d φ} · e^{½ Σ tr A} · det(1 + e^{iφ} U)`. |
| `F(φ)` | the frozen `centeredTrace` (3.1) of the extended history | "Let `F(φ)` be its centered trace" (L97), (3.1) | MATCH (definitions D1–D6 are hash-pinned, unchanged since freeze). |
| `Fhat p` | `(2π)⁻¹ ∫_0^{2π} e^{−ipφ} F(φ) dφ`, Lebesgue interval integral, `p : ℤ` | `F_q = (2π)⁻¹ ∫_0^{2π} e^{−iqφ} F(φ) dφ` (L98) | MATCH. Sign, normalization and interval are those printed. `F` is continuous (P5b), so the integral is a genuine Fourier coefficient, not Bochner's junk value 0. |
| Index range | `q : ℤ`, `hq : |q| ≤ ↑d` | "For `|q| ≤ d`" (L99), `q` integer | MATCH, including negative `q` (the proof's "complex conjugation" case, L129). |
| Binomial | `((2 * d).choose (d + q.natAbs) : ℝ)` | `binom(2d, d+|q|)` | MATCH |
| Exponential | `Real.exp (-(b * mStar * |(q : ℝ)|))` | `e^{−b m_* |q|}` | MATCH |
| `F_0` real | `(Fhat 0).im = 0` | implicit in (3.4); `F_0 = C Σ|e_j|²` (L120) | MATCH (R3) |
| Right side | `… * (Fhat 0).re` | `… F_0` | MATCH (R3); `F_0 > 0` is not claimed by (3.4) and not by Lean, but it holds, so (3.4) is not degenerate (P5e). |
| Modulus | `‖Fhat q‖` (norm on `ℂ` = modulus) | `|F_q|` | MATCH |

The role of `hq`. The provider declares `hq` and does not use it (`set_option
linter.unusedVariables false in`). This is not a symptom of a mis-stated conclusion:
`F(φ) = e^{−idφ} · const · det(1 + e^{iφ}U)` is a trigonometric polynomial with frequencies
`−d, …, d`, so `F_q = 0` for `|q| > d`, and `binom(2d, d+|q|) = 0` there. Both facts were
compiled (P5c–P5d): the provider's argument goes through verbatim for every integer `q`
without `hq`, and for `d < |q|` it yields `Fhat q = 0` while the right side is `0`. So
`hq` transcribes the printed range faithfully and removing it would neither weaken nor
falsify the statement. Conversely, `F_0 > 0` (P5e) shows the bound is not trivially `0 ≤ 0`.

## 6. Seal integrity, exact-type probe and ABI

Proof body (between the markers): 2 lines, 170 bytes (limits 3 lines, 240 bytes):
`by exact QEDCore.PaperA.Provider.canonical_fourier_bound` applied to exactly the 20 explicit
binder names of the anchor, in declaration order (`α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
hαβ_anti d hd mStar b hm hb hist hfree hkick htime q hq`); `ι` and the two instances are
inferred. Nothing else is applied.

Provider statement: byte-identical to the anchor's (§2, SHA-256 `e709021d…aee8` of the
1230-byte span in both). In Lean (Probe 3) the provider type is alpha-equivalent to the
frozen type (`Expr.eqv = true`, same level parameters `[u_1]`); `Expr.equal` differs only in
the hygienic names of the two anonymous instance binders, which embed the module
(`inst._@.Core.PaperA.Provider…` vs `inst._@.Frozen.PaperA…`). The elaborated proof term of
the anchor (`#print`, Probe 3) is
`fun {ι} [Fintype ι] [DecidableEq ι] α β … q hq => QEDCore.PaperA.Provider.canonical_fourier_bound α β … q hq`;
the only non-type constant in it is the provider export. The provider namespace `QEDCore.PaperA.Provider`
declares nothing but the provider theorem, so it cannot shadow `Step`, `centeredTrace` or
any other name. No file under `lean/Core/` or `lean/Frozen/` declares a global `instance`,
notation, macro, `axiom`, `opaque`, `unsafe`, `implemented_by`, `extern` or `native_decide`
(grep); the only instance changes are two `attribute [local instance] Matrix.linftyOp…`
lines in `Core/PaperA/Transfer/BetaForm.lean` and `ExpForm.lean`, local to their files. The
provider export is named only in the frozen anchor and the manifest; the provider imports
the sealed Lemma 3.1 anchor, never the Lemma 3.2 anchor (the checker's reverse-import test
passes).

Import drift. At the freeze the provider was a stub importing only `Defs.CenteredTrace` and
`Defs.StepFreeTime`; it now imports the Fourier and Transfer helpers and the Lemma 3.1
anchor. The ABI string of the frozen export recomputed in the current environment, in
exactly the format of `abiString` in `lean/scripts/Audit/AxiomAudit.lean`
(`theorem <name> : <type>`, 17969 characters), hashes to
`7e2b22d01f60c80db633656f9f12a19b5b7429d6656300750f12cbcdf3e388aa`, the manifest value
recorded at the freeze. So the new imports did not change the elaborated statement.
Constants (P3): the frozen type contains 118 constants; every one is from `Init`, `Lean`,
`Std`, `Batteries` or `Mathlib` except `QEDCore.PaperA.centeredTrace`,
`QEDCore.PaperA.Step`, `Step.free`, `Step.kick`, `Step.freeTime`, all in the hash-pinned
`Core/PaperA/Defs/` files. No helper or provider constant occurs in the statement.

Exact-type probe, results. The auditor wrote the statement from §3 as `reconType` (own
binder names `X, al, be, n, m, t, H, k, G, Gc, θ`, hypotheses as anonymous arrows, explicit
ascriptions such as `(1 : Matrix X X ℂ)`, `(p : ℂ) * (θ : ℂ)`, `Nat.choose`, `Int.natAbs`),
outside the anchor's namespace. Then:

| Check | Result |
|---|---|
| P1 `example : reconType.{u} := @QEDCore.PaperA.canonical_fourier_bound.{u}` | compiles (types definitionally equal) |
| Probe 4: `theorem reconThm : <reconstruction> := @QEDCore.PaperA.canonical_fourier_bound.{u}` | compiles |
| Probe 4: `Expr.eqv` of the reconstruction's type and the frozen type (alpha-equivalence, binder names ignored) | `true` |
| binder infos (implicit / inst-implicit / default), 23 binders | equal |
| Probe 3: provider type vs frozen type, `Expr.eqv` | `true` (`Expr.equal` differs only in hygienic instance names) |
| ABI of the frozen export and of the six closure definitions | all equal to the manifest |
| P5a twist identity `centeredTrace_append_twist` | `F(φ) = e^{−i d φ} · e^{½ Σ tr A} · det(1 + e^{iφ} U)` (sorry-free helper) |
| P5b continuity of `φ ↦ F(φ)` | proved (`fun_prop`) |
| P5c–P5d bound for all `q ∈ ℤ` without `hq`; for `d < |q|`, `Fhat q = 0` and the right side is `0` | proved |
| P5e `0 < (Fhat 0).re` | proved |

So the frozen statement is, syntactically up to binder names, the statement reconstructed
from the source and rulings.

### Probe 1 source (`lean/.lake/scratch/audit3/Probe.lean`, transient, deleted)

```lean
import Frozen.PaperA.CanonicalFourierBound
import Lean

/-! Transient audit probe for `lem_fourier_v1` (LEM_FOURIER_AUDIT_1). Untracked scratch. -/

open Lean Elab Command Meta

universe u

namespace QEDCore.PaperA.Audit3

open Matrix
open scoped Kronecker ComplexOrder

/-- P1. Lemma 3.2 as reconstructed by the auditor from transfer.tex L93-L104 (history class
L9-L26; Dirac structure model.tex L27-L28; D = 2d, L6) and rulings R1(a)-R4. -/
def reconType : Prop :=
  ∀ {X : Type u} [Fintype X] [DecidableEq X]
    -- Dirac structure, model.tex L27-L28: Hermitian, square to one, anticommute pairwise
    (al : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (be : Matrix (Fin 4) (Fin 4) ℂ),
    (∀ j, (al j).IsHermitian) → be.IsHermitian →
    (∀ j, al j * al j = 1) → be * be = 1 →
    (∀ j k, j ≠ k → al j * al k + al k * al j = 0) →
    (∀ j, al j * be + be * al j = 0) →
    -- D = 2d (L6), D = 4|X| (R2)
    ∀ (n : ℕ), 4 * Fintype.card X = 2 * n →
    -- M ≥ m_* I > 0 (L13); total free time b > 0 (L15)
    ∀ (m t : ℝ), 0 < m → 0 < t →
    -- a piecewise-constant history (R1(a)): free steps, Hermitian kicks (R4), ∫ c = b (L25)
    ∀ (H : List (Step X)),
      (∀ τ v M, Step.free τ v M ∈ H →
        0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (m : ℂ) • (1 : Matrix X X ℂ)).PosSemidef) →
      (∀ Θ, Step.kick Θ ∈ H → Θ.IsHermitian) →
      (H.map Step.freeTime).sum = t →
    -- integer Fourier index with |q| ≤ d (L98-L99)
    ∀ (k : ℤ), |k| ≤ (n : ℤ) →
      -- F(φ): centered trace of the history with the global twist appended (L95-L97)
      let G : ℝ → ℂ := fun θ =>
        centeredTrace al be (H ++ [Step.kick ((θ : ℂ) • (1 : Matrix X X ℂ))])
      -- F_p = (2π)⁻¹ ∫_0^{2π} e^{-ipφ} F(φ) dφ (L98)
      let Gc : ℤ → ℂ := fun p =>
        (2 * Real.pi : ℂ)⁻¹ *
          ∫ θ in (0 : ℝ)..2 * Real.pi, Complex.exp (-((p : ℂ) * (θ : ℂ) * Complex.I)) * G θ
      -- (3.4) in the form of ruling R3
      (Gc 0).im = 0 ∧
        ‖Gc k‖ ≤ ((Nat.choose (2 * n) (n + Int.natAbs k) : ℕ) : ℝ) *
          Real.exp (-(t * m * |(k : ℝ)|)) * (Gc 0).re

/-- P1. The exact-type probe: the reconstructed statement is closed by the frozen export. -/
example : reconType.{u} := @QEDCore.PaperA.canonical_fourier_bound.{u}

-- P2. Syntactic comparison of the elaborated types (alpha-equivalence and binder infos), and
-- P3. the constants occurring in the frozen type, by defining module.
run_meta do
  let env ← getEnv
  let frozen := ``QEDCore.PaperA.canonical_fourier_bound
  let some (.thmInfo fi) := env.find? frozen | throwError "frozen export missing"
  let some (.defnInfo ri) := env.find? ``reconType | throwError "reconType missing"
  logInfo m!"frozen levelParams = {fi.levelParams}, recon levelParams = {ri.levelParams}"
  let ft := fi.type.instantiateLevelParams fi.levelParams (ri.levelParams.map Level.param)
  let rt := ri.value
  logInfo m!"P2 Expr.eqv (alpha-equivalence) frozen-type vs reconType: {ft.eqv rt}"
  let rec infos : Expr → List BinderInfo
    | .forallE _ _ b bi => bi :: infos b
    | _ => []
  logInfo m!"P2 binder infos equal: {infos ft == infos rt}; frozen infos: {reprStr (infos ft)}"
  logInfo m!"P2 binder count: {(infos ft).length}"
  let rec names : Expr → List Name
    | .forallE n _ b _ => n :: names b
    | _ => []
  logInfo m!"P2 frozen binder names: {names ft}"
  -- P3. constants in the frozen type
  let consts := fi.type.getUsedConstants
  let mut byMod : Std.HashMap String (Array Name) := {}
  for c in consts do
    let m := match env.getModuleIdxFor? c with
      | some i => (env.header.moduleNames[i.toNat]!).toString
      | none => "<current>"
    byMod := byMod.insert m ((byMod.getD m #[]).push c)
  let project := byMod.toList.filter fun (m, _) =>
    !(m.startsWith "Mathlib" || m.startsWith "Init" || m.startsWith "Lean" ||
      m.startsWith "Std" || m.startsWith "Batteries")
  logInfo m!"P3 constants in frozen type: {consts.size}; non-library modules: {project}"
  -- P4. ABI string, exactly as lean/scripts/Audit/AxiomAudit.lean `abiString` forms it
  let abi := s!"theorem {frozen} : {fi.type}"
  IO.FS.writeFile ".lake/scratch/audit3/abi_frozen.txt" abi
  logInfo m!"P4 ABI string written ({abi.length} chars)"

end QEDCore.PaperA.Audit3

/-! P5. Semantic checks of the conclusion. -/

namespace QEDCore.PaperA.Audit3

open Matrix
open scoped Kronecker ComplexOrder

-- P5a. The twist kick `Step.kick (φ • 1)` multiplies `U` by `e^{iφ}` and contributes the
-- centering phase `e^{-idφ}` (helper lemma, sorry-free; see its axioms below).
#check @QEDCore.PaperA.centeredTrace_append_twist

/-- P5b. `F` is continuous, so each `Fhat p` is a genuine interval integral, not a junk value. -/
example {ι : Type u} [Fintype ι] [DecidableEq ι] (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) {d : ℕ}
    (hd : 4 * Fintype.card ι = 2 * d) :
    Continuous (fun φ : ℝ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])) := by
  simp_rw [QEDCore.PaperA.centeredTrace_append_twist α β hist hd]
  fun_prop

/-- P5c. The provider's argument with `hq` deleted: the bound for every integer `q`. -/
theorem bound_all_q
    {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b)
    (q : ℤ) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    (Fhat 0).im = 0 ∧
      ‖Fhat q‖ ≤ ((2 * d).choose (d + q.natAbs) : ℝ) *
        Real.exp (-(b * mStar * |(q : ℝ)|)) * (Fhat 0).re := by
  intro F Fhat
  obtain ⟨⟨hre, him⟩, hcard, hpair, -⟩ :=
    QEDCore.PaperA.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
      hαβ_anti d hd mStar b hm hb hist hfree hkick htime
  obtain ⟨lam, hlam⟩ := exists_fin_enum_of_card _ hcard
  have hroots : (transferMatrix α β hist).charpoly.roots =
      (Finset.univ : Finset (Fin d)).val.map lam +
        ((Finset.univ : Finset (Fin d)).val.map lam).map (fun z => (star z)⁻¹) := by
    rw [hlam, ← hpair, Multiset.filter_add_not]
  have hmem : ∀ j, lam j ∈ (transferMatrix α β hist).charpoly.roots.filter
      (fun z => ‖z‖ ≤ Real.exp (-(b * mStar))) := fun j =>
    hlam ▸ Multiset.mem_map_of_mem lam (Finset.mem_univ_val j)
  obtain ⟨V, hUV⟩ := (isUnit_transferMatrix (α := α) (β := β) hist).exists_right_inv
  have hlam0 : ∀ j, lam j ≠ 0 := fun j h0 =>
    zero_not_mem_charpoly_roots hUV (h0 ▸ Multiset.mem_of_mem_filter (hmem j))
  have hlamr : ∀ j, ‖lam j‖ ≤ Real.exp (-(b * mStar)) := fun j =>
    (Multiset.mem_filter.mp (hmem j)).2
  have hF0 : F 0 = centeredTrace α β hist := centeredTrace_append_twist_zero α β hist hd
  exact fourier_bound_of_factorization lam (mul_pos hb hm).le hlamr F
    (centeredTrace_append_twist_eq_mul_normSq α β hist hd lam hlam0 hroots)
    (by rw [hF0]; exact hre) (by rw [hF0]; exact him) Fhat (fun _ => rfl) q

/-- P5d. For `|q| > d` both sides of (3.4) vanish, so `hq` restricts nothing. -/
example {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b)
    (q : ℤ) (hq : d < q.natAbs) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    Fhat q = 0 ∧
      ((2 * d).choose (d + q.natAbs) : ℝ) * Real.exp (-(b * mStar * |(q : ℝ)|)) *
        (Fhat 0).re = 0 := by
  intro F Fhat
  obtain ⟨-, h⟩ := bound_all_q α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti d hd mStar b
    hm hb hist hfree hkick htime q
  have hc : (2 * d).choose (d + q.natAbs) = 0 := Nat.choose_eq_zero_of_lt (by omega)
  have hr : ((2 * d).choose (d + q.natAbs) : ℝ) * Real.exp (-(b * mStar * |(q : ℝ)|)) *
      (Fhat 0).re = 0 := by simp [hc]
  exact ⟨norm_le_zero_iff.mp (h.trans_eq hr), hr⟩

end QEDCore.PaperA.Audit3

/-! P6. Axioms. -/
#print axioms QEDCore.PaperA.canonical_fourier_bound
#print axioms QEDCore.PaperA.Provider.canonical_fourier_bound
#print axioms QEDCore.PaperA.centeredTrace_append_twist
#print axioms QEDCore.PaperA.Audit3.bound_all_q
```

### Probe 1 output (exit 0)

No errors: the P1 `example`, P5b, P5c (`bound_all_q`) and P5d all compiled. The
`P2 Expr.eqv … false` line compares against a `def` body and is caused only by `def` proof
abstraction (located by Probe 2, explained in §8 item 6); Probe 4 gives `true`. The ABI file
hashes to the manifest value (§1).

```
frozen levelParams = [u_1], recon levelParams = [u]
P2 Expr.eqv (alpha-equivalence) frozen-type vs reconType: false
P2 binder infos equal: true; frozen infos: [Lean.BinderInfo.implicit,
 Lean.BinderInfo.instImplicit,
 Lean.BinderInfo.instImplicit,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default,
 Lean.BinderInfo.default]
P2 binder count: 23
P2 frozen binder names: [ι,
 inst._@.Frozen.PaperA.CanonicalFourierBound.3380458009._hygCtx._hyg.3,
 inst._@.Frozen.PaperA.CanonicalFourierBound.3380458009._hygCtx._hyg.6,
 α,
 β,
 hα_herm,
 hβ_herm,
 hα_sq,
 hβ_sq,
 hα_anti,
 hαβ_anti,
 d,
 hd,
 mStar,
 b,
 hm,
 hb,
 hist,
 hfree,
 hkick,
 htime,
 q,
 hq]
P3 constants in frozen type: 118; non-library modules: [(Core.PaperA.Defs.CenteredTrace,
  [QEDCore.PaperA.centeredTrace]),
 (Core.PaperA.Defs.StepFreeTime, [QEDCore.PaperA.Step.freeTime]),
 (Core.PaperA.Defs.Step, [QEDCore.PaperA.Step, QEDCore.PaperA.Step.free, QEDCore.PaperA.Step.kick])]
P4 ABI string written (17969 chars)
@centeredTrace_append_twist : ∀ {ι : Type u_1} [inst : Fintype ι] [inst_1 : DecidableEq ι]
  (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ) (hist : List (Step ι)) {d : ℕ},
  4 * Fintype.card ι = 2 * d →
    ∀ (φ : ℝ),
      centeredTrace α β (hist ++ [Step.kick (↑φ • 1)]) =
        Complex.exp (-(↑d * ↑φ * Complex.I)) *
          (Complex.exp (1 / 2 * (List.map (fun s => (Step.generator α β s).trace) hist).sum) *
            (1 + Complex.exp (↑φ * Complex.I) • transferMatrix α β hist).det)
'QEDCore.PaperA.canonical_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.canonical_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_append_twist' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Audit3.bound_all_q' depends on axioms: [propext, Classical.choice, Quot.sound]
```

### Probe 2 (`lean/.lake/scratch/audit3/Probe2.lean`, transient, deleted)

Repeats `reconType` and the exact-type `example` of Probe 1 verbatim (namespace
`QEDCore.PaperA.Audit3b`), then:

```lean
/-- First position where two expressions differ (ignoring binder names). -/
partial def firstDiff (a b : Expr) (path : List String) : Option (List String × Expr × Expr) :=
  if a.eqv b then none else
  match a, b with
  | .mdata _ e1, _ => firstDiff e1 b ("mdataL" :: path)
  | _, .mdata _ e2 => firstDiff a e2 ("mdataR" :: path)
  | .forallE _ t1 b1 _, .forallE _ t2 b2 _ =>
      (firstDiff t1 t2 ("piT" :: path)).orElse fun _ => firstDiff b1 b2 ("piB" :: path)
  | .lam _ t1 b1 _, .lam _ t2 b2 _ =>
      (firstDiff t1 t2 ("lamT" :: path)).orElse fun _ => firstDiff b1 b2 ("lamB" :: path)
  | .letE _ t1 v1 b1 _, .letE _ t2 v2 b2 _ =>
      ((firstDiff t1 t2 ("letT" :: path)).orElse fun _ => firstDiff v1 v2 ("letV" :: path)).orElse
        fun _ => firstDiff b1 b2 ("letB" :: path)
  | .app f1 x1, .app f2 x2 =>
      (firstDiff f1 f2 ("appF" :: path)).orElse fun _ => firstDiff x1 x2 ("appX" :: path)
  | _, _ => some (path, a, b)

partial def stripMData : Expr → Expr
  | .mdata _ e => stripMData e
  | .forallE n t b bi => .forallE n (stripMData t) (stripMData b) bi
  | .lam n t b bi => .lam n (stripMData t) (stripMData b) bi
  | .letE n t v b nd => .letE n (stripMData t) (stripMData v) (stripMData b) nd
  | .app f x => .app (stripMData f) (stripMData x)
  | e => e

run_meta do
  let env ← getEnv
  let some (.thmInfo fi) := env.find? ``QEDCore.PaperA.canonical_fourier_bound | throwError "x"
  let some (.defnInfo ri) := env.find? ``reconType | throwError "y"
  let ft := fi.type.instantiateLevelParams fi.levelParams (ri.levelParams.map Level.param)
  let rt := ri.value
  logInfo m!"eqv raw: {ft.eqv rt}; eqv after stripping mdata: {(stripMData ft).eqv (stripMData rt)}"
  match firstDiff ft rt [] with
  | none => logInfo "no difference"
  | some (p, a, b) => logInfo m!"first difference at {p.reverse}:\n frozen: {toString a}\n recon:  {toString b}"
  -- ABI strings of the six closure definitions, as AxiomAudit.lean `abiString` forms them
  let mut out := ""
  for n in [``QEDCore.PaperA.Step, ``QEDCore.PaperA.diracOperator,
      ``QEDCore.PaperA.Step.generator, ``QEDCore.PaperA.Step.freeTime,
      ``QEDCore.PaperA.transferMatrix, ``QEDCore.PaperA.centeredTrace] do
    let s := match env.find? n with
      | some (.defnInfo d) => s!"def {n} : {d.type} := {d.value}"
      | some (.inductInfo i) =>
        let ctors := i.ctors.map fun k =>
          match env.find? k with
          | some c => s!"{k} : {c.type}"
          | none => s!"{k}"
        s!"inductive {n} : {i.type} | {" | ".intercalate ctors}"
      | _ => "MISSING"
    IO.FS.writeFile s!".lake/scratch/audit3/abi_{n}.txt" s
  logInfo "def ABI strings written"

/-- P5e. Non-degeneracy: `F_0` is strictly positive (so (3.4) is not trivially `0 ≤ 0`). -/
example {ι : Type*} [Fintype ι] [DecidableEq ι]
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (d : ℕ) (hd : 4 * Fintype.card ι = 2 * d)
    (mStar b : ℝ) (hm : 0 < mStar) (hb : 0 < b)
    (hist : List (Step ι))
    (hfree : ∀ τ v M, Step.free τ v M ∈ hist →
      0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef)
    (hkick : ∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian)
    (htime : (hist.map Step.freeTime).sum = b) :
    let F : ℝ → ℂ := fun φ => centeredTrace α β (hist ++ [Step.kick ((φ : ℂ) • 1)])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    0 < (Fhat 0).re := by
  intro F Fhat
  obtain ⟨⟨hre, him⟩, hcard, hpair, -⟩ :=
    QEDCore.PaperA.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
      hαβ_anti d hd mStar b hm hb hist hfree hkick htime
  obtain ⟨lam, hlam⟩ := exists_fin_enum_of_card _ hcard
  have hroots : (transferMatrix α β hist).charpoly.roots =
      (Finset.univ : Finset (Fin d)).val.map lam +
        ((Finset.univ : Finset (Fin d)).val.map lam).map (fun z => (star z)⁻¹) := by
    rw [hlam, ← hpair, Multiset.filter_add_not]
  have hmem : ∀ j, lam j ∈ (transferMatrix α β hist).charpoly.roots.filter
      (fun z => ‖z‖ ≤ Real.exp (-(b * mStar))) := fun j =>
    hlam ▸ Multiset.mem_map_of_mem lam (Finset.mem_univ_val j)
  obtain ⟨V, hUV⟩ := (isUnit_transferMatrix (α := α) (β := β) hist).exists_right_inv
  have hlam0 : ∀ j, lam j ≠ 0 := fun j h0 =>
    zero_not_mem_charpoly_roots hUV (h0 ▸ Multiset.mem_of_mem_filter (hmem j))
  have hF := centeredTrace_append_twist_eq_mul_normSq α β hist hd lam hlam0 hroots
  have hz := centeredTrace_append_twist_zero α β hist hd
  obtain ⟨c, hc, hC⟩ := exists_pos_eq_ofReal_of_mul_mul_star (hF 0)
    (by rw [hz]; exact hre) (by rw [hz]; exact him)
  have hint : (fun φ : ℝ => Complex.exp (-(((0 : ℤ) : ℂ) * φ * Complex.I)) * F φ) =
      fun φ : ℝ => (c : ℂ) * (Complex.exp (-(((0 : ℤ) : ℂ) * φ * Complex.I)) *
        (trigPoly d (QEDCore.elementary lam) φ *
          star (trigPoly d (QEDCore.elementary lam) φ))) := by
    funext φ
    rw [show F φ = _ from hF φ, hC]
    ring
  have h0 : Fhat 0 = (c : ℂ) * (QEDCore.vacuumWeight d (QEDCore.elementary lam) : ℂ) := by
    show (2 * Real.pi : ℂ)⁻¹ *
      ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(((0 : ℤ) : ℂ) * φ * Complex.I)) * F φ = _
    rw [hint, intervalIntegral.integral_const_mul, ← fourierCoeff_normSq_trigPoly_zero]
    ring
  rw [h0, ← Complex.ofReal_mul, Complex.ofReal_re]
  exact mul_pos hc (lt_of_lt_of_le one_pos
    (QEDCore.one_le_vacuumWeight (QEDCore.elementary_zero lam)))

end QEDCore.PaperA.Audit3b
```

Output (exit 0):

```
eqv raw: false; eqv after stripping mdata: false
first difference at [piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 piB,
 letB,
 letV,
 lamB,
 appF,
 appX,
 appX,
 appF,
 appX,
 appX,
 appX]:
 frozen: Nat.instAtLeastTwoHAddOfNat (OfNat.ofNat.{0} Nat 1 (instOfNatNat 1)) (Nat.instNeZeroSucc (OfNat.ofNat.{0} Nat 0 (instOfNatNat 0)))
 recon:  QEDCore.PaperA.Audit3b.reconType._proof_1
def ABI strings written
.lake/scratch/audit3/Probe2.lean:78:10: warning: Variable name `out` is not explicitly referenced.

Hint: The binding can be removed (if unused) or named `_` (if used implicitly). Alternatively, prefix the name with `_` to silence this warning:
  [apply] _out

Note: This linter can be disabled with `set_option linter.unusedVariables false`
```

The six definition ABI strings written by Probe 2 hash to the manifest `abi_sha256` of
`def_step_v1`, `def_dirac_operator_v1`, `def_step_generator_v1`, `def_step_free_time_v1`,
`def_transfer_matrix_v1` and `def_centered_trace_v1` (all MATCH, §1). The `eqv: false` above
is the `def` proof abstraction explained in §8, item 6; Probe 4 settles the comparison.

### Probe 3 (`lean/.lake/scratch/audit3/Probe3.lean`, transient, deleted)

Repeats `reconType` verbatim (namespace `QEDCore.PaperA.Audit3c`), then:

```lean
run_meta do
  let env ← getEnv
  let some (.thmInfo fi) := env.find? ``QEDCore.PaperA.canonical_fourier_bound | throwError "x"
  let some (.thmInfo pi) := env.find? ``QEDCore.PaperA.Provider.canonical_fourier_bound
    | throwError "p"
  let some (.defnInfo ri) := env.find? ``reconType | throwError "y"
  -- Inline the auxiliary proofs `reconType._proof_i` that `def` elaboration abstracted.
  let aux := ri.value.getUsedConstants.filter fun n => (``reconType).isPrefixOf n && n != ``reconType
  logInfo m!"auxiliary proof constants in reconType: {aux}"
  let rt := ri.value.replace fun e => match e with
    | .const n ls =>
      if aux.contains n then
        match env.find? n with
        | some ci => some (ci.instantiateValueLevelParams! ls)
        | none => none
      else none
    | _ => none
  let ft := fi.type.instantiateLevelParams fi.levelParams (ri.levelParams.map Level.param)
  logInfo m!"recon (aux proofs inlined) vs frozen: Expr.eqv = {rt.eqv ft}"
  logInfo m!"provider vs frozen: levelParams {pi.levelParams} / {fi.levelParams}; Expr.eqv = {pi.type.eqv fi.type}; Expr.equal = {pi.type.equal fi.type}"
  let rec names : Expr → List Name
    | .forallE n _ b _ => n :: names b
    | _ => []
  let diffs := (names pi.type).zip (names fi.type) |>.filter fun (a, b) => a != b
  logInfo m!"provider/frozen binder-name differences: {diffs}"

end QEDCore.PaperA.Audit3c

#print QEDCore.PaperA.canonical_fourier_bound
```

Output (exit 0; the `PANIC` is raised by the probe's own `instantiateValueLevelParams!`
on the auxiliary proof and only invalidates the first comparison line, superseded by Probe 4):

```
auxiliary proof constants in reconType: [QEDCore.PaperA.Audit3c.reconType._proof_1]
recon (aux proofs inlined) vs frozen: Expr.eqv = false
provider vs frozen: levelParams [u_1] / [u_1]; Expr.eqv = true; Expr.equal = false
provider/frozen binder-name differences: [(inst._@.Core.PaperA.Provider.CanonicalFourierBound.3380458009._hygCtx._hyg.3,
  inst._@.Frozen.PaperA.CanonicalFourierBound.3380458009._hygCtx._hyg.3),
 (inst._@.Core.PaperA.Provider.CanonicalFourierBound.3380458009._hygCtx._hyg.6,
  inst._@.Frozen.PaperA.CanonicalFourierBound.3380458009._hygCtx._hyg.6)]
PANIC at Lean.ConstantInfo.value! Lean.Declaration:509:62: declaration with value expected
theorem QEDCore.PaperA.canonical_fourier_bound.{u_1} : ∀ {ι : Type u_1} [inst : Fintype ι] [inst_1 : DecidableEq ι]
  (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ),
  (∀ (j : Fin 3), (α j).IsHermitian) →
    β.IsHermitian →
      (∀ (j : Fin 3), α j * α j = 1) →
        β * β = 1 →
          (∀ (j k : Fin 3), j ≠ k → α j * α k + α k * α j = 0) →
            (∀ (j : Fin 3), α j * β + β * α j = 0) →
              ∀ (d : ℕ),
                4 * Fintype.card ι = 2 * d →
                  ∀ (mStar b : ℝ),
                    0 < mStar →
                      0 < b →
                        ∀ (hist : List (QEDCore.PaperA.Step ι)),
                          (∀ (τ : ℝ) (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ),
                              QEDCore.PaperA.Step.free τ v M ∈ hist →
                                0 ≤ τ ∧ (∀ (j : Fin 3), (v j).IsHermitian) ∧ (M - ↑mStar • 1).PosSemidef) →
                            (∀ (Θ : Matrix ι ι ℂ), QEDCore.PaperA.Step.kick Θ ∈ hist → Θ.IsHermitian) →
                              (List.map QEDCore.PaperA.Step.freeTime hist).sum = b →
                                ∀ (q : ℤ),
                                  |q| ≤ ↑d →
                                    have F := fun φ =>
                                      QEDCore.PaperA.centeredTrace α β (hist ++ [QEDCore.PaperA.Step.kick (↑φ • 1)]);
                                    have Fhat := fun p =>
                                      (2 * ↑Real.pi)⁻¹ *
                                        ∫ (φ : ℝ) in 0..2 * Real.pi, Complex.exp (-(↑p * ↑φ * Complex.I)) * F φ;
                                    (Fhat 0).im = 0 ∧
                                      ‖Fhat q‖ ≤
                                        ↑((2 * d).choose (d + q.natAbs)) * Real.exp (-(b * mStar * |↑q|)) *
                                          (Fhat 0).re :=
fun {ι} [Fintype ι] [DecidableEq ι] α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti d hd mStar b hm hb hist hfree hkick
    htime q hq =>
  QEDCore.PaperA.Provider.canonical_fourier_bound α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti d hd mStar b hm hb
    hist hfree hkick htime q hq
```

### Probe 4 (`lean/.lake/scratch/audit3/Probe4.lean`, transient, deleted)

Same imports, `universe u`, namespace `QEDCore.PaperA.Audit3d` with `open Matrix` and
`open scoped Kronecker ComplexOrder`. The Probe 1 reconstruction, stated as a theorem closed
by the frozen export (so it is also an exact-type probe), then compared syntactically:

```lean
theorem reconThm :
  ∀ {X : Type u} [Fintype X] [DecidableEq X]
    (al : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (be : Matrix (Fin 4) (Fin 4) ℂ),
    (∀ j, (al j).IsHermitian) → be.IsHermitian →
    (∀ j, al j * al j = 1) → be * be = 1 →
    (∀ j k, j ≠ k → al j * al k + al k * al j = 0) →
    (∀ j, al j * be + be * al j = 0) →
    ∀ (n : ℕ), 4 * Fintype.card X = 2 * n →
    ∀ (m t : ℝ), 0 < m → 0 < t →
    ∀ (H : List (Step X)),
      (∀ τ v M, Step.free τ v M ∈ H →
        0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (m : ℂ) • (1 : Matrix X X ℂ)).PosSemidef) →
      (∀ Θ, Step.kick Θ ∈ H → Θ.IsHermitian) →
      (H.map Step.freeTime).sum = t →
    ∀ (k : ℤ), |k| ≤ (n : ℤ) →
      let G : ℝ → ℂ := fun θ =>
        centeredTrace al be (H ++ [Step.kick ((θ : ℂ) • (1 : Matrix X X ℂ))])
      let Gc : ℤ → ℂ := fun p =>
        (2 * Real.pi : ℂ)⁻¹ *
          ∫ θ in (0 : ℝ)..2 * Real.pi, Complex.exp (-((p : ℂ) * (θ : ℂ) * Complex.I)) * G θ
      (Gc 0).im = 0 ∧
        ‖Gc k‖ ≤ ((Nat.choose (2 * n) (n + Int.natAbs k) : ℕ) : ℝ) *
          Real.exp (-(t * m * |(k : ℝ)|)) * (Gc 0).re
  := @QEDCore.PaperA.canonical_fourier_bound.{u}

run_meta do
  let env ← getEnv
  let some (.thmInfo fi) := env.find? ``QEDCore.PaperA.canonical_fourier_bound | throwError "x"
  let some ri := env.find? ``reconThm | throwError "y"
  let ft := fi.type.instantiateLevelParams fi.levelParams (ri.levelParams.map Level.param)
  logInfo m!"reconThm type vs frozen type: Expr.eqv = {ri.type.eqv ft}"
  let rec infos : Expr → List BinderInfo
    | .forallE _ _ b bi => bi :: infos b
    | _ => []
  logInfo m!"binder infos equal: {infos ri.type == infos ft}; count {(infos ft).length}"

end QEDCore.PaperA.Audit3d
```

Output (exit 0):

```
reconThm type vs frozen type: Expr.eqv = true
binder infos equal: true; count 23
```

## 7. Axioms

```
'QEDCore.PaperA.canonical_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.canonical_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_append_twist' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Audit3.bound_all_q' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Only the three standard axioms; no `sorryAx`, no project axiom (the checker also finds no
`axiom`/`constant` command and no `sorry` anywhere in the project).

## 8. Concerns (none blocking)

1. **Checker binder-name extraction is looser than D12 says.** `binder_names` in
   `scripts/check_frozen_anchors.py` takes every token before a `:` inside any bracket of the
   header, so for this file its "binder" set also contains `φ`, `0`, `2`, `*` and `Real.pi`
   (from the ascriptions `(φ : ℂ)`, `(0 : ℝ)`, `(2 * Real.pi : ℂ)`). A body applying the
   provider to, say, `0` or `Real.pi` would pass the mechanical check. Not exploited here: the
   body applies exactly the 20 explicit binders in order (§6), and such terms could not
   discharge a Prop premise in any case. Suggest restricting the set to binders before the
   theorem's top-level colon.
2. **Stale status text (fix before recording AUDITED).** `lean/status.json`, result
   `lem:fourier`, still has the pre-seal `lean_coverage` ("the finite coefficient estimate
   inside the proof … for every natural `q`"), which describes the legacy lemmas, not the
   sealed theorem (integer `q`, the full (3.4) for R1(a) histories). Its `outside_lean`
   (R1(a) scope; the Fock-space identification of the twist) is accurate. The `lem:transfer`
   entry has the same stale `lean_coverage`.
3. **D12 wording.** D12 still says `Frozen` is "a separate library that nothing in `Core`
   imports", but `Core/PaperA/Provider/CanonicalFourierBound.lean` imports the sealed
   `Frozen.PaperA.PositivityAndTransferAnnulus` (allowed by the updated `lean/lakefile.lean`
   comment: "A sealed statement may be used by later providers"). The checker's
   reverse-import test (provider must not reach its own anchor) passes. Wording only.
4. **Scope reminders (not defects).** (a) R1(a): only piecewise-constant histories with
   separate kicks (deviation 7); the continuous histories used by Theorem 4.1 are not covered.
   (b) `F(φ)` is the paper's own formula (3.1) applied to the history with the scalar kick
   `φ·1` appended; that this equals the Fock-space twisted trace `Tr e^{iφQ} Γ(U)` is the
   source's definition of the centered trace and is not formalized (stated in
   `lean/status.json` `outside_lean`; graph node `lem:fourier#twist-is-kick` is "not a Lean
   obligation"). (c) R2 and R3 as in D11.
5. **`hq` is unused by the proof.** Verified harmless (§5, P5c–P5d): for `|q| > d` both sides
   are `0`. It is the printed range, so keeping it is correct.
6. **Cosmetic Lean differences.** Provider and frozen types differ only in hygienic instance
   binder names. The auditor's reconstruction is alpha-equivalent to the frozen type when
   stated as a theorem (Probe 4); stated as a `def` (Probes 2–3) it differs only because `def`
   elaboration abstracts the `Nat.AtLeastTwo` instance proof of the numeral `2` in
   `(2 * Real.pi : ℂ)` into `reconType._proof_1`, a proof-irrelevant difference. (Probe 3's
   attempt to inline that auxiliary proof hit a `ConstantInfo.value!` panic in the probe
   itself, not in the audited code; Probe 4 replaces it.)

## Transient files (all deleted after the run)

`lean/.lake/scratch/audit3/`: `hashes.py` (prefix/suffix/closure/source hashes),
`draft_freeze.lean` (the freeze-commit file, for its prefix/suffix hashes), `Probe.lean`,
`Probe2.lean`, `Probe3.lean`, `Probe4.lean` (probes above), `abi_*.txt` (ABI strings),
`probe_out.txt` … `probe4_out.txt`, and `fill.py`/`fill2.py` (paste probe text into this report).
Each Lean file ran as `bash ../scripts/lean-gate.sh lake env lean .lake/scratch/audit3/<file>`
from `lean/`.

At the end of the run `git status` showed only this report and an untracked
`docs/audits/seal/LEM_FOURIER_AUDIT_2.md` written by another session (not read, not
touched); HEAD was still `422b189` and the checker still printed `FROZEN-ANCHOR GUARD OK`.

## 9. Verdicts

DECLARATION_FIDELITY: PASS
SEAL_INTEGRITY: PASS
AXIOMS: PASS
AUDIT_VERDICT: PASS
