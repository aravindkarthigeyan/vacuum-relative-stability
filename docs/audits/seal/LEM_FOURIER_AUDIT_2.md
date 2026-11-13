# Seal audit 2 of `lem_fourier_v1` (Paper A, Lemma 3.2)

- **Target:** `QEDCore.PaperA.canonical_fourier_bound`,
  `lean/Frozen/PaperA/CanonicalFourierBound.lean` (manifest `lem_fourier_v1`, `SEALED`),
  Paper A Lemma 3.2 (`paper-a/transfer.tex` L93-L130) for piecewise-constant histories
  (ruling R1(a), with R2-R4; `docs/DECISIONS.md` D11).
- **Provider:** `QEDCore.PaperA.Provider.canonical_fourier_bound`,
  `lean/Core/PaperA/Provider/CanonicalFourierBound.lean`.
- **Auditor:** independent, refute-first; did not write any of the audited code. Dates
  2026-11-12/13 (the session was interrupted once and resumed on an unchanged tree).
- **Emphasis:** proof consumption, premise discharge, axioms and kernel check, non-vacuity.
  Statement fidelity to the source was audited before the freeze (`docs/audits/pilot/`); it is
  re-checked here only where a cast, coercion or helper could change what is proved.
- **Toolchain:** Lean v4.35.0, Mathlib v4.35.0. Every Lean/Lake command ran from `lean/` through
  `bash ../scripts/lean-gate.sh`. Scratch files: `lean/.lake/scratch/audit4/`
  (`Audit.lean`, `Nontriv.lean`, `numeric.py` and their logs).

## 0. Audited state

`HEAD = 422b189` ("Seal Lemma 3.2 (lem_fourier_v1); Lemma 3.1 audited"), unchanged throughout.
The tree was clean at the start; near the end another session left uncommitted edits to
`docs/DECISIONS.md`, `lean/status.json`, `scripts/check_frozen_anchors.py` (binder-name
scanner) and added `docs/audits/seal/LEM_FOURIER_AUDIT_1.md`. No Lean source changed. The anchor
guard passes with both the `HEAD` copy of the checker (run from scratch,
`lean/.lake/scratch/audit4/check_frozen_anchors_HEAD.py`) and the edited working-tree copy.
SHA-256 of the audited files (all equal to their `HEAD` blobs):

| File | SHA-256 |
|---|---|
| `lean/Frozen/PaperA/CanonicalFourierBound.lean` | `1eed1f5f5788f835f4ee528373c8db0a0e2cc73534f395d68682b4b774a4c2d6` |
| `lean/Core/PaperA/Provider/CanonicalFourierBound.lean` | `3124039a07e30881e6336bef434db9f49d5e80fe7302fe66ef053fe43c1963ed` |
| `lean/Core/PaperA/Fourier/Bound.lean` | `68ff9f08cb8c10afc22f4a98eb0cc4630a0b56387a8032ca97af111d60f68dbd` |
| `lean/Core/PaperA/Fourier/Factorization.lean` | `2d00c0fc9aa4dce11884d6c8ac3be2442a61a669ecac4beaacc6484bc628d83e` |
| `lean/Core/PaperA/Fourier/FourierCoeff.lean` | `294751a14f68b6bce81d4d2e1263c83f432f59a59806b19e0d684286973a565e` |
| `lean/Core/PaperA/Fourier/TwistKick.lean` | `3f8d9e53f90c431dc7dec08454a3600e1e63a87f667c332fd04d4112954a69f5` |
| `lean/Core/PaperA/Fourier/DetProd.lean` | `e8555ce58f72747abcdc54997649c07a8b484cfb97f4f0ceea30ab3ca61f1446` |
| `lean/Core/Coefficients.lean` | `dee5573e50f612aebedab8fd0207ccb556156a6fb92f0bc056e606c0bb004f18` |
| `lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean` | `c7506f3dc611189a9dc7620909fe35adb6cc07faf6096ff2d2bf46cbcfac976e` |

