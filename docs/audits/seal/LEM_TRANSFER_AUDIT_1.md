# Seal audit 1: `lem_transfer_v1` (Paper A, Lemma 3.1)

Independent, refute-first audit of the sealed frozen theorem
`QEDCore.PaperA.positivity_and_transfer_annulus`, with emphasis on statement fidelity
and seal integrity. The auditor did not write any of the audited code. Date 2026-11-12;
repository HEAD `893dbbe` (working tree clean); Lean v4.35.0, Mathlib v4.35.0.

All Lean checks were transient files under `lean/.lake/scratch/audit1/`, compiled through
`bash ../scripts/lean-gate.sh lake env lean <file>` from `lean/`, and deleted after the run.
No tracked file other than this report was touched.

## 1. Pinned target and recomputed hashes

Manifest `lean/frozen-manifest.json` (SHA-256 `d8a0b1fa8e66997395b5f76648e8953f84ed83ea84da2c7f50b2e6f09ebb1086`),
entry `lem_transfer_v1`:

| Field | Manifest | Recomputed / observed |
|---|---|---|
| kind / state | theorem / SEALED | theorem / SEALED |
| path | `Frozen/PaperA/PositivityAndTransferAnnulus.lean` | exists, single declaration, LF line endings, no BOM |
| export | `QEDCore.PaperA.positivity_and_transfer_annulus` | the only declaration in the file |
| implementation | `Core.PaperA.Provider.PositivityAndTransferAnnulus` / `QEDCore.PaperA.Provider.positivity_and_transfer_annulus` | declared once in that module |
| source revision | transfer.tex `b2dcc793…c698cf` | `b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf` (= `lean/status.json` pin) |
| model.tex pin (status.json) | `2464b16f…dcd961e` | `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e` |
| `prefix_sha256` | `358471020e4471b4b95462a49d6b8a88dbaf4c7e75b2b50b271a3f94fb93c27b` | **MATCH** |
| `suffix_sha256` | `a76b93d165dbe18cb2e511588d18edbea48f51c3b0ebc1f430f611de2436f9aa` | **MATCH** |
| `abi_sha256` | `48c44cf3675aa01e2380fb5c4370ce5b5bb2ec1b9bd78f50ba46e25e8e05280f` | **MATCH** (recomputed in the post-seal environment, see §5) |
| approval | Aravind Karthigeyan, 2026-11-12, `docs/DECISIONS.md#d11`, v1 | D11 present |

Prefix and suffix were computed exactly as `scripts/check_frozen_anchors.py`
(`check_theorem_region`) defines them: prefix = all characters up to and including the
newline that ends the `-- FROZEN_ANCHOR_PROOF_BEGIN` line; suffix = everything from the
start of the `-- FROZEN_ANCHOR_PROOF_END` line to end of file; each UTF-8 encoded and hashed.
The same values were obtained on raw bytes. Whole file (informational):
`c7506f3dc611189a9dc7620909fe35adb6cc07faf6096ff2d2bf46cbcfac976e`, 3062 bytes.

Definition closure (whole-file SHA-256; each equals both the closure entry of
`lem_transfer_v1` and the `full_file_sha256` of its own SEALED definition anchor; the
ABI column is the elaborated-signature hash recomputed in the post-seal environment):

| File | SHA-256 | closure | own anchor | ABI |
|---|---|---|---|---|
| `Core/PaperA/Defs/Step.lean` | `599e912a79908055bd6b40919aa06a9d885823470b3aedcb5a297b736e0ce1b2` | MATCH | `def_step_v1` MATCH | MATCH |
| `Core/PaperA/Defs/DiracOperator.lean` | `75ec4f635a0872f7bb25cfb593a07e3674fdd5e87d142780bac8fe01cd8caf68` | MATCH | `def_dirac_operator_v1` MATCH | MATCH |
| `Core/PaperA/Defs/StepGenerator.lean` | `f2204d490751508e616a9aaccc09b8b8d919b2df00eaafddf5779cdd9a05d89e` | MATCH | `def_step_generator_v1` MATCH | MATCH |
| `Core/PaperA/Defs/StepFreeTime.lean` | `1ed87b1ce3052d1fe0a798cefe5601c3d1272cb91a95dc6784197a0f8522e613` | MATCH | `def_step_free_time_v1` MATCH | MATCH |
| `Core/PaperA/Defs/TransferMatrix.lean` | `4a15618f6c2a8f08d96906d4759d6afc4527cb089b614552b77a5404d65e4e96` | MATCH | `def_transfer_matrix_v1` MATCH | MATCH |
| `Core/PaperA/Defs/CenteredTrace.lean` | `edd9450999f0e874e59d79caf986b54be37d6df67f0a9b0666aaea9b7dea2261` | MATCH | `def_centered_trace_v1` MATCH | MATCH |

