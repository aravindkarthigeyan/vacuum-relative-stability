# Statement audit A: finite-dimensional part of Theorem 4.1 (`thm:main`), draft v1

Auditor A, independent of the declaration author, refute-first. Date 2026-11-14. Nothing
here is proved. The audited text is the transient proposal `DraftChargeGap.lean` (not
tracked; SHA-256 `e16372fb6560b6336a0eb0c9353936743b2c45d87ad6a6bfe852a84e7d0fa2bc`, 81 lines).
It holds three definitions, D7 `latticeShift`, D8 `wilsonHopping` and D9 `wilsonMass`, and two
theorems with `sorry` bodies: T3 `wilson_twisted_trace_pos_and_fourier_bound` and T4
`centeredTrace_nonneg_of_posSemidef_mass`.

## Verdicts

| Declaration | Verdict |
|---|---|
| D7 `latticeShift` | `DEFINITION_VERDICT: PASS` |
| D8 `wilsonHopping` | `DEFINITION_VERDICT: PASS` |
| D9 `wilsonMass` | `DEFINITION_VERDICT: PASS` |
| T3 `wilson_twisted_trace_pos_and_fourier_bound` | `DECLARATION_FIDELITY: PASS`, **conditional on ruling R5** (R6 for the record). If R5 is declined, rows 18, 19a and 22 are EXCESS and the verdict is FAIL. |
| T4 `centeredTrace_nonneg_of_posSemidef_mass` | `DECLARATION_FIDELITY: PASS`, **conditional on ruling R7** (extends the scope of R1(a), R2 and R4). If R7 is declined, rows 1, 14, 15a and 16 are outside every existing ruling and the verdict is FAIL. |

For both theorems: `DRAFT_ALLOWLIST: N/A` (the declarations are not manifested yet) and
`PROOF_STATUS: FROZEN_UNPROVED` once frozen. Neither theorem states a displayed claim of
`thm:main`. They are proof-step nodes, so `thm:main` stays `NOT_STARTED` after the freeze
(surface finding S0).

Surface: the declarations are faithful but **incomplete** as "thm:main as far as
finite-dimensional". The finite-CAR identity `Tr_F Γ(A) = det(I + A)` (comparison.tex L55) and
the fermionic factor of `W(u)` are the main finite-dimensional steps that are specific to
`thm:main`, and they are left out. T3 takes the centered trace as the *definition* of the
integrand. That omission needs either a frozen theorem or an explicit scope ruling (R8). The
mass bound (2.5) and gauge covariance (model.tex L71) are also recommended (see Surface
findings).

## 0. Pinning

- Source SHA-256 values were recomputed and match `lean/status.json` `pinned_sha256`:
  `paper-a/model.tex` `2464b16f…961e`, `paper-a/comparison.tex` `1caaf36b…3273`,
  `paper-a/transfer.tex` `b2dcc793…98cf` (the other three pinned files also match).
- The frozen definitions in the semantic closure of T3 and T4 were checked against
  `lean/frozen-manifest.json` `full_file_sha256`: `def_step_v1`, `def_dirac_operator_v1`,
  `def_step_generator_v1`, `def_step_free_time_v1`, `def_transfer_matrix_v1` and
  `def_centered_trace_v1` all match and all are `SEALED`. The theorems `lem_transfer_v1` and
  `lem_fourier_v1` are `SEALED`.
- Rulings: docs/DECISIONS.md D11 R1(a)–R4. Their scope is "the frozen statements of Lemmas
  3.1 and 3.2". No ruling covers `thm:main` or the remark at transfer.tex L89–L91.
- Equation numbers come from `paper-a/build/paper-a-lattice.aux`: `eq:wilson` (2.3),
  `eq:mass-bound` (2.5), `eq:capacity` (2.9), `eq:centered-trace` (3.1), `eq:fourier-bound`
  (3.4), `eq:main` (4.1), `eq:thermal` (4.2), `eq:heat` (4.3), `eq:fk` (4.4) and
  `eq:twisted` **(4.5)**. The brief's "(4.6)" means `eq:twisted`.
- Excluded reading was respected: nothing was read under `lean/Core/PaperA/{Transfer,Fourier,Provider}`,
  `docs/audits/**` (apart from listing directory names to create this file),
  `docs/PROGRESS.md` or `docs/campaign/**`.

## 1. Reconstruction of `thm:main` (from source only)

