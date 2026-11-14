# Statement audit B: T5 `wilson_mass_bound` and T6 `wilson_gauge_covariance`

Independent statement auditor B, 2026-11-14. Refute-first, following the `lean-statement-audit`
fail-closed checklist. Most of the effort went into semantic and numerical refutation, using
float64 sweeps, exact Gaussian-rational arithmetic and certified Arb ball arithmetic. The binder
test and Lean probes are included.

Independence. I read only the target draft, `paper-a/model.tex`, `lean/status.json`,
`lean/frozen-manifest.json` (the `def_dirac_operator_v1` entry), `lean/Core/PaperA/Defs/*.lean`,
`scripts/lean-gate.sh`, `docs/DECISIONS.md` (D11, D12, D15, D16) and Mathlib's `PosDef.lean` and
`Kronecker.lean`. I did not open anything under `docs/audits/**` other than this report, nor
`docs/PROGRESS.md`, `docs/campaign/**`, `lean/Core/PaperA/{Transfer,Fourier,Provider}/`, or any
temp or scratchpad directory outside the repository.

## 1. Verdicts

| Declaration | Statement true? | Matches source? | Vacuous? | EXCESS | New ruling | DECLARATION_FIDELITY |
|---|---|---|---|---|---|---|
| T5 `QEDCore.PaperA.wilson_mass_bound` | Yes. Proof sketch in §4.1; no counterexample in 2,520 instances plus optimization; the bound is **attained exactly** | Yes. The PSD pair is equivalent to "h_W Hermitian and ‖h_W‖_op ≤ h_*" | No (instantiated in Lean at n = 3 and n = 4) | 0 | None | **PASS** |
| T6 `QEDCore.PaperA.wilson_gauge_covariance` | Yes, as an exact identity: 0 nonzero difference entries in 17 exact rational instances; float deviation ≤ 4.4e-16 | Yes. u^* sits on the left, Kronecker order is spatial ⊗ spin, and the field is U^u | No (instantiated in Lean) | 0 | None | **PASS** |

## 2. Pinning

| Item | Value | Check |
|---|---|---|
| Target file | `docs/audits/pilot-chargegap/draft-v1b-with-T5-T6.lean.txt` (6,193 bytes) | SHA-256 `f3169e835332bd8f8b4095dcf31370935e5a76de67a8c07967d7f77bd9e5f339`, **matches** the brief and D16 |
| Source | `paper-a/model.tex` | SHA-256 `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e`, **matches** `lean/status.json` `pinned_sha256` and the `def_dirac_operator_v1` manifest revision; no working-tree changes |
| T5 source range | model.tex L39–L46, display (2.5) `eq:mass-bound` (L41–L45) | (2.3) is the L35 line of the `align` and (2.4) is L37, so (2.5) is the mass bound |
| T6 source range | model.tex L64–L71, display (2.6) `eq:gauge-unitary` and the sentence at L71 | |
| `diracOperator` | `lean/Core/PaperA/Defs/DiracOperator.lean`, manifest `def_dirac_operator_v1`, state SEALED | file SHA-256 `75ec4f63…caf68` **matches** `full_file_sha256` |
| D7–D9 | `latticeShift`, `wilsonHopping` and `wilsonMass` in the draft | The docstring and def blocks appear verbatim in the (then untracked) `lean/Core/PaperA/Defs/{LatticeShift,WilsonHopping,WilsonMass}.lean` |
| Rulings | `docs/DECISIONS.md` D11 (R1–R4) and D16 (R5–R8, plus the T5/T6 condition "two independent statement audits … no EXCESS binder and no new ruling") | D16 was absent when the audit started. It appeared in the working tree during the audit (I read it at SHA-256 `85d76387…`) and is now committed at `8e97f0c`. The T5/T6 paragraph is unchanged in the committed text |
| Toolchain | Lean v4.35.0 (`lean-toolchain`), vendored Mathlib | `Matrix.PosSemidef M := M.IsHermitian ∧ ∀ x : n →₀ R, 0 ≤ x.sum (fun i xi ↦ x.sum fun j xj ↦ star xi * M i j * xj)` (PosDef.lean L62) |

