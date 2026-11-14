# Seal audit 2 of the four proof steps of Theorem 4.1 (T3-T6)

- **Targets** (manifest `lean/frozen-manifest.json`, all `SEALED`):

  | Id | Anchor export | Provider | Source |
  |---|---|---|---|
  | `main_twisted_integrand_v1` (T3) | `QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound` | `Core.PaperA.Provider.WilsonTwistedTraceBound` | comparison.tex L54-L91 |
  | `rem_nonneg_mass_v1` (T4) | `QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass` | `Core.PaperA.Provider.CenteredTraceNonneg` | transfer.tex L89-L91 |
  | `eq_mass_bound_v1` (T5) | `QEDCore.PaperA.wilson_mass_bound` | `Core.PaperA.Provider.WilsonMassBound` | model.tex L39-L46 |
  | `gauge_covariance_v1` (T6) | `QEDCore.PaperA.wilson_gauge_covariance` | `Core.PaperA.Provider.WilsonGaugeCovariance` | model.tex L64-L71 |

  Each provider theorem is `QEDCore.PaperA.Provider.<same name>`.
- **Auditor:** seal auditor 2, independent and refute-first; did not write any of the audited
  code; did not coordinate with auditor 1. Date 2026-11-14.
- **Emphasis:** proof consumption and hypothesis hygiene (does each provider prove the frozen
  statement from the intended predecessors, with no hard step entering as an explicit, implicit,
  instance or bundled hypothesis, and is every conditional premise of every internal helper
  discharged where it is applied). Statement fidelity and byte-level seal integrity are auditor
  1's emphasis; they are touched here only where a cast, `let` or helper could change what is
  proved.
- **Commit:** `939f4ee` ("Prove and seal the four proof steps of Theorem 4.1 (T3-T6, step 4 wave
  3)"), branch `main`, unchanged during the audit. The working tree had uncommitted edits only in
  `docs/history/` and `drafts/` (not in `lean/`, `scripts/` or `paper-a/`).
- **Environment:** Windows 11, Git Bash; Lean v4.35.0 (`lean-toolchain`
  `leanprover/lean4:v4.35.0`), Mathlib v4.35.0; Python 3.12.10 with numpy 2.5.4, scipy 1.18.1,
  mpmath 1.3.0 (numerics only). Every Lean/Lake command ran from `lean/` through
  `bash ../scripts/lean-gate.sh`, one at a time (some waited for a slot held by the other auditor).
  No `lake build` of the project, `lake update` or `lake clean`; the only Lake build invocations
  were `lake build --no-build <one Frozen module>` (a freshness check that builds nothing).
- **Scratch policy:** scratch files only in `lean/.lake/scratch/audit2/thm_steps/`
  (`Consume.lean`, `Probe2.lean`, `Probe3.lean`, `numeric.py` and their logs), deleted at the end
  of the audit; the older files already present in `lean/.lake/scratch/audit2/` (from a previous
  audit of 2026-11-12) were not touched. No tracked file was edited except this report; no
  state-changing git command was run.

## 0. Audited state

SHA-256 of the audited Lean files; each equals its blob at `HEAD = 939f4ee`:

| File | SHA-256 |
|---|---|
| `lean/Frozen/PaperA/WilsonTwistedTraceBound.lean` | `15252d7d35aff7db209cd7d99ed6a8869ec030c42ab5155d0992ca9894a583aa` |
| `lean/Frozen/PaperA/CenteredTraceNonneg.lean` | `2588f1d2bce2a88a8ce6930990b90e4798dc1901b18753c8b0db8f2a32239c7a` |
| `lean/Frozen/PaperA/WilsonMassBound.lean` | `c3d38297b45632ac959abbfb95a180ada55f57a1d6186f80d8aa49779b1b16fd` |
| `lean/Frozen/PaperA/WilsonGaugeCovariance.lean` | `73f4526b45afe33a1a5222bb9c34b2ddc9e0cfa932e2384d8353a61ba00066fb` |
| `lean/Core/PaperA/Provider/WilsonTwistedTraceBound.lean` | `edf753a2d73e1e88c559192f8962a1b8dba0842b5b8a36852453dc33dde942c6` |
| `lean/Core/PaperA/Provider/CenteredTraceNonneg.lean` | `1c8d190799791aee4ae71dc5e3bf5dc17c39a71e3b034fe4f46a393f9b55fbc2` |
| `lean/Core/PaperA/Provider/WilsonMassBound.lean` | `271fa85d4f6732cee07f196586c545965923f84e00d7d66f27d08dbccba7f4e8` |
| `lean/Core/PaperA/Provider/WilsonGaugeCovariance.lean` | `fd55f8c22ecf3b05a2eb36f1fe168b5702cecd799ea25d7f9ac11bfec094c3af` |
| `lean/Core/PaperA/Wilson/Shift.lean` | `64c00c0b2deafc6cdbafa87c80fd004c7cd312ccbae59924535b7f2408143519` |
| `lean/Core/PaperA/Wilson/MassBound.lean` | `f71fb3aa45ae63b1606c0ed724982e41502366fa186f7ca0d2d86cd32477ecfe` |
| `lean/Core/PaperA/Wilson/GaugeCovariance.lean` | `d3159ad7afbd4680897003e43076198a876d746d72efbcd54c99e5dee0aef3a1` |
| `lean/Core/PaperA/Wilson/TwistSplit.lean` | `14199b115b074228b06d31d63330a49bfc8392feb9f74ada19c54577bfc35eeb` |
| `lean/Core/PaperA/Transfer/NonnegMass.lean` | `42ad2a428fc0c2b21889ce3f550b7a0a177b3d1e14d485c35d8c39be174925f7` |
| `lean/Core/PaperA/Defs/LatticeShift.lean` | `463f6cc0139c53351263f08752b018c3e0454dbede475e72f80331493722aa67` |
| `lean/Core/PaperA/Defs/WilsonHopping.lean` | `c1e00e4976e3dd67ffc29ecea0432ea868392ad1bea9a0ea8a802f8ebc328e32` |
| `lean/Core/PaperA/Defs/WilsonMass.lean` | `6255fe3f51c8339b950ea578d673d4701d98fdabe3aab6a2c1829035fddaafb4` |
| `lean/frozen-manifest.json` | `3963096ef6449a8280d5179482d5b706a707c0d03c88b44dbef5854ad3e1cc30` (= `FROZEN_MANIFEST` of `docs/graph/DEPGRAPH.md`) |

