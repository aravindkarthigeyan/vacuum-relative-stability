# Seal audit 1: the four proof steps of Theorem 4.1 (T3, T4, T5, T6)

Independent, refute-first audit of the four theorems sealed in `939f4ee` ("Prove and seal the
four proof steps of Theorem 4.1"), with emphasis on statement fidelity and seal integrity:

| Id | Anchor | Frozen export |
|---|---|---|
| T3 | `main_twisted_integrand_v1` | `QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound` |
| T4 | `rem_nonneg_mass_v1` | `QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass` |
| T5 | `eq_mass_bound_v1` | `QEDCore.PaperA.wilson_mass_bound` |
| T6 | `gauge_covariance_v1` | `QEDCore.PaperA.wilson_gauge_covariance` |

- **Auditor.** Seal auditor 1, a fresh session. The auditor wrote none of the audited code,
  statements or definitions, and did not coordinate with seal auditor 2 (whose untracked
  `THM_MAIN_STEPS_AUDIT_2.md` appeared during the run and was neither read nor touched).
- **Date.** 2026-11-14.
- **Commit.** `939f4ee1e800fa0231f9e73e02b2268bbabc3976` on `main`, HEAD throughout. `lean/` was
  identical to HEAD (`git diff --quiet HEAD -- lean/`). The only working-tree modifications were
  four pre-existing files outside `lean/`, `paper-a/` and `docs/audits/` (`docs/history/MOVES.md`,
  `docs/history/packages/vacuum-relative-stability-manifest.json`,
  `drafts/{consolidated,memorandum}/verification.json`); they were not read or touched.
- **Environment.** Windows 11, Git Bash. Lean `leanprover/lean4:v4.35.0`, Mathlib v4.35.0 (rev
  `56a005855ea17e0b0958f73ec801ae140b0a1679`). Python 3.12, always run with `-I`.
- **Scratch policy.** Lean files lived only under `lean/.lake/scratch/audit1/`, which is
  git-ignored through `/.lake/` in `lean/.gitignore`. Each was compiled alone from `lean/` with
  `bash ../scripts/lean-gate.sh lake env lean .lake/scratch/audit1/<file>`. Kernel replays ran
  as `bash ../scripts/lean-gate.sh lake env leanchecker <Module>`, one module per command. The
  two Python helpers (hash recomputation and the seal-body/binder check) lived in the session
  scratchpad outside the repository. Everything was deleted at the end. No tracked file other
  than this report was written. No state-changing git command was run, and no `lake build` of
  the project, `lake update` or `lake clean`.

## 0. Global checks (all four anchors)

| Check | Result |
|---|---|
| Manifest `lean/frozen-manifest.json` | SHA-256 `3963096ef6449a8280d5179482d5b706a707c0d03c88b44dbef5854ad3e1cc30`, equal to the `FROZEN_MANIFEST` pin in `docs/graph/DEPGRAPH.md` |
| Manifest history | T3 and T4 were created in `8e97f0c` and T5 and T6 in `eea8f30`, each as `DRAFT_SORRY`. `git diff eea8f30 939f4ee -- lean/frozen-manifest.json` is exactly four lines `"state": "DRAFT_SORRY"` → `"SEALED"`. No prefix, suffix, ABI, closure, source, contract, approval or allowlist field of the four entries changed after its freeze. |
| Checker | `scripts/check_frozen_anchors.py` (SHA-256 `3a9f5e45214e8809ae51a561d5a34c7e2e17dd3cf660a33be350b06453eaf1be`, last changed in `da69c1b`, before both freeze commits). From the repo root, `python -I scripts/check_frozen_anchors.py --root lean --manifest lean/frozen-manifest.json --allow-non-module` printed `FROZEN-ANCHOR GUARD OK`, exit 0. |
| Build artifacts current | `lake build --no-build` of the eight audited modules (four frozen, four providers) printed `All targets up-to-date (3707 jobs)`, exit 0. So the `.olean` files that the probes and `leanchecker` read belong to the current sources. |
| Source pins | comparison.tex `1caaf36bb7ab5f90c15224be3bc0f1eb20baeae06f40fb7c340ad3145db13273`, model.tex `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e`, transfer.tex `b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf`. Each recomputed hash equals the manifest `source.revision` and the `pinned_sha256` in `lean/status.json`. |
| Approved drafts | `docs/audits/pilot-chargegap/audited-draft-v1.lean.txt` hashes to `e16372fb6560b6336a0eb0c9353936743b2c45d87ad6a6bfe852a84e7d0fa2bc` and `draft-v1b-with-T5-T6.lean.txt` to `f3169e835332bd8f8b4095dcf31370935e5a76de67a8c07967d7f77bd9e5f339`, both as recorded in D16. Lines 1–76 of the two drafts are identical. Both are UTF-8. |
| D7–D9 text | The docstring and `def` block of `latticeShift`, `wilsonHopping` and `wilsonMass` in each draft is byte-identical to `lean/Core/PaperA/Defs/{LatticeShift,WilsonHopping,WilsonMass}.lean`. |
| Definition anchors | All nine `full_file_sha256` values were recomputed and match the manifest. Each file has LF line endings and no BOM. `lean/Core/PaperA/Defs/` was last changed in `8e97f0c`, which only added the three Wilson files; the six Lemma 3.1/3.2 definitions have been unchanged since `6e68e3a`. |
| Definition ABIs | All nine were recomputed in the post-seal environment (Probe 1) and match the manifest (§5). |
| Upstream sealed anchors | `Frozen/PaperA/{PositivityAndTransferAnnulus,CanonicalFourierBound}.lean` and their providers, which the T3 and T4 providers consume, are byte-unchanged since `422b189`. |
| Global grep of `lean/Core`, `lean/Frozen` | No `instance`, `notation`/`infix`/`prefix`/`postfix`, `macro`, `syntax`, `elab`, `axiom`, `opaque`, `unsafe`, `implemented_by`, `@[extern]`, `native_decide`, `sorry` or `admit`. The only hits are two file-local `attribute [local instance] Matrix.linftyOp…` lines (in `Transfer/BetaForm.lean` and `ExpForm.lean`) and `set_option linter.unusedVariables false in` on four providers, which affects a linter only. |
| `lean/lakefile.lean` | Unchanged since `422b189`. Its only option is `autoImplicit := false`, so no statement can acquire an auto-bound variable. It has no kernel-affecting option. |
| Author's combined audit | `lean/.lake/axiom-audit.json` (written by the author's run just before the commit; I did not rerun it) reports `passed: true`, 390 declarations, `draft_exports: []`, Lean 4.35.0. Its `anchor_abi` strings hash to the same 13 values as my own Probe 1 strings. |

The prefix and suffix were computed exactly as `check_theorem_region` defines them. The
prefix is every character up to and including the newline that ends the
`-- FROZEN_ANCHOR_PROOF_BEGIN` line. The suffix runs from the start of the
`-- FROZEN_ANCHOR_PROOF_END` line to the end of the file. Each was UTF-8 encoded and hashed, for
the working copy, the `HEAD` blob and the freeze-commit blob (`git show <freeze>:<path>`). The
**statement span** runs from `theorem <name>` through the `:=` that closes the statement:
before `-- FROZEN_ANCHOR_PROOF_BEGIN` in a frozen file, or before ` by` in a provider or draft.
That span was compared byte for byte across five texts: the approved draft, the frozen file at
its freeze commit, the frozen file at `939f4ee`, and the provider.

## 1. T3 `main_twisted_integrand_v1` (`wilson_twisted_trace_pos_and_fourier_bound`)

### 1.1 Pinned target

| Field | Manifest | Recomputed / observed |
|---|---|---|
| kind / state | theorem / SEALED | theorem / SEALED |
| path | `Frozen/PaperA/WilsonTwistedTraceBound.lean` | 3141 bytes, LF, no BOM, equal to the `HEAD` blob; file SHA-256 `15252d7d35aff7db209cd7d99ed6a8869ec030c42ab5155d0992ca9894a583aa` |
| export | `QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound` | the file's only declaration |
| implementation | `Core.PaperA.Provider.WilsonTwistedTraceBound` / `QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound` | declared exactly once; the module's only declaration |
| source | comparison.tex `1caaf36b…` 54–91; model.tex `2464b16f…` 27–35 | hashes MATCH; ranges correct |
| contract / split | `paper-a.thm:main.twisted-integrand` v1 / NOT_SPLIT, D16 | D16: "T3 is not split" |
| approval | Aravind Karthigeyan, 2026-11-14, `docs/DECISIONS.md#d16`, v1 | D16 present |
| `prefix_sha256` | `d5ab8ec3df9c632259c292ea47a9870c926b8da91e2252035368533482128aa7` | **MATCH** (now); **MATCH** (`8e97f0c`) |
| `suffix_sha256` | `a76b93d165dbe18cb2e511588d18edbea48f51c3b0ebc1f430f611de2436f9aa` | **MATCH** (now); **MATCH** (`8e97f0c`) |
| `abi_sha256` | `b83a0c8ad43792560d5ef61bc2495ea76a58285a6bb4dfda4de724acbded421c` | **MATCH** (Probe 1; the string is 19,850 characters); also equals DEPGRAPH `FROZEN_ABI_SHA256` |
| closure (8 files) | Step, DiracOperator, StepGenerator, TransferMatrix, CenteredTrace, LatticeShift, WilsonHopping, WilsonMass | all eight hashes **MATCH**. The set equals the transitive closure of project constants in the type (Probe 3). `StepFreeTime` is correctly absent, because the statement sums `links.map Prod.fst`. |

**Identity with the approved text.** The statement span is 1364 bytes with SHA-256
`425f73bd617d7e391a7c08f339c2556b3b185aaea3e8908c480166298bdc5c3a`. It is byte-identical in
the approved draft (block T3 of `audited-draft-v1`, and of `v1b`), the frozen file at
`8e97f0c`, the frozen file at `939f4ee`, and the provider. Both the draft and the frozen file
elaborate in `namespace QEDCore.PaperA` with `open Matrix` and
`open scoped Kronecker ComplexOrder`. The two differ only in the copyright header, the per-file
imports, the module and theorem docstrings, and the five markers. Between `8e97f0c` and
`939f4ee`, `git diff` changes only the body (prefix and suffix are byte-identical):

```diff
 -- FROZEN_ANCHOR_PROOF_BEGIN
-  by sorry
+  by exact QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound hn α β hα_herm
+      hβ_herm hα_sq hβ_sq hα_anti hαβ_anti a m r ha hm hr links hlinks b hb htime ϑ Q hQ
 -- FROZEN_ANCHOR_PROOF_END
```

**Import drift.** At the freeze, the provider stub imported only `Defs.CenteredTrace`,
`Defs.WilsonHopping` and `Defs.WilsonMass`. It now also imports `Wilson.Shift`,
`Wilson.TwistSplit` and the sealed Lemma 3.1 and 3.2 anchors. The ABI recomputed now equals the
value pinned at the freeze, so the new imports did not change the elaborated statement.

### 1.2 Seal body

- **Shape.** The body is 2 lines and 192 bytes (limits: 3 lines, 240 bytes). It is
  `by exact QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound` applied to
  exactly the 23 explicit binders of the anchor, in declaration order (script comparison;
  `args == explicit binders` is `True`).
- **Elaborated term (Probe 1, P4).** The anchor's value is a λ over all 25 binders whose body
  applies the provider to exactly those 25 bound variables, in order. The implicit `n` and the
  `NeZero` instance are filled by the anchor's own binders, and there are no universe
  parameters. The only constant outside the binder types is the provider.