The Lemma 3.1 closure used here (`Core/PaperA/Provider/PositivityAndTransferAnnulus.lean`, all
ten `Core/PaperA/Transfer/*.lean`, `Core/PseudoUnitary.lean`, and `Fourier/DetProd.lean`) is
byte-identical to the hashes recorded in `docs/audits/seal/LEM_TRANSFER_AUDIT_2.md`, so that
audit's findings carry over unchanged. `python -I scripts/check_frozen_anchors.py --root lean
--manifest lean/frozen-manifest.json --allow-non-module`: `FROZEN-ANCHOR GUARD OK`, exit 0.
`lake build Frozen.PaperA.CanonicalFourierBound`: see section 6.

## 1. Proof consumption

- The anchor's proof region is exactly
  `by exact QEDCore.PaperA.Provider.canonical_fourier_bound α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti d hd mStar b hm hb hist hfree hkick htime q hq`
  (2 lines, 169 bytes; manifest seal limits 3 lines / 240 bytes).
- `#print QEDCore.PaperA.canonical_fourier_bound` (scratch `Audit.lean`, exit 0) shows the term
  `fun {ι} [Fintype ι] [DecidableEq ι] α β hα_herm … htime q hq => Provider.canonical_fourier_bound α β hα_herm … htime q hq`:
  every binder is passed once, in order. The constants of the proof term
  (`getUsedConstants` of the stored value) are the binder types plus exactly one theorem,
  `QEDCore.PaperA.Provider.canonical_fourier_bound`.
- The provider's statement text is byte-identical to the anchor's (1099 characters each,
  compared from `theorem` to `(Fhat 0).re`), and the elaborated types are equal as
  `Expr`s (`a.type == b.type` is `true` in a `run_cmd`; both have level parameters `[u_1]`),
  so no name in the statement is shadowed by the `Provider` namespace and no coercion differs.
- The elaborated ABI of every manifest anchor, as written by the axiom audit to
  `lean/.lake/axiom-audit.json`, hashes to its manifest `abi_sha256` (8/8 match, including
  `lem_fourier_v1` and `lem_transfer_v1`).
- Casts in the frozen statement, printed with `pp.coercions false`: the Fourier phase is
  `Complex.exp (-(p.cast * Complex.ofReal φ * Complex.I))` with `p.cast = @Int.cast ℂ _ p`
  (directly ℤ → ℂ, not through ℝ or ℕ); the prefactor is `(2 * Complex.ofReal Real.pi)⁻¹`; the
  integral is the interval integral over `0..2 * Real.pi` for Lebesgue measure; the twist is
  `Step.kick (Complex.ofReal φ • 1)`; the bound is
  `((2 * d).choose (d + q.natAbs)).cast * Real.exp (-(b * mStar * |q.cast|)) * (Fhat 0).re` with
  `q.cast : ℝ`; `hq` is `|q| ≤ d.cast` in ℤ. These are the readings of transfer.tex L95-L103
  under R3 (`Im F_0 = 0` and `Re F_0` on the right).
- Twist reading (cross-checked numerically in section 7): the kick generator `-(i (φ 1 ⊗ 1₄))`
  contributes `½ tr = -i d φ` to the centering (`4|ι| = 2d`), and the transfer matrix becomes
  `e^{iφ} U`, so `F(φ) = e^{-idφ} e^{½ Σ tr A} det(1 + e^{iφ} U)`, the centered trace of the
  history twisted by `e^{iφ(dΓ(I) - d)}`.

**CONSUMPTION: PASS.**

## 2. Premise discharge

Provider route (`Core/PaperA/Provider/CanonicalFourierBound.lean`, 18 proof lines). The table
lists every project helper the provider applies, its premises, and where each premise is
discharged. Mathlib lemmas are named where they carry a premise.