Predecessor closure: `git diff --stat 422b189 939f4ee -- lean/` touches no module of the Lemma
3.1 / 3.2 closure (`Core/PaperA/{Transfer,Fourier}/*` other than the new `Transfer/NonnegMass.lean`,
`Core/PseudoUnitary.lean`, `Core/Coefficients.lean`, the six older `Defs`, the two older providers
and anchors). `Fourier/TwistKick.lean`, `Frozen/PaperA/PositivityAndTransferAnnulus.lean` and
`Frozen/PaperA/CanonicalFourierBound.lean` hash to the values recorded in
`LEM_FOURIER_AUDIT_2.md`, so the seal audits of Lemmas 3.1 and 3.2 carry over unchanged.

Freshness of the compiled objects: `lake build --no-build Frozen.PaperA.<X>` for each of the four
anchors exited 0 with `All targets up-to-date` (3698, 3655, 2264, 2004 jobs), so the `.olean`
files that the probes and the kernel replay read match the sources above; the logs contain no
`sorry` and no error (only module-system notices and the old unused-`simp`-argument lints of
`Transfer/DiracAlgebra.lean`). The landing axiom audit `lean/.lake/axiom-audit.json` (read only,
not rerun) has `passed: true`, `violations: []`, `draft_exports: []`, 390 declarations, and its
elaborated ABI of each of the six Paper A theorem anchors hashes to the manifest `abi_sha256`
(6/6).

Method. `Consume.lean` and `Probe2.lean` import the four `Frozen.PaperA.*` modules and inspect the
environment with `run_cmd`: Expr equality of anchor and provider types, the anchor proof terms,
the constants used directly by each provider proof (`Expr.getUsedConstants`), the transitive
project closure of each provider (`getUsedConstantsAsSet`, including `_private` helpers, with the
sealed anchors not expanded), the binders of each provider proof that do not occur in its body
(`lambdaTelescope` + `containsFVar`, also counting occurrences in later binder types), every
instance binder in the closure, and every definition in the closure. `Probe3.lean` lists every
declaration of the 13 new modules with its kind and any choice-like constant in its value.

## 1. T3 `wilson_twisted_trace_pos_and_fourier_bound` (`main_twisted_integrand_v1`)

**Anchor.** `#print` shows
`fun {n} [NeZero n] hn α β hα_herm … htime ϑ Q hQ => Provider.wilson_twisted_trace_pos_and_fourier_bound hn α β … ϑ Q hQ`:
all 25 binders, once each, in order; the proof term's only theorem constant is the provider.
Anchor type `==` provider type as `Expr` (`true`; level parameters `[]` / `[]`).

**Consumption.** Constants used directly by the provider proof (20 in `QEDCore`):
`centeredTrace, Step, Step.free, Step.kick, Step.freeTime, transferMatrix, wilsonHopping, wilsonMass,
four_mul_card_fin_three_zmod, isHermitian_wilsonHopping, posSemidef_wilsonMass_sub,
positivity_and_transfer_annulus, canonical_fourier_bound, free_mem_map_append_kick,
kick_mem_map_append_kick, isHermitian_diagonal_ofReal, freeTime_sum_map_free_append_kick,
abs_le_natCast_two_mul_pow_three, centeredTrace_free_append_diagonal_add_eq,
choose_two_mul_two_mul_pow_three` (all `QEDCore.PaperA.*`). Lemmas 3.1 and 3.2 are reached as
`QEDCore.PaperA.positivity_and_transfer_annulus` (module `Frozen.PaperA.PositivityAndTransferAnnulus`)
and `QEDCore.PaperA.canonical_fourier_bound` (module `Frozen.PaperA.CanonicalFourierBound`), the
SEALED anchors; no `QEDCore.PaperA.Provider.*` constant occurs in the proof term. Transitive
closure with the sealed anchors not expanded: 56 project constants in 15 modules (`Defs` ×9,
`Wilson.Shift`, `Wilson.TwistSplit`, `Fourier.TwistKick`, the two sealed anchor modules, the
provider); sealed anchors reached: exactly those two; other `Provider.*` reached: none; private
helpers: `Wilson.Shift.two_sub_eq` (and its `abel` auxiliary).

| Graph node (closure of `thm:main#twisted-integrand`) | Discharged by |
|---|---|
| `thm:main#twisted-integrand` (root) | `Provider.wilson_twisted_trace_pos_and_fourier_bound`; anchor body as above |
| `thm:main#apply-transfer` | sealed `positivity_and_transfer_annulus` applied, for each `φ`, to `links.map (free) ++ [kick (diag (ϑ + φ))]` with `d = 2n³`, `mStar = m`; conjunct `.1` (provider L85-L93) |
| `thm:main#apply-fourier` | sealed `canonical_fourier_bound` applied to `links.map (free) ++ [kick (diag ϑ)]` with `d = 2n³`, `mStar = m`, `q = Q` (L94-L102); `binom(2·(2n³), 2n³ + Q.natAbs)` rewritten to `binom(4n³, …)` by `choose_two_mul_two_mul_pow_three` (L107); `exact H32` (L108) |
| `thm:main#twist-split` | `centeredTrace_free_append_diagonal_add_eq` (L104) ← `centeredTrace_append_diagonal_add` ← `diagonal_ofReal_add_eq` (`diag(ϑ+φ) = diag ϑ + φ•1`) and `centeredTrace_append_kick_add_smul_one` ← `transferMatrix_append_kick` (`Fourier/TwistKick`, audited), `exp_I_smul_kron_add_smul_one` (`Matrix.exp_add_of_commute`, `φ•1` central), `Step.generator_kick_add` (generators add, centering factors multiply) |
| `thm:main#wilson-history` | `hd := four_mul_card_fin_three_zmod n` (← `card_fin_three_zmod`, `4·n³ = 2·(2n³)`); `hl` (L80-L83); `free_mem_map_append_kick` (← `exists_mem_of_free_mem_map_append_kick`); `kick_mem_map_append_kick` (← `eq_of_kick_mem_map_append_kick`); `isHermitian_diagonal_ofReal`; `freeTime_sum_map_free_append_kick` |
| `thm:main#wilson-hopping-hermitian` | `isHermitian_wilsonHopping` (`Wilson/Shift`, any real `a`, any `U`) |
| `eq:mass-bound#mass-lower-bound` | `posSemidef_wilsonMass_sub` (`Wilson/Shift`) ← private `two_sub_eq` (`2 - T - Tᴴ = (1 - T)ᴴ(1 - T)`), `posSemidef_conjTranspose_mul_self`, `posSemidef_sum`, `PosSemidef.smul` with `r/(2a) ≥ 0`. T5's helper, not the T5 anchor, as the graph's route (`thm:main#wilson-history` → `#mass-lower-bound`) and TASKS.md Wave 3 prescribe |
| `eq:mass-bound#shift-unitary` | `latticeShift_conjTranspose_mul_self` (used by `two_sub_eq`) |
| `thm:main#integrand-centered-trace` | definitional under R8: the frozen `F` is the centered trace of the twisted history; no Lean obligation. Its dependency `lem:transfer#trace-h-zero` is therefore not needed here (it is also inside the sealed Lemma 3.1) |
| `lem:transfer`, `lem:fourier` | the sealed, audited anchors (`LEM_TRANSFER_AUDIT_1/2.md`, `LEM_FOURIER_AUDIT_1/2.md`); their sub-nodes are not re-mapped |
| `def:centered-trace`, `def:transfer-matrix`, `def:step-generator`, `def:step-free-time`, `def:history-step`, `def:dirac-operator`, `def:lattice-shift`, `def:wilson-hopping`, `def:wilson-mass` | the frozen definitions `centeredTrace`, `transferMatrix`, `Step.generator`, `Step.freeTime`, `Step`, `diracOperator`, `latticeShift`, `wilsonHopping`, `wilsonMass`; used as frozen, never redefined |