- **Provider statement.** It is byte-identical to the anchor's (§1.1). In Lean (P2) the two
  types satisfy `Expr.eqv = true`, with equal binder infos and level parameters `[]` / `[]`.
  `Expr.equal` is false only because the anonymous `[NeZero n]` binder has a different
  hygienic name in each module (`inst._@.Frozen.PaperA…` versus `inst._@.Core.PaperA.Provider…`).
- **Checker binder set.** The set that `binder_names` extracts equals the declared binder names
  exactly. Since `da69c1b` it no longer picks up tokens from ascriptions in the conclusion.

### 1.3 Binder classification (26 logical inputs; `hlinks` split into two)

| # | Binder | Lean type (abridged) | Bin | Citation |
|---|---|---|---|---|
| 1 | `{n}` | `ℕ` | SOURCE | model L4 (`X = (ℤ/nℤ)³`), L5 (`N = n³`) |
| 2 | `[NeZero n]` | instance | TYPING | needed to form `Fintype (ZMod n)` for the finite matrices and `det`; implied by row 3 |
| 3 | `hn` | `3 ≤ n` | SOURCE | model L4 (`n ≥ 3`) |
| 4 | `α` | `Fin 3 → Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | model L27; comparison L6 ("For the Hamiltonian (2.4)") |
| 5 | `β` | `Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | model L27 |
| 6 | `hα_herm` | `∀ j, (α j).IsHermitian` | SOURCE | model L27 "Hermitian" |
| 7 | `hβ_herm` | `β.IsHermitian` | SOURCE | model L27 |
| 8 | `hα_sq` | `∀ j, α j * α j = 1` | SOURCE | model L27–L28 "square to one" |
| 9 | `hβ_sq` | `β * β = 1` | SOURCE | model L27–L28 |
| 10 | `hα_anti` | `∀ j k, j ≠ k → α j * α k + α k * α j = 0` | SOURCE | model L28 "anticommute pairwise" |
| 11 | `hαβ_anti` | `∀ j, α j * β + β * α j = 0` | SOURCE | model L28 |
| 12 | `a` | `ℝ` | SOURCE | model L4 (spacing); (2.3) L32–L33 |
| 13 | `m` | `ℝ` | SOURCE | model L33; comparison L7 |
| 14 | `r` | `ℝ` | SOURCE | model L33; comparison L7 |
| 15 | `ha` | `0 < a` | SOURCE | comparison L6; model L4 |
| 16 | `hm` | `0 < m` | SOURCE | comparison L13 ("for m > 0"), L70 |
| 17 | `hr` | `0 ≤ r` | SOURCE | comparison L7; model L39 |
| 18 | `links` | `List (ℝ × ((Fin 3 → ZMod n) → Fin 3 → ℂ))` | RULED | R5 (stands in for the bridge path ω on `[0, b]`, comparison L43–L51, L57–L61) |
| 19a | `hlinks`: `0 ≤ p.1` | — | RULED | R5 (`τ_k ≥ 0`) |
| 19b | `hlinks`: `‖p.2 x j‖ = 1` | — | SOURCE | model L9, L13 (`U ∈ U(1)^ℰ`, `U_e = e^{iφ_e}`); R5 restates it |
| 20 | `b` | `ℝ` | SOURCE | comparison L12 (inverse temperature, the path length of L43–L45) |
| 21 | `hb` | `0 < b` | SOURCE | comparison L12 |
| 22 | `htime` | `(links.map Prod.fst).sum = b` | RULED | R5 (`Σ_k τ_k = b`) |
| 23 | `ϑ` | `(Fin 3 → ZMod n) → ℝ` | RULED | R6 (comparison L82–L83 fixes `ϑ_root = 0`; R6 takes all of `ℝ^X`, a generalization) |
| 24 | `Q` | `ℤ` | SOURCE | `Q_ν` (comparison L9, L86–L89); Lemma 3.2's integer `q` |
| 25 | `hQ` | `\|Q\| ≤ 2 * (n : ℤ) ^ 3` | SOURCE | model (2.9) L89 (`\|Q_ν\| ≤ 2N`); Lemma 3.2's `\|q\| ≤ d` with `d = 2N` (comparison L89, transfer L99) |

Counts: **SOURCE 21, TYPING 1, RULED 4 (R5 ×3, R6 ×1), EXCESS 0.** Audit A gave the same
assignment under then-pending R5, filing ϑ as SOURCE with R6 recorded. D16 adopted R5–R8.

**Missing-premise direction.** Nothing in the source is dropped in a way that would make T3
claim more than the source:

- `g > 0` is absent because the coupling does not enter the fermionic factor.
- The bridge endpoint conditions `ω_0 = U`, `ω_b = U^u` are dropped by R5, a generalization.
- `ϑ_root = 0` is dropped by R6, a generalization.
- "Spatial matrices commute with the Dirac matrices" (model L39–L40) is built into the
  Kronecker carrier `v j ⊗ₖ α j`.

All binders are universal and precede the conclusion. The constant
`binom(4n³, 2n³+|Q|) e^{−bm|Q|}` depends only on `n, Q, b, m`.

### 1.4 Conclusion, definitions, and the `let`/coercion question

The elaborated conclusion, from `#print` (P4) and the raw ABI string:

| Item | Lean (elaborated) | Source | Verdict |
|---|---|---|---|
| History | `links.map (fun p => Step.free p.1 (wilsonHopping n a p.2) (wilsonMass n a m r p.2)) ++ [Step.kick (diagonal fun x => Complex.ofReal (ϑ x + φ))]` | the ordered propagator `V_ω` of `−h_W(ω_t)` (L48–L49), then the gauge kick `u = e^{iθ}` with `θ = ϑ + φ` (L61, L82–L83) | MATCH under R5/R6. `transferMatrix` puts later steps on the left, so the transfer matrix is `u ⊗ 1 · V`, the `uV_ω` of L61. |
| `F(φ)` | `centeredTrace α β (that history)` | `e^{−2iΣθ} det(I + uV_ω)` (L61), defined as the centered trace by R8 | MATCH. Under the Clifford premises `Tr α_j = Tr β = 0`, so the free-step centering factor is 1. The kick generator `−i(diag θ ⊗ 1)` gives the factor `e^{−2iΣ_x θ_x}`, as at transfer L83–L86. |
| Conjunct 1 | `∀ φ : ℝ, 0 < (F φ).re ∧ (F φ).im = 0` | "every integrand … is positive" (L70–L72), fermionic factor | MATCH. It holds for every real `φ` and every `ϑ`. The scalar factors `K_b` and `e^{−∫H_B}` are omitted (R8). |
| Conjunct 2 | `(Fhat 0).im = 0` | `F_0` real (L90–L91), R6 as R3 | MATCH |
| Conjunct 3 | `‖Fhat Q‖ ≤ ↑((4 n³).choose (2 n³ + Q.natAbs)) * Real.exp (−(b m \|↑Q\|)) * (Fhat 0).re` | Lemma 3.2 with `D = 4N`, `d = 2N`, `m_* = m` (L86–L89); (3.4) | MATCH |

How `F` and `Fhat` elaborate, read from the ABI string. None of these points changes the
meaning from the source.

- **`let`s.** `F` and `Fhat` are non-dependent `let`s, which `#print` shows as `have`. The
  proposition means the same as the substituted one, and consumers can still unfold them: the
  provider uses `simp only [Fhat, hF]`, and my S1 probe uses `show`.
- **Kick coercion.** The kick is `Complex.ofReal (HAdd.hAdd ℝ (ϑ x) φ)`: the real sum, cast once
  to ℂ.
- **Integrand.** `Complex.exp (Neg.neg (Int.cast p * Complex.ofReal φ * Complex.I)) * F φ`.
  Here `p : ℤ` is cast directly to ℂ (`Int.cast` with `Complex.instIntCast`), so the integrand
  is `e^{−ipφ} F(φ)` with transfer.tex L98's sign.
- **Normalization.** `(2 * Complex.ofReal Real.pi)⁻¹`, which is `(2π)⁻¹` in ℂ.
- **Integral.** `intervalIntegral (fun φ => …) 0 (2 * Real.pi) volume`, the oriented interval
  integral over `[0, 2π]` (`0 < 2π`) with Lebesgue measure. `F` is continuous (S1), so every
  `Fhat p` is a genuine Fourier coefficient, not Bochner's junk value `0`.
- **Binomial.** `Nat.cast (Nat.choose (4 * n ^ 3) (2 * n ^ 3 + Int.natAbs Q)) : ℝ`. It is
  computed in ℕ with no truncated subtraction and then cast to ℝ, and it equals
  `binom(4N, 2N + |Q_ν|)`. Under `hQ` the lower index is at most `4n³`, so the coefficient is
  at least 1.
- **Exponential.** `Real.exp (−(b * m * |Int.cast Q|))`, with `Q` cast to ℝ.
- **Non-degeneracy (S1, Probe 2).** For every instance of the hypotheses, `Continuous F` and
  `0 < (Fhat 0).re`. So conjunct 3 is never the degenerate `0 ≤ 0`, and conjunct 2 together
  with conjunct 3 at `Q = 0` express the source's "nonnegative zeroth coefficient".

**Definitions.** The project constants in the type are `centeredTrace`, `Step`, `Step.free`,
`Step.kick`, `wilsonHopping` and `wilsonMass` (P3). Their transitive closure adds
`transferMatrix`, `Step.generator`, `diracOperator`, `latticeShift` and compiler-generated
auxiliaries (`_proof_1`, `match_1`, `rec`, `casesOn`) of the same files (Probe 3). All come
from the eight manifest-hashed `Defs` files, whose whole-file hashes and ABIs match. No helper
or provider constant occurs in the statement.

**Exact-type probe (Probe 2, R1).** I transcribed T3 from comparison.tex L54–L91, model.tex
L4, L27–L35 and L39, and R5/R6/R8. The transcription uses my own binder names (`L, al, be, sp,
ms, rw, path, t, rel, k, G, Gc`), anonymous hypotheses, `Complex.ofReal`, `Nat.choose` and
`Int.natAbs`, and sits outside the project namespaces. It is closed by
`@QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound`, and its type is alpha-equivalent
to the frozen type (`Expr.eqv = true`, 25 binders, binder infos equal).

**Non-vacuity (Probe 4).** I took the standard Dirac representation with all six Clifford
premises proved, `n = 3`, `a = m = 1`, `r = 0`, `links = [(1, U ≡ 1)]`, `b = 1`, `ϑ = 0` and
`Q = 54 = 2·3³`, the extreme value allowed by `hQ`. Every premise is discharged.

### 1.5 Provider proof route (brief)

The route follows comparison.tex L70–L89 with `ι = (ℤ/nℤ)³`, `d = 2n³` and `m_* = m`:

- **Hypotheses.** `four_mul_card_fin_three_zmod` gives `4|ι| = 2(2n³)`.
  `isHermitian_wilsonHopping` and `posSemidef_wilsonMass_sub` (from `Wilson.Shift`, using
  `ha`, `hr`, `hlinks`) supply Lemma 3.1's free-step premises, and `isHermitian_diagonal_ofReal`
  supplies its kick premise.
- **Positivity.** The sealed Lemma 3.1 at each `φ` gives conjunct 1.
- **Fourier bound.** The sealed Lemma 3.2 is applied to the history that ends in `diag ϑ`, at
  `q = Q`. The twist split `centeredTrace_free_append_diagonal_add_eq`
  (`diag(ϑ+φ) = diag ϑ + φ·1`, central, with additive generators) identifies its `F` with
  T3's `F`.