Checker (`scripts/check_frozen_anchors.py`, SHA-256 `8a190ea73b28da3b786f7f30835939cb6d9b8d9db9fa197d6cb70451de9256bb`), run from the repository root:

```
$ python -I scripts/check_frozen_anchors.py --root lean --manifest lean/frozen-manifest.json --allow-non-module
FROZEN-ANCHOR GUARD OK
exit=0
```

`lake build Frozen.PaperA.PositivityAndTransferAnnulus` (through the gate): `Build completed
successfully (3652 jobs)`, no errors (only the Mathlib module-system import warnings).

## 2. Identity with the author-approved text

Approved draft `docs/audits/pilot/audited-draft-v1.lean.txt`: SHA-256
`13952055e164b3a4eefd8ba22b225368184640d194474c8986f9fd10ad883d91` (**MATCH** with D11).

Textual comparison (script-generated, byte for byte):

| Block | Frozen file | Declaration bytes identical | Docstring identical |
|---|---|---|---|
| D1 | `Defs/Step.lean` | yes | yes |
| D2 | `Defs/DiracOperator.lean` | yes | yes |
| D3 | `Defs/StepGenerator.lean` | yes | yes |
| D4 | `Defs/StepFreeTime.lean` | yes | yes |
| D5 | `Defs/TransferMatrix.lean` | yes | yes |
| D6 | `Defs/CenteredTrace.lean` | yes | yes |
| T1 | `Frozen/PaperA/PositivityAndTransferAnnulus.lean` | yes: `theorem positivity_and_transfer_annulus` through the space before `:=`, 1409 bytes, SHA-256 `01cfe910863e20f5415dff26ca98a97591881af1f2c7fb98265f692e7c502391` in both | frozen adds a theorem docstring (allowed) |

Differences are only headers, imports, docstrings, markers and `open` lines. The definition
files open a subset of the draft's `open Matrix` / `open scoped Kronecker ComplexOrder`
(none of D1–D6 uses an order on `ℂ`); the theorem file opens exactly the draft's set.

Elaboration identity (stronger than text): the approved draft was compiled verbatim
(minus its trailing `#check`/`#print` lines) in a transient file, and the elaborated
signatures (in the `abiString` format of `lean/scripts/Audit/AxiomAudit.lean`) of all seven
declarations were compared with those from the frozen environment. After normalizing
hygienic binder names (`x._@.<module>…_hyg.N`, which embed the module name), all seven are
equal, with one cosmetic exception: in the single-file draft `Step.freeTime` reuses the
matcher `Step.generator.match_1`, while the split file has its own `Step.freeTime.match_1`;
the two matchers have alpha-equivalent types and values (checked in Lean). So the frozen
declarations elaborate to the approved draft.

History (`git log -p -- lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean`): two commits.
`6e68e3a` (freeze) created the file with body `  by sorry`; `893dbbe` (seal) changed exactly
one line into two:

```diff
 -- FROZEN_ANCHOR_PROOF_BEGIN
-  by sorry
+  by exact QEDCore.PaperA.Provider.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq
+      hα_anti hαβ_anti d hd mStar b hm hb hist hfree hkick htime
 -- FROZEN_ANCHOR_PROOF_END
```

Since the freeze, `lean/Core/PaperA/Defs/` has no commits, and the manifest diff
`6e68e3a..HEAD` is the single line `"state": "DRAFT_SORRY"` → `"SEALED"` for this entry
(hashes, ABI, closure unchanged).

## 3. Source reconstruction (independent)

From paper-a/transfer.tex L6–L7, L9–L36 and model.tex L27–L28, L39–L40, with D11:

- Standing (model.tex L27–28, imported by transfer.tex L7): `α_1, α_2, α_3, β` Hermitian
  4×4, squaring to one, pairwise anticommuting. One-particle dimension `D = 2d` (L6).
- Premises: ordered free evolutions generated by `h = Σ_j α_j v_j + β M`, `M ≥ m_* I > 0`
  (L13); bounded Hermitian `v_j`; total free time `b > 0` (L15), i.e. `c ≥ 0`, `∫c = b`
  (L25); interspersed spin-scalar unitary kicks (L16), `Φ` Hermitian, spin scalar (L26).