**Hypothesis hygiene.** Every helper premise with content and where it is discharged (provider
line numbers):

| Helper | Premise | Discharged at | By |
|---|---|---|---|
| `positivity_and_transfer_annulus` (sealed) | `hα_herm, hβ_herm, hα_sq, hβ_sq, hα_anti, hαβ_anti` | L86-L87 | the frozen binders, verbatim |
| | `hd : 4·card X = 2·d` | L87 | `four_mul_card_fin_three_zmod n` (proved: `Fintype.card_fun`, `ZMod.card`) |
| | `hm : 0 < mStar`, `hb : 0 < b` | L87 | frozen `hm`, `hb` (`mStar := m`) |
| | `hfree` | L90 | `free_mem_map_append_kick _ hl` |
| | `hkick` | L91-L92 | `kick_mem_map_append_kick (isHermitian_diagonal_ofReal fun x => ϑ x + φ)` |
| | `htime` | L93 | `(freeTime_sum_map_free_append_kick _ _ _ _).trans htime` (frozen `htime`) |
| `canonical_fourier_bound` (sealed) | the same 17 premises | L95-L101 | as above, kick `diag ϑ` (`isHermitian_diagonal_ofReal ϑ`) |
| | `hq : abs q ≤ (d : ℤ)` | L102 | `abs_le_natCast_two_mul_pow_three hQ` (frozen `hQ`; `((2n³ : ℕ) : ℤ) = 2·(n : ℤ)³` by `push_cast; ring`) |
| `free_mem_map_append_kick` | `hlinks : ∀ p ∈ links, 0 ≤ p.1 ∧ (∀ j, (v p.2 j) Hermitian) ∧ (M p.2 - mStar•1) ⪰ 0` | L90, L99 | `hl` (L80-L83): `(hlinks p hp).1`; `isHermitian_wilsonHopping a p.2`; `posSemidef_wilsonMass_sub a m r ha hr p.2 (hlinks p hp).2`. `mStar` is implicit and fixed to `m` by the type of `hl` |
| `kick_mem_map_append_kick` | `hΘ : Θ Hermitian` | L91-L92, L100 | `isHermitian_diagonal_ofReal` (no premise; real diagonal) |
| `posSemidef_wilsonMass_sub` | `ha : 0 < a`, `hr : 0 ≤ r`, `hU : ∀ x j, ‖U x j‖ = 1` | L83 | frozen `ha`, `hr`; `(hlinks p hp).2` |
| `two_sub_eq` (private), `latticeShift_conjTranspose_mul_self` | `hU` | inside `posSemidef_wilsonMass_sub` | the `hU` above (`conj(U)·U = 1` from `Complex.conj_mul'` and `‖U‖ = 1`) |
| `centeredTrace_free_append_diagonal_add_eq` | none (an identity for every history and `ϑ`) | L104 | — |
| `isHermitian_wilsonHopping`, `freeTime_sum_map_free_append_kick`, `choose_two_mul_two_mul_pow_three`, `four_mul_card_fin_three_zmod` | none (`[NeZero n]` instance only) | — | — |

No binder beyond the frozen statement's (types `Expr`-equal). The only instance binder is the
frozen `[NeZero n]`. No helper uses a choice-like constant in its value (`Probe3`), and no
definition is introduced by the T3 route.

**Unused frozen binders.** `hn : 3 ≤ n` only (the provider docstring says so; the option
`linter.unusedVariables false` silences the lint). `hQ` is used, but only to supply Lemma 3.2's
`hq`, which the Lemma 3.2 provider does not use, so the bound in fact holds for every integer `Q`
(for `abs Q > 2n³` the binomial is 0 and `F_Q = 0`; numerically `abs F_{2N+1} / F_0 ≈ 7e-15`).
Both agree with `STATEMENT_AUDIT_A.md` ("`hn`, `NeZero n` and `hQ` are not needed for truth") and
`STATEMENT_AUDIT_B.md`; the source's conclusion does not need `n ≥ 3`, so no unused premise
signals a vacuous or mis-stated conclusion.

**Soundness spot checks.**

- *`let` binders.* The elaborated frozen type stores `F` and `Fhat` as non-dependent `let`s
  (`letE … nondep := true`, printed as `have`), exactly as in the sealed Lemma 3.2. The kernel
  zeta-reduces them either way. To rule out any opaque reading, `Probe2.lean` states T3's
  conclusion with `F` and `Fhat` written out in full (no `let`) and proves it by the term
  `wilson_twisted_trace_pos_and_fourier_bound hn α β … ϑ Q hQ`: it elaborates (exit 0), so the
  sealed theorem asserts the inlined statement by definitional unfolding.