| Helper (module) | Premises | Discharged at the use |
|---|---|---|
| `positivity_and_transfer_annulus` (frozen Lemma 3.1, `Frozen.PaperA.PositivityAndTransferAnnulus`; SEALED, AUDITED) | the 17 anchor hypotheses `hα_herm … htime` | the provider's own binders, verbatim and in order; conjuncts 1-3 are used (`⟨⟨hre, him⟩, hcard, hpair, -⟩`), conjunct 4 (outer annulus) is discarded |
| `exists_fin_enum_of_card S (h : card S = n)` (Fourier.Bound, via `exists_fin_enum`, Factorization) | `card S = d` for `S = roots.filter (‖·‖ ≤ e^{-b m_*})` | `hcard` (conjunct 2). Gives `lam : Fin d → ℂ` with `univ.val.map lam = S` as a multiset equality, so multiplicities are kept |
| `Multiset.filter_add_not` (Mathlib) | none | with `hlam` and `← hpair` (conjunct 3) yields `hroots : roots = map lam + (map lam).map (fun z => (star z)⁻¹)`, the full paired root multiset |
| `isUnit_transferMatrix hist` (Transfer.History) | none (product of matrix exponentials, induction on the history) | `.exists_right_inv` gives `V` with `U * V = 1` |
| `zero_not_mem_charpoly_roots (hUV : U * V = 1)` (Transfer.SpectralPairing) | a right inverse | `hUV` above; with `Multiset.mem_of_mem_filter (hmem j)` gives `hlam0 : ∀ j, lam j ≠ 0` |
| `Multiset.mem_filter` (Mathlib) | membership | `hmem j` (from `hlam` and `Multiset.mem_map_of_mem`) gives `hlamr : ∀ j, ‖lam j‖ ≤ e^{-(b m_*)}` |
| `centeredTrace_append_twist_zero α β hist hd` (Fourier.Bound) | `hd` | anchor `hd`; gives `F 0 = centeredTrace α β hist` |
| `centeredTrace_append_twist_eq_mul_normSq α β hist hd lam hlam0 hroots` (Fourier.Bound) | `hd`, `hlam0`, `hroots` | all three established above; result is `∀ φ, F φ = C · (P φ · conj (P φ))` with `C = e^{½ Σ tr A} (∏ conj λ_j)⁻¹`, `P = trigPoly d (elementary lam)` |
| ↳ `centeredTrace_append_twist` (TwistKick) | `hd` | passed through; the kick trace is computed from `Step.generator` and `hd` (`4|ι| = 2d`) |
| ↳ `det_one_add_exp_smul_of_paired lam hlam0 hroots φ` (Factorization) | `hlam0`, `hroots` | passed through |
| ↳↳ `det_one_add_smul_eq_prod_roots U z` (DetProd) | none (any complex square matrix; splitting by `IsAlgClosed.splits`, `Matrix.reverse_charpoly`) | — ; this is the "determinant eigenvalues only, also for defective matrices" step |
| ↳↳ `one_add_mul_inv_star_eq (hz : z * star z = 1) (hw : w ≠ 0)` (Factorization) | `|z| = 1`, `λ ≠ 0` | `hz := exp_mul_star_exp φ` (proved, `z = e^{iφ}`), `hw := hlam0 j` |
| ↳↳ `prod_one_add_mul_eq_trigPoly` (Factorization) | none | `Finset.prod_one_add`, `Finset.sum_powerset`; `e^{ikφ} = z^k` by `Complex.exp_nat_mul` |
| `fourier_bound_of_factorization lam ht hlam F hF hF0 hF0im Fhat hFhat q` (Fourier.Bound), `t = b · m_*` | `0 ≤ t`; `∀ j, ‖lam j‖ ≤ e^{-t}`; `hF`; `0 < (F 0).re`; `(F 0).im = 0`; `hFhat` | `ht := (mul_pos hb hm).le`; `hlam := hlamr` (the filter bound, `e^{-(b * mStar)}`, syntactically `e^{-t}`); `hF := centeredTrace_append_twist_eq_mul_normSq …`; `hF0`, `hF0im := hre`, `him` of Lemma 3.1 rewritten along `F 0 = centeredTrace hist`; `hFhat := fun _ => rfl` (the frozen `let Fhat` itself); `q` the anchor's `q` |
| ↳ `exists_pos_eq_ofReal_of_mul_mul_star (hF 0) hF0 hF0im` (Bound) | `F 0 = C (w conj w)`, `0 < Re F 0`, `Im F 0 = 0` | from the arguments; gives a real `c > 0` with `C = c` (`#constant-positive`; `normSq w ≠ 0` is derived from `Re F 0 > 0`, not assumed) |
| ↳ `fourierCoeff_normSq_trigPoly_zero` (Bound) | none | gives `Fhat 0 = c · vacuumWeight d (elementary lam)`, real (`#vacuum-real`) |
| ↳ `norm_fourierCoeff_normSq_trigPoly N a p` (Bound), all `p : ℤ` | none | `Int.eq_nat_or_neg p`: `p = n` uses `fourierCoeff_normSq_trigPoly`; `p = -n` rewrites `-((((-n : ℤ)) : ℂ) φ i) = (n : ℂ) φ i` (`push_cast; ring`), uses `fourierCoeff_normSq_trigPoly_neg` (`= conj c_n`) and `norm_star`; `Int.natAbs_neg`, `Int.natAbs_natCast` (`#negative-q`) |
| ↳↳ `fourierCoeff_normSq_trigPoly`, `_neg` (FourierCoeff) | none | via `twisted_mean_normSq_trigPoly`: termwise integration with `intervalIntegral.integral_finsetSum`, integrability from `Continuous.intervalIntegrable` (`fun_prop`), and the orthogonality `integral_exp_int_mul_I` (`integral_exp_mul_complex`, `Complex.exp_int_mul_two_pi_mul_I`); the double sum is matched to `QEDCore.correlation` by `sum_sum_ite_eq_correlation` |
| ↳ `QEDCore.relative_correlation_bound (q := q.natAbs) lam hr0 hr1 hlam` (Coefficients), `r = e^{-t}` | `0 ≤ r`, `r ≤ 1`, `∀ i, ‖lam i‖ ≤ r` | `hr0 := (Real.exp_pos _).le`; `hr1 := Real.exp_le_one_iff.mpr (neg_nonpos.mpr ht)`; `hlam` |
| ↳↳ `elementary_correlation_bound` → `norm_correlation_le hr0 hr1 (norm_elementary_le lam hlam)`; `one_le_vacuumWeight (elementary_zero lam)` (Coefficients) | `0 ≤ r ≤ 1`, coefficient bounds `‖e_k‖ ≤ binom(N,k) r^k`, `e_0 = 1` | from the same `hr0`, `hr1`, `hlam`; `e_0 = 1` proved (`elementary_zero`); Vandermonde by `Nat.add_choose_eq` (`#vandermonde`, `#elementary-bound`, `#vacuum-lower-bound`) |