**Setting** (model.tex L4–L91). `X = (ℤ/nℤ)³`, `n ≥ 3`, `a > 0`, `N = n³` (L4–L5). A link
`(x, j)` joins `x` to `x + e_j` (L5–L6), and `U ∈ U(1)^ℰ` (L9, L13). There are Hermitian 4×4
`α_1, α_2, α_3, β` that square to 1 and anticommute pairwise (L27–L28). (2.3) defines
`(T_j f)(x) = conj(U_{xj}) f(x+e_j)`, `v_j = (T_j − T_j^*)/(2ia)`,
`M = m + (r/2a) Σ_j (2 − T_j − T_j^*)` and `h_W = Σ α_j v_j + β M` (L30–L35). The parameters
satisfy `m ≥ 0` and `r ≥ 0` (L39). The mass bound (2.5) reads `M(U) ≥ mI`,
`‖h_W(U)‖ ≤ h_* = m + (3+6r)/a` (L41–L46). The charge is `q_x = n_x − 2` (L62). Gauge action:
`U^u_{xj} = u_x U_{xj} conj(u_{x+e_j})` and `W(u) = e^{iΣθ_x q_x} R_u` (L64–L70), with
covariance `h_W(U^u) = u^* h_W(U) u` (L71). Capacity (2.9): `Σ q_x = Q_ν` and
`ℋ_ν ≠ 0 ⇔ |Q_ν| ≤ 2N`. "Admissible" means `ℋ_ν ≠ 0` (main.tex L36, model.tex L86–L91).

**Statement** (comparison.tex L4–L21). For `a > 0`, `g > 0`, `r ≥ 0` and `m ≥ 0`:
`E_ν ≥ E_0 + m|Q_ν|` (4.1); `0 < Z_ν(b) ≤ Z_0(b)`; for `m > 0`,
`Z_ν(b) ≤ binom(4N, 2N+|Q_ν|) e^{−bm|Q_ν|} Z_0(b)` (4.2); and the auxiliary ground energy
equals `E_0`.