- *No junk integral.* `Probe2.lean` proves, for every finite `ι`, history, `ϑ : ι → ℝ` and
  `p : ℤ`, that `φ ↦ centeredTrace α β (hist ++ [kick (diag (ϑ + φ))])` is continuous and that
  `φ ↦ exp(-(p φ i)) · F φ` is `IntervalIntegrable` on `[0, 2π]` (axioms `propext`,
  `Classical.choice`, `Quot.sound`). So `Fhat p` is a genuine interval integral, never the junk
  value 0 of a non-integrable function, and conjuncts 2-3 are not trivially `0 = 0`, `0 ≤ 0`.
- *Casts* (`#check` with `pp.coercions false`, `pp.numericTypes true`): the kick is
  `diagonal fun x => Complex.ofReal (ϑ x + φ)` (sum in ℝ, then cast); the phase is
  `Complex.exp (-(p.cast * Complex.ofReal φ * Complex.I))` with `p.cast : ℤ → ℂ` directly; the
  prefactor is `(2 * Complex.ofReal Real.pi)⁻¹`; `hQ` is `abs Q ≤ 2 * n.cast ^ 3` in ℤ (`ℕ → ℤ`
  cast of `n`, no ℕ subtraction); the binomial is
  `((4 * n ^ 3).choose (2 * n ^ 3 + Q.natAbs)).cast` (ℕ, then `ℕ → ℝ`); the exponent is
  `Real.exp (-(b * m * abs Q.cast))` with `Q.cast : ℝ`. After `simp only [Fhat, hF]` and the
  binomial rewrite (`2 * (2 * n ^ 3) = 4 * n ^ 3` in ℕ, `rw [← mul_assoc]; norm_num`), the goal is
  Lemma 3.2's conclusion at `d = 2n³`, `mStar = m`, `q = Q` up to definitional unfolding, closed by
  `exact H32`; no coercion differs.
- *Positivity conjunct.* Proved for every `φ` from Lemma 3.1 at the history whose kick is
  `diag (ϑ + φ)`, the same history as in `F φ`; it is not derived from the Fourier part.
- *Numerics* (`numeric.py`, literal transcription of the frozen definitions; `n = 3`, `D = 108`,
  random unit links, random `ϑ`, 256-point grid, exact for these trigonometric polynomials): for
  (a, m, r, b) = (1, 0.4, 1, 1) and (0.7, 0.05, 0.5, 0.2): `min Re F / abs F = 1.000000`,
  `max abs(Im F) / abs F ≤ 9e-14`, `Im F_0 / abs F_0 ≤ 3.4e-15`,
  `max_{abs Q ≤ 54} abs F_Q / bound = 1.7e-5` resp. `1.1e-14`, and `abs F_{±1}`, `abs F_2` of
  the same order as `F_0`; a direct literal evaluation of the centered trace at `φ = 0.7` agrees
  with the fast evaluation exactly. The conclusion is informative and holds.

**Axioms.** `wilson_twisted_trace_pos_and_fourier_bound`, its provider, and the helpers
`centeredTrace_free_append_diagonal_add_eq`, `centeredTrace_append_kick_add_smul_one`,
`exp_I_smul_kron_add_smul_one`, `free_mem_map_append_kick`, `kick_mem_map_append_kick`,
`freeTime_sum_map_free_append_kick`, `four_mul_card_fin_three_zmod`,
`isHermitian_diagonal_ofReal`, `isHermitian_wilsonHopping`, `posSemidef_wilsonMass_sub`,
`latticeShift_conjTranspose_mul_self`: `[propext, Classical.choice, Quot.sound]`;
`abs_le_natCast_two_mul_pow_three`, `choose_two_mul_two_mul_pow_three`: `[propext]`. The sealed
`positivity_and_transfer_annulus` and `canonical_fourier_bound`: `[propext, Classical.choice,
Quot.sound]`.

**Kernel.** `leanchecker` exit 0 for `Frozen.PaperA.WilsonTwistedTraceBound`,
`Core.PaperA.Provider.WilsonTwistedTraceBound`, `Core.PaperA.Wilson.TwistSplit`,
`Core.PaperA.Wilson.Shift` (section 6).

**Findings.**

- T3-N1 (NOTE). The frozen `let F`, `let Fhat` (T3 and Lemma 3.2) are elaborated as
  non-dependent `let`s and print as `have`. Harmless: the anchor proves the `let`-free statement
  (above). Recorded so that a reader of `#check` output does not take `F` for an opaque function.
- T3-N2 (NOTE). `hn` is unused and `hQ` is only transitively needed (not needed for truth), as the
  statement audits found.
- T3-N3 (NOTE). The graph node `thm:main#integrand-centered-trace` (and through it
  `lem:transfer#trace-h-zero`) has no Lean counterpart: it is definitional under R8.

## 2. T4 `centeredTrace_nonneg_of_posSemidef_mass` (`rem_nonneg_mass_v1`)

**Anchor.** `fun {ι} [Fintype ι] [DecidableEq ι] α β hα_herm … hist hfree hkick htime => Provider.centeredTrace_nonneg_of_posSemidef_mass α β … htime`:
all 17 binders, in order; only theorem constant the provider. Types `Expr`-equal; level
parameters `[u_1]` / `[u_1]`.

**Consumption.** Direct `QEDCore` constants (12): `Step, Step.free, Step.kick, Step.freeTime,
centeredTrace, transferMatrix, Step.shiftMass, centeredTrace_nonneg_of_shiftMass,
positivity_and_transfer_annulus, mem_of_free_mem_map_shiftMass, mem_of_kick_mem_map_shiftMass,
sum_freeTime_map_shiftMass`. Lemma 3.1 is reached as the sealed
`QEDCore.PaperA.positivity_and_transfer_annulus` only; no `Provider.*` constant. Transitive
closure (sealed anchor not expanded): 43 project constants in 11 modules (`Defs` ×6,
`Transfer.NonnegMass`, `Transfer.History` for `transferMatrix_nil/cons`, `Transfer.Homotopy` for
the auto-generated `centeredTrace.congr_simp`, the sealed Lemma 3.1 module, the provider); private
helpers: `continuous_transferMatrix_shiftMass`, `continuous_generator_shiftMass`,
`continuous_matrix_exp_of_shiftMass`, `continuous_sum_trace_shiftMass`.