- Objects: `U` = one-particle product (L17); `F = e^{½∫Tr A} det(I+U)`, `U' = −AU`,
  `A = c h + iΦ` (L19–23), kick centering phase included (L17–18; L83–86).
- Conclusions: `F > 0`; exactly `d` eigenvalues of `U`, with algebraic multiplicity,
  satisfy `|λ| ≤ e^{−b m_*}`; the remaining `d` are their partners `1/conj λ` and have modulus
  `≥ e^{b m_*}` (L27–35). "Normality or diagonalizability of U is not required" (L34–35):
  no such premise may appear.
- Rulings: R1(a) finite piecewise-constant histories (list of free steps `exp(−τh)`, `τ ≥ 0`,
  constant Hermitian `v_j`, constant `M ≥ m_* I`; separate kicks `exp(iΘ⊗1)`); R2 spatial
  factor `ℓ²(ι)`, `ι` any finite type, `d` a binder with `4|ι| = 2d`, any Hermitian 4×4
  Clifford set; R4 kicks by a Hermitian generator `Θ`, phase from `Θ`. (R3 concerns Lemma 3.2.)

Quantifier structure: everything universal, no existential, no constant; `d`, `m_*`, `b`
are binders ahead of the history, so nothing depends on the history except the conclusion.

## 4. Five-bin binder test

21 binders (3 implicit/instance, 18 explicit), in declaration order. No project-owned
bundle or Prop alias occurs among the binder types (the only project constants in the type
are `Step`, `Step.free`, `Step.kick`, `Step.freeTime`, `centeredTrace`, `transferMatrix`;
see §5), so no recursive expansion is needed; `hfree`'s three conjuncts are listed in its row.

| # | Binder | Type (abridged) | Bin | Citation |
|---|---|---|---|---|
| 1 | `{ι : Type*}` | spatial index | RULED | R2 (spatial factor `ℓ²(ι)`); transfer.tex L6–7 |
| 2 | `[Fintype ι]` | finiteness | RULED | R2 ("any finite type `ι`, empty allowed") |
| 3 | `[DecidableEq ι]` | decidable equality | TYPING | needed to form `1`, `det`, Kronecker products on `Matrix ι ι ℂ`; any instance (subsingleton) |
| 4 | `α` | `Fin 3 → Matrix (Fin 4) (Fin 4) ℂ` | STANDING | model.tex L27; R2 |
| 5 | `β` | `Matrix (Fin 4) (Fin 4) ℂ` | STANDING | model.tex L27; R2 |
| 6 | `hα_herm` | `∀ j, (α j).IsHermitian` | STANDING | model.tex L27 "Hermitian" |
| 7 | `hβ_herm` | `β.IsHermitian` | STANDING | model.tex L27 |
| 8 | `hα_sq` | `∀ j, α j * α j = 1` | STANDING | model.tex L28 "square to one" |
| 9 | `hβ_sq` | `β * β = 1` | STANDING | model.tex L28 |
| 10 | `hα_anti` | `∀ j k, j ≠ k → α j α k + α k α j = 0` | STANDING | model.tex L28 "anticommute pairwise" |
| 11 | `hαβ_anti` | `∀ j, α j β + β α j = 0` | STANDING | model.tex L28 (pairs with `β`) |
| 12 | `d : ℕ` | half dimension | SOURCE | transfer.tex L6 (`D = 2d`), L27, L33 |
| 13 | `hd` | `4 * card ι = 2 * d` | RULED | R2 (`4|ι| = 2d`); transfer.tex L6 |
| 14 | `mStar : ℝ` | `m_*` | SOURCE | transfer.tex L13 |
| 15 | `b : ℝ` | total free time | SOURCE | transfer.tex L15, L25 |
| 16 | `hm` | `0 < mStar` | SOURCE | transfer.tex L13 "`m_* I > 0`" |
| 17 | `hb` | `0 < b` | SOURCE | transfer.tex L15 "`b > 0`" |
| 18 | `hist` | `List (Step ι)` | RULED | R1(a) (finite piecewise-constant history); source L11–16 |
| 19 | `hfree` | each `Step.free τ v M ∈ hist`: `0 ≤ τ` ∧ `∀ j, (v j).IsHermitian` ∧ `(M − m_*•1).PosSemidef` | SOURCE | L25 (`c ≥ 0`), L15 (Hermitian `v_j`), L13 (`M ≥ m_* I`); step form per R1(a) |
| 20 | `hkick` | each `Step.kick Θ ∈ hist`: `Θ.IsHermitian` | RULED | R4; source L16 (unitary spin-scalar kicks), L26 (`Φ` Hermitian, spin scalar) |
| 21 | `htime` | `(hist.map Step.freeTime).sum = b` | SOURCE | transfer.tex L15, L25 (`∫c = b`) |