| # | Claim or proof step | Lines | Finite-dimensional? | Covered by draft |
|---|---|---|---|---|
| S1 | (4.1) `E_ν ≥ E_0 + m\|Q_ν\|` | L8–L11 | No (spectrum of `H` on `L²(U(1)^ℰ) ⊗ F`) | No |
| S2 | `0 < Z_ν ≤ Z_0` | L12–L13 | No | No |
| S3 | (4.2) thermal binomial bound | L13–L18 | No | No |
| S4 | auxiliary ground energy `= E_0` | L19–L20 | No | No |
| P1 | heat kernel `k_t > 0` (4.3) | L23–L30 | No (circle analysis, Poisson summation) | No |
| P2 | Dyson series, Feynman–Kac (4.4), bridge paths `ω` | L31–L53 | No (path measure) | No |
| P3 | gauge insertion moves the kernel argument to `U^u` | L54 | Mixed. The finite-dimensional input is covariance `h_W(U^u) = u^* h_W(U) u` (model L71) | No |
| P4 | finite-CAR identity `Tr_F Γ(A) = det(I + A)` | L55 | **Yes** (Fock space of dimension `2^{4N}`) | **No** |
| P5 | twisted formula (4.5): fermionic factor `e^{−2iΣθ} det(I + uV_ω)` | L56–L63; transfer L83–L88 | The factor is finite-dimensional; the trace-formula justification (L64–L68) is not | Yes, **as a definition** (T3's `F`) |
| P6 | for `m > 0` every integrand of (4.5) is positive, by Lemma 3.1 with `M(ω_t) ≥ mI` | L70–L72 | Fermionic factor yes; scalar factors no | T3 conjunct 1 |
| P7 | gauge projection `Z_ν = ∫ e^{−iθ·ν} F_b`, `\|Z_ν\| ≤ Z_0` | L73–L79 | No | No |
| P8 | heat trace of a nonempty sector `> 0` | L80 | No | No |
| P9 | `θ = ϑ + φ`, `ϑ_root = 0`; measure-preserving change of variables; `U^u` and the bridge weight depend only on `ϑ` | L82–L86 | Yes (torus change of variables; identity `U^{e^{i(ϑ+φ)}} = U^{e^{iϑ}}`) | Partly (T3 quantifies over `ϑ + φ`; the identity is not stated) |
| P10 | `φ`-integration is the `Q_ν` Fourier coefficient of the centered trace for `e^{iϑ} V_ω`; Lemma 3.2 with `D = 4N`, `d = 2N`, `m_* = m` | L86–L89 | **Yes** | T3 conjuncts 2–3 |
| P11 | remove `e^{−iϑ·ν}` by absolute value; integrate `F_0`; result `= Z_0` | L90–L93 | No (an abstract measure version is already in Lean, deviation 6) | No |
| P12 | `E_ν = −lim b^{−1} log Z_ν` | L95–L97 | No | No |
| P13 | `m = 0`: "determinants are nonnegative by the limit in Section 3" | L98–L99; transfer L89–L91 | **Yes** | T4 (abstract histories only) |
| P14 | alternative: `‖H_ε − H_0‖ ≤ 2Nε` | L99–L101 | The bound `‖dΓ(εβ)‖ = 2Nε` is finite-dimensional; the continuity is not | No |
| P15 | auxiliary space `=` ⊕ of Gauss sectors | L101–L103 | No | No |
| M1 | (2.3) `T_j`, `v_j`, `M` | model L30–L35 | Yes | D7–D9 |
| M2 | (2.5) `M(U) ≥ mI`, `‖h_W(U)‖ ≤ h_*` | model L41–L46 | Yes | **Not stated**: the first half is a hidden proof step of T3 |
| M3 | covariance `h_W(U^u) = u^* h_W(U) u` | model L71 | Yes | No |
| M4 | capacity (2.9) | model L86–L97 | The fermionic half (`Σq_x ∈ [−2N, 2N]`) and the integer flow are finite; `ℋ_ν ≠ 0` is not | T3 takes `\|Q\| ≤ 2N` as a hypothesis |

None of S1–S4 is a finite-dimensional claim. The finite-dimensional content of `thm:main` is
P4, P5 (factor), P6 (fermionic), P9 (identity), P10, P13, the bound in P14, and M1–M4.

## 2. Definition audits (D7–D9 against (2.3), model.tex L30–L35)

Common carrier. `Fin 3 → ZMod n` is `(ℤ/nℤ)³`; the probe `Fintype.card (Fin 3 → ZMod n) = n ^ 3`
holds under `NeZero n`. `Pi.single j 1` is `e_j`: the probe `Pi.single 1 1 = ![0, 1, 0]` in
`ZMod 3` is checked by `decide`. `Fin 3` indexes `j = 1, 2, 3` as `0, 1, 2` (cosmetic only).
A link variable is `U x j = U_{xj}`, on the link from `x` to `x + e_j`, which matches L5–L6.
Matrices act as `(A *ᵥ f) x = Σ_y A x y f y`.

### D7 `latticeShift n U j := Matrix.of fun x y => if y = x + Pi.single j 1 then star (U x j) else 0`

Probe P1a (proved in scratch): `(latticeShift n U j *ᵥ f) x = star (U x j) * f (x + Pi.single j 1)`.
This is exactly `(T_j f)(x) = conj(U_{xj}) f(x + e_j)`, with the correct forward shift and
conjugation. Probe P1b: `((latticeShift n U j)ᴴ *ᵥ f) x = U (x − e_j) j * f (x − e_j)`, which is
the correct adjoint. The `if` is the literal Kronecker delta of the shift, not a fallback
branch. Outside `n ≥ 3`:

- `n = 1`: probe P2a shows `T_j = diagonal (conj U_{·j})`, because `x + e_j = x`.
- `n = 2`: probe P2b shows `x + 2e_j = x`, so the two links `(x, j)` and `(x+e_j, j)` both join
  `x` and `x + e_j`.
- `n = 0`: `ZMod 0 = ℤ`, and the definition still elaborates as a formal ℤ³-indexed array.

Each of these is the literal formula on a degenerate lattice, not invented semantics. Every
consumer needs `NeZero n` (to take a trace), and T3 also requires `3 ≤ n`.

```
BODY_MATCH: OK
PUBLIC_CARRIER: OK   (U : X → Fin 3 → ℂ is wider than U(1)^ℰ; the formula is literal for every U;
                      unitarity is a consumer premise, carried by T3's hlinks. Watch item.)
WELL_DEFINEDNESS: N/A_LITERAL
CHARACTERIZATION: N/A_LITERAL
CHOICE_INDEPENDENCE: N/A
DEFINITION_VERDICT: PASS
```

### D8 `wilsonHopping n a U j := (2 * I * a)⁻¹ • (T_j − T_jᴴ)`

Probe P1c: `wilsonHopping n a U j = (1 / (2 I a)) • (T_j − T_jᴴ)`. This is
`(T_j − T_j^*)/(2ia)` with the right sign and factor; at `U ≡ 1` it is the symmetric
difference `−i∂`. Probe P2c: at `a = 0`, Lean's total inverse gives `v_j = 0`. That is the
standard field convention, not an authored branch, and the source only defines `v_j` for
`a > 0`. T3 assumes `0 < a`. Watch item: every consumer must carry `a > 0`.

```
BODY_MATCH: OK
PUBLIC_CARRIER: OK
WELL_DEFINEDNESS: N/A_LITERAL
CHARACTERIZATION: N/A_LITERAL
CHOICE_INDEPENDENCE: N/A
DEFINITION_VERDICT: PASS
```

### D9 `wilsonMass n a m r U := (m:ℂ) • 1 + ((r/(2a) : ℝ) : ℂ) • Σ_j ((2:ℂ) • 1 − T_j − T_jᴴ)`

Probe P1d: `= m • 1 + (r/(2a)) • Σ_j (2 • 1 − T_j − T_jᴴ)`. The `pp.numericTypes` print shows
`(2 : ℂ) • (1 : Matrix …)` and `↑(r / ((2:ℝ) * a))`. This is
`m + (r/2a) Σ_{j=1}^3 (2 − T_j − T_j^*)`, with `m` and `2` read as multiples of the identity.
Probe P2d: at `a = 0` the Wilson term vanishes (`M = m • 1`), by the same total-division
convention as D8. Watch item.

```
BODY_MATCH: OK
PUBLIC_CARRIER: OK
WELL_DEFINEDNESS: N/A_LITERAL
CHARACTERIZATION: N/A_LITERAL
CHOICE_INDEPENDENCE: N/A
DEFINITION_VERDICT: PASS
```

`h_W(U)` is not given a new definition. It is the frozen `diracOperator α β (wilsonHopping n a U) (wilsonMass n a m r U)`
`= Σ_j v_j ⊗ α_j + M ⊗ β`, with the spatial factor first ("spatial matrices commute with the
Dirac matrices", model L40).

## 3. Five-bin binder tests

STANDING has no rows: the project has no independently audited standing-assumption object.
Model.tex conventions enter `thm:main` through "For the Hamiltonian (2.4)" (comparison L6) and
are filed as SOURCE with their model.tex lines. "RULED-pending" means a proposed ruling (§6)
that the author has not yet adopted.

### T3 `wilson_twisted_trace_pos_and_fourier_bound`

| # | Binder (expanded) | Bin | Citation and notes |
|---|---|---|---|
| 1 | `{n : ℕ}` | SOURCE | model L4 `X = (ℤ/nℤ)³`; `N = n³` (L5) |
| 2 | `[NeZero n]` | TYPING | `Fintype (ZMod n)` for the finite trace; implied by row 3 |
| 3 | `hn : 3 ≤ n` | SOURCE | model L4 |
| 4 | `α` | SOURCE | model L27 |
| 5 | `β` | SOURCE | model L27 |
| 6 | `hα_herm` | SOURCE | model L27 "Hermitian" |
| 7 | `hβ_herm` | SOURCE | model L27 |
| 8 | `hα_sq` | SOURCE | model L28 "square to one" |
| 9 | `hβ_sq` | SOURCE | model L28 |
| 10 | `hα_anti` (`j ≠ k`) | SOURCE | model L28 "anticommute pairwise" |
| 11 | `hαβ_anti` | SOURCE | model L28 |
| 12 | `a` | SOURCE | model L4; comparison L6 |
| 13 | `m` | SOURCE | model L33, L39; comparison L7 |
| 14 | `r` | SOURCE | model L33, L39; comparison L7 |
| 15 | `ha : 0 < a` | SOURCE | comparison L6 |
| 16 | `hm : 0 < m` | SOURCE | comparison L13 "for m > 0", L70 |
| 17 | `hr : 0 ≤ r` | SOURCE | comparison L7; model L39 |
| 18 | `links : List (ℝ × (X → Fin 3 → ℂ))` | RULED-pending **R5** | stands in for the bridge paths `ω` on `[0,b]` (comparison L43–L51, L57–L61, L72); the step approximations are named at L50–L51 |
| 19a | `hlinks`: `0 ≤ p.1` | RULED-pending **R5** | step durations; the analogue of R1(a)'s `τ ≥ 0` |
| 19b | `hlinks`: `‖p.2 x j‖ = 1` | SOURCE | model L9, L13 (`U ∈ U(1)^ℰ`, `U_e = e^{iφ_e}`) |
| 20 | `b` | SOURCE | comparison L12 (inverse temperature) |
| 21 | `hb : 0 < b` | SOURCE | comparison L12 |
| 22 | `htime : Σ τ = b` | RULED-pending **R5** | the path runs over `[0,b]` (L43–L45, L59–L60) |
| 23 | `ϑ : X → ℝ` | SOURCE (domain widened; R6 records it) | comparison L82–L83: there `ϑ_root = 0` on the torus; T3 takes all of `ℝ^X`, which is a generalization, not a premise |
| 24 | `Q : ℤ` | SOURCE | `Q_ν` (comparison L9, L86–L89); every integer with `\|Q\| ≤ 2N` is some `Σν_x` |
| 25 | `hQ : \|Q\| ≤ 2 n³` | SOURCE | model (2.9) L89 (admissibility); Lemma 3.2's `\|q\| ≤ d` with `d = 2N` (comparison L89, transfer L99) |

Counts: **SOURCE 22, STANDING 0, TYPING 1, RULED 0 (approved) + 3 RULED-pending (R5), EXCESS 0**,
for 26 rows. With R5 adopted, there is no EXCESS. With R5 declined, rows 18, 19a and 22 are
EXCESS (an unruled specialization).

Other T3 checks:

- **Quantifier order.** It is `∀` throughout, and there are no existential constants. The
  constant `binom(4N, 2N+|Q|) e^{−bm|Q|}` depends only on `n`, `Q`, `b` and `m`, matching L89.
- **Implicitness.** Only `n` is implicit, and it is determined by `links` and `ϑ`.
- **Carriers.** `F : ℝ → ℂ` and `Fhat : ℤ → ℂ`, with Lemma 3.2's normalization
  `(2π)^{−1} ∫_0^{2π} e^{−iqφ}` (transfer L98).
- **Coercions.** The probe shows `Complex.exp (−(↑p * ↑φ * I))`; the casts are into ℂ.
- **Unused binders.** `g` is absent because it does not enter the fermionic factor. `hn`,
  `NeZero n` and `hQ` are not needed for truth; they are faithful source premises.
- **Bundling.** Conjunct 1 (positivity) does not involve `Q`, yet it is stated under `Q`/`hQ`.
  This is harmless because `Q = 0` always satisfies `hQ`, but a split is recommended (S9).

### T4 `centeredTrace_nonneg_of_posSemidef_mass`

| # | Binder (expanded) | Bin | Citation and notes |
|---|---|---|---|
| 1 | `{ι : Type*}` | RULED R2, scope pending **R7** | transfer L6–L7 (`D = 2d`); application `ι = X` |
| 2 | `[Fintype ι]` | TYPING | finite dimension (transfer L4, "finite-dimensional") |
| 3 | `[DecidableEq ι]` | TYPING | matrix identity and determinant |
| 4 | `α` | SOURCE | transfer L7; model L27 |
| 5 | `β` | SOURCE | same |
| 6 | `hα_herm` | SOURCE | model L27 |
| 7 | `hβ_herm` | SOURCE | model L27 |
| 8 | `hα_sq` | SOURCE | model L28 |
| 9 | `hβ_sq` | SOURCE | model L28 |
| 10 | `hα_anti` | SOURCE | model L28 |
| 11 | `hαβ_anti` | SOURCE | model L28 |
| 12 | `b` | SOURCE | transfer L15–L16 |
| 13 | `hb : 0 < b` | SOURCE (inherited) | transfer L15 "total free time b > 0". The remark at L89–L91 is set inside Lemma 3.1's setting. Not needed for truth (see §4); R7 records that it is kept. |
| 14 | `hist : List (Step ι)` | RULED R1(a), scope pending **R7** | transfer L11–L16 |
| 15a | `hfree`: `0 ≤ τ` | RULED R1(a), scope pending **R7** | transfer L25 (`c ≥ 0`) |
| 15b | `hfree`: `(v j).IsHermitian` | SOURCE | transfer L15 "bounded Hermitian spatial coefficients" |
| 15c | `hfree`: `M.PosSemidef` | SOURCE | transfer L89 "nonnegative mass coefficient" (`m_* = 0`, i.e. `M ⪰ 0`) |
| 16 | `hkick`: `Θ.IsHermitian` | RULED R4, scope pending **R7** | transfer L16, L26 |
| 17 | `htime : Σ freeTime = b` | SOURCE | transfer L25 `∫c = b`, in R1(a) step form |

Counts: **SOURCE 13, STANDING 0, TYPING 2, RULED 4 (R1(a)/R2/R4, all scope-pending R7),
EXCESS 0**, for 19 rows. D11 limits R1(a)–R4 to "the frozen statements of Lemmas 3.1 and 3.2",
and the remark at L89–L91 is a new statement, so R7 must extend that scope explicitly.

## 4. Conclusion fidelity

### Semantic closure

T3's `F φ` unfolds through the sealed definitions (`centeredTrace`, `transferMatrix`,
`Step.generator`, `diracOperator`):

- **Free steps.** The centering phase is `exp(½ Σ_k τ_k Tr h_W(U_k)) = 1`, because Clifford gives
  `Tr α_j = Tr β = 0`.
- **Kick.** The generator `−i(diag θ ⊗ 1)` with `θ = ϑ + φ` has trace `−4iΣθ_x`. The centering
  factor is therefore `e^{−2iΣθ_x}`, which is transfer L83–L86 exactly. Its propagator is
  `e^{i diag θ ⊗ 1} = u`.
- **Transfer.** Later steps go on the left, so the transfer matrix is `u · V` with
  `V = Π exp(−τ_k h_W(U_k))`, the ordered propagator of `−h_W` (comparison L48–L49).
- **Result.** `F(φ) = e^{−2iΣθ} det(I + uV)`, the fermionic factor of (4.5) (L61) for the
  step history.

### Conclusion table

| Conjunct | Lean | Source | Verdict |
|---|---|---|---|
| T3.1 | `∀ φ, 0 < Re F(φ) ∧ Im F(φ) = 0` (for every `ϑ`, hence every twist `θ ∈ ℝ^X`) | comparison L70–L72, "For m > 0 every integrand in (4.5) is positive", fermionic factor `e^{−2iΣθ} det(I+uV_ω)` | **Equal** on the fermionic factor. The path class is **different** (R5: step histories instead of continuous bridges; the bridge endpoints are dropped, which is more general). The scalar factors `K_b > 0` and `e^{−∫H_B} > 0` are omitted because they are not finite-dimensional. |
| T3.2 | `Im Fhat 0 = 0` | L90–L91, "nonnegative zeroth coefficient"; R3 convention | **Equal**. Nonnegativity follows from T3.3 at `Q = 0`: `‖F̂_0‖ ≤ binom(4N,2N) Re F̂_0`. |
| T3.3 | `‖Fhat Q‖ ≤ binom(4n³, 2n³+\|Q\|) e^{−bm\|Q\|} Re Fhat 0` for `\|Q\| ≤ 2n³` | L86–L89, Lemma 3.2 with `D = 4N`, `d = 2N`, `m_* = m`; (3.4) | **Equal** (modulo R5 and R6). The single kick `diag(ϑ+φ)` equals Lemma 3.2's two-step form, history ending in kick `diag ϑ` followed by kick `φ·1`. The two kicks commute and their centering phases add, so the one-kick form is equivalent, but showing this is a proof step. Fourier sign: `θ·ν = ϑ·ν + φQ_ν`, so the coefficient taken is `+Q_ν` in transfer L98's convention; the bound depends only on `\|Q\|`. |
| T4 | `Im F = 0 ∧ 0 ≤ Re F` | transfer L91, "The centered trace is then nonnegative but may vanish"; comparison L98–L99, "determinants are nonnegative" | **Equal** to L91. "May vanish" is not a claim, but T4 cannot be strengthened: `v = 0`, `M = 0`, and a final kick `Θ = π·1` give transfer `−I`, phase `e^{−2πi\|ι\|} = 1`, and `F = 0`. For comparison L98–L99 T4 is **abstract**: the Wilson `m = 0` instance needs (2.5) at `m = 0`, which is not stated (S4). |

**On `b > 0` in T4.** T4 is true without it. If `b = 0`, every free step has `τ = 0`, so the
history consists only of kicks and `F = (e^{−is/2} det(I+W))^4`, the fourth power of a real
number. The premise is therefore a faithful inheritance of L15 that makes T4 slightly weaker
than the strongest true statement; it is not an error.

## 5. Surface findings

- **S0. Status.** No displayed claim of `thm:main` (S1–S4) is finite-dimensional. Freezing T3
  and T4 must not change `thm:main`'s state in `lean/status.json`. They are proof-step nodes
  (P6, P10, P13).
- **S1. Finite-CAR identity and the fermionic factor of `W(u)`** (P4, P5; comparison L55, L61;
  transfer L83–L88). This is finite-dimensional (`dim F = 2^{4N}`) and is the step that makes
  the integrand a *trace*. T3 takes the right-hand side `e^{−2iΣθ} det(I + uV)` as its
  definition of the integrand. **Not acceptable silently.** The options are:
  - (a) freeze a T5 stating `Tr_F(e^{iΣθ_x q_x} Γ(V)) = centeredTrace(… ++ [kick diag θ])`. This
    needs new definitions for the fermionic Fock space (for example the occupation-number basis
    `Finset (X × Fin 4)` or `ExteriorAlgebra`), for `Γ(A)` and for `q_x`, each audited as a
    literal definition;
  - (b) adopt the scope ruling R8 and keep the `outside_lean` note, as was done for
    `lem:fourier`.
- **S2. Mass bound (2.5)** (M2; model L41–L46). This is a labeled source display.
  `M(U) ⪰ mI` is the only `thm:main`-specific mathematical input of T3 (L72), and it is also
  needed to instantiate T4 at `m = 0` (L98). **Recommend freezing** it with `m ≥ 0`, `r ≥ 0`,
  `a > 0` and `|U| = 1`, together with Hermiticity of `v_j`. The norm half should be stated as
  `(h_*•1 − h_W).PosSemidef ∧ (h_*•1 + h_W).PosSemidef`, so that no Lean matrix norm has to be
  chosen; it is used by the Dyson bound (L33–L36) and Lemma 2.1. The norm half alone is
  optional for thm:main.
- **S3. Gauge covariance** `h_W(U^u) = u^* h_W(U) u` (M3; model L71), and
  `U^{e^{i(ϑ+φ)}} = U^{e^{iϑ}}` (P9; L85–L86). These are cheap and finite-dimensional, and they
  carry the finite-dimensional content of L54 and L85–L86. **Recommended**, with a literal
  gauge-action definition. Omitting them is acceptable if R8 is adopted.
- **S4. Wilson integrand at `m = 0`** (P13). T4 is the abstract remark at transfer L89–L91; no
  declaration states that the Wilson twisted integrand is `≥ 0` for `m ≥ 0`, which is what
  `0 < Z_ν ≤ Z_0` at `m = 0` uses. **Recommend** either a Wilson-level conjunct for `m ≥ 0`
  (nonnegativity) or freezing S2, so that T4 composed with (2.5) is a term-level composition.
- **S5. Fixed-charge-sector reading of `F̂_q`.** Not used explicitly by the source; acceptable to
  omit.
- **S6. `‖dΓ(εβ)‖ = 2Nε`** (P14). An alternative route; acceptable to omit.
- **S7. Capacity (2.9)** (M4). T3 takes `|Q| ≤ 2N` directly. Acceptable to omit.
- **S8. Heat-kernel positivity (4.3)** and the integration step (P11, which is already abstract
  in Lean as deviation 6) are not finite-dimensional fermionic content. Acceptable to omit.
- **S9. Form.** Split T3 into a positivity statement (no `Q`, `hQ`) and a Fourier statement, and
  add docstrings to T3 and T4 as the sealed theorems have. Optional: use `Circle` for link
  variables to make D7–D9's carrier exact.

## 6. Proposed rulings (text for the author)

- **R5 (history class for `thm:main`'s integrand; extends R1(a)).** "Theorem 4.1's fermionic
  integrand is frozen for finite piecewise-constant link histories. Such a history is a list of
  pairs `(τ_k, U_k)` with `τ_k ≥ 0`, `U_k : X → Fin 3 → ℂ`, `|U_k(x,j)| = 1` and `Σ_k τ_k = b`.
  Each pair contributes the free step `exp(−τ_k h_W(U_k))` built from (2.3), and the history
  ends with the gauge kick `exp(i diag θ ⊗ 1)`. This stands in for the continuous
  Brownian-bridge paths `ω` of (4.4)–(4.5) (comparison.tex L43–L51, L57–L61, L70–L72). The bridge
  endpoint conditions `ω_0 = U` and `ω_b = U^u` are not imposed. The passage from step paths to
  bridge paths (L50–L51) is not formalized."
- **R6 (record only).** "(a) In T3 the twist is `θ = ϑ + φ·1` with `ϑ ∈ ℝ^X` unrestricted: there
  is no root site with `ϑ_root = 0` and no reduction modulo 2π (L82–L84). This is a
  generalization. (b) As in R3, `F̂_0` real is stated as `Im F̂_0 = 0`, with the bound written
  against `Re F̂_0`."
- **R7 (scope of R1(a), R2 and R4 for the remark at transfer.tex L89–L91).** "The nonnegative-mass
  remark is frozen in Lemma 3.1's setting as fixed by R1(a), R2 and R4 (piecewise-constant
  histories, any finite spatial index, Hermitian kick generators), with `M ⪰ 0` for `m_* = 0`.
  Lemma 3.1's premise `b > 0` (L15) is retained."
- **R8 (scope; needed only if S1(a) is declined).** "For `thm:main` the centered trace of the
  twisted Wilson history is taken as the definition of the fermionic integrand
  `e^{−2iΣθ} det(I + uV_ω)`. The finite-CAR identity (comparison.tex L55), the identity
  `e^{iΣθ_x q_x} = e^{−2iΣθ_x} Γ(u)` and the fixed-charge reading of the `φ`-Fourier coefficient
  remain outside the frozen surface."

## 7. Lean runs

All commands were run from `lean/` through the gate. The scratch files were created under
`lean/.lake/scratch/caudA/` and deleted after this record.

1. `bash ../scripts/lean-gate.sh lake env lean .lake/scratch/caudA/DraftCopy.lean`.
   `DraftCopy.lean` is a byte-identical copy of the proposal (SHA-256 `e16372fb…fa2bc`). The
   output was two warnings, `declaration uses 'sorry'` at 38:8 (T3) and 62:8 (T4), and no
   errors; wall time 13 s. The `#check` output shows the elaborated binder lists exactly as
   tabulated in §3, with `F` and `Fhat` as `have`-bound lambdas,
   `Matrix.diagonal fun x => ↑(ϑ x + φ)`, `Complex.exp (−(↑p * ↑φ * Complex.I))` and
   `↑((4 * n ^ 3).choose (2 * n ^ 3 + Q.natAbs))`.
2. `bash ../scripts/lean-gate.sh lake env lean .lake/scratch/caudA/Probes.lean`
   (SHA-256 `6a98de94…2dac`, 205 lines: the draft declarations verbatim, then probes P1–P5).
   - The first run timed out (200000 heartbeats) in the `α_j β` anticommutation case of the
     Clifford witness.
   - The second run, with `set_option maxHeartbeats 2000000 in` on that witness, gave only the
     two expected `sorry` warnings and no errors; wall time 2 min 27 s.
   - The probes passed:
     - **P1a**: `(T_j *ᵥ f) x = star (U x j) * f (x + Pi.single j 1)`.
     - **P1b**: `(T_jᴴ *ᵥ f) x = U (x − e_j) j * f (x − e_j)`.
     - **P1c, P1d**: the D8 and D9 equations, with `(2:ℂ) • 1` confirmed by `pp.numericTypes`.
     - **e_j**: `Pi.single 1 1 = ![0,1,0]` in `ZMod 3` (`decide`).
     - **P2**: `n = 1` gives a diagonal `T_j`; `n = 2` has `x + 2e_j = x`; `latticeShift 0`
       elaborates; at `a = 0`, `v_j = 0` and `M = m•1`.
     - **P3**: `Fintype.card (Fin 3 → ZMod n) = n^3`.
     - **P4 (non-vacuity)**: a Dirac set (`β = diag(1,1,−1,−1)`, `α_j = [[0,σ_j],[σ_j,0]]`) satisfies
       all six Clifford hypotheses (proved). T3 then applies at `n = 3`, `a = m = 1`, `r = 0`,
       `links = [(1, fun _ _ => 1)]`, `b = 1`, `ϑ = 0`, `Q = 0`, and T4 applies at
       `ι = Unit`, `hist = [Step.free 1 (fun _ => 0) 0]`, `b = 1`. Both hypothesis sets are
       satisfiable.
     - **P5**: T4 instantiates at `ι = Fin 3 → ZMod 3` with no extra typing.

## 8. Per-theorem verdict blocks

```
T3 wilson_twisted_trace_pos_and_fourier_bound
DECLARATION_FIDELITY: PASS   (conditional on R5; R6 recorded; FAIL if R5 is declined)
DRAFT_ALLOWLIST: N/A         (not manifested)
PROOF_STATUS: FROZEN_UNPROVED (upon freeze)

T4 centeredTrace_nonneg_of_posSemidef_mass
DECLARATION_FIDELITY: PASS   (conditional on R7; FAIL if R7 is declined)
DRAFT_ALLOWLIST: N/A         (not manifested)
PROOF_STATUS: FROZEN_UNPROVED (upon freeze)
```