| Graph node (closure of `rem:nonneg-mass`) | Discharged by |
|---|---|
| `rem:nonneg-mass` (root) | `Provider.centeredTrace_nonneg_of_posSemidef_mass` |
| `rem:nonneg-mass#apply-transfer` | sealed `positivity_and_transfer_annulus` at the history `hist.map (Step.shiftMass ε)`, `d = 2·card ι`, `mStar = ε`, for every `ε > 0` (provider L57-L62), using `mem_of_free_mem_map_shiftMass`, `mem_of_kick_mem_map_shiftMass`, `sum_freeTime_map_shiftMass`; only conjunct 1 is used |
| `rem:nonneg-mass#continuity` | `centeredTrace_nonneg_of_shiftMass` (L55): the set of `z` with `Im z = 0 ∧ 0 ≤ Re z` is closed, `ε ↦ F_ε` continuous (`continuous_centeredTrace_shiftMass` ← the four private lemmas and `Step.generator_shiftMass`), `F_0 = F` (`map_shiftMass_zero` ← `Step.shiftMass_zero`), limit along `nhdsWithin 0 (Ioi 0)` |
| `lem:transfer` | the sealed, audited anchor |
| `def:centered-trace`, `def:transfer-matrix`, `def:step-generator`, `def:step-free-time`, `def:history-step`, `def:dirac-operator` | the frozen definitions; the new definition `Step.shiftMass` (`free τ v M ↦ free τ v (M + (ε:ℂ)•1)`, kicks unchanged; plain pattern match) occurs only inside the proof, not in the statement |

**Hypothesis hygiene.**

| Helper | Premise | Discharged at | By |
|---|---|---|---|
| `centeredTrace_nonneg_of_shiftMass` | `hpos : ∀ ε > 0, Im F_ε = 0 ∧ 0 ≤ Re F_ε` | L55-L63 | `fun ε hε => …`: conjunct 1 `⟨hre, him⟩` of the sealed Lemma 3.1 at `mStar = ε`, returned as `⟨him, hre.le⟩` |
| `positivity_and_transfer_annulus` (sealed) | Clifford premises ×6 | L58-L59 | frozen binders, verbatim |
| | `hd` | L59 | `d := 2 * Fintype.card ι`, `by ring` |
| | `hm : 0 < mStar`, `hb` | L59 | `hε`; frozen `hb` |
| | `hfree` (with `(M - (ε:ℂ)•1) ⪰ 0`) | L60 | `fun τ v M h => hfree τ v _ (mem_of_free_mem_map_shiftMass h)`: the frozen `hfree` applied to the original step `free τ v (M - ε•1) ∈ hist`, whose mass `M - ε•1` is exactly the matrix Lemma 3.1 asks about |
| | `hkick` | L61 | `fun Θ h => hkick Θ (mem_of_kick_mem_map_shiftMass h)` (frozen `hkick`) |
| | `htime` | L62 | `by rw [sum_freeTime_map_shiftMass, htime]` |
| `mem_of_free_mem_map_shiftMass`, `mem_of_kick_mem_map_shiftMass` | `h` (membership in the shifted history) | L60, L61 | the membership argument Lemma 3.1 supplies to `hfree`/`hkick` |
| `continuous_matrix_exp_of_shiftMass` (private) | none; passes Mathlib's `Matrix.linftyOpNormedRing`, `linftyOpNormedAlgebra` explicitly to `NormedSpace.exp_continuous` | inside `continuous_transferMatrix_shiftMass` | its stated type uses the default matrix topology and the kernel accepts the definitional match (same device as in the audited Lemma 3.1 closure); no content |

No binder beyond the frozen statement's; instance binders `[Fintype ι] [DecidableEq ι]` (frozen).

**Unused frozen binders.** None: all 17 binders occur in the proof. `hb` is used only to supply
Lemma 3.1's premise; the remark is true without it (`STATEMENT_AUDIT_A.md` row 13; R7 keeps it).

**Soundness spot checks.** The conclusion is the non-strict `0 ≤ Re F` with `Im F = 0`; the
limit step uses the shift `M ↦ M + ε I` with `F_0 = F` literally (`(0:ℂ)•1` added), so the
nonnegativity is about the given history, not a shifted one. Numerics: two runs of 200 (seed
20261114) and 300 (seed 7; 278 kept) random histories, draws with `b = 0` skipped
(`card ι ∈ {1,2,3}`, rank-one, hence
singular, PSD masses, Hermitian `v_j` and kicks, Dirac matrices) give `min Re F / abs F = 1.0000`;
the float64 `abs(Im F) / abs F` reached 6e-5 (first run) and 4.3e-6 (second run), only for
`abs F ~ 1e28-1e30`, and a 60-digit `mpmath` recomputation of the second run's worst history gives
`Im F / abs F = 8e-52`, so these are rounding errors.

**Axioms.** Anchor, provider, `centeredTrace_nonneg_of_shiftMass`,
`continuous_centeredTrace_shiftMass`, `mem_of_free_mem_map_shiftMass`,
`mem_of_kick_mem_map_shiftMass`, `sum_freeTime_map_shiftMass`: `[propext, Classical.choice,
Quot.sound]`.

**Kernel.** `leanchecker` exit 0 for `Frozen.PaperA.CenteredTraceNonneg`,
`Core.PaperA.Provider.CenteredTraceNonneg`, `Core.PaperA.Transfer.NonnegMass` (section 6).

**Findings.**

- T4-N1 (NOTE). The continuity proof supplies a non-canonical normed-ring structure explicitly to
  one Mathlib lemma; it carries no hypothesis and the result is stated for the standard topology.

## 3. T5 `wilson_mass_bound` (`eq_mass_bound_v1`)

**Anchor.** `fun {n} [NeZero n] hn α β … U hU => Provider.wilson_mass_bound hn α β … U hU`: all 19
binders, in order. Types `Expr`-equal; level parameters `[]`.

**Consumption.** Direct `QEDCore` constants (7): `diracOperator, wilsonHopping, wilsonMass,
latticeShift, posSemidef_bound_add_smul_diracOperator, latticeShift_conjTranspose_mul_self,
posSemidef_wilsonMass_sub`. Closure: 22 project constants in 7 modules (`Defs.{DiracOperator,
LatticeShift, WilsonHopping, WilsonMass}`, `Wilson.Shift`, `Wilson.MassBound`, the provider); no
anchor, no other provider; private: `two_sub_eq`.