Counts: **SOURCE 7, STANDING 8, TYPING 1, RULED 5, EXCESS 0** (total 21).

Further comparisons:

- No normality, diagonalizability, invertibility, determinant, spectral-gap or
  eigenvector premise (source L34–35 forbids the first two; the rest are proof steps).
- `M` is constrained only by `M − m_* I ⪰ 0` (Mathlib `PosSemidef` under `ComplexOrder`:
  Hermitian and nonnegative quadratic form), which is the operator inequality `M ≥ m_* I`
  and implies `M` Hermitian. `v_j` are finite matrices, hence bounded.
- Conclusion carriers: `centeredTrace … : ℂ`; eigenvalues as `Polynomial.roots` of
  `Matrix.charpoly` of `transferMatrix … : Matrix (ι × Fin 4) (ι × Fin 4) ℂ`; radii
  `Real.exp (−(b * mStar))` and `Real.exp (b * mStar)` match `e^{∓ b m_*}`; norm on `ℂ` is
  the modulus. Inequalities: `≤` for the inner disk and `≥` for the outer region, as printed.
- The two generalizations (any finite `ι`, any Clifford set) and the one specialization
  (piecewise-constant histories) are exactly R2 and R1(a), recorded as deviations 8 and 7.

## 5. Seal integrity and exact-type probe

Proof body (between the markers): 2 lines, 173 bytes (limits 3 lines, 240 bytes), exactly
`by exact QEDCore.PaperA.Provider.positivity_and_transfer_annulus` applied to the 18
explicit binder names of the anchor in declaration order; `ι` and the two instances are
inferred. The elaborated proof term (printed by `#print`) is
`fun {ι} [Fintype ι] [DecidableEq ι] α β … htime => QEDCore.PaperA.Provider.positivity_and_transfer_annulus α β … htime`,
and the only non-type constant in it is the provider export.

Provider statement: the text from `theorem positivity_and_transfer_annulus` to `:=` in
`Core/PaperA/Provider/PositivityAndTransferAnnulus.lean` is byte-identical to the frozen
one (SHA-256 of the span without the trailing space,
`0035e176ce17bdbf6402ffe168f891098ae17de3147eac7f5052b0e94f67a09a`, in both). In Lean, the
provider type is alpha-equivalent to the frozen type (`Expr.eqv = true`), binder infos
are identical, and `Expr.equal` differs only in the two anonymous instance binder names,
whose hygienic names embed the module (`inst._@.Frozen.PaperA…` vs `inst._@.Core.PaperA.Provider…`).
The provider namespace `QEDCore.PaperA.Provider` adds no shadowing names; no project file
declares a global `instance`, notation, macro, `axiom`, `opaque`, `implemented_by`, `extern`,
`unsafe`, `native_decide` or `skipKernelTC` (grep over `Core/` and `Frozen/`); the only
instance changes are two `attribute [local instance] Matrix.linftyOp…` lines in
`Core/PaperA/Transfer/BetaForm.lean` and `ExpForm.lean`, which do not leave their files.

Import drift: the frozen statement is elaborated in an environment that now imports the
full provider (`Core.PaperA.Transfer.*`); at freeze time the provider was an empty stub. The
recomputed ABI hash of the frozen export in the current environment equals the manifest's
`abi_sha256` recorded at freeze time, so the new imports did not change the elaborated
statement.

### Probe source (`lean/.lake/scratch/audit1/Probe.lean`, transient, deleted)

Reconstructed from the source and rulings (§3), written outside every namespace with fully
qualified names and without `open Matrix`, so no project namespace can capture an
identifier; the body is the frozen export itself.