State: both theorems are draft `by sorry` (draft lines 78 and 95). Lean reports exactly one
`declaration uses sorry` per draft theorem and nothing else. For both, PROOF_STATUS is
FROZEN_UNPROVED once frozen.

## 3. Independent reconstruction of the source

Objects (model.tex L4–L6, L13, L27–L34):
- X = (ℤ/nℤ)³ with n ≥ 3 and spacing a > 0.
- Links e = (x, j) run from x to x + e_j, with U ∈ U(1)^ℰ.
- (T_j(U)f)(x) = conj(U_{xj}) f(x+e_j).
- v_j = (T_j − T_j^*)/(2ia).
- M = m + (r/2a) Σ_j (2 − T_j − T_j^*).
- h_W = Σ_j α_j v_j + β M, where α₁, α₂, α₃, β are Hermitian 4×4 matrices that square to one and
  anticommute pairwise.
- Spatial matrices commute with the Dirac matrices (L40), so `diracOperator` uses v_j ⊗ α_j.

**(2.5), L39–L46.** Premises: m ≥ 0 and r ≥ 0 (L39), the standing premises above, and unitarity
of T_j(U), which comes from |U_{xj}| = 1 (L40). Conclusions: M(U) ≥ mI and
‖h_W(U)‖ ≤ h_* := m + (3+6r)/a. The norm is the operator norm on ℓ²(X) ⊗ ℂ⁴. The source's
argument for the first claim is 2 − T − T^* = (I−T)^*(I−T) (L46).

**L64–L71.** For a gauge function u_x = e^{iθ_x}, define U^u_{xj} = u_x U_{xj} conj(u_{x+e_j}).
Then h_W(U^u) = u^* h_W(U) u, where u is the one-particle multiplication operator on
ℓ²(X) ⊗ ℂ⁴. As a matrix, (u^* A u)_{(x,s),(y,t)} = conj(u_x) A_{(x,s),(y,t)} u_y.

I checked consistency with the rest of the source. With W(u) = e^{iΣθ_x q_x} R_u (L68),
commutation with dΓ(h_W) requires Γ(u) dΓ(u^* h u) Γ(u)^* = dΓ(h). That holds exactly for this
orientation (u^* on the left, together with the conj in T_j).

## 4. Semantics and numerical refutation

### 4.1 Analytic status (why the statements are true)

**T5.**
1. Write T_j = D_j P_j, where P_j is the shift permutation and D_j = diag(conj U_{·j}). This is
   unitary exactly when |U| = 1.
2. Hence v_j is Hermitian with ‖v_j‖ ≤ 1/a.
3. M − m = (r/2a) Σ_j (I − T_j)^*(I − T_j) ⪰ 0, which uses T_j^* T_j = I. This is conjunct 1.
4. M has spectrum in [m, m + 6r/a], so ‖M‖ ≤ m + 6r/a. This uses m ≥ 0.
5. ‖α_j‖ = ‖β‖ = 1 because the matrices are Hermitian and square to one.
6. The triangle inequality gives ‖h_W‖ ≤ 3/a + m + 6r/a = h_*.
7. Since h_W is Hermitian, −h_* ≤ h_W ≤ h_*. These are conjuncts 2 and 3.

The anticommutation premises are not used. They are SOURCE premises (L28), so keeping them
is harmless.

**T6.**
1. For any D = diag(u), T_j(U^u) = D^* T_j(U) D. No unitarity is needed for this step.
2. Taking adjoints, T_j(U^u)^* = D^* T_j(U)^* D. So v_j(U^u) = D^* v_j(U) D for all u.
3. The identity part of M has coefficient m + 3r/a. That part is covariant only if
   D^*D = 1, which is exactly `hu`.
4. The mixed-product rule (A ⊗ B)(C ⊗ E) = AC ⊗ BE then gives
   h(U^u) = (D^* ⊗ 1) h(U) (D ⊗ 1).