| Graph node (closure of `eq:mass-bound`) | Discharged by |
|---|---|
| `eq:mass-bound` (root) | `Provider.wilson_mass_bound` |
| `eq:mass-bound#mass-lower-bound` | conjunct 1: `posSemidef_wilsonMass_sub a m r ha hr U hU` (L66) |
| `eq:mass-bound#norm-bound` | conjuncts 2-3: `posSemidef_bound_add_smul_diracOperator` at `s = -1` and `s = 1` (L60-L70) ← `posSemidef_hopping` (`W = -i T_j ⊗ α_j`, weight `1/a` each), `posSemidef_mass_const` (`W = 1 ⊗ β`, weight `m`), `posSemidef_wilson_term` (`W = 1 ⊗ β` and `T_j ⊗ β`, weight `4 · r/(2a)` each) ← `posSemidef_two_smul_one_add_real_smul` ← `posSemidef_two_smul_one_add_self_add_conjTranspose` (`2 + W + Wᴴ = (1 + W)ᴴ(1 + W)`); `inv_two_mul_I_mul_ofReal`, `matrix_sub_kronecker`; total `m + 3/a + 12 r/(2a) = m + (3 + 6r)/a` (`hcst`) |
| `eq:mass-bound#shift-unitary` | `latticeShift_conjTranspose_mul_self` (both conjunct routes); `latticeShift_mul_conjTranspose_self` (`T Tᴴ = 1`) is proved but used by no provider |
| `thm:main#wilson-hopping-hermitian`, `lem:transfer#dirac-hermitian` | not invoked as lemmas: the graph needs them only so that the two-sided form equals the norm bound; Mathlib's `PosSemidef` includes `IsHermitian`, and the sum-of-squares route proves `h_*·1 ∓ h_W ⪰ 0` (hence `h_W` Hermitian) directly |
| `def:dirac-operator`, `def:wilson-hopping`, `def:wilson-mass`, `def:lattice-shift` | frozen definitions; their bodies enter through `hv`, `hM` (`rfl`) |

**Hypothesis hygiene.**

| Helper | Premise | Discharged at | By |
|---|---|---|---|
| `posSemidef_bound_add_smul_diracOperator` | `hα_herm, hβ_herm, hα_sq, hβ_sq` | provider L63 | frozen binders |
| | `ha, hm, hr` | L64 | frozen binders |
| | `hT : ∀ j, (T j)ᴴ * T j = 1` | L64 | `latticeShift_conjTranspose_mul_self U hU` (proved from frozen `hU`) |
| | `hv : ∀ j, v j = (2 i a)⁻¹ • (T j - (T j)ᴴ)` | L65 | `fun _ => rfl`: the body of the frozen `wilsonHopping` with `T = latticeShift n U` (kernel-checked definitional equality; not an assumption) |
| | `hM : M = m•1 + (r/(2a))•Σ_j (2•1 - T j - (T j)ᴴ)` | L65 | `rfl`: the body of the frozen `wilsonMass` |
| | `hs : s * s = 1` | L67, L69 | `by norm_num` at `s = -1` and `s = 1`; then `ofReal_neg/one`, `neg_one_smul`, `sub_eq_add_neg` turn `h_*•1 + s•h` into the two frozen conjuncts |
| `posSemidef_hopping` | `hA, hA_sq, ha, hT, hs` | MassBound L156 | `hα_herm j`, `hα_sq j`, `ha`, `hT j`, `hs` |
| `posSemidef_mass_const` | `hβ, hβ_sq, hm, hs` | L157 | `hβ_herm`, `hβ_sq`, `hm`, `hs` |
| `posSemidef_wilson_term` | `hβ, hβ_sq, hT, hs` | L160 | `hβ_herm`, `hβ_sq`, `hT j`, `hs` (and internally `(-s)(-s) = 1` from `hs`) |
| `posSemidef_two_smul_one_add_real_smul` | `hW : Wᴴ W = 1`, `hs` | L91, L110, L131-L132 | `hWW`, `hBB`, `hTT`, each computed from `hT`/`hA_sq`/`hβ_sq` by `mul_kronecker_mul`; `hs`/`hs'` |
| `posSemidef_two_smul_one_add_self_add_conjTranspose` | `hW` | L73 | from `hW`, `conj s = s`, `hs` |
| weights `1/(2a)`, `m/2`, `r/(2a) ≥ 0` | — | L90, L109, L161 | `positivity` from `ha`, `hm`, `hr` |
| `posSemidef_wilsonMass_sub` | `ha, hr, hU` | provider L66 | frozen binders |

**Unused frozen binders.** `hn`, `hα_anti`, `hαβ_anti`. Consistent with
`STATEMENT_AUDIT_T5T6_A.md` (rows 3, 10, 11: "faithful, unused"; numerics with `n = 1, 2` and the
commuting control `α = β = I` hold) and `…_B.md`. The source's bound `‖h_W‖ ≤ m + (3+6r)/a` is a
term-by-term bound that never uses anticommutation, so no needed premise is idle.

**Soundness spot checks.** The constant is `Complex.ofReal (m + (3 + 6 * r) / a)` (real arithmetic,
then cast); `hcst` splits it as `m + 3·(1/a) + 12·(r/(2a))` by `push_cast; ring`, matching the
block weights. The conclusion is `PosSemidef`, which in Mathlib includes `IsHermitian`.
Numerics: random unit links, `(n, a, m, r) = (3, 1, 0.4, 1), (3, 0.5, 0, 2), (4, 1.3, 1, 0)`:
`h_W` Hermitian exactly, `max abs eig(h_W) / h_* = 0.59, 0.69, 0.58`, `min eig(M - m) ≥ 0` (= 0
at `r = 0`); the π-flux configuration at `n = 4`, `m = r = 0`, `a = 1` gives
`max abs eig = 3.000000 = h_*`, so the bound is attained and not vacuous.

**Axioms.** Anchor, provider, `posSemidef_bound_add_smul_diracOperator`, `posSemidef_hopping`,
`posSemidef_mass_const`, `posSemidef_wilson_term`, `posSemidef_two_smul_one_add_real_smul`,
`posSemidef_wilsonMass_sub`, `latticeShift_conjTranspose_mul_self`,
`latticeShift_mul_conjTranspose_self`: `[propext, Classical.choice, Quot.sound]`.

**Kernel.** `leanchecker` exit 0 for `Frozen.PaperA.WilsonMassBound`,
`Core.PaperA.Provider.WilsonMassBound`, `Core.PaperA.Wilson.MassBound`, `Core.PaperA.Wilson.Shift`
(section 6).