```lean
import Frozen.PaperA.PositivityAndTransferAnnulus
import Lean

open scoped ComplexOrder

universe u

example :
    ∀ {ι : Type u} [inst₁ : Fintype ι] [inst₂ : DecidableEq ι]
      (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ),
      -- model.tex L27-28: Hermitian, square to one, anticommute pairwise
      (∀ j, Matrix.IsHermitian (α j)) → Matrix.IsHermitian β →
      (∀ j, α j * α j = 1) → β * β = 1 →
      (∀ j k, j ≠ k → α j * α k + α k * α j = 0) →
      (∀ j, α j * β + β * α j = 0) →
      -- transfer.tex L6 (D = 2d) with R2 (D = 4|ι|)
      ∀ (d : ℕ), 4 * Fintype.card ι = 2 * d →
      -- transfer.tex L13, L15: m_* > 0, b > 0
      ∀ (mStar b : ℝ), 0 < mStar → 0 < b →
      -- R1(a): finite piecewise-constant history
      ∀ (hist : List (QEDCore.PaperA.Step ι)),
      (∀ (τ : ℝ) (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ),
          QEDCore.PaperA.Step.free τ v M ∈ hist →
          0 ≤ τ ∧ (∀ j, Matrix.IsHermitian (v j)) ∧
            Matrix.PosSemidef (M - (mStar : ℂ) • (1 : Matrix ι ι ℂ))) →
      -- R4: kick by a Hermitian generator
      (∀ Θ : Matrix ι ι ℂ, QEDCore.PaperA.Step.kick Θ ∈ hist → Matrix.IsHermitian Θ) →
      -- transfer.tex L15/L25: total free time b
      (List.map QEDCore.PaperA.Step.freeTime hist).sum = b →
      -- F > 0 (as Re F > 0 and Im F = 0)
      (0 < Complex.re (QEDCore.PaperA.centeredTrace α β hist) ∧
          Complex.im (QEDCore.PaperA.centeredTrace α β hist) = 0) ∧
      -- exactly d roots of the charpoly (algebraic multiplicity) in |λ| ≤ e^{-b m_*}
      Multiset.card (Multiset.filter (fun z : ℂ => ‖z‖ ≤ Real.exp (-(b * mStar)))
          (Polynomial.roots (Matrix.charpoly (QEDCore.PaperA.transferMatrix α β hist)))) = d ∧
      -- the remaining roots are the partners 1 / conj λ, as multisets
      Multiset.filter (fun z : ℂ => ¬ ‖z‖ ≤ Real.exp (-(b * mStar)))
          (Polynomial.roots (Matrix.charpoly (QEDCore.PaperA.transferMatrix α β hist))) =
        Multiset.map (fun z : ℂ => (star z)⁻¹)
          (Multiset.filter (fun z : ℂ => ‖z‖ ≤ Real.exp (-(b * mStar)))
            (Polynomial.roots (Matrix.charpoly (QEDCore.PaperA.transferMatrix α β hist)))) ∧
      -- and have modulus at least e^{b m_*}
      ∀ z ∈ Polynomial.roots (Matrix.charpoly (QEDCore.PaperA.transferMatrix α β hist)),
        ¬ ‖z‖ ≤ Real.exp (-(b * mStar)) → Real.exp (b * mStar) ≤ ‖z‖ :=
  @QEDCore.PaperA.positivity_and_transfer_annulus
```

The file also declared a named copy `audit1_probe` of the same type with the same body,
and a `run_cmd` that compared types, listed the constants of the frozen type, wrote the
`abiString`, and inspected the proof term; then:

```lean
#print axioms QEDCore.PaperA.positivity_and_transfer_annulus
#print axioms QEDCore.PaperA.Provider.positivity_and_transfer_annulus
#print QEDCore.PaperA.positivity_and_transfer_annulus
```

### Probe output (exit 0; only unused-variable lint warnings for `inst₁`, `inst₂`)

```
levelParams frozen=[u_1] provider=[u_1] probe=[u]
probe  == frozen (alpha-eqv, binder info ignored): true
provider == frozen (alpha-eqv): true
provider == frozen (Expr.equal, binder names/info too): false      -- hygienic instance names only
project constants in frozen type: [QEDCore.PaperA.Step, QEDCore.PaperA.Step.free,
 QEDCore.PaperA.Step.freeTime, QEDCore.PaperA.Step.kick, QEDCore.PaperA.centeredTrace,
 QEDCore.PaperA.transferMatrix]
  QEDCore.PaperA.Step defined in Core.PaperA.Defs.Step
  QEDCore.PaperA.Step.free defined in Core.PaperA.Defs.Step
  QEDCore.PaperA.Step.freeTime defined in Core.PaperA.Defs.StepFreeTime
  QEDCore.PaperA.Step.kick defined in Core.PaperA.Defs.Step
  QEDCore.PaperA.centeredTrace defined in Core.PaperA.Defs.CenteredTrace
  QEDCore.PaperA.transferMatrix defined in Core.PaperA.Defs.TransferMatrix
frozen proof value: fun {ι} [Fintype ι] [DecidableEq ι] α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
  hαβ_anti d hd mStar b hm hb hist hfree hkick htime =>
  QEDCore.PaperA.Provider.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq hα_anti
    hαβ_anti d hd mStar b hm hb hist hfree hkick htime
'QEDCore.PaperA.positivity_and_transfer_annulus' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.positivity_and_transfer_annulus' depends on axioms: [propext, Classical.choice, Quot.sound]
```