- **Binomial.** `choose_two_mul_two_mul_pow_three` rewrites Lemma 3.2's
  `binom(2·2n³, 2n³+|Q|)` into `binom(4n³, 2n³+|Q|)`.

The provider's type is the frozen type (P2), so the provider proves exactly the statement, not
a weaker one. `hn` is unused.

### 1.6 Axioms and kernel

- `#print axioms` on the frozen export and on the provider gives `[propext, Classical.choice,
  Quot.sound]` for both (P5, with `collectAxioms` agreeing).
- `lake env leanchecker Frozen.PaperA.WilsonTwistedTraceBound` exits 0 with no output (29 s).
- `lake env leanchecker Core.PaperA.Provider.WilsonTwistedTraceBound` exits 0 with no output
  (30 s).

### 1.7 Findings

- **T3-N1 (NOTE) Scope.** T3 is a proof step of `thm:main`, not Theorem 4.1. It covers
  piecewise-constant link histories without bridge endpoint conditions (R5), with `ϑ ∈ ℝ^X`
  unrestricted (R6), and with the centered trace standing as the definition of the fermionic
  factor (R8). The finite-CAR identity, the scalar factors and the passage to continuous bridges
  are outside the frozen surface (deviation 9). The README and `lean/status.json` keep
  Theorem 4.1 "not formalized as stated".
- **T3-N2 (NOTE) Unused premise.** The provider does not use `hn`, and its unused-variables
  linter is disabled for the declaration. `hn` is a faithful source premise (model L4);
  dropping it would only strengthen the statement.
- **T3-N3 (NOTE) Bundled conjunct.** The positivity conjunct is stated under `Q`/`hQ`. This is
  harmless because `Q = 0` always qualifies, and D16 declined a split.
- **T3-N4 (NOTE) Graph dependency.** The DEPGRAPH node lists `def:step-free-time` among T3's
  DEPS, a proof-level dependency through Lemmas 3.1 and 3.2. The frozen statement does not use
  `Step.freeTime`, and the manifest closure correctly omits it. There is no effect on the
  statement.

## 2. T4 `rem_nonneg_mass_v1` (`centeredTrace_nonneg_of_posSemidef_mass`)

### 2.1 Pinned target

| Field | Manifest | Recomputed / observed |
|---|---|---|
| kind / state | theorem / SEALED | theorem / SEALED |
| path | `Frozen/PaperA/CenteredTraceNonneg.lean` | 2119 bytes, LF, no BOM, equal to the `HEAD` blob; SHA-256 `2588f1d2bce2a88a8ce6930990b90e4798dc1901b18753c8b0db8f2a32239c7a` |
| export | `QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass` | the file's only declaration |
| implementation | `Core.PaperA.Provider.CenteredTraceNonneg` / `QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass` | declared exactly once; the module's only declaration |
| source | transfer.tex `b2dcc793…` 89–91; comparison.tex `1caaf36b…` 98–99 | hashes MATCH |
| contract / split | `paper-a.rem:nonneg-mass` v1 / NOT_SPLIT, D16 | consistent |
| approval | Aravind Karthigeyan, 2026-11-14, D16, v1 | D16 present (R7) |
| `prefix_sha256` | `a73e24cac502ee6146ed261a239ad0c8d471c9d72a23af1e0b5e8c044497ed06` | **MATCH** (now); **MATCH** (`8e97f0c`) |
| `suffix_sha256` | `a76b93d165dbe18cb2e511588d18edbea48f51c3b0ebc1f430f611de2436f9aa` | **MATCH** (now); **MATCH** (`8e97f0c`) |
| `abi_sha256` | `8da711bd44595add34e9f40de2ef6a89d94d7ca311ff955d94f11d4fe3e42316` | **MATCH** (Probe 1; 13,548 characters); also equals DEPGRAPH |
| closure (6 files) | Step, DiracOperator, StepGenerator, StepFreeTime, TransferMatrix, CenteredTrace | all six **MATCH**; equals the transitive closure of the type (Probe 3) |

**Identity with the approved text.** The statement span is 791 bytes with SHA-256
`0f11d0aabd927688827f0cc7bab88937ed027d7e97e89272f819351ef5c09018`. It is byte-identical in
the approved draft (block T4), the frozen file at `8e97f0c`, the frozen file at `939f4ee`, and
the provider. Only the body changed (`by sorry` → the line below), and prefix and suffix are
byte-identical. At the freeze the provider stub imported only `Defs`. It now imports
`Transfer.NonnegMass` and the sealed Lemma 3.1 anchor, and the ABI is unchanged.

### 2.2 Seal body

- **Shape.** The body is 2 lines and 167 bytes: `by exact
  QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass α β hα_herm hβ_herm hα_sq
  hβ_sq hα_anti hαβ_anti b hb hist hfree hkick htime`. These are exactly the 14 explicit
  binders, in order.
- **Elaborated term (P4).** The value is a λ over the 17 binders, with the provider applied to
  exactly those binders in order. The universe argument is the anchor's own `u_1`, and the only
  non-type constant is the provider.
- **Provider statement.** Byte-identical. `Expr.eqv = true`, binder infos are equal, and the
  level parameters are `[u_1]` / `[u_1]`. `Expr.equal` differs only in the hygienic names of
  the two anonymous instance binders.

### 2.3 Binder classification (19 logical inputs; `hfree` split into three)

| # | Binder | Lean type (abridged) | Bin | Citation |
|---|---|---|---|---|
| 1 | `{ι}` | `Type u_1` | RULED | R2 via R7 (transfer L6 `D = 2d`; the application takes `ι = X`) |
| 2 | `[Fintype ι]` | instance | RULED | R2 via R7 ("any finite type"; finite-dimensional, transfer L4) |
| 3 | `[DecidableEq ι]` | instance | TYPING | needed for `1 : Matrix ι ι ℂ` and `det` |
| 4–11 | `α, β, hα_herm, hβ_herm, hα_sq, hβ_sq, hα_anti, hαβ_anti` | as in T3 | SOURCE | transfer L6–L7 ("same four-component Dirac structure"); model L27–L28 |
| 12 | `b` | `ℝ` | SOURCE | transfer L15 |
| 13 | `hb` | `0 < b` | SOURCE | transfer L15; retained by R7 |
| 14 | `hist` | `List (Step ι)` | RULED | R1(a) via R7 |
| 15a | `hfree`: `0 ≤ τ` | — | RULED | R1(a) via R7 (source `c ≥ 0`, L25) |
| 15b | `hfree`: `∀ j, (v j).IsHermitian` | — | SOURCE | transfer L15 |
| 15c | `hfree`: `M.PosSemidef` | — | SOURCE | transfer L89 ("nonnegative mass coefficient"); R7 (`M ⪰ 0`) |
| 16 | `hkick` | `∀ Θ, Step.kick Θ ∈ hist → Θ.IsHermitian` | RULED | R4 via R7 (source `Φ` Hermitian, spin scalar, L26) |
| 17 | `htime` | `(hist.map Step.freeTime).sum = b` | SOURCE | transfer L25 (`∫ c = b`), in the step form of R1(a) |

Counts: **SOURCE 13, TYPING 1, RULED 5, EXCESS 0.** Audit A filed row 2 as TYPING; the
difference is classification only. In the missing-premise direction, Lemma 3.1's
`M ≥ m_* I > 0` is replaced by the remark's `M ⪰ 0` (L89). `D = 2d` needs no premise because
`D = 4|ι|` and `d` does not occur.

### 2.4 Conclusion and definitions

| Item | Lean | Source | Verdict |
|---|---|---|---|
| Conclusion | `(centeredTrace α β hist).im = 0 ∧ 0 ≤ (centeredTrace α β hist).re` | "The centered trace is then nonnegative but may vanish" (transfer L91); "determinants are nonnegative" (comparison L98–L99) | MATCH. "May vanish" is not a claim. The non-strict form cannot be strengthened: audit A's example (`v = 0`, `M = 0`, kick `π·1`) gives `F = 0`. |

- **Definitions.** The project constants in the type are `Step`, `Step.free`, `Step.kick`,
  `Step.freeTime` and `centeredTrace` (P3). The transitive closure (Probe 3) lies in the six
  manifest-hashed `Defs` files.
- **Exact-type probe (Probe 2, R2).** My transcription (`S, al, be, t, H`), closed by
  `@QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass`, has `Expr.eqv = true` with the
  frozen type (17 binders, infos equal).
- **Non-vacuity (Probe 4).** Instantiated at `ι = Fin 1` with the Dirac set above, `b = 1` and
  the history `[free 1 0 0, kick 0]`, whose mass coefficient `0` is positive semidefinite but
  not definite. Every premise is discharged.

### 2.5 Provider proof route (brief)

The route follows transfer L89–L91, "replace `M` by `M + εI` … pass to the limit":

- `Step.shiftMass ε` maps `free τ v M` to `free τ v (M + ε·1)` and leaves kicks alone (helper
  `Transfer/NonnegMass.lean`).
- For `ε > 0`, the sealed Lemma 3.1 applies with `m_* = ε`, `d = 2|ι|` and the same `b`. Its
  premise `(M' − ε·1) ⪰ 0` for a shifted step is `hfree` for the original step.
- `ε ↦ F_ε` is continuous, and `{z | Im z = 0 ∧ 0 ≤ Re z}` is closed, which gives the
  conclusion (`centeredTrace_nonneg_of_shiftMass`).

The provider's type is the frozen type (P2).

### 2.6 Axioms and kernel

- `#print axioms` on the frozen export and on the provider gives `[propext, Classical.choice,
  Quot.sound]` for both.
- `leanchecker Frozen.PaperA.CenteredTraceNonneg` exits 0 (31 s).
- `leanchecker Core.PaperA.Provider.CenteredTraceNonneg` exits 0 (30 s).

### 2.7 Findings

- **T4-N1 (NOTE) Retained premise.** `hb : 0 < b` is kept from Lemma 3.1 (R7, deviation 10),
  although the conclusion also holds at `b = 0`. The statement is therefore slightly weaker
  than the strongest true one. This is faithful, not an error.
- **T4-N2 (NOTE) Setting.** T4 is stated in Lemma 3.1's abstract frozen setting. The Wilson
  `m = 0` instance used at comparison L98–L99 also needs T5's first conjunct at `m = 0`.
  Statement audit T5T6_B §8.5 recorded that consumption witness.

## 3. T5 `eq_mass_bound_v1` (`wilson_mass_bound`)

### 3.1 Pinned target

