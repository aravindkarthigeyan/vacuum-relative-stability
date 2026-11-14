# Statement audit A: T5 `wilson_mass_bound` and T6 `wilson_gauge_covariance`

Independent, refute-first statement audit (auditor A, fresh session, 2026-11-14) of two proposed
declarations in `docs/audits/pilot-chargegap/draft-v1b-with-T5-T6.lean.txt`, following the
`lean-statement-audit` fail-closed checklist. Emphasis: binders, carriers, Lean probes, numerics.
Independence: no file under `docs/audits/**` other than the target draft was read, nor
`docs/PROGRESS.md`, `docs/campaign/**`, `lean/Core/PaperA/{Transfer,Fourier,Provider}/`.

## Verdicts

| Declaration | Five-bin | Conclusion fidelity | True? | Non-vacuous | New ruling | Verdict |
|---|---|---|---|---|---|---|
| T5 `QEDCore.PaperA.wilson_mass_bound` | SOURCE 17, STANDING 0, TYPING 2, RULED 0, **EXCESS 0** | exact: (2.5) both halves; PSD pair ⇔ ‖h_W‖ ≤ h_* (proved in Lean, P3c) | yes; the bound is **attained** (exact certificate, n = 4 π-flux, m = r = 0) | yes (P6) | none | **PASS** |
| T6 `QEDCore.PaperA.wilson_gauge_covariance` | SOURCE 9, STANDING 0, TYPING 2, RULED 0, **EXCESS 0** | exact: L66 `U^u` and L71 `u^* h_W(U) u`, star on the left, spatial factor first | yes, in a strictly stronger form (no Clifford, no |U| = 1, no sign conditions) | yes (P6) | none | **PASS** |

No counterexample was found. Every negative control broke as it should.

## 1. Pinning

| Item | Value | Check |
|---|---|---|
| Target file | `docs/audits/pilot-chargegap/draft-v1b-with-T5-T6.lean.txt` | SHA-256 `f3169e835332bd8f8b4095dcf31370935e5a76de67a8c07967d7f77bd9e5f339` = required value (checked at start and end) |
| Source | `paper-a/model.tex` | SHA-256 `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e` = `lean/status.json` `pinned_sha256` |
| T5 text | draft lines 78–92 (header comment line 77) | spliced byte for byte into the probe file |
| T6 text | draft lines 95–106 (header comment line 94) | spliced byte for byte; the sliced lines 77–106 hash to `c79498ec…f488` |
| D7–D9 | draft lines 16–35 | declaration text identical (`diff`) to the frozen `lean/Core/PaperA/Defs/{LatticeShift,WilsonHopping,WilsonMass}.lean` |
| Frozen definitions used | `def_lattice_shift_v1`, `def_wilson_hopping_v1`, `def_wilson_mass_v1`, `def_dirac_operator_v1` | all four `SEALED`; whole-file SHA-256 equals `full_file_sha256` in `lean/frozen-manifest.json` (`463f6cc0…`, `c1e00e49…`, `6255fe3f…`, `75ec4f63…`) |
| Rulings | `docs/DECISIONS.md` D11, D16 | D16 was **not** in the file at my first read (253 lines, D1–D15); it appeared during the session (commit `8e97f0c`). I audited against the D16 text in that commit (file SHA-256 `675e129a…8373` at the end of the session). D16 approves T5/T6 "on condition that two independent statement audits pass with no EXCESS binder and no new ruling". |
| Toolchain | Lean `v4.35.0`, Mathlib from `lean/lake-manifest.json`; Python 3.12.10, numpy 2.5.4, python-flint 0.9.0 | |
| Draft state | not frozen; the brief fixes `DRAFT_ALLOWLIST: N/A` | the verbatim draft (all of it) compiles: only the four `sorry` warnings |

## 2. Independent source reconstruction (model.tex)

- L4–6: `X = (ℤ/nℤ)³`, `n ≥ 3`, spacing `a > 0`, `N = n³`; link `e = (x, j)` joins `x` to `x + e_j`.
- L9, L13: link configurations `U ∈ U(1)^ℰ`, `U_e = e^{iφ_e}`. So `|U_{xj}| = 1`.
- L27–28: `α_1, α_2, α_3, β` are Hermitian 4×4, square to one, anticommute pairwise.
- L31–34 (2.3): `(T_j(U)f)(x) = \bar U_{xj} f(x+e_j)`, `v_j = (T_j − T_j^*)/(2ia)`,
  `M(U) = m + (r/2a) Σ_j (2 − T_j − T_j^*)`, `h_W(U) = Σ_j α_j v_j(U) + β M(U)`.
- L39–40: `m ≥ 0`, `r ≥ 0`; spatial matrices commute with Dirac matrices (so `h_W` acts on
  `ℓ²(X) ⊗ ℂ⁴` as `Σ_j v_j ⊗ α_j + M ⊗ β`).
- L40–45 (2.5), the T5 source: "Since `T_j(U)` is unitary, `M(U) ≥ mI` and
  `‖h_W(U)‖ ≤ h_* := m + (3+6r)/a`." L46 gives the reason for the first half. The norm is the
  operator norm of the one-particle operator on `ℓ²(X) ⊗ ℂ⁴` (L117–119 use it as a bound on every
  eigenvalue of `h_W`).
- L64–71, the T6 source: for `u_x = e^{iθ_x}`, `U^u_{xj} = u_x U_{xj} \bar u_{x+e_j}`, and
  `h_W(U^u) = u^* h_W(U) u`, with `u` the (spin-scalar) multiplication operator by `u_x`.
- Quantifiers: everything universal; no existential, witness, or constant other than the explicit
  `h_*`, which depends on `m, r, a` only.

Truth of the source claims (reconstructed, for the refutation phase only). With `|U| = 1`, `T_j` is a
permutation times a unimodular diagonal, hence unitary; `2 − T − T^* = (I−T)^*(I−T) ⪰ 0` and
`r/2a ≥ 0` give `M ⪰ mI`. `‖v_j‖ ≤ 1/a`, `0 ⪯ M ⪯ (m + 6r/a) I`, `‖X ⊗ A‖ = ‖X‖‖A‖` and
`‖α_j‖ = ‖β‖ = 1` (Hermitian involutions) give `‖h_W‖ ≤ 3/a + m + 6r/a`. For T6,
`T_j(U^u) = u^* T_j(U) u` entrywise for **any** `u, U` (proved in Lean, P5b), hence the same for
`T_j^*`; the identity terms `2·1`, `m·1` need `u^* u = 1`; the mixed-product rule moves `u ⊗ 1` through
`v ⊗ α_j` and `M ⊗ β` with no condition on `α, β`.

