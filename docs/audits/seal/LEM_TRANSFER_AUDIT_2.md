# Seal audit 2 of `lem_transfer_v1` (Paper A, Lemma 3.1)

- **Target:** `QEDCore.PaperA.positivity_and_transfer_annulus`,
  `lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean` (manifest `lem_transfer_v1`, `SEALED`),
  Paper A Lemma 3.1 (`paper-a/transfer.tex` L9-L81) for piecewise-constant histories
  (ruling R1(a), `docs/DECISIONS.md` D11).
- **Provider:** `QEDCore.PaperA.Provider.positivity_and_transfer_annulus`,
  `lean/Core/PaperA/Provider/PositivityAndTransferAnnulus.lean`.
- **Auditor:** independent, refute-first; did not write any of the audited code. Date 2026-11-12.
- **Emphasis:** proof consumption, premise discharge, axioms and kernel check, non-vacuity.
  Statement fidelity to the source was audited separately (`docs/audits/pilot/`) and is
  not re-litigated here beyond the definitions the helpers introduce.
- **Toolchain:** Lean v4.35.0, Mathlib v4.35.0. All Lean/Lake commands ran from `lean/` through
  `bash ../scripts/lean-gate.sh`. Scratch files: `lean/.lake/scratch/audit2/`.

## 0. Audited state

`HEAD = 893dbbe` ("Seal Lemma 3.1 ..."). During the audit another session was sealing Lemma 3.2
in the same working tree (modified: `Core/PaperA/Provider/CanonicalFourierBound.lean`,
`Frozen/PaperA/CanonicalFourierBound.lean`, `frozen-manifest.json` (entry `lem_fourier_v1`),
`lakefile.lean` (docstring only); new: `Core/PaperA/Fourier/Bound.lean`). None of these is in
the target's import closure, and no file of the target's closure was modified relative to
`HEAD`. SHA-256 of the audited files at audit time:

| File | SHA-256 |
|---|---|
| `Frozen/PaperA/PositivityAndTransferAnnulus.lean` | `c7506f3dc611189a9dc7620909fe35adb6cc07faf6096ff2d2bf46cbcfac976e` |
| `Core/PaperA/Provider/PositivityAndTransferAnnulus.lean` | `9405d25e52496c94032262ad1c4f7c7ce95ac8fa29eb21ede21c5f23735864db` |
| `Core/PaperA/Transfer/Annulus.lean` | `6906b9ed9f0aa95297d61c6c4cf774925888b45810e31c6202dd6f114ea2c5dc` |
| `Core/PaperA/Transfer/BetaForm.lean` | `d067e82d6f4424926a8e6f2bcc180e8029431721ad40b0512892e9fc97b4a805` |
| `Core/PaperA/Transfer/DetExp.lean` | `bc25c134e40d4116815f16c0ebd65cd4ffb5ebb0e87d69a50ed6462e2c63e63c` |
| `Core/PaperA/Transfer/DiracAlgebra.lean` | `afb8954aececc149d0e42310f86e980b94b6ed93c58277beb33544a2cd4a1fb5` |
| `Core/PaperA/Transfer/DiracLift.lean` | `ad5c4cea762a544e36714cd0342dc7ede43930718147d693499b3c06183005c2` |
| `Core/PaperA/Transfer/ExpForm.lean` | `390ea0edee7dbf11401e41adfafcf48a14fc1ca47fd0a3251a307fec6d00e9ec` |
| `Core/PaperA/Transfer/History.lean` | `875d2982c903449a72151ab282886fe9d426ec59aef674ee04b938e149c5f6d1` |
| `Core/PaperA/Transfer/Homotopy.lean` | `071c917895a538df0b8c80a71b67db72b6787debbefa34143b1d8b164742a203` |
| `Core/PaperA/Transfer/RootCount.lean` | `cb394a8f1175c01da918616e797cd2bd5a8ae182b4e7dbac003e15f1a937a570` |
| `Core/PaperA/Transfer/SpectralPairing.lean` | `5bfd302b01a641dacaf3d35fc808caf1f6a0d0e9d5ab9244947dbc28ffb3dbe0` |
| `Core/PaperA/Fourier/DetProd.lean` | `e8555ce58f72747abcdc54997649c07a8b484cfb97f4f0ceea30ab3ca61f1446` |
| `Core/PseudoUnitary.lean` | `e18d8da5538355fa898fa31d0503c6477972b80caf315d9f90a98b4d45796f24` |