**Findings.**

- T5-N1 (NOTE). The graph nodes `thm:main#wilson-hopping-hermitian` and
  `lem:transfer#dirac-hermitian` in the closure of `eq:mass-bound` are discharged implicitly
  (Hermiticity is part of `PosSemidef` of the sum-of-squares expression), not by a call. This is
  the route the provider docstring states; no gap.
- T5-N2 (NOTE). The norm bound is proved by a sum of squares, not by the triangle inequality the
  graph node's NOTE sketches; the constant is the same and TASKS.md (Wave 3) records the route.
  `latticeShift_mul_conjTranspose_self` is unused by every provider.

## 4. T6 `wilson_gauge_covariance` (`gauge_covariance_v1`)

**Anchor.** `fun {n} [NeZero n] hn α β a m r U u hu => Provider.wilson_gauge_covariance hn α β a m r U u hu`:
all 11 binders, in order. Types `Expr`-equal; level parameters `[]`.

**Consumption.** Direct `QEDCore` constants (6): `diracOperator, wilsonHopping, wilsonMass,
wilsonHopping_gauge, wilsonMass_gauge, kronecker_conj_one`. Closure: 13 project constants in 6
modules; no anchor, no other provider; private: `conj_conjTranspose`, `diag_star_mul_diag`.

| Graph node (closure of `model:gauge-covariance`) | Discharged by |
|---|---|
| `model:gauge-covariance` (root) | `Provider.wilson_gauge_covariance` (one `simp only`, L46-L47) |
| `model:gauge-covariance#shift-covariance` | `latticeShift_gauge` (`T_j(U^u) = Dᴴ T_j(U) D`, `D = diag u`; no premise, entrywise) |
| edge `def:wilson-hopping` (`v_j(U^u) = u* v_j u`) | `wilsonHopping_gauge` ← `latticeShift_gauge`, private `conj_conjTranspose` |
| edge `def:wilson-mass` (`M(U^u) = u* M u`, using `u*u = I`) | `wilsonMass_gauge` ← `latticeShift_gauge`, `conj_conjTranspose`, private `diag_star_mul_diag` (`Dᴴ D = 1` from `hu`) |
| edge `def:dirac-operator` (`u` on the spatial factor commutes with `α_j`, `β`) | `kronecker_conj_one` (`(Dᴴ⊗1)(v⊗α)(D⊗1) = (Dᴴ v D)⊗α`, `mul_kronecker_mul`) |
| `def:lattice-shift`, `def:wilson-hopping`, `def:wilson-mass`, `def:dirac-operator` | frozen definitions, unfolded inside the helpers |

**Hypothesis hygiene.**

| Helper | Premise | Discharged at | By |
|---|---|---|---|
| `wilsonMass_gauge` | `hu : ∀ x, ‖u x‖ = 1` | provider L46 | frozen `hu` |
| `diag_star_mul_diag` (private) | `hu` | GaugeCovariance L62 | the `hu` of `wilsonMass_gauge` (`conj(u) u = ‖u‖² = 1`) |
| `latticeShift_gauge`, `wilsonHopping_gauge`, `conj_conjTranspose`, `kronecker_conj_one` | none | — | — |

The `simp only` set is these three helper equations and the linearity lemmas `Matrix.mul_add`,
`Matrix.add_mul`, `Matrix.mul_sum`, `Matrix.sum_mul`; no other hypothesis is used.