| Field | Manifest | Recomputed / observed |
|---|---|---|
| kind / state | theorem / SEALED | theorem / SEALED |
| path | `Frozen/PaperA/WilsonMassBound.lean` | 2180 bytes, LF, no BOM, equal to the `HEAD` blob; SHA-256 `c3d38297b45632ac959abbfb95a180ada55f57a1d6186f80d8aa49779b1b16fd` |
| export | `QEDCore.PaperA.wilson_mass_bound` | the file's only declaration |
| implementation | `Core.PaperA.Provider.WilsonMassBound` / `QEDCore.PaperA.Provider.wilson_mass_bound` | declared exactly once; the module's only declaration |
| source | model.tex `2464b16f…` 39–46 | hash MATCH |
| contract / split | `paper-a.eq:mass-bound` v1 / NOT_SPLIT, D16 | consistent |
| approval | Aravind Karthigeyan, 2026-11-14, D16, v1 | D16: approved on condition of two clean statement audits; both are on file with PASS, EXCESS 0 and no new ruling |
| `prefix_sha256` | `84412720976eada1b2bcfa0b025710118c80f1d335ddd9084cdb3afa94a98fb4` | **MATCH** (now); **MATCH** (`eea8f30`) |
| `suffix_sha256` | `a76b93d165dbe18cb2e511588d18edbea48f51c3b0ebc1f430f611de2436f9aa` | **MATCH** (now); **MATCH** (`eea8f30`) |
| `abi_sha256` | `218a74588ce44905592eaf7ad7850a4e9fc3618f39a40435f3af38a6e1343880` | **MATCH** (Probe 1; 24,470 characters); also equals DEPGRAPH |
| closure (4 files) | DiracOperator, LatticeShift, WilsonHopping, WilsonMass | all four **MATCH**; equals the transitive closure of the type (Probe 3) |

**Identity with the approved text.** The statement span is 880 bytes with SHA-256
`0b47baa6a2db64c578cb6da7990acf2b0d0c0251c1addad6cf6832b74e053c2e`. It is byte-identical in
the approved draft (`draft-v1b-with-T5-T6`, block T5), the frozen file at `eea8f30`, the frozen
file at `939f4ee`, and the provider. Only the body changed, and prefix and suffix are
byte-identical. The provider now imports `Wilson.Shift` and `Wilson.MassBound`, and the ABI is
unchanged.

### 3.2 Seal body

- **Shape.** The body is 2 lines and 140 bytes: `by exact QEDCore.PaperA.Provider.wilson_mass_bound
  hn α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti a m r ha hm hr U hU`. These are exactly
  the 17 explicit binders, in order.
- **Elaborated term (P4).** The value is a λ over the 19 binders with the provider applied to
  exactly those binders in order. The only non-type constant is the provider.
- **Provider statement.** Byte-identical. `Expr.eqv = true`, binder infos are equal, and the
  only `Expr.equal` difference is the hygienic `[NeZero n]` name.

### 3.3 Binder classification (19 logical inputs)

| # | Binder | Bin | Citation (model.tex) |
|---|---|---|---|
| 1 | `{n : ℕ}` | SOURCE | L4 |
| 2 | `[NeZero n]` | TYPING | `Fintype (ZMod n)`; implied by row 3 |
| 3 | `hn : 3 ≤ n` | SOURCE | L4 |
| 4–11 | Clifford set (8 binders) | SOURCE | L27–L28 |
| 12–14 | `a m r : ℝ` | SOURCE | L4, L33 |
| 15 | `ha : 0 < a` | SOURCE | L4 |
| 16 | `hm : 0 ≤ m` | SOURCE | L39 ("m ≥ 0") |
| 17 | `hr : 0 ≤ r` | SOURCE | L39 ("r ≥ 0") |
| 18 | `U : X → Fin 3 → ℂ` | SOURCE | L9, L13, (2.3) L31 (link variables `U_{xj}`) |
| 19 | `hU : ∀ x j, ‖U x j‖ = 1` | SOURCE | L13 (`U_e = e^{iφ_e}`); L40 ("Since `T_j(U)` is unitary") |

Counts: **SOURCE 18, TYPING 1, RULED 0, EXCESS 0**, matching statement audit T5T6_B.

### 3.4 Conclusion and definitions

| Conjunct | Lean | Source | Verdict |
|---|---|---|---|
| 1 | `(wilsonMass n a m r U − (m : ℂ) • 1).PosSemidef` | `M(U) ≥ mI` (L42) | MATCH (Loewner order on `ℓ²(X)`) |
| 2, 3 | `(↑(m + (3 + 6r)/a) • 1 ∓ diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef` | `‖h_W(U)‖ ≤ h_* := m + (3+6r)/a` (L43) | MATCH as recorded in deviation 11. `PosSemidef` includes Hermiticity, so conjunct 2 already forces `h_W(U)` Hermitian. For a Hermitian `h`, the pair is equivalent to `spec h ⊂ [−h_*, h_*]`, i.e. `‖h‖_op ≤ h_*`. Statement audit T5T6_A proved this equivalence in Lean (P3c); I did not re-prove it. The ABI shows `h_*` as `Complex.ofReal (m + (3 + 6 * r) / a)` with real division, and `1` as the identity on `X × Fin 4`. |

- **Definitions.** The project constants in the type are `wilsonMass`, `diracOperator` and
  `wilsonHopping` (P3). Their closure adds `latticeShift` (Probe 3). All four files are
  manifest-hashed, and their ABIs match.
- **Exact-type probe (Probe 2, R3).** My transcription (`L, al, be, sp, ms, rw, V`), with
  explicit matrix types on `1`, has `Expr.eqv = true` with the frozen type (19 binders).
- **Non-vacuity (Probe 4).** At `n = 3`, `U ≡ 1`, `a = 1`, `m = r = 0`, with the Dirac set
  above, every premise is discharged.

### 3.5 Provider proof route (brief)

- **Conjunct 1** is `posSemidef_wilsonMass_sub`, from `2 − T − Tᴴ = (1 − T)ᴴ(1 − T)` (L46) and
  `T_jᴴ T_j = 1` for unit links.
- **Conjuncts 2 and 3** are `posSemidef_bound_add_smul_diracOperator` at `s = ∓1`. It writes
  `h_* ± h_W` as a sum of terms `c • XᴴX` with `c ≥ 0`, using `W*W = 1 ⇒
  2 ± (W + W*) = (1 ± W)*(1 ± W)` applied to `−i T_j ⊗ α_j`, `1 ⊗ β` and `T_j ⊗ β`.

The provider's type is the frozen type (P2). `hn`, `hα_anti` and `hαβ_anti` are unused.

### 3.6 Axioms and kernel

- `#print axioms` on the frozen export and on the provider gives `[propext, Classical.choice,
  Quot.sound]` for both.
- `leanchecker Frozen.PaperA.WilsonMassBound` exits 0 (28 s).
- `leanchecker Core.PaperA.Provider.WilsonMassBound` exits 0 (26 s).

### 3.7 Findings

- **T5-N1 (NOTE) Unused premises.** The provider does not use `hn`, `hα_anti` or `hαβ_anti`.
  All three are faithful source premises (model L4, L28).
- **T5-N2 (NOTE) Norm encoding.** The norm bound is encoded as a PSD pair, so no matrix norm
  is chosen (deviation 11). The encoding is equivalent, as explained in §3.4.

## 4. T6 `gauge_covariance_v1` (`wilson_gauge_covariance`)

### 4.1 Pinned target

| Field | Manifest | Recomputed / observed |
|---|---|---|
| kind / state | theorem / SEALED | theorem / SEALED |
| path | `Frozen/PaperA/WilsonGaugeCovariance.lean` | 1944 bytes, LF, no BOM, equal to the `HEAD` blob; SHA-256 `73f4526b45afe33a1a5222bb9c34b2ddc9e0cfa932e2384d8353a61ba00066fb` |
| export | `QEDCore.PaperA.wilson_gauge_covariance` | the file's only declaration |
| implementation | `Core.PaperA.Provider.WilsonGaugeCovariance` / `QEDCore.PaperA.Provider.wilson_gauge_covariance` | declared exactly once; the module's only declaration |
| source | model.tex `2464b16f…` 64–71 | hash MATCH |
| contract / split | `paper-a.model.gauge-covariance` v1 / NOT_SPLIT, D16 | consistent |
| approval | Aravind Karthigeyan, 2026-11-14, D16, v1 | conditional approval; condition met (as for T5) |
| `prefix_sha256` | `45a8dcb2a0be2d040aab52aee7320b7e215c288f0aedaa9e57885909c6dce1b9` | **MATCH** (now); **MATCH** (`eea8f30`) |
| `suffix_sha256` | `a76b93d165dbe18cb2e511588d18edbea48f51c3b0ebc1f430f611de2436f9aa` | **MATCH** (now); **MATCH** (`eea8f30`) |
| `abi_sha256` | `a9c88dba21a22f42a995d0324d6f025daec649649709fa10ded792094271864b` | **MATCH** (Probe 1; 14,324 characters); also equals DEPGRAPH |
| closure (4 files) | DiracOperator, LatticeShift, WilsonHopping, WilsonMass | all four **MATCH**; equals the transitive closure of the type (Probe 3) |

**Identity with the approved text.** The statement span is 691 bytes with SHA-256
`c440b37bf017adf03016e2525cae12e83e58449fc3e3aea24a9b86cc37f49388`. It is byte-identical in
the approved draft (`v1b`, block T6), the frozen file at `eea8f30`, the frozen file at
`939f4ee`, and the provider. Only the body changed, and prefix and suffix are byte-identical.
The provider now imports `Wilson.GaugeCovariance`, and the ABI is unchanged.

### 4.2 Seal body

- **Shape.** The body is 1 line and 81 bytes: `by exact QEDCore.PaperA.Provider.wilson_gauge_covariance
  hn α β a m r U u hu`. These are exactly the 9 explicit binders, in order.
- **Elaborated term (P4).** The value is a λ over the 11 binders with the provider applied to
  exactly those binders in order. The only non-type constant is the provider.
- **Provider statement.** Byte-identical. `Expr.eqv = true`, binder infos are equal, and the
  only `Expr.equal` difference is the hygienic `[NeZero n]` name.

### 4.3 Binder classification (11 logical inputs)