`lake build` at audit start: `Build completed successfully (3696 jobs)`, exit 0. The only
`sorry` warning in the build log was `Frozen/PaperA/CanonicalFourierBound.lean:27:8`
(Lemma 3.2, then `DRAFT_SORRY`, outside the target's closure). Other warnings: unused simp
arguments (DiracAlgebra), automatically included but unused section variables (DiracLift),
and "module system" import notes; none affects soundness.

## 1. Proof consumption

- The anchor's proof region is exactly
  `by exact QEDCore.PaperA.Provider.positivity_and_transfer_annulus α β hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti d hd mStar b hm hb hist hfree hkick htime`
  (2 lines, within the manifest seal limits of 3 lines / 240 bytes).
- `#print QEDCore.PaperA.positivity_and_transfer_annulus` (scratch `Check.lean`) shows the term
  `fun {ι} [Fintype ι] [DecidableEq ι] α β hα_herm … htime => Provider.positivity_and_transfer_annulus α β hα_herm … htime`:
  every anchor binder is passed once, in order; there are no extra arguments, casts or
  auxiliary constants.
- The provider's statement text is byte-identical to the anchor's (1267 characters each,
  compared programmatically from `theorem` to `:=`). The provider namespace
  `QEDCore.PaperA.Provider` declares only this theorem, so no name in the statement
  (`centeredTrace`, `transferMatrix`, `Step`, `Step.freeTime`) is shadowed.
- The elaborated signature recorded by the axiom audit hashes to
  `48c44cf3675aa01e2380fb5c4370ce5b5bb2ec1b9bd78f50ba46e25e8e05280f`, equal to the manifest's
  `abi_sha256`: the sealed statement is the approved one.
- `python -I scripts/check_frozen_anchors.py --root lean --manifest lean/frozen-manifest.json --allow-non-module`
  (the CI invocation): `FROZEN-ANCHOR GUARD OK`, exit 0 (prefix/suffix hashes, definition
  closure hashes and seal limits). Without `--allow-non-module` it fails only because no
  file starts with `module`, which is the documented reason CI passes that flag.
- Nothing in the target's closure imports a `Frozen` module (the only `import Frozen` in `Core`
  is `Core/PaperA/Provider/CanonicalFourierBound.lean`, Lemma 3.2's provider consuming the
  sealed Lemma 3.1), so there is no circularity.

## 2. Premise discharge

Notation: `h := IsDiracClifford α β`, `hadm := ∀ s ∈ hist, s.IsAdmissible mStar`,
`hH := ∀ s ∈ hist, s.IsHermitianData`, `P := 1 ⊗ β`, `C := 1 ⊗ C₅`, `U := transferMatrix α β hist`,
`r := exp (-(b * mStar))`.

### 2a. Provider level