**Unused frozen binders.** `hn` only (`STATEMENT_AUDIT_T5T6_B.md` row 3: "not used by the
identity"). The identity holds for any `n`, so nothing the source needs is idle.

**Soundness spot checks.** The statement is an equation between two different matrices: with
arbitrary complex `U` (not unimodular), random non-Clifford `α_j`, `β` and random unit `u` at
`n = 3`, the numerics give `‖LHS − RHS‖ / ‖RHS‖ = 1.2e-16` while `h_W(U^u)` differs from
`h_W(U)` by 59 % (relative Frobenius norm), so the identity is not trivial. The gauge field in the
statement, `fun x j => u x * U x j * star (u (x + Pi.single j 1))`, is syntactically the one in
`latticeShift_gauge`/`wilsonHopping_gauge`/`wilsonMass_gauge`; `u` acts as `diagonal u ⊗ₖ 1`
(spatial factor first).

**Axioms.** Anchor, provider, `latticeShift_gauge`, `wilsonHopping_gauge`, `wilsonMass_gauge`,
`kronecker_conj_one`: `[propext, Classical.choice, Quot.sound]`.

**Kernel.** `leanchecker` exit 0 for `Frozen.PaperA.WilsonGaugeCovariance`,
`Core.PaperA.Provider.WilsonGaugeCovariance`, `Core.PaperA.Wilson.GaugeCovariance` (section 6).

**Findings.** None beyond the unused `hn` (NOTE, consistent with the statement audits).

## 5. Cross-cutting checks

**Instances, definitions, choice.** Over the whole closure of the four providers (299 project
constants, sealed anchors expanded, private helpers included): the instance classes bound anywhere
are `Fintype`, `DecidableEq`, `NeZero` and, in generic algebra lemmas of the audited Lemma 3.1
closure and `simp`-generated auxiliaries, `Monoid`, `StarMul`, `AddCommMonoid`, `CommSemiring`,
`AddGroup`, `DistribSMul`; no `Fact` or other content-carrying class, and no project declaration
is registered as an instance. No `instance` or `attribute [local instance]` occurs in the 13 new
modules. The 32 project definitions in the closure contain no `Classical.*` constant in their
bodies; the only new definition is `Step.shiftMass` (plus its match splitters). `Probe3.lean`
lists the 70 declarations of the 13 new modules (non-private internal details such as `match_1`
excluded): all theorems except `Step.shiftMass` and three auto-generated match splitters; no
`axiom`, no `opaque`. None uses `Classical.choose`,
`Classical.choice`, `Classical.epsilon`, `Exists.choose`, `Nonempty.some`, `Inhabited.default` or
`sorryAx` directly in its value.

**Grep** (`Core/`, `Frozen/`): no `sorry`, `admit`, `axiom`, `native_decide`, `implemented_by`,
`extern`, `unsafe`, `opaque`, `maxHeartbeats`, `skipKernelTC`, `ofReduceBool` in code (hits only in
prose: `Core/CanonicalComparison.lean:30`, and the provider docstrings of T5 and T6 mentioning
the replaced `by sorry`). `set_option` occurrences in the new files: only
`linter.unusedVariables false in` on the T3, T5 and T6 providers (frozen binders kept verbatim).

**Quarantine.** `python -I scripts/check_frozen_anchors.py --root lean --manifest
lean/frozen-manifest.json --allow-non-module` (repo root): `FROZEN-ANCHOR GUARD OK`, exit 0.
The script's provider quarantine applies only to `DRAFT_SORRY` anchors, so for the sealed ones I
recomputed the import graph of all project `.lean` files (outside `.lake`, `vendor`, `tools`):

- Every `Frozen.PaperA.<X>` imports exactly its own provider; no provider module imports another
  provider module directly.
- `Core.PaperA.Provider.WilsonTwistedTraceBound` imports the sealed anchors
  `Frozen.PaperA.PositivityAndTransferAnnulus` and `Frozen.PaperA.CanonicalFourierBound` (and
  through them their providers); `Core.PaperA.Provider.CenteredTraceNonneg` imports the sealed
  `Frozen.PaperA.PositivityAndTransferAnnulus`; the T5 and T6 providers import no frozen anchor.
  This is the permitted pattern (`lean/lakefile.lean`: "A sealed statement may be used by later
  providers"; D12).
- No non-provider `Core` module reaches a `Frozen` or `Provider` module; `Core.lean` imports
  neither. `scripts/Audit/AxiomAudit.lean` imports all anchors (audit tool).
- Name level: in code, a `QEDCore.PaperA.Provider.*` export occurs only in its own anchor's proof
  body (other hits are docstrings); the elaborated provider terms confirm this (sections 1-4).

## 6. Kernel replay

`bash ../scripts/lean-gate.sh lake env leanchecker --verbose <Module>`, from `lean/`, one module per
command, exit code taken directly (no pipe), output in
`lean/.lake/scratch/audit2/thm_steps/lc_<Module>.log`:

| Module | Exit | Output | Wall |
|---|---|---|---|
| `Frozen.PaperA.WilsonTwistedTraceBound` | 0 | `replaying Frozen.PaperA.WilsonTwistedTraceBound` | 30 s |
| `Frozen.PaperA.CenteredTraceNonneg` | 0 | `replaying …` | 33 s |
| `Frozen.PaperA.WilsonMassBound` | 0 | `replaying …` | 27 s |
| `Frozen.PaperA.WilsonGaugeCovariance` | 0 | `replaying …` | 26 s |
| `Core.PaperA.Provider.WilsonTwistedTraceBound` | 0 | `replaying …` | 29 s |
| `Core.PaperA.Provider.CenteredTraceNonneg` | 0 | `replaying …` | 36 s |
| `Core.PaperA.Provider.WilsonMassBound` | 0 | `replaying …` | 30 s |
| `Core.PaperA.Provider.WilsonGaugeCovariance` | 0 | `replaying …` | 29 s |
| `Core.PaperA.Wilson.Shift` | 0 | `replaying …` | 30 s |
| `Core.PaperA.Wilson.MassBound` | 0 | `replaying …` | 31 s |
| `Core.PaperA.Wilson.GaugeCovariance` | 0 | `replaying …` | 29 s |
| `Core.PaperA.Wilson.TwistSplit` | 0 | `replaying …` | 27 s |
| `Core.PaperA.Transfer.NonnegMass` | 0 | `replaying …` | 30 s |
| `Core.PaperA.Defs.LatticeShift` (extra) | 0 | `replaying …` | 27 s |
| `Core.PaperA.Defs.WilsonHopping` (extra) | 0 | `replaying …` | 25 s |
| `Core.PaperA.Defs.WilsonMass` (extra) | 0 | `replaying …` | 25 s |

16 modules (the 13 requested plus the three Wilson definitions), 0 failures, no
"failed to read file" error, so no rerun was needed.

`leanchecker` replays each named module's own declarations through the kernel (imports trusted as
compiled; the Lemma 3.1/3.2 closure was replayed module by module on 2026-11-13 and is unchanged).

## 7. Findings summary

No BLOCKING and no MINOR finding.

| Id | Severity | Finding |
|---|---|---|
| T3-N1 | NOTE | Frozen `let F`, `let Fhat` are non-dependent `let`s (print as `have`); the anchor proves the inlined statement, so the meaning is unaffected |
| T3-N2 | NOTE | `hn` unused; `hQ` used only to feed Lemma 3.2's (itself unused) `hq`: the bound holds for every integer `Q` |
| T3-N3 | NOTE | `thm:main#integrand-centered-trace` (and its dependency `lem:transfer#trace-h-zero`) is definitional under R8; no Lean declaration |
| T4-N1 | NOTE | `continuous_matrix_exp_of_shiftMass` passes Mathlib's `linftyOp` normed structure explicitly to one continuity lemma; no content |
| T5-N1 | NOTE | Hermiticity nodes of the `eq:mass-bound` closure are discharged implicitly by the `PosSemidef` sum of squares |
| T5-N2 | NOTE | Sum-of-squares route instead of the triangle inequality (same constant; recorded in TASKS.md); `latticeShift_mul_conjTranspose_self` is unused by providers; `hn`, `hα_anti`, `hαβ_anti` unused (consistent with the statement audits) |
| T6-N1 | NOTE | `hn` unused (consistent with the statement audits) |
| X-N1 | NOTE | `check_frozen_anchors.py` enforces the provider import quarantine only for `DRAFT_SORRY` anchors; for sealed anchors the "providers import sealed anchors, never other providers" discipline holds (section 5) but is checked by hand, not by the guard |

## 8. Verdict

| Theorem | Consumption | Hypotheses | Axioms | Kernel | Overall |
|---|---|---|---|---|---|
| T3 `wilson_twisted_trace_pos_and_fourier_bound` | PASS | PASS | PASS | PASS | PASS |
| T4 `centeredTrace_nonneg_of_posSemidef_mass` | PASS | PASS | PASS | PASS | PASS |
| T5 `wilson_mass_bound` | PASS | PASS | PASS | PASS | PASS |
| T6 `wilson_gauge_covariance` | PASS | PASS | PASS | PASS | PASS |

AUDIT_VERDICT: PASS (all four seals count as proofs of the author-approved statements from the
intended predecessors; T3 and T4 consume Lemmas 3.1 and 3.2 only through their sealed anchors).