## 3. T5 `wilson_mass_bound`

### 3.1 Five-bin table (every binder, in order)

| # | Binder | Bin | Citation / reason | Needed for truth? |
|---|---|---|---|---|
| 1 | `{n : ℕ}` | TYPING | L4 `X = (ℤ/nℤ)³`; carrier `Fin 3 → ZMod n` | — |
| 2 | `[NeZero n]` | TYPING | Prop class `n ≠ 0`, required for `Fintype (ZMod n)` (sums, products, `PosSemidef`); implied by L4 `n ≥ 3` | typing only |
| 3 | `hn : 3 ≤ n` | SOURCE | L4 `n ≥ 3` | no (n = 1, 2 also satisfy (2.5); numerics §7) — faithful, unused |
| 4 | `α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | L27 `α_1, α_2, α_3` | — |
| 5 | `β : Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | L27 `β` | — |
| 6 | `hα_herm` | SOURCE | L27 "Hermitian" | yes (C9; Hermiticity of `h_W`, P2d) |
| 7 | `hβ_herm` | SOURCE | L27 "Hermitian" | yes (same) |
| 8 | `hα_sq` | SOURCE | L28 "square to one" | yes (C8: `3α_j` breaks the bound) |
| 9 | `hβ_sq` | SOURCE | L28 "square to one" | yes (same mechanism, `‖β‖ = 1`) |
| 10 | `hα_anti` (j ≠ k) | SOURCE | L28 "anticommute pairwise" (α–α pairs) | no (commuting control holds) — faithful, unused |
| 11 | `hαβ_anti` | SOURCE | L28 "anticommute pairwise" (α–β pairs) | no (same) — faithful, unused |
| 12 | `a : ℝ` | SOURCE | L4 spacing | — |
| 13 | `m : ℝ` | SOURCE | L33, L39 | — |
| 14 | `r : ℝ` | SOURCE | L33, L39 | — |
| 15 | `ha : 0 < a` | SOURCE | L4 `a > 0` | yes (C7) |
| 16 | `hm : 0 ≤ m` | SOURCE | L39 `m ≥ 0` | yes (C4: `m = −10` makes `h_* < 0`) |
| 17 | `hr : 0 ≤ r` | SOURCE | L39 `r ≥ 0` | yes (C6) |
| 18 | `U : (Fin 3 → ZMod n) → Fin 3 → ℂ` | SOURCE | L5–6 links `(x, j)`, L9 `U(1)^ℰ`; ℂ carrier cut down by #19 | — |
| 19 | `hU : ∀ x j, ‖U x j‖ = 1` | SOURCE | L13 `U_e = e^{iφ_e}`, L40 "`T_j(U)` is unitary" | yes (C5: `|U| = 2` breaks `M ≥ mI`) |