| Helper (module) | Premises | Where each premise comes from |
|---|---|---|
| `IsDiracClifford.mk` (DiracAlgebra) | the six Clifford fields | anchor `hα_herm hβ_herm hα_sq hβ_sq hα_anti hαβ_anti` via the anonymous constructor (field types identical; see 3) |
| `isAdmissible_of_mem` (History) | `hfree`, `hkick` | anchor `hfree`, `hkick` |
| `hb' : 0 < Σ freeTime` | | `htime ▸ hb` |
| `im_centeredTrace` (History) | `h`, `hH` | `h`; `(hadm s hs).isHermitianData` (proved: `M - m_*·1 ⪰ 0` gives `M` Hermitian) |
| `transferMatrix_annulus` (Annulus) | `h`, `hd`, `hm`, `hb`, `hadm`, `htime` | `h`; anchor `hd hm hb htime`; `hadm` |
| `re_centeredTrace_pos_of_ne_zero` (Homotopy) | `h`, `hadm`, `hne : ∀ σ ∈ [0,1], F(H_σ) ≠ 0` | `h`, `hadm`; `hne` is **proved** inline (next row), not assumed |
| `centeredTrace_ne_zero` (Annulus) at `hist.map (Step.deform mStar σ)` | `h`, `hm`, admissibility of `H_σ`, `0 < Σ freeTime(H_σ)` | `h`, `hm`; `(hadm s₀ hs₀).deform hσ.1 hσ.2`; `Step.freeTime_deform` + `List.map_map` + `hb'` |
| `Step.IsAdmissible.deform` (Homotopy) | `s.IsAdmissible mStar`, `0 ≤ σ`, `σ ≤ 1` | `hadm`; `hσ : σ ∈ Set.Icc 0 1` |

### 2b. Annulus conjuncts (inside `transferMatrix_annulus`)

| Helper (module) | Premises | Where each premise comes from |
|---|---|---|
| `isUnit_transferMatrix` (History) | none | product of `Matrix.isUnit_exp` |
| `transferMatrix_preservesForm` (History) | `h`, `hH` | `h`; `hadm → isHermitianData` |
| `charpoly_roots_map_star_inv` (SpectralPairing) | `U V = 1`, `C C = 1`, `Uᴴ C U = C` | `Matrix.mul_nonsing_inv` with `isUnit_transferMatrix`; `h.one_kronecker_c5_mul_self`; `transferMatrix_preservesForm` |
| `card_charpoly_roots` (SpectralPairing) | none | then `Fintype.card_prod`, `Fintype.card_fin`, `omega` with anchor `hd` gives `card roots = 2 d` |
| `zero_not_mem_charpoly_roots` (SpectralPairing) | `U V = 1` | as above |
| `norm_charpoly_root_dichotomy` (Annulus) | `h`, `hm`, `hadm`, `htime`, `hb`, `z ∈ roots` | binders of `transferMatrix_annulus`; `z` ranges over **all** roots |
| `annulus_split_of_pairing` (RootCount) | `0 < r`, `r < 1`, `card S = 2d`, `0 ∉ S`, `S.map (star ·)⁻¹ = S`, `∀ z ∈ S, ‖z‖ ≤ r ∨ r⁻¹ ≤ ‖z‖` | `Real.exp_pos`; `Real.exp_lt_one_iff` with `0 < b m_*` from `hb`, `hm`; `hcard`; `zero_not_mem_charpoly_roots`; `charpoly_roots_map_star_inv`; the dichotomy rewritten with `r⁻¹ = exp (b m_*)` (`Real.exp_neg`, `inv_inv`) |

### 2c. Dichotomy and β-form chain