Points of special attention:

- **Enumeration of the small roots, `card = d`.** `lam` enumerates the multiset
  `roots.filter (‖·‖ ≤ e^{-b m_*})` exactly (multiset equality), whose cardinality is `d` by
  Lemma 3.1; nothing is assumed about distinctness or diagonalizability.
- **Paired-root decomposition.** `hroots` is derived, not assumed: the whole root multiset is
  the filter plus its complement, and the complement equals the filter mapped by
  `z ↦ (conj z)⁻¹` (Lemma 3.1, conjunct 3). `det(1 + zU) = ∏_{μ ∈ roots} (1 + zμ)` holds for
  every complex matrix (no diagonalizability).
- **`C` real and positive.** Obtained from `F(0) = C |P(1)|²` with `Re F(0) > 0`,
  `Im F(0) = 0` (Lemma 3.1 at the untwisted history, transported by
  `centeredTrace_append_twist_zero`).
- **Negative `q` and casts.** The frozen phase uses `((q : ℤ) : ℂ)`; the helper splits
  `q = n` or `q = -n` with `n : ℕ` and rewrites the casts by `Int.cast_natCast`, `push_cast`;
  `q.natAbs` is matched to `|(q : ℝ)|` by `Nat.cast_natAbs`, `Int.cast_abs` in
  `exp(-t)^{|q|} = exp(-(t |q|))` (`Real.exp_nat_mul`). No step passes through `ℕ`-subtraction
  or truncation that could change the statement.
- **`Fhat` = `C` · correlation.** `hFhat'` in `fourier_bound_of_factorization` pulls the
  constant `c` out of the interval integral (`intervalIntegral.integral_const_mul`) after
  rewriting `F` pointwise; the remaining integral is computed exactly from integrable
  continuous terms, so the identification is not an artefact of the junk value `0` of a
  non-integrable integral.
- **Reuse of `relative_correlation_bound` with `r = e^{-b m_*}`.** All three premises are
  discharged from `t = b m_* ≥ 0` and `hlamr`; the conclusion's `(N + N).choose (N + q)` is
  rewritten to `(2 * d).choose (d + q.natAbs)` by `ring`.
- **Unused `hq`.** The provider marks `hq : |q| ≤ d` unused (`set_option
  linter.unusedVariables false in`); the bound is proved for every integer `q` (for `|q| > d`
  the binomial is `0` and the correlation vanishes). The theorem is therefore stronger than the
  paper's statement; this is not a defect.

## 3. No helper weaker than its use