Counts: SOURCE 17, STANDING 0, TYPING 2, RULED 0, **EXCESS 0**. No binder is a result, estimate,
gate, witness, or bundle; no project-owned Prop alias or structure hides premises (the type mentions
only `PosSemidef`, `IsHermitian`, the four sealed definitions, and Mathlib arithmetic). Order and
implicitness match the frozen T3/T4 conventions; all quantifiers are universal, matching the source.
**Missing premises: none** — every premise needed for truth is present (#6–9, 15–17, 19), and the
statement is true under them (§2, numerics). The full source premise list of (2.5) (L4, L13,
L27–28, L39) is present; nothing is generalized or specialized.

### 3.2 Conclusion fidelity

- **Conjunct 1** `(wilsonMass n a m r U - (m : ℂ) • 1).PosSemidef` is exactly `M(U) ≥ mI` on
  `ℓ²(X)` (not on `ℓ²(X) ⊗ ℂ⁴`, matching L42). Probe P3d proves it is equivalent to the Loewner
  inequality `algebraMap ℝ _ m ≤ M(U)` under Mathlib's `MatrixOrder`, where `algebraMap m = (m:ℂ)•1`
  (P3a). Mathlib's `PosSemidef` = Hermitian ∧ nonnegative quadratic form over `ComplexOrder`.
- **Conjuncts 2–3** (the PSD pair) are exactly `‖h_W(U)‖ ≤ h_*` for the ℓ² operator norm:
  - `h_W(U)` is Hermitian under `hα_herm, hβ_herm` alone, for every real `a, m, r` and every
    complex link field (P2a–P2d, proved). So the reformulation is faithful.
  - P3b proves, for any Hermitian `A` on a nonempty finite index and any real `c`,
    `(c•1 − A ⪰ 0 ∧ c•1 + A ⪰ 0) ↔ ‖A‖ ≤ c` with `‖·‖` Mathlib's ℓ²-operator (C*) norm
    (`Matrix.Norms.L2Operator`). P3c instantiates it at `h_W(U)` and `c = m + (3+6r)/a` under T5's
    hypotheses. The pair asserts in addition that `h_* • 1 ∓ h_W` is Hermitian, which holds.
  - Sharpness makes the non-strict form essential: at `n = 4`, genuine π-flux, `m = r = 0`,
    `‖h_W‖ = 3/a = h_*` exactly (§7.2). A `PosDef` (strict) version would be false.
- **Constant and casts.** The elaborated term is `↑(m + (3 + 6 * r) / a) • 1`: one `ℝ → ℂ` cast of a
  real expression, parsed `m + ((3 + 6r)/a)` as in L43. P4: it equals
  `(m:ℂ) + (3 + 6(r:ℂ))/(a:ℂ)`, and `m = 0, r = 1, a = 2` gives `9/2` (no ℕ division).
- `diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)` is the sealed
  `Σ_j v_j ⊗ₖ α_j + M ⊗ₖ β`, spatial factor first, which is L34 together with L40. The
  identity matrices are on the right carriers: P1 restates T5 with explicit carrier ascriptions
  `Matrix X X ℂ` (conjunct 1) and `Matrix (X × Fin 4) (X × Fin 4) ℂ` (conjuncts 2–3) and is closed by
  `@wilson_mass_bound`.

T5: no new ruling is needed. D11's R2 (arbitrary finite `ι`) does not arise, since the carrier is the
source's `(ℤ/nℤ)³`. R5–R8 of D16 concern T3/T4 and are not used.

## 4. T6 `wilson_gauge_covariance`

### 4.1 Five-bin table

| # | Binder | Bin | Citation / reason | Needed for truth? |
|---|---|---|---|---|
| 1 | `{n : ℕ}` | TYPING | L4 | — |
| 2 | `[NeZero n]` | TYPING | `Fintype (ZMod n)` for the matrix products; implied by L4 | typing only |
| 3 | `hn : 3 ≤ n` | SOURCE | L4 | no — faithful, unused |
| 4 | `α` | SOURCE | L27 (no property assumed) | — |
| 5 | `β` | SOURCE | L27 (no property assumed) | — |
| 6 | `a : ℝ` | SOURCE | L4 (no sign assumed) | — |
| 7 | `m : ℝ` | SOURCE | L33 (no sign assumed) | — |
| 8 | `r : ℝ` | SOURCE | L33 (no sign assumed) | — |
| 9 | `U : (Fin 3 → ZMod n) → Fin 3 → ℂ` | SOURCE | L66 `U_{xj}` (no unit modulus assumed) | — |
| 10 | `u : (Fin 3 → ZMod n) → ℂ` | SOURCE | L64 gauge function `u_x` | — |
| 11 | `hu : ∀ x, ‖u x‖ = 1` | SOURCE | L64 `u_x = e^{iθ_x}`; P5c proves `‖z‖ = 1 ↔ ∃ θ : ℝ, z = e^{iθ}` | yes when `m + 3r/a ≠ 0` (D6, D8); not when `m = r = 0` (D7) |

Counts: SOURCE 9, STANDING 0, TYPING 2, RULED 0, **EXCESS 0**.

Source premises **absent** from T6: the Clifford relations (L27–28), `a > 0` (L4), `m, r ≥ 0`
(L39), `|U_{xj}| = 1` (L13). Dropping a premise makes the statement stronger, not weaker; it is not an
EXCESS binder and needs no ruling, provided the stronger statement is true. It is: P5b proves
`T_j(U^u) = u^* T_j(U) u` in Lean for all `U, u`; the rest is linearity, `u^* u = 1` and the
mixed-product rule. Numerically it holds for non-unit Gaussian `U`, random non-Hermitian
non-Clifford `α, β`, and negative `a, m, r` (§7.3). At `a = 0` Lean's `0⁻¹ = 0` gives `v_j = 0`,
`M = m•1`, and the identity still holds since `u^* u = 1`. P7 compiles the source-shaped statement
(all source premises present, `u_x = exp(iθ_x)`) as a one-line instance of T6, so T6 implies the
source claim.

### 4.2 Conclusion fidelity

- **Transformed links.** `fun x j => u x * U x j * star (u (x + Pi.single j 1))` is
  `u_x U_{xj} \bar u_{x+e_j}` with the same `e_j = Pi.single j 1` as D7. P5a restates T6 with an
  independently written `probeGauge` using `starRingEnd ℂ`, closed by T6 after
  `diagonal_conjTranspose`.
- **Side of the star.** `((diagonal u)ᴴ ⊗ₖ 1) * h_W(U) * (diagonal u ⊗ₖ 1)` is `u^* h_W(U) u` with
  `u^*` on the left, as in L71. Under the D7 convention `T[x, x+e_j] = \bar U_{xj}`,
  `T_j(U^u) = u^* T_j(U) u` (P5b, Lean). Numerically, putting the star on the right (D2) breaks it.
- **Kronecker order.** `diagonal u ⊗ₖ 1` acts on the spatial factor, the first factor of
  `diracOperator`. Swapping the factors (D5) breaks it.
- **Equality** is equality of `Matrix (X × Fin 4) (X × Fin 4) ℂ`, not up to unitary equivalence or
  phase.
- `hn` and `[NeZero n]`: both present and consistent; `NeZero n` follows from `3 ≤ n`, so any source
  instance can supply it (`⟨by omega⟩`).

T6: no new ruling is needed. A record entry of the kind D16 made for R6 (a generalization) is optional
documentation, not a ruling: the source statement is a direct instance (P7).

## 5. Semantic closure

Project-owned constants in the two types: `latticeShift`, `wilsonHopping`, `wilsonMass` (D7–D9,
approved and sealed; the draft's text equals the frozen files) and `diracOperator`
(`def_dirac_operator_v1`, sealed). I read all four bodies. No notation, coercion, structure, or
class from the project appears. Mathlib constants: `Matrix.PosSemidef`, `Matrix.kroneckerMap`,
`Matrix.diagonal`, `conjTranspose`, `Pi.single`, `Complex.ofReal`, the norm on ℂ. Note for the frozen
files: `PosSemidef` over ℂ needs `open scoped ComplexOrder`. Without it the statement fails to
elaborate rather than silently changing meaning. T6 needs `open scoped Kronecker`.

## 6. Lean probes (transient; source in Appendix A)

Command (from `lean/`):
`bash ../scripts/lean-gate.sh lake env lean .lake/scratch/t56A/Probe.lean`.
Result: exit 0. The only warnings are `declaration uses sorry` at the spliced T5 (line 38) and T6
(line 55), plus unused-simp-argument lints. There are no errors. The probe file was then deleted.
The verbatim draft copy (`Draft.lean`, SHA-256 `f3169e83…f339`) also compiled with only its four
`sorry` warnings, and was deleted.

| Probe | Statement | Status |
|---|---|---|
| P1 | T5 at an independently written exact type (with `let`s and explicit carrier ascriptions) `:= @wilson_mass_bound` | compiles |
| P2a–d | `v_j(U)`, `M(U)`, `diracOperator` of Hermitian data, and `h_W(U)` are Hermitian (any `U`, any real `a, m, r`) | proved |
| P3a | `algebraMap ℝ (Matrix ι ι ℂ) t = (t:ℂ) • 1` | proved |
| P3b | Hermitian `A`: `(c•1 − A).PosSemidef ∧ (c•1 + A).PosSemidef ↔ ‖A‖ ≤ c` (ℓ² operator norm) | proved |
| P3c | the same at `A = h_W(U)`, `c = m + (3+6r)/a`, under `hα_herm, hβ_herm` | proved |
| P3d | conjunct 1 `↔ algebraMap m ≤ M(U)` (Loewner) | proved |
| P4 | `↑(m + (3+6r)/a) = ↑m + (3 + 6↑r)/↑a`; value `9/2` at `(0, 1, 2)` | proved |
| P5a | T6 at an independently written type (`probeGauge`, `diagonal (conj ∘ u)`) | compiles from T6 |
| P5b | `latticeShift n (U^u) j = (diagonal u)ᴴ * latticeShift n U j * diagonal u`, all `U, u` | proved |
| P5c | `‖z‖ = 1 ↔ ∃ θ : ℝ, z = exp(θ i)` | proved |
| P6 | non-vacuity (§6.1) | proved / elaborated |
| P7 | source-shaped T6 (all L4/L13/L27–28/L39 premises, `u_x = exp(iθ_x)`) `:=` T6 | compiles |

### 6.1 Non-vacuity

- Standard Dirac matrices `diracα`, `diracβ` (Dirac representation, `α_j = [[0, σ_j], [σ_j, 0]]`,
  `β = diag(1, 1, −1, −1)`). All six Clifford hypotheses are proved entrywise
  (`diracα_herm`, `diracβ_herm`, `diracα_sq`, `diracβ_sq`, `diracα_anti`, `diracαβ_anti`).
- Nontrivial unit links on `(ℤ/3)³`: `probeU x j = exp(i(x_0 + 2x_j + j))`, with
  `‖probeU x j‖ = 1` proved.
- `#check wilson_mass_bound (n := 3) le_rfl diracα diracβ … (1/2) 1 1 (by norm_num) zero_le_one
  zero_le_one probeU probeU_unit` elaborates with every hypothesis discharged by a term. So does the
  edge `a = 1, m = r = 0`.
- `#check wilson_gauge_covariance (n := 3) le_rfl diracα diracβ 1 1 1 probeU
  (fun x => exp((x 1).val · i)) (fun _ => norm_exp_ofReal_mul_I _)` elaborates.
- Closed propositions `probe_T5_hyps_sat` and `probe_T6_hyps_sat` (`∃ n, NeZero n ∧ … ∧ ∃ x, u x ≠ 1`)
  are proved.

## 7. Numerical refutation attempts

Scripts: `lean/.lake/scratch/t56A/numerics_t56.py` (SHA-256 `bb684a94…b953`, ignored scratch) and
`exact_piflux.py` (Appendix B). Run with `python -I`; 57 s plus a few seconds. The matrices are built
from the Lean definitions exactly: `T[x, x+e_j] = conj U[x, j]`, `v = (T − Tᴴ)/(2ia)`,
`M = mI + r/(2a) Σ(2I − T − Tᴴ)`, `h = Σ kron(v_j, α_j) + kron(M, β)`. For n = 3, N = 27 and the
matrices are 108×108. The Clifford sets are Dirac, Weyl, and a random unitary conjugate of Dirac;
each is checked to 1e-12. The links are `U ≡ 1`, `U ≡ −1`, a π-flux pattern (Landau gauge
`U_{x2} = (−1)^{x_0}`, `U_{x3} = (−1)^{x_0+x_1}`; for n = 3, 54 of 81 plaquettes are −1, and for
n = 4 all 192 are, a genuine π-flux), Z₃ phases, Haar U(1), and small phases.

### 7.1 T5

1920 configurations: n ∈ {3, 4}; a ∈ {0.05, 0.3, 1, 7, 100}; m ∈ {0, 0.5, 3}; r ∈ {0, 0.5, 1, 4}; and
the links and Clifford sets above.

| Quantity | Worst value |
|---|---|
| relative Hermiticity defect of `h_W` | 8.5e-17 |
| min eig(`M − mI`)/max(1, r/a) | −1.1e-15 (rounding) |
| min eig(`h_* I ∓ h_W`)/`h_*` | −1.8e-15 (rounding, at the equality case below) |
| max ‖h_W‖/h_* | 1.0000000000000018 at n = 4 π-flux, m = r = 0 (every a). This is exact equality; see 7.2 |
| max ratio among all other configurations | 0.9918 (n = 4 π-flux, a = 0.05, m = 0.5, r = 0) |
| adversarial hill-climb over U(1) links, n = 3 | best ratio 0.8714 (a = 1, m = r = 0), 0.6529 (r = 1), 0.8715 (m = 0.5, r = 4), 0.5587 (a = 0.3, m = 3, r = 0.5) |
| unused hypotheses: commuting α = β = I | min eig(h_* ∓ h)/h_* = 0.134 ≥ 0 (holds) |
| unused hypotheses: n = 1, 2 | ratio 0.52, 0.60; `M − mI ⪰ 0` (holds) |

Controls that must break, and did:

| Control | Result |
|---|---|
| C1 constant `m + 6r/a` (no 3/a), U = 1, a = 1, m = .5, r = 0 | min eig −1.08: breaks |
| C2 constant `m + (3+3r)/a`, U = 1, r = 10 | −12.0: breaks |
| C3 constant `1/a` instead of `3/a` (m = r = 0) | −0.50: breaks |
| C4 `m = −10` (violates `hm`) | h_* = −7, min eig −17.1: breaks |
| C5 `|U| = 2` (violates `hU`) | min eig(M − mI) = −3.0: breaks |
| C6 `r = −1`; C7 `a = −1` | min eig(M − mI) = −5.06: breaks |
| C8 `α_j` scaled by 3 (violates `hα_sq`) | −1.50: breaks |
| C9 non-Hermitian `α` | `h_W` not Hermitian (defect 0.5), so the PSD pair fails: breaks |

### 7.2 Exact certificate: the T5 constant is attained

Take n = 4, genuine π-flux (all 192 plaquettes −1), a = 1, m = r = 0, Dirac matrices. Then `2h_W`
has Gaussian-integer entries. Its real symmetric 512×512 form has the exact integer characteristic
polynomial (python-flint `fmpz_mat.charpoly` and `factor`)

`x^160 (x−6)^8 (x+6)^8 (x−4)^48 (x+4)^48 (x−2)^120 (x+2)^120`.

So `spec h_W = {0, ±1, ±2, ±3}`, and `‖h_W‖ = 3 = h_*` exactly. The `1.0000000000000018` above is
rounding at an exact equality. The source's norm bound is never violated, it is sharp in the
`3/a` term, and only the non-strict `PosSemidef` form is true.

### 7.3 T6

120 configurations: n ∈ {3, 4}; links Haar, π-flux, `U ≡ 1`, and **non-unit Gaussian complex**;
Dirac, Weyl, conjugated Dirac and a **random non-Hermitian** `α, β`; (a, m, r) ∈ {(1, 0, 0),
(0.05, .5, 1), (7, 3, 4), (−2, −1, −3), (1e-3, 0, 100)}; Haar unit `u`. The maximum relative
deviation `|h_W(U^u) − (u^*⊗1) h_W(U) (u⊗1)|` is **3.5e-16**.

Controls (n = 3, Haar U and u, Dirac, a = 1, m = .5, r = 1):

| Control | Relative deviation |
|---|---|
| D0 faithful (reference) | 1.3e-16 (holds) |
| D1 `U^u` with `x − e_j` | 0.286: breaks |
| D2 star on the right, `u h u^*` | 0.286: breaks |
| D3 `latticeShift` without `conj U` | 0.286: breaks |
| D4 `latticeShift` to `x − e_j` | 0.286: breaks |
| D5 Kronecker order swapped (`1 ⊗ u`) | 0.286: breaks |
| D6 `|u| = 2` (violates `hu`) | 3.0: breaks |
| D7 `|u| = 2` with m = r = 0 | 4e-16: holds (`hu` enters only through the identity terms) |
| D8 random non-unit `|u|` | 1.23: breaks |

## 8. Rulings needed

**None, for either declaration.** In force: D11 (R1–R4, Lemmas 3.1/3.2) and D16 (R5–R8, T3/T4).
None of them is needed to read T5 or T6. Both are transcriptions of model.tex (2.5) and L64–71 with
no premise beyond the source, T6 being a strict generalization. D16's condition for T5/T6 (no
EXCESS binder, no new ruling) is met by this audit.

Non-blocking observations:

1. T6 drops the source premises Clifford, `a > 0`, `m, r ≥ 0` and `|U| = 1`. It is true without
   them (P5b, numerics), so this is a strengthening. Recording it like R6 is optional.
2. `hn` (both), `hα_anti` and `hαβ_anti` (T5) are faithful source premises not needed for truth.
   This is fine and should not be "cleaned up": they keep the statement source-shaped.
3. The frozen files must keep `open scoped ComplexOrder` (T5) and `Kronecker` (T6).
4. T5 is sharp (§7.2). Any later edit to a strict inequality, or to a smaller constant at `r = 0`,
   would make it false.

## 9. Reproduction

```bash
cd lean
mkdir -p .lake/scratch/t56A   # write head.part, probes.part, gen.sh from Appendix A
bash .lake/scratch/t56A/gen.sh          # splices draft lines 11-35 and 77-106 into Probe.lean
bash ../scripts/lean-gate.sh lake env lean .lake/scratch/t56A/Probe.lean   # ~3 min (Dirac fin_cases)
cd .lake/scratch/t56A && python -I numerics_t56.py && python -I exact_piflux.py
```

The transient Lean files (`Probe.lean`, `Draft.lean`, `head.part`, `probes.part`, `gen.sh`) were
deleted after the run. Their content is in Appendix A. The Python scripts and logs remain in the
ignored scratch directory. No background job was left running.

## Per-declaration verdicts

### T5 `QEDCore.PaperA.wilson_mass_bound`

```text
DECLARATION_FIDELITY: PASS
DRAFT_ALLOWLIST: N/A
PROOF_STATUS: FROZEN_UNPROVED (upon freeze)
```

### T6 `QEDCore.PaperA.wilson_gauge_covariance`

```text
DECLARATION_FIDELITY: PASS
DRAFT_ALLOWLIST: N/A
PROOF_STATUS: FROZEN_UNPROVED (upon freeze)
```

## Appendix A. Transient Lean probe sources (deleted after the run)

`gen.sh` concatenates `head.part`, draft lines 11–35 (namespace, `open`s, D7–D9), a blank line,
draft lines 77–106 (T5, T6), `probes.part`, and `end QEDCore.PaperA`.

### A.1 `gen.sh`

```bash
#!/usr/bin/env bash
# Regenerate Probe.lean: head + draft lines 11-35 (namespace, opens, D7-D9) + 77-106 (T5, T6) + probes.
set -eu
here=$(cd "$(dirname "$0")" && pwd)
draft="$here/../../../../docs/audits/pilot-chargegap/draft-v1b-with-T5-T6.lean.txt"
{ cat "$here/head.part"; sed -n '11,35p' "$draft"; echo; sed -n '77,106p' "$draft"; cat "$here/probes.part"; echo; echo "end QEDCore.PaperA"; } > "$here/Probe.lean"
sed -n '11,35p' "$draft" | sha256sum
sed -n '77,106p' "$draft" | sha256sum
```

### A.2 `head.part`

```lean
import Core.PaperA.Defs.DiracOperator
import Mathlib.Data.ZMod.Basic
import Mathlib.LinearAlgebra.Matrix.PosDef
import Mathlib.Analysis.Matrix.Order
import Mathlib.Analysis.CStarAlgebra.Matrix
import Mathlib.Analysis.CStarAlgebra.ContinuousFunctionalCalculus.Order

/-! TRANSIENT probe file of statement auditor A for T5/T6 (draft-v1b). D7-D9, T5, T6 are spliced
in byte for byte from the draft by `gen.sh`; everything after them is a probe. Not tracked. -/

```

### A.3 `probes.part`

```lean

/-! ## Probes (auditor A). Nothing below is part of the audited surface. -/

/-- P1. T5 at an independently written exact type (`h_W`, `h_*` named by `let`). -/
example : ∀ {n : ℕ} [NeZero n], 3 ≤ n →
    ∀ (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ),
    (∀ j, (α j).IsHermitian) → β.IsHermitian → (∀ j, α j * α j = 1) → β * β = 1 →
    (∀ j k, j ≠ k → α j * α k + α k * α j = 0) → (∀ j, α j * β + β * α j = 0) →
    ∀ a m r : ℝ, 0 < a → 0 ≤ m → 0 ≤ r →
    ∀ U : (Fin 3 → ZMod n) → Fin 3 → ℂ, (∀ x j, ‖U x j‖ = 1) →
      let M := wilsonMass n a m r U
      let hW := diracOperator α β (fun j => wilsonHopping n a U j) M
      let hstar : ℝ := m + (3 + 6 * r) / a
      (M - (m : ℂ) • (1 : Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ)).PosSemidef ∧
      ((hstar : ℂ) • (1 : Matrix ((Fin 3 → ZMod n) × Fin 4) ((Fin 3 → ZMod n) × Fin 4) ℂ)
          - hW).PosSemidef ∧
      ((hstar : ℂ) • (1 : Matrix ((Fin 3 → ZMod n) × Fin 4) ((Fin 3 → ZMod n) × Fin 4) ℂ)
          + hW).PosSemidef :=
  @wilson_mass_bound

/-- P2a. `v_j(U)` is Hermitian for every real `a` and every complex link field. -/
theorem probe_wilsonHopping_isHermitian (n : ℕ) (a : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (j : Fin 3) : (wilsonHopping n a U j).IsHermitian := by
  have h2 : star (2 * Complex.I * (a : ℂ)) = -(2 * Complex.I * (a : ℂ)) := by
    simp
  have hc : star ((2 * Complex.I * (a : ℂ))⁻¹) = -(2 * Complex.I * (a : ℂ))⁻¹ := by
    rw [star_inv₀, h2, neg_inv]
  unfold wilsonHopping
  rw [IsHermitian, conjTranspose_smul, conjTranspose_sub, conjTranspose_conjTranspose, hc,
    neg_smul, ← smul_neg, neg_sub]

/-- P2b. `M(U)` is Hermitian for all real `a, m, r` and every complex link field. -/
theorem probe_wilsonMass_isHermitian (n : ℕ) (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) :
    (wilsonMass n a m r U).IsHermitian := by
  unfold wilsonMass
  simp only [IsHermitian, conjTranspose_add, conjTranspose_smul, conjTranspose_sum,
    conjTranspose_sub, conjTranspose_one, conjTranspose_conjTranspose, Complex.star_def,
    Complex.conj_ofReal, star_ofNat]
  exact congrArg₂ _ rfl (congrArg _ (Finset.sum_congr rfl fun j _ => sub_right_comm _ _ _))

/-- P2c. `diracOperator` of Hermitian data is Hermitian. -/
theorem probe_diracOperator_isHermitian {ι : Type*} (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (v : Fin 3 → Matrix ι ι ℂ) (M : Matrix ι ι ℂ)
    (hα : ∀ j, (α j).IsHermitian) (hβ : β.IsHermitian) (hv : ∀ j, (v j).IsHermitian)
    (hM : M.IsHermitian) : (diracOperator α β v M).IsHermitian := by
  have hα' : ∀ j, (α j)ᴴ = α j := hα
  have hv' : ∀ j, (v j)ᴴ = v j := hv
  unfold diracOperator
  simp only [IsHermitian, conjTranspose_add, conjTranspose_sum, conjTranspose_kronecker, hα', hv',
    hM.eq, hβ.eq]

/-- P2d. `h_W(U)` is Hermitian under T5's hypotheses (only `hα_herm`, `hβ_herm` are needed). -/
theorem probe_hW_isHermitian (n : ℕ) (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (hα : ∀ j, (α j).IsHermitian) (hβ : β.IsHermitian)
    (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) :
    (diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).IsHermitian :=
  probe_diracOperator_isHermitian α β _ _ hα hβ (fun j => probe_wilsonHopping_isHermitian n a U j)
    (probe_wilsonMass_isHermitian n a m r U)

section NormProbe
open scoped MatrixOrder Matrix.Norms.L2Operator

/-- P3a. `algebraMap ℝ (Matrix ι ι ℂ) t = (t : ℂ) • 1`. -/
theorem probe_algebraMap_eq {ι : Type*} [Fintype ι] [DecidableEq ι] (t : ℝ) :
    algebraMap ℝ (Matrix ι ι ℂ) t = (t : ℂ) • (1 : Matrix ι ι ℂ) := by
  ext i j
  simp [Matrix.algebraMap_matrix_apply, Matrix.one_apply]

/-- P3b. For Hermitian `A` on a nonempty finite index, the PSD pair of T5 is exactly the
operator-norm (ℓ²→ℓ²) bound `‖A‖ ≤ c`. -/
theorem probe_psd_pair_iff_norm_le {ι : Type*} [Fintype ι] [DecidableEq ι] [Nonempty ι]
    (A : Matrix ι ι ℂ) (hA : A.IsHermitian) (c : ℝ) :
    (((c : ℂ) • (1 : Matrix ι ι ℂ) - A).PosSemidef ∧
        ((c : ℂ) • (1 : Matrix ι ι ℂ) + A).PosSemidef) ↔ ‖A‖ ≤ c := by
  have hsa : IsSelfAdjoint A := hA
  constructor
  · rintro ⟨h1, h2⟩
    have hle : A ≤ algebraMap ℝ (Matrix ι ι ℂ) c := by
      rw [probe_algebraMap_eq, Matrix.le_iff]; exact h1
    have hge : algebraMap ℝ (Matrix ι ι ℂ) (-c) ≤ A := by
      rw [probe_algebraMap_eq, Matrix.le_iff]
      have : A - (((-c : ℝ)) : ℂ) • (1 : Matrix ι ι ℂ) = (c : ℂ) • 1 + A := by
        push_cast; rw [neg_smul, sub_neg_eq_add, add_comm]
      rw [this]; exact h2
    rw [le_algebraMap_iff_spectrum_le hsa] at hle
    rw [algebraMap_le_iff_le_spectrum hsa] at hge
    rcases CStarAlgebra.norm_or_neg_norm_mem_spectrum A hsa with h | h
    · exact hle _ h
    · have := hge _ h; linarith
  · intro h
    have h1 : A ≤ algebraMap ℝ (Matrix ι ι ℂ) ‖A‖ := IsSelfAdjoint.le_algebraMap_norm_self A hsa
    have h2 : -(algebraMap ℝ (Matrix ι ι ℂ) ‖A‖) ≤ A :=
      IsSelfAdjoint.neg_algebraMap_norm_le_self A hsa
    have hmono : algebraMap ℝ (Matrix ι ι ℂ) ‖A‖ ≤ algebraMap ℝ (Matrix ι ι ℂ) c := by
      rw [probe_algebraMap_eq, probe_algebraMap_eq, Matrix.le_iff, ← sub_smul]
      refine Matrix.PosSemidef.one.smul ?_
      rw [← Complex.ofReal_sub]; exact Complex.zero_le_real.mpr (by linarith)
    have hu := h1.trans hmono
    have hl := (neg_le_neg hmono).trans h2
    rw [probe_algebraMap_eq, Matrix.le_iff] at hu hl
    refine ⟨hu, ?_⟩
    simpa [sub_neg_eq_add, add_comm] using hl

/-- P3c. Under T5's hypotheses, T5's second and third conjuncts give `‖h_W(U)‖ ≤ h_*` for the
ℓ² operator norm, and conversely; the PSD pair is exactly the source's norm bound. -/
example {n : ℕ} [NeZero n] (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (hα_herm : ∀ j, (α j).IsHermitian) (hβ_herm : β.IsHermitian) (a m r : ℝ)
    (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) :
    ((((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 -
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef ∧
      (((m + (3 + 6 * r) / a : ℝ) : ℂ) • 1 +
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)).PosSemidef) ↔
    ‖diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)‖ ≤ m + (3 + 6 * r) / a :=
  probe_psd_pair_iff_norm_le _ (probe_hW_isHermitian n α β hα_herm hβ_herm a m r U) _

/-- P3d. Conjunct 1 is the Loewner inequality `m•1 ≤ M(U)`, and `m•1 = algebraMap m` (= `mI`). -/
example {n : ℕ} [NeZero n] (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) :
    (wilsonMass n a m r U - (m : ℂ) • 1).PosSemidef ↔
      algebraMap ℝ (Matrix (Fin 3 → ZMod n) (Fin 3 → ZMod n) ℂ) m ≤ wilsonMass n a m r U := by
  rw [probe_algebraMap_eq, Matrix.le_iff]

end NormProbe

/-- P4. Casts: `h_*` is real arithmetic, e.g. `m = 0, r = 1, a = 2` gives `9/2` (not `ℕ`-division). -/
example (m r a : ℝ) : (((m + (3 + 6 * r) / a : ℝ)) : ℂ) = (m : ℂ) + (3 + 6 * (r : ℂ)) / (a : ℂ) := by
  push_cast; ring
example (m r a : ℝ) (hm : m = 0) (hr : r = 1) (ha : a = 2) : (m + (3 + 6 * r) / a : ℝ) = 9 / 2 := by
  subst hm hr ha; norm_num

/-- P5. Independent transcription of `U^u_{xj} = u_x U_{xj} \bar u_{x+e_j}` (model.tex L66). -/
def probeGauge (n : ℕ) (u : (Fin 3 → ZMod n) → ℂ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) :
    (Fin 3 → ZMod n) → Fin 3 → ℂ :=
  fun x j => u x * U x j * (starRingEnd ℂ) (u (x + Pi.single j (1 : ZMod n)))

/-- P5a. T6 at the independently written type `h_W(U^u) = (ū ⊗ 1) h_W(U) (u ⊗ 1)`. -/
example {n : ℕ} [NeZero n] (hn : 3 ≤ n) (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (u : (Fin 3 → ZMod n) → ℂ) (hu : ∀ x, ‖u x‖ = 1) :
    diracOperator α β (wilsonHopping n a (probeGauge n u U)) (wilsonMass n a m r (probeGauge n u U)) =
      (diagonal (fun x => (starRingEnd ℂ) (u x)) ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) *
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U) *
        (diagonal u ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) := by
  have h := wilson_gauge_covariance hn α β a m r U u hu
  rw [diagonal_conjTranspose] at h
  exact h

/-- P5b. Side of the star at the level of `T_j`: `T_j(U^u) = u^* T_j(U) u` (any `u`, any `U`). -/
theorem probe_latticeShift_gauge {n : ℕ} [NeZero n] (U : (Fin 3 → ZMod n) → Fin 3 → ℂ)
    (u : (Fin 3 → ZMod n) → ℂ) (j : Fin 3) :
    latticeShift n (probeGauge n u U) j = (diagonal u)ᴴ * latticeShift n U j * diagonal u := by
  ext x y
  simp only [latticeShift, probeGauge, diagonal_conjTranspose, Matrix.mul_diagonal,
    Matrix.diagonal_mul, of_apply, Pi.star_apply]
  split_ifs with h
  · subst h; simp [star_mul', mul_comm]
  · simp

/-- P5c. `‖u_x‖ = 1` is exactly `u_x = e^{iθ_x}` for real `θ_x` (model.tex L64). -/
example (z : ℂ) : ‖z‖ = 1 ↔ ∃ θ : ℝ, z = Complex.exp (θ * Complex.I) := by
  constructor
  · intro h; refine ⟨z.arg, ?_⟩
    have := Complex.norm_mul_exp_arg_mul_I z
    rw [h, Complex.ofReal_one, one_mul] at this; exact this.symm
  · rintro ⟨θ, rfl⟩; exact Complex.norm_exp_ofReal_mul_I θ

/-! ### P6. Non-vacuity: standard Dirac matrices, `n = 3`, nontrivial unit links. -/

def diracβ : Matrix (Fin 4) (Fin 4) ℂ := !![1, 0, 0, 0; 0, 1, 0, 0; 0, 0, -1, 0; 0, 0, 0, -1]
def diracα : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ := ![
  !![0, 0, 0, 1; 0, 0, 1, 0; 0, 1, 0, 0; 1, 0, 0, 0],
  !![0, 0, 0, -Complex.I; 0, 0, Complex.I, 0; 0, -Complex.I, 0, 0; Complex.I, 0, 0, 0],
  !![0, 0, 1, 0; 0, 0, 0, -1; 1, 0, 0, 0; 0, -1, 0, 0]]

theorem diracα_herm : ∀ j, (diracα j).IsHermitian := by
  intro j
  fin_cases j <;>
    (refine Matrix.IsHermitian.ext fun i k => ?_; fin_cases i <;> fin_cases k <;> simp [diracα])
theorem diracβ_herm : diracβ.IsHermitian := by
  refine Matrix.IsHermitian.ext fun i k => ?_; fin_cases i <;> fin_cases k <;> simp [diracβ]
theorem diracα_sq : ∀ j, diracα j * diracα j = 1 := by
  intro j
  fin_cases j <;>
    (ext i k; fin_cases i <;> fin_cases k <;>
      simp [diracα, Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply])
theorem diracβ_sq : diracβ * diracβ = 1 := by
  ext i k; fin_cases i <;> fin_cases k <;>
    simp [diracβ, Matrix.mul_apply, Fin.sum_univ_four, Matrix.one_apply]
theorem diracα_anti : ∀ j k, j ≠ k → diracα j * diracα k + diracα k * diracα j = 0 := by
  intro j k hjk
  fin_cases j <;> fin_cases k <;>
    first
    | exact absurd rfl hjk
    | (ext i l; fin_cases i <;> fin_cases l <;> simp [diracα, Matrix.mul_apply, Fin.sum_univ_four])
theorem diracαβ_anti : ∀ j, diracα j * diracβ + diracβ * diracα j = 0 := by
  intro j
  fin_cases j <;>
    (ext i l; fin_cases i <;> fin_cases l <;>
      simp [diracα, diracβ, Matrix.mul_apply, Fin.sum_univ_four])

/-- A nontrivial unit link field on `(ℤ/3)³`: `U_{xj} = exp(i (x_0 + 2 x_j + j))`. -/
noncomputable def probeU : (Fin 3 → ZMod 3) → Fin 3 → ℂ :=
  fun x j => Complex.exp ((((x 0).val + 2 * (x j).val + (j : ℕ) : ℕ) : ℝ) * Complex.I)
theorem probeU_unit : ∀ x j, ‖probeU x j‖ = 1 := fun _ _ => Complex.norm_exp_ofReal_mul_I _

-- P6a. Every hypothesis of T5 discharged by actual terms (`a = 1/2, m = 1, r = 1`).
#check
  wilson_mass_bound (n := 3) le_rfl diracα diracβ diracα_herm diracβ_herm diracα_sq diracβ_sq
    diracα_anti diracαβ_anti (1 / 2) 1 1 (by norm_num) zero_le_one zero_le_one probeU probeU_unit

-- P6b. The same at the edge `m = 0, r = 0`.
#check
  wilson_mass_bound (n := 3) le_rfl diracα diracβ diracα_herm diracβ_herm diracα_sq diracβ_sq
    diracα_anti diracαβ_anti 1 0 0 one_pos le_rfl le_rfl probeU probeU_unit

-- P6c. T6 with a nontrivial unit gauge function `u_x = exp(i x_1)`.
#check
  wilson_gauge_covariance (n := 3) le_rfl diracα diracβ 1 1 1 probeU
    (fun x => Complex.exp (((x 1).val : ℝ) * Complex.I)) (fun _ => Complex.norm_exp_ofReal_mul_I _)

/-- P6d. The hypothesis lists as closed satisfiable propositions. -/
theorem probe_T5_hyps_sat : ∃ (n : ℕ) (_ : NeZero n) (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ)
    (β : Matrix (Fin 4) (Fin 4) ℂ) (a m r : ℝ) (U : (Fin 3 → ZMod n) → Fin 3 → ℂ),
    3 ≤ n ∧ (∀ j, (α j).IsHermitian) ∧ β.IsHermitian ∧ (∀ j, α j * α j = 1) ∧ β * β = 1 ∧
    (∀ j k, j ≠ k → α j * α k + α k * α j = 0) ∧ (∀ j, α j * β + β * α j = 0) ∧
    0 < a ∧ 0 ≤ m ∧ 0 ≤ r ∧ (∀ x j, ‖U x j‖ = 1) :=
  ⟨3, inferInstance, diracα, diracβ, 1, 0, 0, probeU, le_rfl, diracα_herm, diracβ_herm, diracα_sq,
    diracβ_sq, diracα_anti, diracαβ_anti, one_pos, le_rfl, le_rfl, probeU_unit⟩
theorem probe_T6_hyps_sat : ∃ (n : ℕ) (_ : NeZero n) (u : (Fin 3 → ZMod n) → ℂ),
    3 ≤ n ∧ (∀ x, ‖u x‖ = 1) ∧ ∃ x, u x ≠ 1 :=
  ⟨3, inferInstance, fun _ => -1, le_rfl, fun _ => by simp, 0, by norm_num⟩

/-- P7. T6 implies the source statement under every source premise (it is a specialization). -/
example {n : ℕ} [NeZero n] (hn : 3 ≤ n)
    (α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ) (β : Matrix (Fin 4) (Fin 4) ℂ)
    (_hα_herm : ∀ j, (α j).IsHermitian) (_hβ_herm : β.IsHermitian)
    (_hα_sq : ∀ j, α j * α j = 1) (_hβ_sq : β * β = 1)
    (_hα_anti : ∀ j k, j ≠ k → α j * α k + α k * α j = 0)
    (_hαβ_anti : ∀ j, α j * β + β * α j = 0)
    (a m r : ℝ) (_ha : 0 < a) (_hm : 0 ≤ m) (_hr : 0 ≤ r)
    (U : (Fin 3 → ZMod n) → Fin 3 → ℂ) (_hU : ∀ x j, ‖U x j‖ = 1) (θ : (Fin 3 → ZMod n) → ℝ) :
    diracOperator α β
        (wilsonHopping n a (probeGauge n (fun x => Complex.exp (θ x * Complex.I)) U))
        (wilsonMass n a m r (probeGauge n (fun x => Complex.exp (θ x * Complex.I)) U)) =
      ((Matrix.diagonal fun x => Complex.exp (θ x * Complex.I))ᴴ ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) *
        diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U) *
        (Matrix.diagonal (fun x => Complex.exp (θ x * Complex.I)) ⊗ₖ (1 : Matrix (Fin 4) (Fin 4) ℂ)) :=
  wilson_gauge_covariance hn α β a m r U _ (fun x => Complex.norm_exp_ofReal_mul_I (θ x))

```

## Appendix B. `exact_piflux.py`

```python
"""Exact certificate (python-flint) that T5's norm bound is attained with equality:
n = 4, genuine pi-flux links (every plaquette = -1), a = 1, m = r = 0, Dirac matrices.
Claim: ||h_W(U)|| = 3 = h_* exactly. Run: python -I exact_piflux.py"""
import sys

import numpy as np
import flint

sys.path.insert(0, __file__.rsplit("\\", 1)[0] if "\\" in __file__ else ".")
import numerics_t56 as T  # noqa: E402

n = 4
U = T.links(n, "piflux")
assert T.plaquette_stats(n, U) == (192, 192)
H = T.hW(n, 1.0, 0.0, 0.0, U, T.dirac_alpha, T.dirac_beta)
G2 = 2 * H
assert np.allclose(G2.real, np.round(G2.real)) and np.allclose(G2.imag, np.round(G2.imag))
A = np.round(G2.real).astype(int)
B = np.round(G2.imag).astype(int)
R = np.block([[A, -B], [B, A]])  # real symmetric form of 2H; each eigenvalue doubled
assert (R == R.T).all()
G = flint.fmpz_mat(R.tolist())
cp = G.charpoly()
c, facs = cp.factor()
print("charpoly(2 H_R) =", c, "*", " * ".join(f"({f})^{e}" for f, e in facs))
mx = 0
for f, e in facs:
    for root, mult in f.complex_roots():
        mx = max(mx, abs(root).upper())
        print(f"  factor {f}: root {root} (|.| <= {abs(root).upper()})")
x = flint.fmpz_poly([-6, 1])  # x - 6
print("x - 6 divides charpoly:", cp % x == 0, "; x + 6 divides:", cp % flint.fmpz_poly([6, 1]) == 0)
print("max |eigenvalue of 2H| (rigorous upper):", mx, "-> ||h_W|| = 3 = h_* exactly")
```