The `abiString` written by the `run_cmd` (21918 bytes) was hashed in Python:
`48c44cf3675aa01e2380fb5c4370ce5b5bb2ec1b9bd78f50ba46e25e8e05280f`, which **matches** the manifest.

**Axioms.** Both the frozen export and the provider depend only on `propext`,
`Classical.choice` and `Quot.sound`. There is no `sorryAx`, no project axiom, and no
`Lean.ofReduceBool`.

The remaining 93 constants of the frozen type are Mathlib/core (`Matrix.IsHermitian`,
`Matrix.PosSemidef`, `Complex.partialOrder`, `Matrix.charpoly`, `Polynomial.roots`,
`Multiset.filter/map/card`, `Real.exp`, `Complex.instNorm`, `Star.star`, `Inv.inv`, instances).
The project constants all live in the six audited definition files (closure complete).

## 6. Definition audit (D1–D6)

Defining equations were checked by `rfl` (or a one-line `simp`) in a transient file
(`Defeqs.lean`, exit 0): `diracOperator α β v M = ∑ j, v j ⊗ₖ α j + M ⊗ₖ β`;
`generator (free τ v M) = (τ:ℂ) • diracOperator α β v M`;
`generator (kick Θ) = −(I • (Θ ⊗ₖ 1))`; `freeTime (free τ v M) = τ`, `freeTime (kick Θ) = 0`;
`transferMatrix α β hist = (hist.map fun s => exp(−s.generator α β)).reverse.prod`,
`transferMatrix α β [] = 1`, `transferMatrix α β (hist ++ [s]) = exp(−s.generator α β) * transferMatrix α β hist`
(later steps on the left); `exp(−generator (kick Θ)) = exp(I • (Θ ⊗ₖ 1))`;
`centeredTrace α β hist = Complex.exp ((1/2) * Σ_s tr(s.generator α β)) * det(1 + transferMatrix α β hist)`;
kick centering exponent `(1/2)·tr(generator (kick Θ)) = −(I/2)·tr(Θ ⊗ₖ 1) = −2 I · tr Θ`,
which is the source's `e^{−(i/2) Tr Θ}` for the one-particle `Θ⊗1` (L83–86: `Tr Θ = 4Σθ_x` gives `e^{−2iΣθ_x}`).

**D1 `Step` (inductive; transfer.tex L11–26 with R1(a), R4).** `free (τ : ℝ) (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ) | kick (Θ : Matrix ι ι ℂ)`: a free step with constant spatial coefficients and mass matrix, or a spin-scalar kick by its spatial generator. Constraints (sign, Hermiticity, mass bound) are premises of the theorem, not carrier semantics; no fallback values.

    BODY_MATCH: OK
    PUBLIC_CARRIER: OK
    WELL_DEFINEDNESS: N/A_LITERAL
    CHARACTERIZATION: N/A_LITERAL
    CHOICE_INDEPENDENCE: N/A
    DEFINITION_VERDICT: PASS

**D2 `diracOperator` (model.tex L27–38, L40; transfer.tex L13).** `Σ_j v_j ⊗ α_j + M ⊗ β` on `ℓ²(ι) ⊗ ℂ⁴` (spatial factor first); "spatial matrices commute with the Dirac matrices" is realized by the Kronecker product. Total on its carrier.

    BODY_MATCH: OK
    PUBLIC_CARRIER: OK
    WELL_DEFINEDNESS: N/A_LITERAL
    CHARACTERIZATION: N/A_LITERAL
    CHOICE_INDEPENDENCE: N/A
    DEFINITION_VERDICT: PASS

**D3 `Step.generator` (transfer.tex L20–26, L83–84).** `∫A` over a step: free step `τ h` (`A = c h`, `∫c = τ`), kick `−i(Θ⊗1)` (`A = iΦ` with `∫Φ = −Θ⊗1`, so the factor `exp(−∫A) = exp(i Θ⊗1)` is the kick and `½ Tr ∫A` is its centering phase). For a free step `Tr h = 0` under the Clifford relations, so free steps contribute no phase, as in L49.

    BODY_MATCH: OK
    PUBLIC_CARRIER: OK
    WELL_DEFINEDNESS: N/A_LITERAL
    CHARACTERIZATION: N/A_LITERAL
    CHOICE_INDEPENDENCE: N/A
    DEFINITION_VERDICT: PASS