| # | Binder | Bin | Citation (model.tex) |
|---|---|---|---|
| 1 | `{n : ℕ}` | SOURCE | L4 |
| 2 | `[NeZero n]` | TYPING | `Fintype (ZMod n)`; implied by row 3 |
| 3 | `hn : 3 ≤ n` | SOURCE | L4 |
| 4 | `α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | L27 (the Clifford relations are not assumed, a generalization per deviation 11) |
| 5 | `β` | SOURCE | L27 |
| 6–8 | `a m r : ℝ` | SOURCE | L4, L33 (no sign conditions, a generalization) |
| 9 | `U : X → Fin 3 → ℂ` | SOURCE | L31, L66 (any complex link array, a generalization) |
| 10 | `u : X → ℂ` | SOURCE | L64 (gauge function) |
| 11 | `hu : ∀ x, ‖u x‖ = 1` | SOURCE | L64 (`u_x = e^{iθ_x}`) |

Counts: **SOURCE 10, TYPING 1, RULED 0, EXCESS 0**, matching statement audit T5T6_B. In the
missing-premise direction, every omitted source condition (Clifford, `|U| = 1`, `a > 0`,
`m, r ≥ 0`) only makes the theorem stronger. The source statement is the instance that has
those conditions.

### 4.4 Conclusion and definitions

| Item | Lean | Source | Verdict |
|---|---|---|---|
| Transformed field | `fun x j => u x * U x j * star (u (x + Pi.single j 1))` | `U^u_{xj} = u_x U_{xj} \bar u_{x+e_j}` (L66), `e_j = Pi.single j 1` | MATCH |
| Left side | `diracOperator α β (wilsonHopping n a U^u) (wilsonMass n a m r U^u)` | `h_W(U^u)` | MATCH |
| Right side | `((diagonal u)ᴴ ⊗ₖ 1) * h_W(U) * (diagonal u ⊗ₖ 1)` (ABI: `kroneckerMap (·*·) (diagonal u).conjTranspose 1`) | `u^* h_W(U) u` (L71), with `u` acting on `ℓ²(X)` | MATCH. The star is on the left, and the spatial factor comes first, as in `diracOperator`'s `v j ⊗ₖ α j`. |

Hand check of the orientation, from (2.3):
`(T_j(U^u) f)(x) = conj(u_x U_{xj} conj(u_{x+e_j})) f(x+e_j) = conj(u_x) conj(U_{xj}) u_{x+e_j} f(x+e_j) = (u^* T_j(U) u f)(x)`.

- **Definitions.** The project constants are `diracOperator`, `wilsonHopping` and `wilsonMass`
  (P3), and the closure adds `latticeShift` (Probe 3). All are manifest-hashed.
- **Exact-type probe (Probe 2, R4).** My transcription (`L, al, be, sp, ms, rw, V, g`) has
  `Expr.eqv = true` with the frozen type (11 binders).
- **Non-vacuity (Probe 4).** At `n = 3`, `U ≡ 1`, `u ≡ I` and `a = m = r = 1`, every premise
  is discharged.

### 4.5 Provider proof route (brief)

`simp only` with the helper identities `wilsonHopping_gauge` (`v_j(U^u) = D^* v_j(U) D`) and
`wilsonMass_gauge` (`M(U^u) = D^* M(U) D`, which uses `|u_x| = 1`), linearity, and
`kronecker_conj_one`. The provider's type is the frozen type (P2). `hn` is unused.

### 4.6 Axioms and kernel

- `#print axioms` on the frozen export and on the provider gives `[propext, Classical.choice,
  Quot.sound]` for both.
- `leanchecker Frozen.PaperA.WilsonGaugeCovariance` exits 0 (27 s).
- `leanchecker Core.PaperA.Provider.WilsonGaugeCovariance` exits 0 (27 s).

### 4.7 Findings

- **T6-N1 (NOTE) Stronger than the source.** The statement drops the Clifford relations, the
  unit-link condition and all sign conditions (deviation 11). The source statement is an
  instance. `hn` is unused by the provider.

## 5. ABI recomputation (Probe 1, P1)

Each string was formed exactly as `abiString` in `lean/scripts/Audit/AxiomAudit.lean` does it
(`theorem <name> : <type>`, `def <name> : <type> := <value>`, or the inductive form), in the
post-seal environment, and hashed with SHA-256:

| Export | Length | Recomputed = manifest |
|---|---|---|
| `QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound` | 19850 | `b83a0c8a…421c` MATCH |
| `QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass` | 13548 | `8da711bd…2316` MATCH |
| `QEDCore.PaperA.wilson_mass_bound` | 24470 | `218a7458…3880` MATCH |
| `QEDCore.PaperA.wilson_gauge_covariance` | 14324 | `a9c88dba…864b` MATCH |
| `QEDCore.PaperA.Step` | 408 | `1490cf38…a1d2` MATCH |
| `QEDCore.PaperA.diracOperator` | 3722 | `8e584268…0ac8` MATCH |
| `QEDCore.PaperA.Step.generator` | 4625 | `7a85dcbb…1f79` MATCH |
| `QEDCore.PaperA.Step.freeTime` | 935 | `f02bcd44…48f5` MATCH |
| `QEDCore.PaperA.transferMatrix` | 4681 | `e0943f9b…c828` MATCH |
| `QEDCore.PaperA.centeredTrace` | 4782 | `0d9d1742…a31f` MATCH |
| `QEDCore.PaperA.latticeShift` | 6409 | `3400f002…b960` MATCH |
| `QEDCore.PaperA.wilsonHopping` | 3378 | `7349b3eb…7435` MATCH |
| `QEDCore.PaperA.wilsonMass` | 8786 | `4e71de78…8787` MATCH |

The ABI string prints the raw elaborated expression, including every instance and coercion
term. A shadowing name, a project instance or a changed coercion in a statement would
therefore change the hash. The hashes are the ones pinned at the freeze, when every provider
was a stub that imported only `Defs`.

## 6. Kernel replay

`bash ../scripts/lean-gate.sh lake env leanchecker <Module>` from `lean/`, one process per
module, in default mode: the module's own declarations are replayed through the kernel, and
compiled imports are trusted. `leanchecker` resolves its argument: a nonexistent module fails
with exit 1 ("Could not find any oleans").

| Module | Exit | Output |
|---|---|---|
| `Frozen.PaperA.WilsonTwistedTraceBound` | 0 | none |
| `Frozen.PaperA.CenteredTraceNonneg` | 0 | none |
| `Frozen.PaperA.WilsonMassBound` | 0 | none |
| `Frozen.PaperA.WilsonGaugeCovariance` | 0 | none |
| `Core.PaperA.Provider.WilsonTwistedTraceBound` | 0 | none |
| `Core.PaperA.Provider.CenteredTraceNonneg` | 0 | none |
| `Core.PaperA.Provider.WilsonMassBound` | 0 | none |
| `Core.PaperA.Provider.WilsonGaugeCovariance` | 0 | none |
| *extra:* `Core.PaperA.Wilson.Shift` | 0 | none |
| *extra:* `Core.PaperA.Wilson.MassBound` | 0 | none |
| *extra:* `Core.PaperA.Wilson.GaugeCovariance` | 0 | none (a gate wait) |
| *extra:* `Core.PaperA.Wilson.TwistSplit` | 0 | none |
| *extra:* `Core.PaperA.Transfer.NonnegMass` | 0 | none |

## 7. Global findings

- **G-N1 (NOTE) Checker coverage of the seal body.** The checker's SEALED-body rule checks
  that each argument is one of the declaration's binder names, not their order or arity. I
  verified order and arity separately, by script on the source and by the elaborated term
  (P4). Since `da69c1b`, `binder_names` scans only the top-level binder groups. For all four
  files the extracted set equals the declared names, so the looseness reported in
  LEM_FOURIER_AUDIT_1 §8.1 is fixed. Any misuse would in any case have to type-check against
  the pinned frozen type.
- **G-N2 (NOTE) Replay scope.** `leanchecker` in default mode trusts compiled imports. My
  replays cover the eight audited modules and, in addition, the five new helper modules. The
  older helper modules and the sealed Lemma 3.1/3.2 anchors and providers, all byte-unchanged
  since `422b189`, rely on KERNEL_REPLAY_2026-11-13 and KERNEL_REPLAY_2026-11-14 and were not
  replayed again here. Their axioms enter the axiom check of the four exports, which is
  standard.
- **G-N3 (NOTE) Graph status field.** `docs/graph/DEPGRAPH.md` shows `LEAN_STATUS:
  NOT_STARTED` for all 71 nodes, including the four roots, while `lean/status.json` lists the
  four `frozen_steps` as `PROVED`. Per the graph's own policy, the Lean fields stay at their
  initial value at this stage. This is bookkeeping only. The graph's `FROZEN_ABI_SHA256` pins
  for the four roots equal the manifest.
- **G-N4 (NOTE) Form of the approval.** D16 records the author's words for the package as
  "okay finish with what you think is next", in reply to a request to approve it as
  recommended, and treats them as approval. T5 and T6 were approved on condition of two clean
  statement audits. Both are on file (`STATEMENT_AUDIT_T5T6_A/B.md`: PASS, EXCESS 0, no new
  ruling), and the frozen module docstrings say so. I take D16 as authoritative. The approved
  bytes are archived with the hashes D16 records, and they equal the sealed statements.

No BLOCKING and no MINOR finding.

## 8. Verdicts

| Theorem | Statement | Seal integrity | Axioms | Kernel | Overall |
|---|---|---|---|---|---|
| T3 `wilson_twisted_trace_pos_and_fourier_bound` (`main_twisted_integrand_v1`) | PASS (EXCESS 0; R5, R6, R8) | PASS | PASS (standard three) | PASS (anchor and provider) | **PASS** |
| T4 `centeredTrace_nonneg_of_posSemidef_mass` (`rem_nonneg_mass_v1`) | PASS (EXCESS 0; R1(a), R2, R4 via R7) | PASS | PASS (standard three) | PASS (anchor and provider) | **PASS** |
| T5 `wilson_mass_bound` (`eq_mass_bound_v1`) | PASS (EXCESS 0; no ruling) | PASS | PASS (standard three) | PASS (anchor and provider) | **PASS** |
| T6 `wilson_gauge_covariance` (`gauge_covariance_v1`) | PASS (EXCESS 0; no ruling; stronger than the source) | PASS | PASS (standard three) | PASS (anchor and provider) | **PASS** |

## Appendix A. Probe sources and outputs (transient, deleted)

All four files were in `lean/.lake/scratch/audit1/` and were compiled with
`bash ../scripts/lean-gate.sh lake env lean .lake/scratch/audit1/ProbeN.lean` from `lean/`.
All exited 0. Probes 1–3 printed no error, warning or `sorry`. Probe 4 printed only six
"simp argument is unused" lints.

### A.1 Probe 1 (ABI strings, provider comparison, constants, proof-term shape, axioms)

```lean
import Frozen.PaperA.WilsonTwistedTraceBound
import Frozen.PaperA.CenteredTraceNonneg
import Frozen.PaperA.WilsonMassBound
import Frozen.PaperA.WilsonGaugeCovariance
import Lean

open Lean Elab Command Meta

namespace Audit1

def abiStr (env : Environment) (n : Name) : Option String :=
  match env.find? n with
  | some (.thmInfo t) => some s!"theorem {n} : {t.type}"
  | some (.defnInfo d) => some s!"def {n} : {d.type} := {d.value}"
  | some (.inductInfo i) =>
    let ctors := i.ctors.map fun k =>
      match env.find? k with
      | some c => s!"{k} : {c.type}"
      | none => s!"{k}"
    some s!"inductive {n} : {i.type} | {" | ".intercalate ctors}"
  | _ => none

def pairs : List (Name × Name) :=
  [(``QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound,
    ``QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound),
   (``QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass,
    ``QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass),
   (``QEDCore.PaperA.wilson_mass_bound, ``QEDCore.PaperA.Provider.wilson_mass_bound),
   (``QEDCore.PaperA.wilson_gauge_covariance, ``QEDCore.PaperA.Provider.wilson_gauge_covariance)]

def defs : List Name :=
  [``QEDCore.PaperA.Step, ``QEDCore.PaperA.diracOperator, ``QEDCore.PaperA.Step.generator,
   ``QEDCore.PaperA.Step.freeTime, ``QEDCore.PaperA.transferMatrix, ``QEDCore.PaperA.centeredTrace,
   ``QEDCore.PaperA.latticeShift, ``QEDCore.PaperA.wilsonHopping, ``QEDCore.PaperA.wilsonMass]

def isLib (m : String) : Bool :=
  m.startsWith "Mathlib" || m.startsWith "Init" || m.startsWith "Lean" ||
    m.startsWith "Std" || m.startsWith "Batteries"

partial def binders : Expr → List (Name × BinderInfo)
  | .forallE n _ b bi => (n, bi) :: binders b
  | _ => []