Each helper's conclusion was compared with the term it is used at. `fourier_bound_of_factorization`
is an abstract statement for any `F` with `F = C |P|²`; its conclusion, instantiated at
`t = b * mStar` and `Fhat := fun p => …` (by `rfl`), is literally the provider's goal
(`b * mStar * |↑q|` is `t * |↑q|`). `norm_fourierCoeff_normSq_trigPoly` is stated for all
`p : ℤ` (not only `p ≥ 0`). `centeredTrace_append_twist_eq_mul_normSq` holds for every real `φ`
and is passed as the `∀ φ` hypothesis. The helpers' hypotheses are exactly the facts
established in the provider (table above); none is introduced by `sorry`, an extra binder, a
`Classical` choice of a convenient witness, or a local instance. The only local instances in
the closure (`Matrix.linftyOpNormedRing/Algebra`, `attribute [local instance]` in
`Transfer/BetaForm.lean`, `Transfer/ExpForm.lean`) belong to the Lemma 3.1 closure and were
reviewed in `LEM_TRANSFER_AUDIT_2.md`; no Fourier module declares an instance.

**PREMISE_DISCHARGE: PASS.**

## 4. Grep (all `.lean` files of `lean/` outside `.lake*`, `vendor`, `tools`, `Audit`; 34 files)

Word search for `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`, `extern`, `unsafe`,
`opaque`, and substring search for `maxHeartbeats`, `skipKernelTC`, `ofReduceBool`, `@[extern`:

- `Core/CanonicalComparison.lean:30` — docstring text "is postulated as a Lean axiom: the
  theorem has explicit data and hypotheses" (prose, no declaration).
- `lakefile.lean:15` — docstring about quarantining a `sorry` anchor.
- `scripts/Audit/AxiomAudit.lean` lines 11-185 — the audit script's own prose and its match on
  `.axiomInfo`/`.opaqueInfo` (tooling, not library code).
- No hit in `Core/` or `Frozen/` code. No `maxHeartbeats`, `skipKernelTC`, `ofReduceBool`.

`set_option` (all of them):

| Location | Option | Purpose |
|---|---|---|
| `Core/PaperA/Provider/CanonicalFourierBound.lean:42` | `linter.unusedVariables false in` | silences the unused-variable lint for the frozen binder `hq` (statement kept verbatim) |
| `Core/PaperA/Transfer/BetaForm.lean:235` | `linter.unusedVariables false in` | `betaForm_exp_lt` keeps unused `hP`, `hPP` for its interface |

Both are linter switches with no effect on elaboration or kernel checking. Other
meta-level code: one `run_cmd` in `scripts/Audit/AxiomAudit.lean:101` (the audit itself); no
`macro`, `elab`, `syntax`, `notation`, `instance`, `initialize` or `#eval` in `Core`/`Frozen`.

## 5. Axioms

`#print axioms` (scratch `Audit.lean`, exit 0):

```
'QEDCore.PaperA.canonical_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.canonical_fourier_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.positivity_and_transfer_annulus' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.fourier_bound_of_factorization' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_append_twist_eq_mul_normSq' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_append_twist_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_append_twist' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.det_one_add_exp_smul_of_paired' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.det_one_add_smul_eq_prod_roots' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.norm_fourierCoeff_normSq_trigPoly' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.fourierCoeff_normSq_trigPoly' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.fourierCoeff_normSq_trigPoly_neg' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.integral_exp_int_mul_I' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.relative_correlation_bound' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.exists_fin_enum_of_card' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.isUnit_transferMatrix' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.zero_not_mem_charpoly_roots' depends on axioms: [propext, Classical.choice, Quot.sound]
```

Transitive closure of the provider inside `QEDCore` (scratch `Audit.lean`, `run_cmd` over
`getUsedConstantsAsSet`): 143 constants, all in `Core.PaperA.{Defs,Transfer,Fourier,Provider}`,
`Core.Coefficients`, `Core.PseudoUnitary` and `Frozen.PaperA.PositivityAndTransferAnnulus`; it
reaches Lemma 3.1 only through the sealed frozen anchor, and never the Lemma 3.2 anchor.