| Helper (module) | Premises | Where each premise comes from |
|---|---|---|
| `exists_eigenvector_of_mem_charpoly_roots` (SpectralPairing) | `z ∈ U.charpoly.roots` | `hz`; gives `v ≠ 0`, `U v = z v` via `det (z I - U) = 0` |
| `betaForm_transferMatrix_le` (Annulus) | `h`, `hm`, `hadm` | passed through |
| `betaForm_transferMatrix_lt` (Annulus) | `h`, `hm`, `hadm`, `0 < Σ freeTime`, `v ≠ 0` | `htime ▸ hb`; eigenvector `v ≠ 0` |
| `betaForm_transferMatrix_le_self` (Annulus) | `h`, `hm`, `hadm` | `hrest` (tail of `hadm`); `sum_freeTime_nonneg hadm` |
| `betaForm_exp_generator_le` (Annulus) | `h`, `hm`, `s.IsAdmissible mStar` | head of `hadm` |
| `betaForm_exp_generator_lt` (Annulus) | ... and `0 < s.freeTime`, `f ≠ 0` | case split `lt_or_ge 0 s.freeTime`; `f ≠ 0` propagated by `exp_mulVec_ne_zero'` |
| `betaForm_exp_le` (BetaForm) | `H` Herm., `P` Herm., `P P = 1`, `0 < m`, `H P + P H - 2m ⪰ 0`, `0 ≤ τ` | `h.isHermitian_diracOperator` (from `isHermitianData`); `h.isHermitian_one_kronecker_β`; `h.one_kronecker_β_mul_self`; `hm`; `posSemidef_anticomm_sub` (from `h.one_kronecker_β_anticomm` and `posSemidef_kronecker_one_sub` applied to the admissibility bound on `M`); `τ ≥ 0` from admissibility |
| `betaForm_exp_lt` (BetaForm) | same, with `0 < τ`, `f ≠ 0` | as above |
| `betaForm_exp_kick` (BetaForm) | `K` Herm., `K P = P K` | `isHermitian_kronecker_one'` from kick admissibility; `one_kronecker_mul_kronecker_one` |
| `le_exp_mul_of_hasDerivAt` (BetaForm, private) | `∀ u, HasDerivAt B (B' u) u`, `∀ u, B' u + c B u ≤ 0`, `0 ≤ τ` | `hasDerivAt_betaForm_exp hH`; `two_mul_le_of_posSemidef` + `abs_betaForm_le hP hPP`; `hτ` |
| `hasDerivAt_betaForm_exp` (BetaForm) | `H` Hermitian | `hH` |

### 2d. Reality chain (`im_centeredTrace`)

| Helper (module) | Premises | Where each premise comes from |
|---|---|---|
| `star_centeredTrace` (History) | `h`, `hH` | passed |
| `re_sum_trace_generator` (History) | `h`, `hH` | `IsDiracClifford.trace_generator_re`: free steps traceless (`trace_α`, `trace_β` from Clifford relations), kick trace `-4 i tr Θ` with `tr Θ` real (`trace_im_eq_zero` of Hermitian `Θ`) |
| `star_det_one_add_transferMatrix` (History) | `h`, `hH` | `det_transferMatrix`, `transferMatrix_preservesForm`, `isUnit_transferMatrix`, `h.one_kronecker_c5_mul_self`, `conjTranspose_eq_conj_inverse` |
| `det_transferMatrix` / `det_exp_neg_generator` (History) | `h`, `hH` | `det_exp_smul_of_isHermitian` (DetExp) with `isHermitian_diracOperator` / `isHermitian_kronecker_one` |
| `conjTranspose_eq_conj_inverse` (SpectralPairing) → `QEDCore.adjoint_eq_conjugate_inverse` (PseudoUnitary) | `C C = 1`, `U V = 1`, `Uᴴ C U = C` | discharged at both call sites (History, SpectralPairing) as in 2b |
| `transferMatrix_preservesForm` (History) | `h`, `hH` | per step `conjTranspose_exp_neg_mul_mul_exp_neg` (ExpForm) with premise `h.generator_adjoint_c5 s hs` (DiracLift: free from `one_kronecker_c5_mul_diracOperator` ← `c5_mul_α`, `c5_mul_β`; kick from `one_kronecker_mul_kronecker_one`) |

### 2e. Positivity chain (`re_centeredTrace_pos_of_ne_zero`, `centeredTrace_ne_zero`)