run_meta do
  let env ← getEnv
  -- P1
  for n in (pairs.map (·.1)) ++ defs do
    match abiStr env n with
    | some s => IO.FS.writeFile s!".lake/scratch/audit1/abi_{n}.txt" s
    | none => logError m!"no ABI for {n}"
  -- P2, P3, P4
  for (f, p) in pairs do
    let some (.thmInfo fi) := env.find? f | throwError "frozen {f} missing or not a theorem"
    let some (.thmInfo pi) := env.find? p | throwError "provider {p} missing or not a theorem"
    let fmod := (env.getModuleIdxFor? f).map fun i => env.header.moduleNames[i.toNat]!
    let pmod := (env.getModuleIdxFor? p).map fun i => env.header.moduleNames[i.toNat]!
    let bf := binders fi.type
    let bp := binders pi.type
    let nameDiffs := (bf.zip bp).filter (fun (x, y) => x.1 != y.1) |>.map fun (x, y) => (x.1, y.1)
    logInfo m!"[P2] {f} (module {fmod}) vs {p} (module {pmod}):\n  levelParams {fi.levelParams} / {pi.levelParams}; \
      Expr.eqv = {fi.type.eqv pi.type}; Expr.equal = {fi.type.equal pi.type}; \
      binder count {bf.length} / {bp.length}; binder infos equal: {bf.map (·.2) == bp.map (·.2)}\n  \
      binder-name differences: {nameDiffs}\n  frozen binder names: {bf.map (·.1)}"
    -- P3: project constants in the frozen type
    let consts := fi.type.getUsedConstants
    let mut proj : Array (Name × Name) := #[]
    for c in consts do
      let m := match env.getModuleIdxFor? c with
        | some i => env.header.moduleNames[i.toNat]!
        | none => `current
      unless isLib m.toString do proj := proj.push (c, m)
    logInfo m!"[P3] {f}: {consts.size} constants in the type; non-library: {proj}"
    -- P4: the proof term is `fun xs => provider xs` with exactly the binders, in order
    let ok ← lambdaTelescope fi.value fun xs body => do
      let fn := body.getAppFn
      let args := body.getAppArgs
      let lvlOk := fn.constLevels!.length == fi.levelParams.length &&
        (fn.constLevels!.zip fi.levelParams).all fun (l, n) => l == Level.param n
      logInfo m!"[P4] {f}: value is λ over {xs.size} binders; head constant {fn.constName?}; \
        {args.size} args; args == binders: {args == xs}; universe args are the anchor's own: {lvlOk}; \
        constants in value: {fi.value.getUsedConstants.filter fun c => !isLib ((env.getModuleIdxFor? c).map (fun i => (env.header.moduleNames[i.toNat]!).toString) |>.getD "cur")}"
      return fn.constName? == some p && args == xs && lvlOk
    logInfo m!"[P4] {f}: proof term is exactly the provider applied to the anchor's binders: {ok}"
  -- P5 (programmatic)
  for (f, p) in pairs do
    for n in [f, p] do
      let axs ← collectAxioms n
      logInfo m!"[P5] {n}: {axs}"

end Audit1

#print axioms QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound
#print axioms QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound
#print axioms QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass
#print axioms QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass
#print axioms QEDCore.PaperA.wilson_mass_bound
#print axioms QEDCore.PaperA.Provider.wilson_mass_bound
#print axioms QEDCore.PaperA.wilson_gauge_covariance
#print axioms QEDCore.PaperA.Provider.wilson_gauge_covariance

set_option pp.funBinderTypes true in
#print QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound
#print QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass
#print QEDCore.PaperA.wilson_mass_bound
#print QEDCore.PaperA.wilson_gauge_covariance
```

Output (exit 0). The per-binder name lists are condensed; the full `#print` statements are
reproduced in §1.4–§4.4.

```
[P2] …wilson_twisted_trace_pos_and_fourier_bound (module Frozen.PaperA.WilsonTwistedTraceBound) vs Provider… (module Core.PaperA.Provider.WilsonTwistedTraceBound):
  levelParams [] / []; Expr.eqv = true; Expr.equal = false; binder count 25 / 25; binder infos equal: true
  binder-name differences: [(inst._@.Frozen.PaperA.WilsonTwistedTraceBound.2907726669._hygCtx._hyg.5,
  inst._@.Core.PaperA.Provider.WilsonTwistedTraceBound.2907726669._hygCtx._hyg.5)]
  frozen binder names: [n, inst…, hn, α, β, hα_herm, hβ_herm, hα_sq, hβ_sq, hα_anti, hαβ_anti, a, m, r, ha, hm, hr, links, hlinks, b, hb, htime, ϑ, Q, hQ]
[P3] …wilson_twisted_trace_pos_and_fourier_bound: 126 constants in the type; non-library: [(QEDCore.PaperA.centeredTrace, Core.PaperA.Defs.CenteredTrace), (QEDCore.PaperA.Step, Core.PaperA.Defs.Step), (QEDCore.PaperA.Step.free, Core.PaperA.Defs.Step), (QEDCore.PaperA.wilsonHopping, Core.PaperA.Defs.WilsonHopping), (QEDCore.PaperA.wilsonMass, Core.PaperA.Defs.WilsonMass), (QEDCore.PaperA.Step.kick, Core.PaperA.Defs.Step)]
[P4] …wilson_twisted_trace_pos_and_fourier_bound: value is λ over 25 binders; head constant some (QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound); 25 args; args == binders: true; universe args are the anchor's own: true; constants in value: [QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound]
[P4] …: proof term is exactly the provider applied to the anchor's binders: true
[P2] …centeredTrace_nonneg_of_posSemidef_mass (module Frozen.PaperA.CenteredTraceNonneg) vs Provider… (module Core.PaperA.Provider.CenteredTraceNonneg):
  levelParams [u_1] / [u_1]; Expr.eqv = true; Expr.equal = false; binder count 17 / 17; binder infos equal: true
  binder-name differences: the two anonymous instance binders (hygienic names, Frozen vs Provider module)
  frozen binder names: [ι, inst…, inst…, α, β, hα_herm, hβ_herm, hα_sq, hβ_sq, hα_anti, hαβ_anti, b, hb, hist, hfree, hkick, htime]
[P3] …centeredTrace_nonneg_of_posSemidef_mass: 60 constants in the type; non-library: [(QEDCore.PaperA.Step, …Defs.Step), (QEDCore.PaperA.Step.free, …Defs.Step), (QEDCore.PaperA.Step.kick, …Defs.Step), (QEDCore.PaperA.Step.freeTime, …Defs.StepFreeTime), (QEDCore.PaperA.centeredTrace, …Defs.CenteredTrace)]
[P4] …centeredTrace_nonneg_of_posSemidef_mass: value is λ over 17 binders; head constant some (QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass); 17 args; args == binders: true; universe args are the anchor's own: true; constants in value: [Step, Step.free, Step.kick, Step.freeTime (binder types), QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass]
[P4] …: proof term is exactly the provider applied to the anchor's binders: true
[P2] …wilson_mass_bound vs Provider…: levelParams [] / []; Expr.eqv = true; Expr.equal = false; binder count 19 / 19; binder infos equal: true
  binder-name differences: the anonymous [NeZero n] binder only
[P3] …wilson_mass_bound: 80 constants in the type; non-library: [(QEDCore.PaperA.wilsonMass, …Defs.WilsonMass), (QEDCore.PaperA.diracOperator, …Defs.DiracOperator), (QEDCore.PaperA.wilsonHopping, …Defs.WilsonHopping)]
[P4] …wilson_mass_bound: value is λ over 19 binders; …; 19 args; args == binders: true; …; constants in value: [QEDCore.PaperA.Provider.wilson_mass_bound]
[P4] …: proof term is exactly the provider applied to the anchor's binders: true
[P2] …wilson_gauge_covariance vs Provider…: levelParams [] / []; Expr.eqv = true; Expr.equal = false; binder count 11 / 11; binder infos equal: true
  binder-name differences: the anonymous [NeZero n] binder only
[P3] …wilson_gauge_covariance: 65 constants in the type; non-library: [(QEDCore.PaperA.diracOperator, …), (QEDCore.PaperA.wilsonHopping, …), (QEDCore.PaperA.wilsonMass, …)]
[P4] …wilson_gauge_covariance: value is λ over 11 binders; …; 11 args; args == binders: true; …; constants in value: [QEDCore.PaperA.Provider.wilson_gauge_covariance]
[P4] …: proof term is exactly the provider applied to the anchor's binders: true
[P5] each of the 8 exports: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.wilson_mass_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.wilson_mass_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.wilson_gauge_covariance' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.wilson_gauge_covariance' depends on axioms: [propext, Classical.choice, Quot.sound]
```

`#print QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound`, the statement part:

```
∀ {n : ℕ} [inst : NeZero n], 3 ≤ n → ∀ (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ),
  (∀ (j : Fin 3), (α j).IsHermitian) → β.IsHermitian → (∀ (j : Fin 3), α j * α j = 1) → β * β = 1 →
  (∀ (j k : Fin 3), j ≠ k → α j * α k + α k * α j = 0) → (∀ (j : Fin 3), α j * β + β * α j = 0) →
  ∀ (a m r : ℝ), 0 < a → 0 < m → 0 ≤ r →
  ∀ (links : List (ℝ × ((Fin 3 → ZMod n) → Fin 3 → ℂ))),
    (∀ p ∈ links, 0 ≤ p.1 ∧ ∀ (x : Fin 3 → ZMod n) (j : Fin 3), ‖p.2 x j‖ = 1) →
  ∀ (b : ℝ), 0 < b → (List.map Prod.fst links).sum = b →
  ∀ (ϑ : (Fin 3 → ZMod n) → ℝ) (Q : ℤ), |Q| ≤ 2 * ↑n ^ 3 →
    have F := fun (φ : ℝ) => QEDCore.PaperA.centeredTrace α β
      (List.map (fun p => QEDCore.PaperA.Step.free p.1 (QEDCore.PaperA.wilsonHopping n a p.2)
          (QEDCore.PaperA.wilsonMass n a m r p.2)) links ++
        [QEDCore.PaperA.Step.kick (Matrix.diagonal fun (x : Fin 3 → ZMod n) => ↑(ϑ x + φ))]);
    have Fhat := fun (p : ℤ) => (2 * ↑Real.pi)⁻¹ *
      ∫ (φ : ℝ) in 0..2 * Real.pi, Complex.exp (-(↑p * ↑φ * Complex.I)) * F φ;
    (∀ (φ : ℝ), 0 < (F φ).re ∧ (F φ).im = 0) ∧ (Fhat 0).im = 0 ∧
      ‖Fhat Q‖ ≤ ↑((4 * n ^ 3).choose (2 * n ^ 3 + Q.natAbs)) * Real.exp (-(b * m * |↑Q|)) * (Fhat 0).re
```

The four `#print` values are:

```
fun {n} [NeZero n] hn α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti a m r ha hm hr links hlinks b hb htime ϑ Q hQ =>
  QEDCore.PaperA.Provider.wilson_twisted_trace_pos_and_fourier_bound hn α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti
    a m r ha hm hr links hlinks b hb htime ϑ Q hQ
fun {ι} [Fintype ι] [DecidableEq ι] α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti b hb hist hfree hkick htime =>
  QEDCore.PaperA.Provider.centeredTrace_nonneg_of_posSemidef_mass α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti b hb
    hist hfree hkick htime
fun {n} [NeZero n] hn α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti a m r ha hm hr U hU =>
  QEDCore.PaperA.Provider.wilson_mass_bound hn α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti a m r ha hm hr U hU
fun {n} [NeZero n] hn α β a m r U u hu => QEDCore.PaperA.Provider.wilson_gauge_covariance hn α β a m r U u hu
```

### A.2 Probe 2 (exact-type reconstructions R1–R4, T3 semantics S1)