Project axiom audit, `lake env lean scripts/Audit/AxiomAudit.lean`: exit 0,
`axiom audit passed: 299 declarations in 31 modules, 125 theorems (0 registered DRAFT_SORRY
anchors); axioms used outside them: [Quot.sound, Classical.choice, propext]`.
`lean/.lake/axiom-audit.json`: `passed: true`, `violations: []`, `draft_exports: []`,
`lean_version: 4.35.0`, `axiom_usage = {propext: 297, Quot.sound: 290, Classical.choice: 273}`;
both `QEDCore.PaperA.canonical_fourier_bound` and `QEDCore.PaperA.Provider.canonical_fourier_bound`
have `draft: false` and axioms exactly `[Classical.choice, Quot.sound, propext]`.

## 6. Kernel replay

Each module separately, from `lean/`:
`bash ../scripts/lean-gate.sh lake env leanchecker --verbose <Module> > lean/.lake/scratch/audit4/lc_<Module>.log 2>&1`,
exit code taken directly from the command (no pipe). Requested modules:

| Module | Exit | Output |
|---|---|---|
| `Frozen.PaperA.CanonicalFourierBound` | 0 | `replaying Frozen.PaperA.CanonicalFourierBound` |
| `Core.PaperA.Provider.CanonicalFourierBound` | 0 | `replaying …` |
| `Core.PaperA.Fourier.Bound` | 0 | `replaying …` |
| `Core.PaperA.Fourier.Factorization` | 0 | `replaying …` |
| `Core.PaperA.Fourier.FourierCoeff` | 0 | `replaying …` |
| `Core.PaperA.Fourier.TwistKick` | 0 | `replaying …` |
| `Core.PaperA.Fourier.DetProd` | 0 | `replaying …` |
| `Core.Coefficients` | 0 | `replaying …` |

Rest of the project closure (also one module per command):

| Module | Exit | Output |
|---|---|---|
| `Frozen.PaperA.PositivityAndTransferAnnulus` | 0 | `replaying …` |
| `Core.PaperA.Provider.PositivityAndTransferAnnulus` | 0 | `replaying …` |
| `Core.PaperA.Transfer.Annulus` | 0 | `replaying …` |
| `Core.PaperA.Transfer.BetaForm` | 0 | `replaying …` |
| `Core.PaperA.Transfer.DetExp` | 0 | `replaying …` |
| `Core.PaperA.Transfer.DiracAlgebra` | 0 | `replaying …` |
| `Core.PaperA.Transfer.DiracLift` | 0 | `replaying …` |
| `Core.PaperA.Transfer.ExpForm` | 0 | `replaying …` |
| `Core.PaperA.Transfer.History` | 0 | `replaying …` |
| `Core.PaperA.Transfer.Homotopy` | 0 | `replaying …` |
| `Core.PaperA.Transfer.RootCount` | 0 | `replaying …` |
| `Core.PaperA.Transfer.SpectralPairing` | 0 | `replaying …` |
| `Core.PseudoUnitary` | 0 | `replaying …` |
| `Core.PaperA.Defs.Step` | 0 | `replaying …` |
| `Core.PaperA.Defs.DiracOperator` | 0 | `replaying …` |
| `Core.PaperA.Defs.StepGenerator` | 0 | `replaying …` |
| `Core.PaperA.Defs.StepFreeTime` | 0 | `replaying …` |
| `Core.PaperA.Defs.TransferMatrix` | 0 | `replaying …` |
| `Core.PaperA.Defs.CenteredTrace` | 0 | `replaying …` |

All 27 project modules in the target's closure replay with exit 0 (Mathlib imports are not
re-replayed; `leanchecker` checks each named module's own declarations). No "failed to read
file …olean.private" error occurred in any run, so no rerun was needed.
`lake build Frozen.PaperA.CanonicalFourierBound`: `Build completed successfully (3691 jobs)`,
exit 0; every project module of the closure was `Replayed` from cache (nothing rebuilt), so
the replayed `.olean` files match the sources at `422b189`; the build log has no `sorry` and
no error (warnings: replayed unused-section-variable and unused-simp-argument lints).

**AXIOMS_AND_KERNEL: PASS.**

## 7. Non-vacuity

**Lean instance** (scratch `Audit.lean`, exit 0; repeated in `Nontriv.lean`, exit 0):
standard Dirac matrices `α_j = [[0, σ_j], [σ_j, 0]]`, `β = diag(1, 1, -1, -1)`, with all six
Clifford hypotheses proved by `fin_cases`/`simp` (axioms: the standard three); `ι = Fin 1`,
`hist = [Step.free 1 0 1]`, `mStar = b = 1`, `d = 2` (`hd : 4 * 1 = 2 * 2`), `hfree`
(`0 ≤ 1`, `v = 0` Hermitian, `1 - 1 = 0` positive semidefinite), `hkick` (no kicks), `htime`
(`Σ freeTime = 1`). The frozen theorem is applied at `q = 1` and at `q = -2` (negative
branch, `|q| = d`), with `hq` by `norm_num`; both terms elaborate.