| Helper (module) | Premises | Where each premise comes from |
|---|---|---|
| `continuous_centeredTrace_deform` (Homotopy) | none | generator affine in `σ` (`generator_deform`), `NormedSpace.exp_continuous`, `Continuous.matrix_det`, `matrix_trace` |
| `im_centeredTrace` at `H_σ` | `h`, `hH(H_σ)` | `((hadm s hs).deform hσ.1 hσ.2).isHermitianData` |
| `centeredTrace_deform_one` (Homotopy) | `h`, `Σ freeTime = b` | `h`; `rfl` |
| `det_one_add_exp_smul_of_isHermitian` (Homotopy) | `H` Hermitian | `h.isHermitian_one_kronecker_β`; value `∏ (1 + e^{c λ_i}) > 0` |
| `transferMatrix_deform_one` (Homotopy) | none | `Matrix.exp_add_of_commute` with an explicit `Commute` proof |
| `intermediate_value_Icc` (Mathlib) | `0 ≤ 1`, `ContinuousOn`, `f 0 ≤ 0 ≤ f 1` | `zero_le_one`; continuity; `by_contra`; `centeredTrace_deform_one` |
| `det_one_add_transferMatrix_ne_zero` (Annulus) | `h`, `hm`, `hadm`, `0 < Σ freeTime` | passed; `det_one_add_smul_eq_prod_roots` (DetProd, no premises) and `norm_charpoly_root_dichotomy … rfl hb` at `μ = -1` (`‖-1‖ = 1` lies strictly between `r` and `r⁻¹`) |

Unused premises (helper is *more* restrictive, never weaker; discharged at every use):
`Step.IsAdmissible.deform` keeps `0 ≤ σ` (documented), `betaForm_exp_lt` keeps `hP`, `hPP`
(documented; `set_option linter.unusedVariables false in`). No premise of any helper is
supplied by `sorry`, by an assumption of the conclusion, or by a weaker statement; the one
source node that a helper takes as a premise (`#homotopy-nonvanishing`, in
`re_centeredTrace_pos_of_ne_zero`) is discharged in the provider by `centeredTrace_ne_zero`.

**PREMISE_DISCHARGE: PASS.**

## 3. Strength of helper statements (refutation attempts)

- **Dichotomy vs. all roots.** `norm_charpoly_root_dichotomy` is stated for every
  `z ∈ U.charpoly.roots`, and obtains an eigenvector of each such root from
  `det (z I - U) = 0`. It therefore covers defective eigenvalues; multiplicity is handled by
  the multiset identity, not by eigenvectors. No eigenvector-only statement is applied to roots.
- **Pairing.** `charpoly_roots_map_star_inv` is the multiset identity
  `roots.map (fun z => (star z)⁻¹) = roots` on the full multiset (with multiplicity), proved from
  `charpoly Uᴴ = (charpoly U).map conj` and `charpoly U⁻¹ = c · reverse (charpoly U)`; the map is
  exactly the anchor's `(star z)⁻¹`.
- **Count.** `card_charpoly_roots` gives `Fintype.card (ι × Fin 4) = |ι| · 4`, and `omega` with
  `hd : 4 |ι| = 2 d` yields `2 d`; the right cardinality and the anchor's `d`.
- **Reality.** `im_centeredTrace` is about the frozen constant `centeredTrace` (centering factor
  `exp (½ Σ tr A)` of `def_centered_trace_v1`), the same constant the anchor uses.
- **Radii.** `r = exp (-(b * mStar))` and `r⁻¹` rewritten to `exp (b * mStar)`: the anchor's
  literal expressions. The disc is closed (`‖z‖ ≤ r`) in both the helper and the anchor.
- **Positivity.** The IVT is applied to `Re F(H_σ)` on `[0,1]`, with `F(H_σ)` real (reality
  re-applied to each admissible `H_σ`) and nonzero, and `F(H_1) = ∏ (1 + e^{-b m_* λ_i}) > 0`
  for the eigenvalues `λ_i` of `1 ⊗ β`; `H_0 = H` by `Step.deform_zero`.

No helper was found to be weaker than its use requires.

## 4. Definitions introduced by helpers