The identity is linear in (α, β) and needs no constraint on U, a, m or r. This includes Lean's
junk value a = 0, where (2ia)⁻¹ = 0 and r/(2a) = 0.

### 4.2 Method

All three implementations below were written from model.tex alone. None was derived from the Lean
text.

1. **float64 (numpy/scipy).** Builds dense T_j, v_j, M and h_W = Σ kron(v_j, α_j) + kron(M, β),
   with the spatial factor first, as in `diracOperator`. It mirrors Lean's junk semantics at
   a = 0. Clifford sets are the standard Dirac representation and random unitary conjugates.
   I checked that all six Clifford relations hold to 1e-13.
2. **Exact (Python `Fraction`, Gaussian rationals).** Links and gauge functions are exact unit
   complex numbers (p² − q² + 2pqi)/(p² + q²). a, m and r are rational. The Clifford sets are the
   Dirac and Weyl (chiral) representations, both verified exactly. Null spaces use sympy
   `DomainMatrix` over `QQ_I`, and every eigenvector was re-verified with the independent
   Fraction arithmetic.
3. **Certified balls (python-flint 0.9.0, Arb, 128 bits).** Links U = exp(iθ) are exact unit
   complex numbers for float θ, and Arb encloses every entry of h_W. Each midpoint was checked
   against the float build (≤ 1e-12).
   - Lower bound on λ_max: a Rayleigh quotient in balls.
   - Upper bound λ_max(±h) < c: write c·I ∓ h = LL^* + δI + R, with L the float Cholesky factor
     of (c − δ)I ∓ h and R enclosed in balls. If ‖R‖_F < δ, the bound is certified.

Versions: Python 3.12.10, numpy 2.5.4, scipy 1.18.1, sympy 1.14.0, python-flint 0.9.0.

### 4.3 T5 results

**Edge-case grid (float64).** 2,520 instances in 160 s:
- n ∈ {3, 4, 5}
- links: ≡ 1, ≡ −1, ≡ i, π-flux, two random U(1) configurations, and a random uniform phase
- Clifford set: standard and a random unitary conjugate
- r ∈ {0, 0.25, 1, 3}, m ∈ {0, 0.5, 2}, a ∈ {1e-6, 1e-2, 1, 1e2, 1e6}

Results:
- max λ_max(h_W)/h_* = 1 + 2.9e-15, at n = 4, π-flux, r = m = 0
- max λ_max(−h_W)/h_* = 1 + 1.3e-15, at the same configuration
- min λ(M − mI)/scale = −7.4e-16
- Hermiticity residual ≤ 4.9e-17 relative

The largest excess over 1 is 2.9e-15, which is rounding level. It occurs at the configuration
where §4.4 proves exact equality.

**Clifford-set independence.** Across 20 random Clifford conjugates, the spectral deviation is
1.8e-14. This is expected: Cl₄(ℂ) ≅ M₄(ℂ) has a unique irreducible representation. The spectrum
is symmetric to 9e-15, from the chiral operator C₅ at L116–L118.

**How close does λ_max(±h_W) get to h_*?** The search maximized λ_max over all 3N link phases with
L-BFGS. The gradient is Hellmann–Feynman and was checked against finite differences to 2e-9. The
search used 60 restarts at n = 3 and 24 at n = 4, plus structured candidates. By chiral symmetry
the results for −h_W are identical.

| r | m | h_* | Uniform phase (any continuous k) | π-flux, n = 4 | Optimized, n = 3 | Optimized, n = 4 | max ‖h_W‖/h_* |
|---|---|---|---|---|---|---|---|
| 0 | 0 | 3 | 1.732051 | **3.000000** | 2.718978 | **3.000000** | **1.000000** |
| 0.25 | 0 | 4.5 | 1.921533 | 3.092329 | 2.846609 | 3.094331 | 0.687629 |
| 1 | 0 | 9 | 6.000000 | 4.732051 | 6.000000 | 6.000000 | 0.666667 |
| 3 | 0 | 21 | 18.000000 | 14.196152 | 18.000000 | 18.000000 | 0.857143 |
| 0 | 1 | 4 | 2.000000 | 3.162278 | 2.897040 | 3.162278 | 0.790569 |
| 1 | 1 | 10 | 7.000000 | 5.732051 | 7.000000 | 7.000000 | 0.700000 |
| 0.25 | 0.5 | 5 | 2.218799 | 3.250000 | 3.030861 | 3.255307 | 0.651061 |