**The conclusion is not trivially true** (scratch `Nontriv.lean`, exit 0, no errors, axioms of
every lemma `[propext, Classical.choice, Quot.sound]`). Computed in Lean directly from the
frozen definitions, without the provider or `Fourier/Bound.lean`:

- `gen1`: the generator of `Step.free 1 0 1` is `diagonal g`, `g = (1, 1, -1, -1)` (i.e.
  `1 ⊗ β`); `U1`: `transferMatrix = diagonal (e^{-g})` (`Matrix.exp_diagonal`); `trace1`:
  `Σ tr A = 0`.
- `F1`: `F(φ) = e^{-2iφ} (1 + e^{iφ} e^{-1})² (1 + e^{iφ} e)²` (from `centeredTrace_append_twist`
  and `Matrix.det_diagonal`).
- `Fhat1_eq`: `(2π)⁻¹ ∫_0^{2π} e^{-iφ} F(φ) dφ = 2 (e^{-1} + e)`, by expanding into five
  Fourier monomials and integrating each with `integral_exp_int_mul_I`; `two_sR_ne_zero`:
  this is nonzero.
- A final `example` destructures the frozen theorem at this instance with `q = 1` and checks,
  by definitional unfolding of the anchor's `let Fhat`, that its left-hand side is
  `‖2 (e^{-1} + e)‖ > 0`: `‖2 (e^{-1}+e)‖ ≤ binom(4, 3) · e^{-1} · Re F_0`.

**Independent numerics** (`lean/.lake/scratch/audit4/numeric.py`, numpy/scipy, mirroring the
frozen definitions literally; uniform 512-point quadrature, exact for these trigonometric
polynomials): for the instance, `F_0 = 11.524391 = e² + 4 + e⁻²`, `|F_{±1}| = 6.172323 =
2(e + e⁻¹)` (bound 16.958347), `|F_{±2}| = 1` (bound 1.559657), `F_{±3} = 0`, ratio
`max |F_q| / bound = 0.641`. Six random admissible histories (`|ι| = 1, 2, 3`, Hermitian
`v_j`, `M ≥ m_* I`, Hermitian kicks) satisfy the bound for every `q ∈ [-d-1, d+1]` with
`Im F_0` at rounding level (ratios 0.0011-0.1717). The statement is satisfiable, its conclusion
is informative, and it agrees with an independent evaluation.

**NON_VACUITY: PASS.**

## 8. Concerns (none blocking)

1. `hq` is unused; the proved bound holds for every integer `q`. Stronger than the paper, not
   a defect; recorded so that a future reader does not read the hypothesis as load-bearing.
2. `docs/DECISIONS.md` D12 says the `Frozen` library is one "that nothing in `Core` imports",
   but `Core/PaperA/Provider/CanonicalFourierBound.lean` imports
   `Frozen.PaperA.PositivityAndTransferAnnulus`. This is the intended route (the provider
   consumes the sealed, audited Lemma 3.1 statement; `lean/lakefile.lean` says "A sealed
   statement may be used by later providers", and the anchor guard passes), and it is sound,
   but D12's sentence at `422b189` is out of date. An uncommitted working-tree edit by another
   session rewrites it ("a sealed one may be used by later providers (the Lemma 3.2 provider
   uses the sealed Lemma 3.1)"); once that edit is committed, this concern is closed.
3. Cosmetic: two enumeration lemmas with the same content (`exists_fin_enum_of_card` in
   `Fourier/Bound.lean`, private `exists_fin_enum_of_card_eq` in `Fourier/Factorization.lean`).
4. Scope (not re-litigated): R1(a) restricts Lemma 3.2 to piecewise-constant histories with
   instantaneous kicks; the time-dependent case of the paper is not covered (D11).

## Verdicts

CONSUMPTION: PASS
PREMISE_DISCHARGE: PASS
AXIOMS_AND_KERNEL: PASS
NON_VACUITY: PASS
AUDIT_VERDICT: PASS