| Definition | Body | Verdict |
|---|---|---|
| `IsDiracClifford α β` (DiracAlgebra) | structure with `herm_α : ∀ j, (α j).IsHermitian`, `herm_β : β.IsHermitian`, `sq_α : ∀ j, α j * α j = 1`, `sq_β : β * β = 1`, `anti_α : ∀ j k, j ≠ k → α j * α k + α k * α j = 0`, `anti_αβ : ∀ j, α j * β + β * α j = 0` | exactly the anchor's six Clifford hypotheses; checked in Lean by an `Iff` with the conjunction of the anchor's hypothesis types (scratch `Check.lean`); satisfiable (section 7) |
| `c5 α β` (DiracAlgebra) | `α 0 * α 1 * α 2 * β` | `C₅ = α₁ α₂ α₃ β` (model.tex L116); Hermitian, involutive, anticommuting with `α_j`, `β` proved from the Clifford fields only; internal (not in the anchor) |
| `Step.IsHermitianData` (DiracLift) | free: `(∀ j, (v j).IsHermitian) ∧ M.IsHermitian`; kick: `Θ.IsHermitian` | always derived from `IsAdmissible` (`isHermitianData`), never assumed |
| `Step.IsAdmissible mStar` (History) | free: `0 ≤ τ ∧ (∀ j, (v j).IsHermitian) ∧ (M - (mStar : ℂ) • 1).PosSemidef`; kick: `Θ.IsHermitian` | exactly the per-step bodies of `hfree`/`hkick`; checked in Lean: `(∀ s ∈ hist, s.IsAdmissible mStar) ↔ (hfree-type ∧ hkick-type)` |
| `Step.deform mStar σ` (Homotopy) | free: `free τ ((1-σ) • v) ((1-σ) • M + (σ m_*) • 1)`; kick: `kick ((1-σ) • Θ)` | matches transfer.tex L73-L75 (kicks and `v_j` turned off, `M ↦ (1-s)M + s m_* I`, free times kept); `deform_zero`, admissibility on `[0,1]`, `freeTime_deform` proved |
| `betaForm P f` (BetaForm) | `(star f ⬝ᵥ (P *ᵥ f)).re` with `P = 1 ⊗ β` | `Re ⟨f, β f⟩` (transfer.tex L54); real-valued, not degenerate |

None of these definitions occurs in the anchor's statement (the ABI hash is unchanged), so an
unfaithful helper definition could only make a proof fail, not weaken the sealed claim.

## 5. Grep for forbidden constructs

Command (from `lean/`, excluding `.lake*`, `vendor`, `tools`, `Audit`):
`grep -rnE "\bsorry\b|\badmit\b|\baxiom\b|native_decide|implemented_by|\bextern\b|\bunsafe\b|maxHeartbeats|skipKernelTC|ofReduceBool|\bopaque\b"`

At audit start:

| Hit | Context | Assessment |
|---|---|---|
| `Frozen/PaperA/CanonicalFourierBound.lean:50` `by sorry` | Lemma 3.2 anchor `lem_fourier_v1`, then `DRAFT_SORRY` | outside the target's closure; the target's axioms exclude `sorryAx`. Re-grep at the end of the audit: gone (Lemma 3.2 sealed concurrently by another session) |
| `lakefile.lean:15` | docstring ("While a statement's proof is `sorry` ...") | comment |
| `Core/CanonicalComparison.lean:30` | docstring ("No determinant ... identity is postulated as a Lean axiom") | comment |
| `Core/PaperA/Provider/CanonicalFourierBound.lean:13,19` | module docstring | comment (Lemma 3.2) |
| `README.md:23,37`, `status.json:20-21` | documentation strings | not Lean code |
| `scripts/Audit/AxiomAudit.lean:11-185` | docstrings, `ConstantInfo` patterns `.axiomInfo`/`.opaqueInfo`, log messages | the audit tool itself |
| `Audit/README.md:11,16,36` | documentation | excluded directory |