These runs use a = 1. Every quantity scales as 1/a, which the grid confirms.

**Certified brackets (Arb).** Every case also certified h_* ∓ h_W ≻ 0 with margin.

| Instance | λ_max bracket | Ratio to h_* |
|---|---|---|
| n=3, optimized, r=m=0 | [2.718977586575, 2.718977592013] | 0.906326 |
| n=3, optimized, r=0.25, m=0 | [2.846609335928, 2.846609341621] | 0.632580 |
| n=3, optimized, r=1, m=0 | [5.999999999972, 6.000000011972] | 0.666667 |
| n=3, optimized, r=0, m=1 | [2.897039716245, 2.897039722039] | 0.724260 |
| n=3, optimized, r=0.25, m=0.5 | [3.030860924964, 3.030860931026] | 0.606172 |
| n=4, optimized, r=0.25, m=0 | [3.094331293292, 3.094331299481] | 0.687629 |
| n=3, random links, a=1e-6, m=0, r=0.25 | [2325374.94889, 2325374.95354] | 0.516750 |
| n=3, random links, a=1e6, m=2, r=3 | [2.000015195919, 2.000015199919] | 0.999997 (margin 5.8e-6, certified) |
| n=3, random links, a=0.37, m=0.5, r=1 | [14.734763450631, 14.734763480100] | 0.593562 |

For every row, ‖R‖_F ≤ 3.6e-9 against δ ≥ 2.9e-6.

### 4.4 T5: exact saturation and exact identities

- **The bound is attained.** Take n = 4, π-flux links (U_{x1} = 1, U_{x2} = (−1)^{x₁},
  U_{x3} = (−1)^{x₁+x₂}; every plaquette is exactly −1), with m = r = 0.
  - Exactly, dim ker(h_W − h_*) = 4 and dim ker(h_W + h_*) = 4. This was checked at a = 1
    (h_* = 3) and a = 1/5 (h_* = 15).
  - Float runs give the same at n = 8 (λ = 3.000000000000009). At n = 6 they give 3√3/2.
  - So conjuncts 2 and 3 hold with **zero margin**: h_*·1 ∓ h_W is singular PSD. The draft's
    constant cannot be lowered at r = 0.
  - The mechanism: π-flux makes the v_j pairwise anticommute, so the α_j ⊗ v_j commute and their
    joint top eigenvalues add up to 3/a. This needs 4 | n. At n = 3 the optimum found is
    2.71898/a.
- **Large-r slope.** With U ≡ −1 and ψ = const ⊗ e₀, h_W ψ = (m + 6r/a) ψ exactly. This was
  checked at n = 3, 4 with (a, m, r) = (1, 0, 4) and (2/3, 1/2, 10). So sup‖h_W‖ ≥ m + 6r/a for
  every r, and the ratio tends to 1 as r → ∞.
- **Best affine constant.** Any constant m + (A + Br)/a valid for all r ≥ 0 needs A ≥ 3 and
  B ≥ 6. The source's (3 + 6r)/a is therefore the best constant of that form, and each
  coefficient is individually sharp.