**D4 `Step.freeTime` (transfer.tex L15, L25).** `τ` for a free step, `0` for a kick; `Σ freeTime = b` is `∫c = b`.

    BODY_MATCH: OK
    PUBLIC_CARRIER: OK
    WELL_DEFINEDNESS: N/A_LITERAL
    CHARACTERIZATION: N/A_LITERAL
    CHOICE_INDEPENDENCE: N/A
    DEFINITION_VERDICT: PASS

**D5 `transferMatrix` (transfer.tex L11–21).** Ordered product of `exp(−∫A_s)` with later steps on the left, i.e. the solution `U(T)` of `U' = −AU`, `U(0) = I`, for piecewise-constant `A` (each step's generator is constant, so its propagator is the plain matrix exponential `NormedSpace.exp`). Empty history gives `1`.

    BODY_MATCH: OK
    PUBLIC_CARRIER: OK
    WELL_DEFINEDNESS: N/A_LITERAL
    CHARACTERIZATION: N/A_LITERAL
    CHOICE_INDEPENDENCE: N/A
    DEFINITION_VERDICT: PASS

**D6 `centeredTrace` (transfer.tex L17–23, (3.1)).** `exp(½ Σ_s Tr ∫A_s) · det(I + U)` = `e^{½∫Tr A} det(I+U)`, kick phases included.

    BODY_MATCH: OK
    PUBLIC_CARRIER: OK
    WELL_DEFINEDNESS: N/A_LITERAL
    CHARACTERIZATION: N/A_LITERAL
    CHOICE_INDEPENDENCE: N/A
    DEFINITION_VERDICT: PASS

## 7. Meaning of the encodings

Checked in a transient file (`Encoding.lean`, importing the frozen module plus
`Mathlib.LinearAlgebra.Matrix.Charpoly.Eigs`, `Mathlib.FieldTheory.IsAlgClosed.Basic`,
`Mathlib.Analysis.Complex.Polynomial.Basic`; exit 0, no errors or warnings apart from the
module-system import notices):

```lean
example (F : ℂ) : (0 < F.re ∧ F.im = 0) ↔ 0 < F                      -- via Complex.pos_iff
example : Multiset.card (transferMatrix α β hist).charpoly.roots = 4 * Fintype.card ι
                                                                    -- IsAlgClosed.card_roots_eq_natDegree,
                                                                    -- Matrix.charpoly_natDegree_eq_dim
example (z : ℂ) : z ∈ (transferMatrix α β hist).charpoly.roots ↔
    z ∈ spectrum ℂ (transferMatrix α β hist)                        -- Polynomial.mem_roots (charpoly monic),
                                                                    -- Matrix.mem_spectrum_iff_isRoot_charpoly
example (z : ℂ) : Multiset.count z (transferMatrix α β hist).charpoly.roots =
    (transferMatrix α β hist).charpoly.rootMultiplicity z           -- Polynomial.count_roots
```

- **`F > 0` as `0 < re F ∧ im F = 0`.** Under `ComplexOrder` this is exactly `0 < F`, i.e.
  `F` is a positive real, which is the paper's meaning ("these identities make (3.1)
  real", L49–50). Faithful, and the reality claim is explicit.
- **Charpoly roots as eigenvalues with algebraic multiplicity.** Over the algebraically
  closed `ℂ`, the monic characteristic polynomial splits, its root multiset has total size
  `4|ι| = 2d = D`, membership is exactly the spectrum, and the multiplicity of `λ` is its
  root multiplicity in `det(XI − U)`, i.e. the algebraic multiplicity. So "exactly `d`
  eigenvalues, with algebraic multiplicity, obey `|λ| ≤ e^{−b m_*}`" is the `card … = d`
  conjunct. No normality or diagonalizability enters.
- **Partner multiset equality.** The roots outside the closed disk, as a multiset, equal
  the image of the inside roots under `λ ↦ (conj λ)⁻¹`. This states "the remaining `d` are
  their partners `1/conj λ`" with multiplicities (`Multiset.map` preserves cardinality, so
  the remaining count is `d`). Lean's `0⁻¹ = 0` cannot hide a defect: if `0` were a root it
  would lie in the inner filter, and its image `0` would have to lie in the outer filter,
  which is impossible, so the conjunct also forces `0 ∉ spec U` (true, since `U` is a product
  of exponentials). The last conjunct (`e^{b m_*} ≤ ‖z‖` off the disk) is the printed modulus
  bound. It also follows from the partner equality, so it is redundant but harmless.