No `admit`, `native_decide`, `implemented_by`, `extern`, `unsafe`, `maxHeartbeats`,
`debug.skipKernelTC`, `Lean.ofReduceBool` or `opaque` declaration anywhere in `Core`/`Frozen`.
The only `set_option`s are `set_option linter.unusedVariables false in` at
`Core/PaperA/Transfer/BetaForm.lean:235` (target closure) and
`Core/PaperA/Provider/CanonicalFourierBound.lean:42` (not in closure): linter-only.
No `macro`, `elab`, `syntax`, `notation`, `instance`, `run_cmd`, `#eval` or `initialize` in
`Core`/`Frozen`. Two `attribute [local instance] Matrix.linftyOpNormedRing
Matrix.linftyOpNormedAlgebra` (BetaForm L138, ExpForm L16) are section-local and only used inside
proofs; the statements that leave those sections are consumed against the default-instance
`transferMatrix`, and the kernel accepted the result (section 6).

## 6. Axioms and kernel

### `#print axioms` (scratch `lean/.lake/scratch/audit2/Check.lean`, exit 0)

```
'QEDCore.PaperA.positivity_and_transfer_annulus' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.Provider.positivity_and_transfer_annulus' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.transferMatrix_annulus' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.re_centeredTrace_pos_of_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.centeredTrace_ne_zero' depends on axioms: [propext, Classical.choice, Quot.sound]
'QEDCore.PaperA.im_centeredTrace' depends on axioms: [propext, Classical.choice, Quot.sound]
```

### Project axiom audit

`lake env lean scripts/Audit/AxiomAudit.lean`: exit 0,
`axiom audit passed: 290 declarations in 30 modules, 116 theorems (1 registered DRAFT_SORRY anchors); axioms used outside them: [Quot.sound, Classical.choice, propext]`.
`lean/.lake/axiom-audit.json`: `passed: true`, `violations: []`, `lean_version: 4.35.0`;
both `QEDCore.PaperA.positivity_and_transfer_annulus` (draft: false) and
`QEDCore.PaperA.Provider.positivity_and_transfer_annulus` (draft: false) list exactly
`[Classical.choice, Quot.sound, propext]`; the only theorem with `sorryAx` was the then-draft
`QEDCore.PaperA.canonical_fourier_bound` (registered `DRAFT_SORRY`). All 25 `Core.PaperA.*`,
`Core.PseudoUnitary` and both `Frozen.PaperA.*` modules are among the audited modules. ABI
SHA-256 of the anchor = manifest `abi_sha256` (section 1).
(This run reflects the tree before the concurrent Lemma 3.2 seal; the target's closure did not
change afterwards.)

### Kernel replay (`leanchecker`, run without a pipe; exit code is the tool's)

Commands, each from `lean/` as
`bash ../scripts/lean-gate.sh lake env leanchecker [--verbose] <Module> > log 2>&1; echo $?`:

| Module | Exit | Output |
|---|---|---|
| `Frozen.PaperA.PositivityAndTransferAnnulus` | 0 | (plain run: no output); `--verbose`: `replaying Frozen.PaperA.PositivityAndTransferAnnulus` |
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
| `Core.PaperA.Fourier.DetProd` | 0 | `replaying …` |
| `Core.PaperA.Fourier.Factorization` | 0 | `replaying …` (not in target closure) |
| `Core.PaperA.Fourier.FourierCoeff` | 0 | `replaying …` (not in target closure) |
| `Core.PaperA.Fourier.TwistKick` | 0 | `replaying …` (not in target closure) |
| `Core.PaperA.Fourier.Bound` | 0 | `replaying …` (concurrent Lemma 3.2 work; not in target closure) |
| `Core.PaperA.Provider.CanonicalFourierBound` | 0 | `replaying …` (Lemma 3.2; not in target closure) |
| `Core.PaperA.Defs.CenteredTrace` | 0 | `replaying …` |
| `Core.PaperA.Defs.DiracOperator` | 0 | `replaying …` |
| `Core.PaperA.Defs.Step` | 0 | `replaying …` |
| `Core.PaperA.Defs.StepFreeTime` | 0 | `replaying …` |
| `Core.PaperA.Defs.StepGenerator` | 0 | `replaying …` |
| `Core.PaperA.Defs.TransferMatrix` | 0 | `replaying …` |
| `Core.PseudoUnitary` | 0 | `replaying …` |