- **Conjunct 1 certificate (the source's L46 argument), exact.** With Pythagorean links at
  n = 3, 4 and (a, m, r) = (3/7, 5/11, 2/3):
  - T_j^* T_j = I exactly
  - M − mI − (r/2a) Σ_j (I − T_j)^*(I − T_j) = 0 exactly (zero nonzero entries)
  - h_W is exactly Hermitian

### 4.5 T6 results

- **float64:** 180 instances, maximum relative entry deviation **4.4e-16**. The instances cover:
  - n ∈ {3, 4, 5}
  - random U(1) links, π-flux and ≡ −1 links
  - Dirac and random Clifford sets
  - non-unit Gaussian links with arbitrary non-Clifford complex α and β
  - (a, m, r) ∈ {(1, .5, 1), (1e-3, 0, 0), (37, −2, −1.5), (0, 1.3, .7), (−.4, .2, 2)},
    with a = 0 using Lean's junk semantics
- **Exact:** 16 instances, n ∈ {3, 4} × {Dirac, Weyl} × (a, m, r) ∈ {(3/7, 5/11, 2/3), (1, 0, 0),
  (0, 1/3, 4), (−2, −1, −3/2)}, plus one instance with non-unit Gaussian-integer links and
  arbitrary Gaussian-integer α and β. Every instance has **0 nonzero entries** in LHS − RHS.
  T6 is an exact algebraic identity, and it remains true for arbitrary α, β, U, a, m and r.

## 5. Controls (each must break)

| Control | float64 rel. deviation or verdict | Exact witness |
|---|---|---|
| T6, U^u built with x − e_j | 0.560 (breaks) | 1,280 nonzero entries of 11,664 at n = 3. E.g. row (site (0,0,0), spin 0), column (site (0,0,1), spin 0): −136906/98345 + 200116/295035 i |
| T6, no conj in `latticeShift` | 0.561 (breaks) | 1,232 nonzero entries |
| T6, star on the right (u h u^*) | 0.561 (breaks) | 1,232 nonzero entries |
| T6, field U^{u^*} instead of U^u | 0.561 (breaks) | 1,232 nonzero entries |
| T6, \|u\| ≠ 1 (m = 5/11, r = 2/3) | 1.25 (breaks; `hu` is load-bearing) | 72 nonzero diagonal entries |
| *Consistency:* no conj in T **and** star on the right | 2.3e-16 (holds) | 0 entries. The two conventions are tied, and the draft's pair is the source's (L29–L31, L71) |
| *Consistency:* \|u\| ≠ 1 with m = r = 0 | 5.4e-16 (holds) | Only the identity terms of M need \|u\| = 1 |
| T5, smaller constant (2.99 + 6r)/a, or any A < 3 | Breaks: n = 4 π-flux, r = m = 0, ‖h_W‖ = 3/a | Exact eigenvector, kernel of dimension 4 |
| T5, (3 + 5r)/a, or any B < 6 | Breaks: U ≡ −1, r = 4, a = 1: 24 > 23 | Exact eigenvector |
| T5, halved constant m + (3+6r)/(2a) | Breaks under both witnesses above (e.g. 3 > 1.5 at r = m = 0) | Exact |
| T5, free-field constant √3/a at r = m = 0 | Breaks: 3 > 1.732 | Exact |
| T5, m < 0: m = −2, r = 0, a = 1, U = 1 | λ_max = √7 = 2.646 vs h_* = 1 (breaks by 2.65×) | h_W ψ = −2ψ exactly for ψ = const ⊗ e₀, so ⟨ψ, (h_* + h_W)ψ⟩ = −‖ψ‖² < 0 |
| T5, m < 0: m = −5, r = 1 (or −4.6, r = 1) | 5.0 vs 4.0 (4.6 vs 4.4), breaks | U = 1 gives ‖h‖ ≥ \|m\|, which refutes every m < −(3+6r)/(2a) |
| T5, m = −0.1 | 1.735 ≤ 2.9 (does not break) | `hm` is not tight but is necessary in general |
| T5, non-unit links \|U\| = 1.5 | min λ(M − m) = −1.5 (conjunct 1 breaks) | `hU` is load-bearing |
| T5, α₁ → 2α₁ (violates α² = 1), π-flux n = 4 | ‖h‖ = 4 > 3 (breaks) | The Clifford norm premises are load-bearing |

## 6. Five-bin binder test

Convention: a data binder that names a source-quantified object is SOURCE, with the carrier
choice noted. Pure instance or type-formation binders are TYPING. The project has no audited
standing-assumption bundle. The section-level premises of model.tex are explicit binders, so they
are SOURCE rather than STANDING.

### T5 `wilson_mass_bound` (19 binders)

| # | Binder | Bin | Citation and note |
|---|---|---|---|
| 1 | `{n : ℕ}` | SOURCE | L4: X = (ℤ/nℤ)³. The carrier `Fin 3 → ZMod n` is the approved D7 carrier |
| 2 | `[NeZero n]` | TYPING | Needed for `Fintype (ZMod n)`, so that PosSemidef and the matrix 1 make sense. Implied by `hn` |
| 3 | `hn : 3 ≤ n` | SOURCE | L4 "n ≥ 3" |
| 4 | `α : Fin 3 → Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | L27 α₁, α₂, α₃ |
| 5 | `β : Matrix (Fin 4) (Fin 4) ℂ` | SOURCE | L27 β |
| 6 | `hα_herm` | SOURCE | L27 "Hermitian" |
| 7 | `hβ_herm` | SOURCE | L27 "Hermitian" |
| 8 | `hα_sq` | SOURCE | L28 "square to one". Load-bearing (§5) |
| 9 | `hβ_sq` | SOURCE | L28 "square to one" |
| 10 | `hα_anti` | SOURCE | L28 "anticommute pairwise", α–α pairs. Not needed for truth; harmless |
| 11 | `hαβ_anti` | SOURCE | L28, α–β pairs. Not needed for truth; harmless |
| 12 | `a : ℝ` | SOURCE | L4 "spacing a" |
| 13 | `m : ℝ` | SOURCE | L33 (in M(U)), L39 |
| 14 | `r : ℝ` | SOURCE | L33, L39 |
| 15 | `ha : 0 < a` | SOURCE | L4 "a > 0" |
| 16 | `hm : 0 ≤ m` | SOURCE | L39 "m ≥ 0". Load-bearing (§5) |
| 17 | `hr : 0 ≤ r` | SOURCE | L39 "r ≥ 0". Needed for conjunct 1 |
| 18 | `U : (Fin 3 → ZMod n) → Fin 3 → ℂ` | SOURCE | L5–L6 (links (x, j)), L9 and L13 (U ∈ U(1)^ℰ). ℂ-valued, with the U(1) constraint in binder 19 |
| 19 | `hU : ∀ x j, ‖U x j‖ = 1` | SOURCE | L9 U(1)^ℰ, L13 U_e = e^{iφ_e}, L40 "T_j(U) is unitary". Load-bearing (§5) |

Counts: **SOURCE 18, STANDING 0, TYPING 1, RULED 0, EXCESS 0.**

Other comparisons:
- **Order and scope.** All binders are universal and come before the colon. The constant h_* is
  a closed-form term in (m, r, a), with no existential.
- **Missing premises.** None. Every source premise needed for (2.5) is present. The source
  mentions no extra one, and the analysis found none.

### T6 `wilson_gauge_covariance` (11 binders)

| # | Binder | Bin | Citation and note |
|---|---|---|---|
| 1 | `{n : ℕ}` | SOURCE | L4 |
| 2 | `[NeZero n]` | TYPING | `Fintype (ZMod n)` for the matrix products; implied by `hn` |
| 3 | `hn : 3 ≤ n` | SOURCE | L4. Not used by the identity; a retained source premise |
| 4 | `α` | SOURCE | L27. The Clifford premises L27–L28 are **omitted**, which strengthens the statement |
| 5 | `β` | SOURCE | L27. Same note as α |
| 6 | `a : ℝ` | SOURCE | L4. `0 < a` is omitted; the identity holds at a = 0 (junk) and a < 0, exactly |
| 7 | `m : ℝ` | SOURCE | L33. `0 ≤ m` is omitted |
| 8 | `r : ℝ` | SOURCE | L33. `0 ≤ r` is omitted |
| 9 | `U` | SOURCE | L9, L13. The unit-modulus premise is omitted; verified exactly with non-unit links |
| 10 | `u : (Fin 3 → ZMod n) → ℂ` | SOURCE | L64 "gauge function u_x" |
| 11 | `hu : ∀ x, ‖u x‖ = 1` | SOURCE | L64 u_x = e^{iθ_x}. Load-bearing (§5) |

Counts: **SOURCE 10, STANDING 0, TYPING 1, RULED 0, EXCESS 0.**

**Omitted Clifford and unit-link premises.** The omission makes T6 a faithful, stronger
statement and hides no needed premise. Three reasons:
1. h_W is linear in (α, β), and T_j(U^u) = D^* T_j(U) D holds for every complex U.
2. On the source domain, T6 specializes verbatim to L71.
3. The only premise the identity needs, |u_x| = 1, is present, and the |u| ≠ 1 control shows it
   matters.

## 7. Conclusion fidelity

**T5, conjunct 1.** `(wilsonMass n a m r U - (m : ℂ) • 1).PosSemidef` is exactly M(U) ≥ mI in the
Loewner order. Mathlib's PosSemidef includes Hermiticity, and the quadratic form is real and
nonnegative under `ComplexOrder`.

**T5, conjuncts 2 and 3.** `(h_*•1 − h_W).PosSemidef ∧ (h_*•1 + h_W).PosSemidef`, with
h_* = `((m + (3 + 6 * r) / a : ℝ) : ℂ)`.
- Each conjunct contains `IsHermitian`, and h_*•1 is Hermitian, so the pair forces h_W to be
  Hermitian.
- For Hermitian h, (−c ≤ h ≤ c) ⇔ spec(h) ⊂ [−c, c] ⇔ ‖h‖_op ≤ c.
- So the pair is **exactly** "h_W is Hermitian and ‖h_W‖_op ≤ h_*". Hermiticity follows from
  the source premises (verified exactly in §4.4) and is implicit in h_W being the one-particle
  Hamiltonian (L112).
- The constant is the source's m + (3+6r)/a (L43), character for character, and §4.4 shows it is
  sharp.
- The rendering is two-sided, unlike a weaker one-sided λ_max bound. It also avoids Mathlib's
  non-canonical matrix norms. Under the Frobenius norm, for example, the claim would be false:
  for m = r = 0, any unit links and n ≥ 3, ‖h_W‖_F = √(6N)/a. That is 12.73 at n = 3, a = 1,
  against h_* = 3 (checked numerically).

**T6.**
- **The star is on the left.** The appended Lean lemma `rhs_entry` proves that the RHS entry at
  ((x,s), (y,t)) is `star (u x) * A (x,s) (y,t) * u y`. That is the matrix of u^* A u (L71).
  The opposite placement breaks (§5).
- **Kronecker order.** `diagonal u ⊗ₖ 1₄` matches `diracOperator`'s `v j ⊗ₖ α j` (spatial
  first). The order is type-forced: `1₄ ⊗ₖ diagonal u` has index type `Fin 4 × X` and would not
  elaborate.
- **The field.** `fun x j => u x * U x j * star (u (x + Pi.single j 1))` is the source's
  U^u_{xj} = u_x U_{xj} conj(u_{x+e_j}). It is not U^{u^*}, a control that breaks.
- **Equality.** The conclusion is an equality of matrices over `X × Fin 4`. No unfolding of
  `diracOperator` is hidden.

**Semantic closure.** The project definitions in the two types are `latticeShift`,
`wilsonHopping`, `wilsonMass` (D7–D9, approved) and `diracOperator` (sealed). I read all four,
and their bodies match model.tex (2.3) as reconstructed in §3. No other project-owned definition,
alias or structure occurs.

## 8. Non-vacuity and exact-type checks in Lean

I generated a transient file, `lean/.lake/scratch/t56B/T56B_check.lean`, with
`gen_lean.py <repo>`. It consists of the draft bytes (hash-checked) followed by auditor B's
appended block. I compiled it from `lean/` with:

`bash ../scripts/lean-gate.sh lake env lean .lake/scratch/t56B/T56B_check.lean`

The run exited 0 in 27 s. The only diagnostics were four `declaration uses sorry` warnings, at
draft lines 38, 62, 78 and 95 (T3, T4, T5, T6), and six unused-`simp`-argument linter warnings in
the appended proofs. The file was deleted afterwards. The appended block contains:

1. **Exact-type checks.** For both theorems, an `example` whose type is auditor B's
   reconstruction is closed by the bare export (`@QEDCore.PaperA.wilson_mass_bound`,
   `@QEDCore.PaperA.wilson_gauge_covariance`). The reconstruction has the binders in source
   order, h_* as a `let`, and for T6 the field U^u written with `conj` (= `starRingEnd ℂ`)
   instead of `star`. Both are accepted.
2. **`rhs_entry`** (the star orientation; sorry-free). Axioms: `propext`, `Classical.choice`,
   `Quot.sound`.
3. **Standard Dirac matrices with all six Clifford premises proved** (`αD_herm`, `βD_herm`,
   `αD_sq`, `βD_sq`, `αD_anti`, `αβD_anti`; sorry-free, standard axioms only).
4. **Instantiations.**
   - T5 at n = 3 with U ≡ 1 and (a, m, r) = (1, 0, 0).
   - T5 at n = 4 with the π-flux links (±1), the case where it saturates.
   - T6 at n = 3 with u ≡ i, non-unit U ≡ 2 and (a, m, r) = (1, 1/2, 2).

   Every premise is discharged, so neither theorem is vacuous.
5. **Consumption witness.** T5's first conjunct at m = 0 yields `(wilsonMass n a 0 r U).PosSemidef`
   by `simpa`. That is exactly T4's per-step premise `M.PosSemidef`, so conjunct 1 is in a usable
   form.

## 9. Rulings needed

**None, for either declaration.**
- **T5.** The PSD-pair rendering is an exact equivalence (§7), not a deviation.
- **T6.** It drops the premises it does not need: the Clifford relations, |U| = 1, a > 0, m ≥ 0
   and r ≥ 0. This strictly generalizes the source and specializes to L71 verbatim. It requires
   no correction of the source.

Optionally, the author may log T6's generalization as a record-only note in the style of D16's
R6. It is not a ruling, and D16's condition ("no new ruling") is met.

## 10. Reproduction

All scripts are in `lean/.lake/scratch/t56B/` (git-ignored); run them from that directory.

| File | SHA-256 |
|---|---|
| `t56_num.py` | `4e6d71d5b7ccd5c945e83f28244634d048d116bcff1ca4f16d3d629604764fb6` |
| `t56_exact.py` | `e1abb9ab0e8045de141a180ec78a78954832a819d91ff500a4185dd65ebf9df7` |
| `t56_ball.py` | `41efc6b15fe3655c2784e68106a8eb9275f4e8400a44805c6d0237605773f077` |
| `gen_lean.py` | `8a379fa4ae0393558319043db4c42acebb0755e5191dfbbc8e4649e796eb59a9` |

```
python -I t56_num.py grid cliff t6 t5c                       # ~3 min: grid, Clifford invariance, T6, T5 controls
OMP_NUM_THREADS=4 python -I t56_num.py sup0,1,2,3,4,5,6      # ~2.5 min: sup table; writes theta_*.npy
python -I t56_exact.py t6 t5 sat minus                       # ~15 s: exact identities, controls, saturation kernel
python -I t56_ball.py                                        # ~5 s: certified brackets (needs theta_*.npy)
# Lean (from lean/):
python -I .lake/scratch/t56B/gen_lean.py "$(cd .. && pwd)"
bash ../scripts/lean-gate.sh lake env lean .lake/scratch/t56B/T56B_check.lean
rm .lake/scratch/t56B/T56B_check.lean
```

The repository HEAD at report time was `8e97f0c`. During the audit, the orchestrator committed
D16 and the D7–D9 definition files.

## 11. Per-declaration verdicts

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