- **Radii and inequality directions.** The closed inner disk `‖z‖ ≤ e^{−b m_*}` and the
  outer bound `e^{b m_*} ≤ ‖z‖` match (3.2) and "at least `e^{bm_*}`". The complement
  predicate `¬ ‖z‖ ≤ e^{−b m_*}` defines "remaining" exactly as the paper does.

## 8. Concerns (none blocking)

1. **Stale status text (fix before recording AUDITED).** `lean/status.json`, result
   `lem:transfer`, has `state: PROVED` but keeps the pre-seal `lean_coverage` and
   `outside_lean` text, which lists "algebraic multiplicities and the exact eigenvalue
   count; reality and positivity of the centered trace along the homotopy" as outside Lean.
   That contradicts the sealed theorem. Deviation 5 in `docs/ERRATA-AND-DEVIATIONS.md`
   ("no multiplicity or counting statement is formalized") likewise describes only the
   legacy `Core/Eigenvectors.lean` and now reads as if it applied to Lemma 3.1. Neither
   affects the frozen declaration or the seal.
2. **D12 import remark.** D12 says one import differs from the draft
   (`Mathlib.Data.Complex.Basic` → `Mathlib.Basic.Complex.Basic`), but the approved draft
   imports no `Data.Complex.Basic`, and the per-file imports differ from the draft's
   single import list anyway. Imports are outside the frozen declaration, and §2 shows the
   elaborated signatures equal the draft's, so this is a wording problem only.
3. **Scope reminder (not a defect).** The sealed result is the R1(a) special case
   (piecewise-constant histories, separate kicks). Continuous or measurable histories,
   which Theorem 4.1 uses, are not covered (deviation 7). An AUDITED or PROVED status for
   `lem:transfer` should keep the R1(a) note it now carries (`frozen_note`).
4. **Cosmetic Lean differences, no semantic effect.** The provider and frozen types are
   `Expr.equal`-different only in the hygienic names of the two anonymous instance binders.
   `Step.freeTime` has its own matcher `Step.freeTime.match_1` where the single-file draft
   reused `Step.generator.match_1`; the two are alpha-equivalent.
5. **Non-vacuity was argued, not compiled.** The premises can be satisfied: a standard Dirac
   representation gives the Clifford set, and `ι = Fin 1`, `d = 2`,
   `hist = [Step.free b 0 (m_* • 1)]` give `hfree`, `hkick` (vacuous) and `htime`. No hypothesis
   is contradictory, and the conclusion is not trivially true.

## Transient files (all deleted after the run)

`lean/.lake/scratch/audit1/`: `rehash.py` (prefix/suffix/closure hashes), `cmpdraft.py`
(byte comparison with the draft), `Probe.lean` (exact-type probe, axioms, ABI), `Draft.lean`
(the approved draft compiled verbatim, plus an ABI dump), `AbiFrozen.lean` (the same dump in
the frozen environment), `Defeqs.lean` (defining equations of D1–D6, binder comparison,
matcher equivalence), `Encoding.lean` (§7). Every Lean file ran as
`bash ../scripts/lean-gate.sh lake env lean .lake/scratch/audit1/<file>` from `lean/`, with exit 0.

## Concurrent working-tree changes

While this audit ran, another session changed the working tree without committing:
`lean/frozen-manifest.json` (only `lem_fourier_v1`: `DRAFT_SORRY` → `SEALED`), the
`lem_fourier_v1` frozen file and provider, `lean/lakefile.lean` (docstring only), and a new
`Core/PaperA/Fourier/Bound.lean`. At the end of the audit:

- the `lem_transfer_v1` entry and all six definition anchors were identical to `HEAD`;
- none of the changed files is in the 20-module project import closure of
  `Frozen.PaperA.PositivityAndTransferAnnulus`; and
- the checker still printed `FROZEN-ANCHOR GUARD OK` (manifest now
  `40c3c09f12a467fc0bb84ad0e8ed0b42343b9f58844179b44e596e190e65cbda`; the hashes in §1 were
  taken from the `HEAD` manifest `d8a0b1fa…1086`).

These changes therefore do not affect the verdicts.

## 9. Verdicts

DECLARATION_FIDELITY: PASS
SEAL_INTEGRITY: PASS
AXIOMS: PASS
AUDIT_VERDICT: PASS