Every module of `Core.PaperA` (as present on disk) and `Core.PseudoUnitary` replayed with exit
code 0; no kernel error. Logs: `lean/.lake/scratch/audit2/lc_frozen.log`, `lc_frozen_v.log`,
`lc_all.log`.

`leanchecker` (non-`--fresh`) re-checks every constant of the named module in the kernel
against the environment of its imports loaded from `.olean` files; Mathlib and core are not
re-checked from scratch. The build itself also kernel-checks every declaration, and no
`debug.skipKernelTC` occurs anywhere.

## 7. Non-vacuity (scratch `lean/.lake/scratch/audit2/Check.lean`, exit 0, no errors)

- Dirac representation: `α₁ = [[0,σ₁],[σ₁,0]]`, `α₂ = [[0,σ₂],[σ₂,0]]`, `α₃ = [[0,σ₃],[σ₃,0]]`,
  `β = diag(1,1,-1,-1)` as explicit `!![…]` matrices over `ℂ`. Proved in Lean (`ext` +
  `fin_cases` + `simp`): `hα_herm`, `hβ_herm`, `hα_sq`, `hβ_sq`, `hα_anti` (all `j ≠ k`),
  `hαβ_anti`; `example : IsDiracClifford αD βD`. Axioms of these proofs: standard three.
- Instance 1: `ι = Fin 1`, `hist1 = [Step.free 1 0 1]`, `mStar = 1`, `b = 1`, `d = 2`:
  `hd1 : 4 * Fintype.card (Fin 1) = 2 * 2`, `hfree1` (`τ = 1 ≥ 0`, `v = 0` Hermitian,
  `1 - 1•1 = 0 ⪰ 0`), `hkick1` (no kicks), `htime1 : Σ freeTime = 1`, and
  `example := positivity_and_transfer_annulus αD βD … 2 hd1 1 1 one_pos one_pos hist1 hfree1 hkick1 htime1`
  elaborates: every hypothesis of the anchor holds simultaneously.
- Instance 2 (stronger): `hist2 = [Step.kick 1, Step.free 1 (fun _ => 1) (2 • 1)]` (a nontrivial
  kick, nonzero spatial coefficients, `M - 1 = 1 ⪰ 0`): all hypotheses proved and the theorem
  applied likewise.
- The anchor is therefore not vacuously true; `d` is forced to `2 |ι|` by `hd`.

**NON_VACUITY: PASS.**

## 8. Concerns and observations (none blocking)

1. Concurrent edits by another session (Lemma 3.2 seal) happened during the audit; the target's
   closure was unchanged relative to `HEAD` and is pinned by the hashes in section 0. The axiom
   audit JSON reflects the pre-seal state of Lemma 3.2; it does not affect this target.
2. `leanchecker` was run in its default (non-`--fresh`) mode, which trusts the imported Mathlib
   `.olean`s; a `--fresh` replay of the whole closure was not run (cost).
3. Two helpers carry unused, documented premises (`0 ≤ σ` in `Step.IsAdmissible.deform`;
   `hP`, `hPP` in `betaForm_exp_lt`). They only strengthen the helpers' hypotheses and are
   discharged at every use.
4. The lakefile docstring at `HEAD` says nothing in `Core` imports `Frozen`; Lemma 3.2's provider
   now imports the sealed Lemma 3.1 (the working-tree lakefile docstring has been updated to say
   so). Documentation only.
5. Lint noise only: unused simp arguments, auto-included unused section variables.

## Verdicts

CONSUMPTION: PASS
PREMISE_DISCHARGE: PASS
AXIOMS_AND_KERNEL: PASS
NON_VACUITY: PASS
AUDIT_VERDICT: PASS