```lean
import Frozen.PaperA.WilsonTwistedTraceBound
import Frozen.PaperA.CenteredTraceNonneg
import Frozen.PaperA.WilsonMassBound
import Frozen.PaperA.WilsonGaugeCovariance
import Lean

open Lean Elab Command Meta

universe u

namespace Audit1b

open Matrix
open scoped Kronecker ComplexOrder

/-- R1. T3, comparison.tex L54-L91 (fermionic factor of (4.5) at L61, positivity L70-L72,
Lemma 3.2 with D = 4N, d = 2N, m_* = m at L82-L89), model.tex L4, L27-L35, L39, under
R5 (step link histories), R6 (relative twist in ℝ^X, R3 form), R8 (centered trace = integrand). -/
theorem reconT3 :
    ∀ {L : ℕ} [NeZero L], 3 ≤ L →
    ∀ (al : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (be : Matrix (Fin 4) (Fin 4) ℂ),
      (∀ j, (al j).IsHermitian) → be.IsHermitian →
      (∀ j, al j * al j = 1) → be * be = 1 →
      (∀ j k, j ≠ k → al j * al k + al k * al j = 0) →
      (∀ j, al j * be + be * al j = 0) →
    ∀ (sp ms rw : ℝ), 0 < sp → 0 < ms → 0 ≤ rw →
    ∀ (path : List (ℝ × ((Fin 3 → ZMod L) → Fin 3 → ℂ))),
      (∀ p ∈ path, 0 ≤ p.1 ∧ ∀ x j, ‖p.2 x j‖ = 1) →
    ∀ (t : ℝ), 0 < t → (path.map Prod.fst).sum = t →
    ∀ (rel : (Fin 3 → ZMod L) → ℝ) (k : ℤ), |k| ≤ 2 * (L : ℤ) ^ 3 →
      let G : ℝ → ℂ := fun ph => QEDCore.PaperA.centeredTrace al be
        (path.map (fun p => QEDCore.PaperA.Step.free p.1 (QEDCore.PaperA.wilsonHopping L sp p.2)
            (QEDCore.PaperA.wilsonMass L sp ms rw p.2)) ++
          [QEDCore.PaperA.Step.kick (Matrix.diagonal fun x => Complex.ofReal (rel x + ph))])
      let Gc : ℤ → ℂ := fun p =>
        (2 * (Real.pi : ℂ))⁻¹ *
          ∫ ph in (0 : ℝ)..2 * Real.pi, Complex.exp (-((p : ℂ) * (ph : ℂ) * Complex.I)) * G ph
      (∀ ph : ℝ, 0 < (G ph).re ∧ (G ph).im = 0) ∧ (Gc 0).im = 0 ∧
        ‖Gc k‖ ≤ ((Nat.choose (4 * L ^ 3) (2 * L ^ 3 + Int.natAbs k) : ℕ) : ℝ) *
          Real.exp (-(t * ms * |(k : ℝ)|)) * (Gc 0).re :=
  @QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound

/-- R2. T4, transfer.tex L89-L91 in Lemma 3.1's setting (L9-L26) under R1(a), R2, R4, R7. -/
theorem reconT4 :
    ∀ {S : Type u} [Fintype S] [DecidableEq S]
      (al : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (be : Matrix (Fin 4) (Fin 4) ℂ),
      (∀ j, (al j).IsHermitian) → be.IsHermitian →
      (∀ j, al j * al j = 1) → be * be = 1 →
      (∀ j k, j ≠ k → al j * al k + al k * al j = 0) →
      (∀ j, al j * be + be * al j = 0) →
    ∀ (t : ℝ), 0 < t → ∀ (H : List (QEDCore.PaperA.Step S)),
      (∀ τ v M, QEDCore.PaperA.Step.free τ v M ∈ H →
        0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M : Matrix S S ℂ).PosSemidef) →
      (∀ Θ, QEDCore.PaperA.Step.kick Θ ∈ H → Θ.IsHermitian) →
      (H.map QEDCore.PaperA.Step.freeTime).sum = t →
      (QEDCore.PaperA.centeredTrace al be H).im = 0 ∧ 0 ≤ (QEDCore.PaperA.centeredTrace al be H).re :=
  @QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass

/-- R3. T5, model.tex (2.5) L39-L46 with (2.3) L30-L35, X = (ℤ/nℤ)³ (L4), Clifford (L27-L28). -/
theorem reconT5 :
    ∀ {L : ℕ} [NeZero L], 3 ≤ L →
    ∀ (al : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (be : Matrix (Fin 4) (Fin 4) ℂ),
      (∀ j, (al j).IsHermitian) → be.IsHermitian →
      (∀ j, al j * al j = 1) → be * be = 1 →
      (∀ j k, j ≠ k → al j * al k + al k * al j = 0) →
      (∀ j, al j * be + be * al j = 0) →
    ∀ (sp ms rw : ℝ), 0 < sp → 0 ≤ ms → 0 ≤ rw →
    ∀ (V : (Fin 3 → ZMod L) → Fin 3 → ℂ), (∀ x j, ‖V x j‖ = 1) →
      (QEDCore.PaperA.wilsonMass L sp ms rw V -
          (ms : ℂ) • (1 : Matrix (Fin 3 → ZMod L) (Fin 3 → ZMod L) ℂ)).PosSemidef ∧
      (Complex.ofReal (ms + (3 + 6 * rw) / sp) • (1 : Matrix ((Fin 3 → ZMod L) × Fin 4) ((Fin 3 → ZMod L) × Fin 4) ℂ) -
          QEDCore.PaperA.diracOperator al be (QEDCore.PaperA.wilsonHopping L sp V)
            (QEDCore.PaperA.wilsonMass L sp ms rw V)).PosSemidef ∧
      (Complex.ofReal (ms + (3 + 6 * rw) / sp) • (1 : Matrix ((Fin 3 → ZMod L) × Fin 4) ((Fin 3 → ZMod L) × Fin 4) ℂ) +
          QEDCore.PaperA.diracOperator al be (QEDCore.PaperA.wilsonHopping L sp V)
            (QEDCore.PaperA.wilsonMass L sp ms rw V)).PosSemidef :=
  @QEDCore.PaperA.wilson_mass_bound

/-- R4. T6, model.tex L64-L71: `U^u_{xj} = u_x U_{xj} conj(u_{x+e_j})`, `h_W(U^u) = u^* h_W(U) u`. -/
theorem reconT6 :
    ∀ {L : ℕ} [NeZero L], 3 ≤ L →
    ∀ (al : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (be : Matrix (Fin 4) (Fin 4) ℂ) (sp ms rw : ℝ)
      (V : (Fin 3 → ZMod L) → Fin 3 → ℂ) (g : (Fin 3 → ZMod L) → ℂ), (∀ x, ‖g x‖ = 1) →
      QEDCore.PaperA.diracOperator al be
          (QEDCore.PaperA.wilsonHopping L sp fun x j => g x * V x j * star (g (x + Pi.single j 1)))
          (QEDCore.PaperA.wilsonMass L sp ms rw fun x j => g x * V x j * star (g (x + Pi.single j 1))) =
        ((Matrix.diagonal g)ᴴ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) *
          QEDCore.PaperA.diracOperator al be (QEDCore.PaperA.wilsonHopping L sp V)
            (QEDCore.PaperA.wilsonMass L sp ms rw V) *
          (Matrix.diagonal g ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) :=
  @QEDCore.PaperA.wilson_gauge_covariance

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

partial def binders : Expr → List BinderInfo
  | .forallE _ _ b bi => bi :: binders b
  | _ => []

run_meta do
  let env ← getEnv
  for (r, f) in [(``reconT3, ``QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound),
      (``reconT4, ``QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass),
      (``reconT5, ``QEDCore.PaperA.wilson_mass_bound),
      (``reconT6, ``QEDCore.PaperA.wilson_gauge_covariance)] do
    let some ri := env.find? r | throwError "no {r}"
    let some fi := env.find? f | throwError "no {f}"
    let ft := fi.type.instantiateLevelParams fi.levelParams (ri.levelParams.map Level.param)
    logInfo m!"{r} vs {f}: Expr.eqv = {ri.type.eqv ft}; binder infos equal = \
      {binders ri.type == binders ft} ({(binders ft).length} binders)"
    match firstDiff ri.type ft [] with
    | none => pure ()
    | some (p, a, b) => logInfo m!"  first difference at {p.reverse}:\n  recon: {a}\n  frozen: {b}"

/-- S1. Semantics of T3's `F` and `Fhat`: `F` is continuous (so every `Fhat p` is a genuine
interval integral, not Bochner's junk value), and `Re Fhat 0 > 0` for every instance of the
hypotheses (so the bound of conjunct 3 is never the degenerate `0 ≤ 0`). -/
theorem t3_semantics {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian)
    (hα_sq : ∀ j, α j * α j = 1) (hβ_sq : β * β = 1)
    (hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (a m r : ℝ) (ha : 0 < a) (hm : 0 < m) (hr : 0 ≤ r)
    (links : List (ℝ × ((Fin 3 → ZMod n) → Fin 3 → ℂ)))
    (hlinks : ∀ p ∈ links, 0 ≤ p.1 ∧ ∀ x j, ‖p.2 x j‖ = 1)
    (b : ℝ) (hb : 0 < b) (htime : (links.map Prod.fst).sum = b)
    (ϑ : (Fin 3 → ZMod n) → ℝ) :
    let F : ℝ → ℂ := fun φ => QEDCore.PaperA.centeredTrace α β
      (links.map (fun p => QEDCore.PaperA.Step.free p.1 (QEDCore.PaperA.wilsonHopping n a p.2)
          (QEDCore.PaperA.wilsonMass n a m r p.2)) ++
        [QEDCore.PaperA.Step.kick (Matrix.diagonal fun x => ((ϑ x + φ : ℝ) : ℂ))])
    let Fhat : ℤ → ℂ := fun p =>
      (2 * Real.pi : ℂ)⁻¹ *
        ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(p * φ * Complex.I)) * F φ
    Continuous F ∧ 0 < (Fhat 0).re := by
  intro F Fhat
  have H := QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound hn α β hα_herm hβ_herm
    hα_sq hβ_sq hα_anti hαβ_anti a m r ha hm hr links hlinks b hb htime ϑ 0
    (by rw [abs_zero]; positivity)
  obtain ⟨hpos, -, -⟩ := H
  have hre : ∀ φ, 0 < (F φ).re ∧ (F φ).im = 0 := hpos
  have hd := QEDCore.PaperA.four_mul_card_fin_three_zmod n
  have hF : F = _ := QEDCore.PaperA.centeredTrace_free_append_diagonal_add_eq α β links
    (QEDCore.PaperA.wilsonHopping n a) (QEDCore.PaperA.wilsonMass n a m r) ϑ
  have hcont : Continuous F := by
    rw [hF]
    simp_rw [QEDCore.PaperA.centeredTrace_append_twist α β _ hd]
    fun_prop
  refine ⟨hcont, ?_⟩
  have hreal : (fun φ : ℝ => Complex.exp (-(((0 : ℤ) : ℂ) * φ * Complex.I)) * F φ) =
      fun φ : ℝ => (((F φ).re : ℝ) : ℂ) := by
    funext φ
    simp only [Int.cast_zero, zero_mul, neg_zero, Complex.exp_zero, one_mul]
    exact Complex.ext (by simp) (by simp [(hre φ).2])
  have h0 : Fhat 0 = (2 * Real.pi : ℂ)⁻¹ * (((∫ φ in (0 : ℝ)..2 * Real.pi, (F φ).re) : ℝ) : ℂ) := by
    show (2 * Real.pi : ℂ)⁻¹ *
      ∫ φ in (0 : ℝ)..2 * Real.pi, Complex.exp (-(((0 : ℤ) : ℂ) * φ * Complex.I)) * F φ = _
    rw [hreal, intervalIntegral.integral_ofReal]
  have hI : 0 < ∫ φ in (0 : ℝ)..2 * Real.pi, (F φ).re :=
    intervalIntegral.intervalIntegral_pos_of_pos_on
      ((Complex.continuous_re.comp hcont).intervalIntegrable _ _) (fun x _ => (hre x).1)
      (by positivity)
  have hc : ((2 * Real.pi : ℂ))⁻¹ = (((2 * Real.pi)⁻¹ : ℝ) : ℂ) := by push_cast; ring
  rw [h0, hc, ← Complex.ofReal_mul, Complex.ofReal_re]
  positivity

end Audit1b

#print axioms Audit1b.reconT3
#print axioms Audit1b.reconT4
#print axioms Audit1b.reconT5
#print axioms Audit1b.reconT6
#print axioms Audit1b.t3_semantics
```

Output (exit 0):

```
Audit1b.reconT3 vs QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound: Expr.eqv = true; binder infos equal = true (25 binders)
Audit1b.reconT4 vs QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass: Expr.eqv = true; binder infos equal = true (17 binders)
Audit1b.reconT5 vs QEDCore.PaperA.wilson_mass_bound: Expr.eqv = true; binder infos equal = true (19 binders)
Audit1b.reconT6 vs QEDCore.PaperA.wilson_gauge_covariance: Expr.eqv = true; binder infos equal = true (11 binders)
'Audit1b.reconT3' depends on axioms: [propext, Classical.choice, Quot.sound]
'Audit1b.reconT4' depends on axioms: [propext, Classical.choice, Quot.sound]
'Audit1b.reconT5' depends on axioms: [propext, Classical.choice, Quot.sound]
'Audit1b.reconT6' depends on axioms: [propext, Classical.choice, Quot.sound]
'Audit1b.t3_semantics' depends on axioms: [propext, Classical.choice, Quot.sound]
```

### A.3 Probe 3 (transitive definition closure of each statement)

```lean
import Frozen.PaperA.WilsonTwistedTraceBound
import Frozen.PaperA.CenteredTraceNonneg
import Frozen.PaperA.WilsonMassBound
import Frozen.PaperA.WilsonGaugeCovariance
import Lean

open Lean Elab Command Meta

def isLibMod (m : String) : Bool :=
  m.startsWith "Mathlib" || m.startsWith "Init" || m.startsWith "Lean" ||
    m.startsWith "Std" || m.startsWith "Batteries"

run_meta do
  let env ← getEnv
  let modOf (c : Name) : Name := match env.getModuleIdxFor? c with
    | some i => env.header.moduleNames[i.toNat]!
    | none => `current
  for f in [``QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound,
      ``QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass,
      ``QEDCore.PaperA.wilson_mass_bound, ``QEDCore.PaperA.wilson_gauge_covariance] do
    let some fi := env.find? f | throwError "no {f}"
    let mut todo : Array Name := fi.type.getUsedConstants.filter fun c => !isLibMod (modOf c).toString
    let mut seen : Std.HashSet Name := {}
    while !todo.isEmpty do
      let c := todo.back!
      todo := todo.pop
      if seen.contains c then continue
      seen := seen.insert c
      let more : Array Name := match env.find? c with
        | some (.defnInfo d) => d.type.getUsedConstants ++ d.value.getUsedConstants
        | some (.inductInfo i) => i.type.getUsedConstants ++ i.ctors.toArray
        | some (.ctorInfo k) => k.type.getUsedConstants ++ #[k.induct]
        | some ci => ci.type.getUsedConstants
        | none => #[]
      for d in more do
        if !isLibMod (modOf d).toString && !seen.contains d then todo := todo.push d
    let mods := (seen.toList.map modOf).eraseDups
    logInfo m!"[C1] {f}: {seen.size} project constants in the closure of the type; modules: {mods}\n  constants: {seen.toList}"
```

Output (exit 0), condensed to the module sets:

```
[C1] …wilson_twisted_trace_pos_and_fourier_bound: 17 project constants; modules: [Defs.WilsonMass, Defs.StepGenerator, Defs.Step, Defs.LatticeShift, Defs.WilsonHopping, Defs.TransferMatrix, Defs.CenteredTrace, Defs.DiracOperator]
[C1] …centeredTrace_nonneg_of_posSemidef_mass: 14 project constants; modules: [Defs.StepGenerator, Defs.Step, Defs.StepFreeTime, Defs.TransferMatrix, Defs.DiracOperator, Defs.CenteredTrace]
[C1] …wilson_mass_bound: 6 project constants; modules: [Defs.WilsonHopping, Defs.WilsonMass, Defs.DiracOperator, Defs.LatticeShift]
[C1] …wilson_gauge_covariance: 6 project constants; modules: [Defs.WilsonHopping, Defs.WilsonMass, Defs.DiracOperator, Defs.LatticeShift]
```

The 17 constants for T3 are `wilsonMass`, `Step.generator`, `Step`, `Step.rec`,
`latticeShift`, `wilsonHopping._proof_1`, `Step.casesOn`, `Step.generator.match_1`,
`transferMatrix._proof_1`, `wilsonHopping`, `centeredTrace._proof_1`, `transferMatrix`,
`diracOperator`, `Step.kick`, `Step.free`, `wilsonMass._proof_1` and `centeredTrace`. Each
module set equals the manifest's `definition_closure` for that anchor.

### A.4 Probe 4 (non-vacuity)

```lean
import Frozen.PaperA.WilsonTwistedTraceBound
import Frozen.PaperA.CenteredTraceNonneg
import Frozen.PaperA.WilsonMassBound
import Frozen.PaperA.WilsonGaugeCovariance

namespace Audit1d

open Matrix
open scoped Kronecker ComplexOrder

/-- Standard Dirac representation: `α_j = [[0, σ_j], [σ_j, 0]]`, `β = diag(1, 1, -1, -1)`. -/
def α1 : Matrix (Fin 4) (Fin 4) ℂ := !![0, 0, 0, 1; 0, 0, 1, 0; 0, 1, 0, 0; 1, 0, 0, 0]
def α2 : Matrix (Fin 4) (Fin 4) ℂ :=
  !![0, 0, 0, -Complex.I; 0, 0, Complex.I, 0; 0, -Complex.I, 0, 0; Complex.I, 0, 0, 0]
def α3 : Matrix (Fin 4) (Fin 4) ℂ := !![0, 0, 1, 0; 0, 0, 0, -1; 1, 0, 0, 0; 0, -1, 0, 0]
def αD : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ := ![α1, α2, α3]
def βD : Matrix (Fin 4) (Fin 4) ℂ := !![1, 0, 0, 0; 0, 1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1]

theorem αD_herm : ∀ j, (αD j).IsHermitian := by
  intro j
  fin_cases j <;>
  · ext a b
    fin_cases a <;> fin_cases b <;>
      simp [αD, α1, α2, α3, Matrix.conjTranspose_apply]

theorem βD_herm : βD.IsHermitian := by
  ext a b
  fin_cases a <;> fin_cases b <;> simp [βD, Matrix.conjTranspose_apply]

theorem αD_sq : ∀ j, αD j * αD j = 1 := by
  intro j
  fin_cases j <;>
  · ext a b
    fin_cases a <;> fin_cases b <;>
      simp [αD, α1, α2, α3, Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply]

theorem βD_sq : βD * βD = 1 := by
  ext a b
  fin_cases a <;> fin_cases b <;>
    simp [βD, Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply]

theorem αD_anti : ∀ j k, j ≠ k → αD j * αD k + αD k * αD j = 0 := by
  intro j k hjk
  fin_cases j <;> fin_cases k <;> simp at hjk <;>
  · ext a b
    fin_cases a <;> fin_cases b <;>
      simp [αD, α1, α2, α3, Matrix.mul_apply, Fin.sum_univ_four]

theorem αβD_anti : ∀ j, αD j * βD + βD * αD j = 0 := by
  intro j
  fin_cases j <;>
  · ext a b
    fin_cases a <;> fin_cases b <;>
      simp [αD, α1, α2, α3, βD, Matrix.mul_apply, Fin.sum_univ_four]

-- T3 at n = 3, a = m = 1, r = 0, one free step of length 1 with unit links, b = 1, ϑ = 0.
example : True := by
  have := QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound (n := 3) (by norm_num)
    αD βD αD_herm βD_herm αD_sq βD_sq αD_anti αβD_anti 1 1 0 one_pos one_pos le_rfl
    [((1 : ℝ), fun _ _ => (1 : ℂ))] (by simp) 1 one_pos (by simp) (fun _ => 0) 54 (by norm_num)
  trivial

-- T4 at ι = Fin 1: one free step with v = 0, M = 0 (PSD, not PD), then the kick Θ = 0.
example : True := by
  have := QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass (ι := Fin 1)
    αD βD αD_herm βD_herm αD_sq βD_sq αD_anti αβD_anti 1 one_pos
    [QEDCore.PaperA.Step.free 1 (fun _ => 0) 0, QEDCore.PaperA.Step.kick 0]
    (by
      intro τ v M h
      simp only [List.mem_cons, QEDCore.PaperA.Step.free.injEq, List.not_mem_nil, or_false,
        reduceCtorEq] at h
      obtain ⟨rfl, rfl, rfl⟩ := h
      exact ⟨zero_le_one, fun _ => Matrix.isHermitian_zero, Matrix.PosSemidef.zero⟩)
    (by
      intro Θ h
      simp only [List.mem_cons, QEDCore.PaperA.Step.kick.injEq, List.not_mem_nil, or_false,
        reduceCtorEq, false_or] at h
      subst h
      exact Matrix.isHermitian_zero)
    (by simp [QEDCore.PaperA.Step.freeTime])
  trivial

-- T5 at n = 3, unit links, a = 1, m = r = 0.
example : True := by
  have := QEDCore.PaperA.wilson_mass_bound (n := 3) (by norm_num) αD βD αD_herm βD_herm αD_sq
    βD_sq αD_anti αβD_anti 1 0 0 one_pos le_rfl le_rfl (fun _ _ => 1) (by simp)
  trivial

-- T6 at n = 3, u ≡ I.
example : True := by
  have := QEDCore.PaperA.wilson_gauge_covariance (n := 3) (by norm_num) αD βD 1 1 1
    (fun _ _ => 1) (fun _ => Complex.I) (by simp)
  trivial

end Audit1d
```

Output (exit 0): six `linter.unusedSimpArgs` warnings (unused `Matrix.one_apply`,
`Matrix.mul_apply` and `Fin.sum_univ_four` in some `simp` calls), and no error or `sorry`.

## Appendix B. Transient files (all deleted after the run)

- `lean/.lake/scratch/audit1/`: `Probe1.lean`–`Probe4.lean`, `probe1_out.txt`–`probe4_out.txt`,
  the thirteen `abi_<name>.txt` strings, and thirteen `lc_<Module>.txt` leanchecker logs (all
  empty).
- Session scratchpad, outside the repository: `hashes.py` (prefix, suffix, statement-span,
  closure, source, draft and definition hashes) and `seal_body.py` (explicit binders and body
  arguments, and the checker's `binder_names` set via `importlib` of the repository checker).
