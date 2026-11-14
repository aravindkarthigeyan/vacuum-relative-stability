# Topology review, revision 5: proof steps of Theorem 4.1 (nodes and coverage)

- Graph reviewed: `docs/graph/DEPGRAPH.md` (revision 5, schema `GRAPH_VERSION: 4`; 71 nodes and 195
  edges, of which 19 nodes and 61 edges are new) and `docs/graph/DEPGRAPH_COVERAGE.md` (60 items,
  20 EXCLUDED; 37 items PROPOSED).
- Scope: every record whose status is PROPOSED, which means the 19 new nodes and the 37 PROPOSED
  coverage items (33 new, plus 4 earlier items the writer changed: `transfer:remark-centering`,
  `transfer:remark-massless`, `model:wilson` and `model:tensor-structure`). I also checked the
  header changes. The global closure review is not part of this report.
- Reviewer: `topology-reviewer-2`, a fresh adversarial node/coverage reviewer (a subagent of session
  f3486c47). I did not write or extract any part of this graph. Date 2026-11-14.
- Method: I rebuilt each record from the raw LaTeX it cites. I made no proof attempts and no Lean
  judgments, and I edited no file other than this report. From Lean I read only the
  declaration-only frozen files and the identity fields of the manifest. I did not read any
  provider or implementation module.
- Defect classes, as in `TOPOLOGY_REVIEW_NODES.md`:
  - **T**: topology. A missing, reversed, transitive or unnecessary edge, or a missing node.
  - **S**: source fields. A dropped premise, a wrong quantifier, or a strengthened or weakened
    conclusion or scope.
  - **G**: SOURCE_GAP marking or grade.
  - **L**: EDGE locator.
  - **R**: framing. A SOURCE_HYPOTHESES entry restates the conclusion of a prerequisite node that
    also arrives through an edge.
  - **F**: frozen-field identity.

## 1. Hashes verified

| File | SHA-256 computed | Graph and coverage CORPUS | `lean/status.json` `source.pinned_sha256` | Result |
|---|---|---|---|---|
| `paper-a/transfer.tex` (134 lines) | `b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf` | same | same | match |
| `paper-a/model.tex` (129 lines) | `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e` | same | same | match |
| `paper-a/comparison.tex` (208 lines) | `1caaf36bb7ab5f90c15224be3bc0f1eb20baeae06f40fb7c340ad3145db13273` | same | same | match |
| `lean/frozen-manifest.json` | `a9ab3a4a4c4e0a47a907d7507cce98f444561c09e76046302d437a7fb931feaf` | `FROZEN_MANIFEST` pin | n/a | match |

- The CORPUS line is byte-identical in both files. `status.json` dates the source as the draft of
  29 October 2026, as the header says.
- Frozen-field identity was checked by script for all 15 `FROZEN_ANCHORS`. For each one,
  FROZEN_FILE, FROZEN_DECL, FROZEN_ANCHOR_ID, FROZEN_ABI_SHA256, CONTRACT_ID and CONTRACT_VERSION
  equal the manifest's `path`, `export`, `id`, `abi_sha256`, `contract.id` and `contract.version`.
  The header lists exactly the manifest's 15 anchors. The seven new anchors are:

  | Anchor | ABI hash | State |
  |---|---|---|
  | `main_twisted_integrand_v1` | b83a0c8a… | DRAFT_SORRY |
  | `rem_nonneg_mass_v1` | 8da711bd… | DRAFT_SORRY |
  | `gauge_covariance_v1` | a9c88dba… | DRAFT_SORRY |
  | `eq_mass_bound_v1` | 218a7458… | DRAFT_SORRY |
  | `def_lattice_shift_v1` | 3400f002… | SEALED |
  | `def_wilson_hopping_v1` | 7349b3eb… | SEALED |
  | `def_wilson_mass_v1` | 4e71de78… | SEALED |

  Every non-anchor new node has `-` in all four `FROZEN_*` fields. No F defect.
- Linter: `python -I scripts/proof_depgraph.py --db docs/graph/DEPGRAPH.md --manifest
  docs/graph/DEPGRAPH_COVERAGE.md --source-root . --require-complete-coverage
  --require-initial-lean-status --require-all-reachable --check` exits 0 with no output.

## 2. Source spans re-read

- `paper-a/comparison.tex` L1-L208 (the whole file; the corpus is L4-L104).
- `paper-a/model.tex` L1-L129 (the whole file; the corpus is L4-15, L27-46, L62-71, L86-97 and
  L116-118).
- `paper-a/transfer.tex` L1-L134 (the whole file).
- `paper-a/main.tex` L30-L50 and L90-L100, only to see how "admissible" is used. L96 places the
  admissible sectors in Section 2, where (2.9) characterizes the nonempty sectors `H_nu != 0` by
  `|Q_nu| <= 2N`.
- Frozen declarations (identification only):
  - `lean/Frozen/PaperA/{WilsonTwistedTraceBound,CenteredTraceNonneg,WilsonMassBound,WilsonGaugeCovariance}.lean`
  - `lean/Core/PaperA/Defs/{LatticeShift,WilsonHopping,WilsonMass}.lean`
  - `lean/frozen-manifest.json`, identity fields only.
- `docs/DECISIONS.md` D11, D14 and D16 (R5-R8, T5, T6), and `docs/ERRATA-AND-DEVIATIONS.md`
  deviations 6-11.

## 3. Header findings

**Accurate:**
- `ROOTS`: five roots, each a frozen anchor.
- `CORPUS`: every line cited by a new node or item lies inside the declared ranges.
- `FROZEN_ANCHORS` and the `FROZEN_MANIFEST` pin.
- `CONVENTIONS`, revision-5 clause. Checked against the source and the frozen files:
  - torus and dimensions: model.tex L4-L5, `D = 4N`, `d = 2N`;
  - the Wilson conventions of (2.3) and `e_j = Pi.single j 1`;
  - the gauge action, model.tex L64-L66;
  - the two-sided encoding of the bound in (2.5);
  - R5 to R8, including the bridge endpoints `omega_0 = U`, `omega_b = U^u` from
    `E_{U -> U^u}^b` at comparison.tex L59;
  - "later steps on the left", so the transfer matrix is `u V_omega`.
- `EXTERNAL_POLICY`: no `\cite` in the added lines. The named standard results (finite-CAR
  identity, Dyson and Feynman-Kac) sit in excluded parts.

**H1 (S, in a REVIEWED record, outside this review's scope; triggered by the CORPUS change).**
- `lem:fourier#twist-is-kick` says in SOURCE_HYPOTHESES "(dGamma and the Fock space are in model.tex
  L8-12, L36, outside the corpus)".
- Revision 5 brings model.tex L4-15 and L27-46 into the corpus, so both ranges are now inside it.
- Proposed `AMEND` with `SET_SOURCE_HYPOTHESES` (or an in-place fix, if the orchestrator treats
  revision 5 as a drafting round):

  ```
  SET_SOURCE_HYPOTHESES: Q = dGamma(I) - d (dGamma and the Fock space are in model.tex L8-12 and L36; eq:hilbert is EXCLUDED and H of (2.4) lies outside the frozen surface, R8); the history of Lemma 3.1; D = 2d
  ```

- In the same way, the REASON of the REVIEWED item `transfer:remark-prefactor` says "no obligation
  for either root". There are now five roots, so it should read "no obligation for any root".

**H2 (advisory, prose).**
- Header prose L31-L32 says the closures reach `lem:transfer` and `lem:fourier` "where
  comparison.tex L71-L72 and L88-L89 apply them".
- It omits the third application, `rem:nonneg-mass#apply-transfer` -> `lem:transfer` at
  transfer.tex L89-L90.
- Replace with: "which reach `lem:transfer` and `lem:fourier` where comparison.tex L71-L72 and
  L88-L89 and transfer.tex L89-L90 apply them".

**H3 (advisory).**
- `WRITER` is still `orchestrator-f3486c47`, while the prose says `graph-writer-2` "added" the
  revision-5 records, and those records carry `EXTRACTOR: graph-writer-2`.
- This is consistent if the orchestrator remains the single writer that merges and applies the
  verdicts. If not, record that in `WRITER` or in the prose.

**H4 (advisory).**
- The `EXTERNAL_POLICY` list "(Poisson summation in (4.3), the Dyson and Feynman-Kac
  representation, the finite-CAR identity)" reads as closed.
- The excluded parts also use dominated convergence (comparison.tex L51), a Hilbert-Schmidt trace
  formula (L64-L66) and compact resolvent (L95).
- Write "for example" before the list, or add these three.

**H5 (optional, an alternative to the per-node fixes N11, N14 and N15).** Add to CONVENTIONS:

```
H41 abbreviates the hypotheses of thm:main#twisted-integrand: X = (Z/nZ)^3 with n >= 3 and N = n^3; a Hermitian 4x4 Clifford set commuting with spatial matrices; a > 0, m > 0, r >= 0, b > 0; a step history of pairs (tau_k, U_k) with tau_k >= 0, |U_k(x, j)| = 1 and sum_k tau_k = b (R5); every thm:main#* step or application assumes H41 unless its SOURCE_HYPOTHESES names a part of it
```

## 4. Node table (19 nodes): 13 PASS, 6 FAIL

| # | Node | Verdict | Class | Spans re-read and finding |
|---|---|---|---|---|
| 1 | thm:main#twisted-integrand | PASS | | comparison L4-L21, L43-L91; model L4-L5, L13, L27-L40, L64; transfer L95-L98. The fields match the source under R5, R6 and R8, and the binder order matches the frozen statement (n, Clifford set, a, m, r, links, b, vartheta, Q with abs Q <= 2N; positivity for every phi). The closure reaches `lem:transfer` through apply-transfer (L71-L72) and `lem:fourier` through apply-fourier (L88-L89), and nowhere else. The CONSTANT_SCOPE is right. |
| 2 | rem:nonneg-mass | PASS | | transfer L9-L36, L89-L91; comparison L98-L99. The hypotheses match the frozen statement: Clifford set, tau >= 0, Hermitian v_j, M positive semidefinite, Hermitian kick generator, b > 0 retained (R7). "May vanish" is rightly not a conclusion. The edges carry the epsilon-shift and limit argument. Advisory A2. |
| 3 | def:lattice-shift | PASS | | model L4-L6, L29-L31. The frozen matrix `if y = x + e_j then conj(U x j)` gives (T f)(x) = conj(U_xj) f(x + e_j). |
| 4 | def:wilson-hopping | PASS | | model L32. |
| 5 | def:wilson-mass | PASS | | model L33, L39. |
| 6 | eq:mass-bound#shift-unitary | PASS | | model L13, L29-L31, L40. SOURCE_GAP [minor] is justified: the source asserts "Since T_j(U) is unitary" without an argument. |
| 7 | eq:mass-bound | **FAIL** | T, R | model L39-L46. **T:** the frozen form (h_* 1 -/+ h_W(U) positive semidefinite) is the source's norm bound only for Hermitian h_W(U) (deviation 11). The writer's own NOTE on norm-bound says so. But no edge brings h_W(U) Hermitian into this anchor's closure, which hides an obligation of the frozen statement. The graph already has the nodes `thm:main#wilson-hopping-hermitian` and `lem:transfer#dirac-hermitian`. **R:** "so that T_j(U) is unitary (L40)" restates the conclusion of shift-unitary. |
| 8 | eq:mass-bound#mass-lower-bound | **FAIL** | R | model L39-L46. "T_j(U) unitary (L40), i.e. U in U(1)^E" restates the conclusion of the prerequisite shift-unitary, which also arrives through its edge. The source premise is abs U_xj = 1 (L13). Edges and the no-gap ruling are correct: the method is named at L46. |
| 9 | eq:mass-bound#norm-bound | **FAIL** | R | model L27-L28, L39-L43. Same R defect: "T_j(U) unitary (L40)". The SOURCE_GAP [minor] is justified. Arithmetic checked: 3 times 1/a, plus m, plus (r/2a)·3·4 gives h_* = m + (3 + 6r)/a. The NOTE should point to the edges added in N7. |
| 10 | thm:main#wilson-hopping-hermitian | PASS | | model L32; comparison L71-L72; transfer L15. ((T - T^*)/(2ia))^* = (T - T^*)/(2ia) for any real nonzero a, so SOURCE_GAP [minor] is justified. Optional: after N7 its NOTE can also name eq:mass-bound as a consumer. |
| 11 | thm:main#wilson-history | **FAIL** | S | comparison L48-L49, L71-L72, L86-L89. SOURCE_HYPOTHESES lists the root's hypotheses on n, the Clifford set, a, m, r and the step history, but drops **b > 0**. In the root, b > 0 is a separate premise (L12). The conclusion "satisfies H31 with total free time b" needs b > 0 (transfer.tex L15). So Lemma 3.1's premise b > 0 is not supplied at either application. Advisory A3 on one locator. |
| 12 | thm:main#integrand-centered-trace | PASS | | transfer L83-L88; comparison L48-L49, L56-L63, L86-L88. The kick u = exp(i diag(theta) (x) I_4) has Tr Theta = 4 sum theta and centering e^{-2i sum theta}. The free steps give exp((1/2) tau Tr h_W) = 1, hence the edge to trace-h-zero. SOURCE_GAP [minor] is justified, and so is the R8 remark. |
| 13 | thm:main#twist-split | PASS | | comparison L82-L88. The two kicks commute. Centerings: e^{-2i sum vartheta} e^{-i d phi} with d = 2N equals e^{-2i sum theta}. The result matches lem_fourier_v1's appended Step.kick (phi * 1). SOURCE_GAP [minor] is justified, and it is a genuine Lean obligation. |
| 14 | thm:main#apply-transfer | **FAIL** | S | comparison L70-L72. SOURCE_HYPOTHESES is only "m > 0; the step history of thm:main#twisted-integrand followed by the gauge kick u". It drops the Clifford set, a > 0, r >= 0 and b > 0. Its prerequisite wilson-history needs all four to discharge Lemma 3.1's premises: Hermitian v_j, M >= mI, b > 0. Edges and locators are correct. |
| 15 | thm:main#apply-fourier | **FAIL** | S | comparison L82-L89. Same defect: "m > 0; abs Q <= 2N; the step history ..." drops the Clifford set, a > 0, r >= 0 and b > 0, which wilson-history needs to supply Lemma 3.2's history premise. Restating m > 0 and abs Q <= 2N while omitting the rest makes the omission explicit. Edges, the binomial match (binom(2d, d + abs q) with d = 2N) and the no-gap ruling are correct. |
| 16 | model:gauge-covariance | PASS | | model L4, L13, L27-L40, L64-L71. The fields match the source. The NOTE correctly says the frozen statement is more general: only abs u_x = 1, any U, a, m, r, no Clifford relations. This is checked against `WilsonGaugeCovariance.lean`. Being its own root is justified: comparison L54 and L85-L86 lie on the excluded side. Advisories A2 and A6. |
| 17 | model:gauge-covariance#shift-covariance | PASS | | model L66-L71. (T_j(U^u) f)(x) = conj(u_x) conj(U_xj) u_{x+e_j} f(x + e_j) = (u^* T_j(U) u f)(x), with no need for abs u = 1. SOURCE_GAP [minor] is justified. |
| 18 | rem:nonneg-mass#apply-transfer | PASS | | transfer L9-L36, L89-L90. M + eps I >= eps I > 0 with the same free times. Only positivity is used. Not a gap. |
| 19 | rem:nonneg-mass#continuity | PASS | | transfer L89-L91. SOURCE_GAP [minor] matches the grade of the reviewed `lem:transfer#homotopy-continuity` for step histories. |

### 4.1 Replacement fragments for every FAIL

Only the changed fields are shown. DEPS lines are complete. EDGE lines marked "(new)" are added,
and all other EDGE lines stay.

**N7 eq:mass-bound (T, R)**
```
SOURCE_HYPOTHESES: X = (Z/nZ)^3 with n >= 3 (model.tex L4); alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (L27-28), commuting with spatial matrices (L39-40); a > 0 (L4); m >= 0 and r >= 0 (L39); U in U(1)^E, |U_{xj}| = 1 for every link (L13)
DEPS: eq:mass-bound#mass-lower-bound, eq:mass-bound#norm-bound, def:wilson-mass, def:wilson-hopping, def:dirac-operator, thm:main#wilson-hopping-hermitian, lem:transfer#dirac-hermitian
EDGE: thm:main#wilson-hopping-hermitian | paper-a/model.tex#eq:mass-bound@L43-L43 | ‖h_W(U)‖ <= h_* is frozen as h_* 1 -/+ h_W(U) positive semidefinite (deviation 11), which needs h_W(U) Hermitian: v_j(U) Hermitian   (new)
EDGE: lem:transfer#dirac-hermitian | paper-a/model.tex#eq:mass-bound@L43-L43 | h_W(U) = sum_j alpha_j v_j(U) + beta M(U) is Hermitian for Hermitian v_j(U) and M(U), M(U) by the first assertion   (new)
NOTE: <existing text> The two-sided encoding equals the source's norm bound only for Hermitian h_W(U) (deviation 11); that Hermiticity, which the source never states, reaches this anchor through thm:main#wilson-hopping-hermitian (v_j(U), SOURCE_GAP [minor]), eq:mass-bound#mass-lower-bound (M(U)) and lem:transfer#dirac-hermitian (h, SOURCE_GAP [minor]).
```

**N8 eq:mass-bound#mass-lower-bound (R)**
```
SOURCE_HYPOTHESES: a > 0 (model.tex L4); m >= 0 and r >= 0 (L39; only r >= 0 is used); U in U(1)^E, |U_{xj}| = 1 for every link (L13)
```

**N9 eq:mass-bound#norm-bound (R)**
```
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I (model.tex L27-28), commuting with spatial matrices (L39-40); a > 0 (L4); m >= 0 and r >= 0 (L39); U in U(1)^E, |U_{xj}| = 1 for every link (L13)
NOTE: SOURCE_GAP: [minor] asserted from 'Since T_j(U) is unitary' alone; the triangle inequality with ||alpha_j|| = ||beta|| = 1 (Hermitian involutions), ||v_j(U)|| <= 1/a and ||M(U)|| <= m + (r/2a) 3 4 = m + 6r/a (using m >= 0, r >= 0) is not written. The frozen two-sided form h_* 1 -/+ h_W(U) positive semidefinite is equivalent for Hermitian h_W(U); that Hermiticity, which the source does not state, reaches the anchor eq:mass-bound through its edges to thm:main#wilson-hopping-hermitian and lem:transfer#dirac-hermitian (M(U) by the first assertion). No other root uses this assertion.
```

**N11 thm:main#wilson-history (S)**
```
SOURCE_HYPOTHESES: the hypotheses of thm:main#twisted-integrand on n, the Clifford set, a > 0, m > 0, r >= 0, b > 0 and the step history; theta in R^X
```

**N14 thm:main#apply-transfer (S)**
```
SOURCE_HYPOTHESES: the hypotheses of thm:main#twisted-integrand on n, the Clifford set, a > 0, m > 0, r >= 0, b > 0 and the step history; the gauge kick u = e^{i theta}, theta in R^X, appended to the step history
```

**N15 thm:main#apply-fourier (S)**
```
SOURCE_HYPOTHESES: the hypotheses of thm:main#twisted-integrand on n, the Clifford set, a > 0, m > 0, r >= 0, b > 0 and the step history; the relative kick e^{i vartheta}, vartheta in R^X, appended to the step history; an integer Q with |Q| <= 2N
```

If the orchestrator adopts H5 instead, the three S fragments become `SOURCE_HYPOTHESES: H41;
theta in R^X` (N11), `H41; the gauge kick u = e^{i theta}, theta in R^X, appended` (N14) and
`H41; the relative kick e^{i vartheta}, vartheta in R^X, appended; an integer Q with |Q| <= 2N`
(N15).

### 4.2 Advisories (no FAIL)

**A1 (modeling choice).**
- `thm:main#wilson-history` depends on the whole anchor `eq:mass-bound`, but the source uses only
  its first assertion (comparison.tex L71-L72).
- As a result, `eq:mass-bound#norm-bound`, and after N7 the Hermiticity of h_W(U), lie in the
  closure of `thm:main#twisted-integrand`, although the source never uses them there.
- This matches the convention that an application depends on the applied result:
  `thm:main#apply-transfer` -> `lem:transfer`, of which only positivity is used. I accept it.
- The alternative is the edge `wilson-history` -> `eq:mass-bound#mass-lower-bound`, with
  `eq:mass-bound` added to ROOTS.

**A2.** SOURCE_QUANTIFIERS of the roots `model:gauge-covariance` ("for every gauge function u and
every link configuration U") and `rem:nonneg-mass` ("for every such history") leave the outer
parameters implicit. These are universal, so their order is immaterial. Suggested text:
- "for all n >= 3, Clifford sets, a > 0, m >= 0, r >= 0, every gauge function u and every U in
  U(1)^E"
- "for all Clifford sets, d, b > 0 and every such history"

**A3.**
- `thm:main#wilson-history` cites `paper-a/comparison.tex#eq:fk@L43-L45` for its def:step-free-time
  edge. That is display (4.4), the untwisted kernel, which is excluded.
- The root cites `eq:twisted@L59-L60` for the same fact. Aligning the two (or citing L71-L72,
  "Lemma 3.1 applies" to the path on [0, b]) would be cleaner.

**A4 and A5** are coverage advisories; they are given in the rows of section 5.

**A6.** The NOTEs of `model:gauge-covariance` and `eq:mass-bound` could cite deviation 11, which
D16 names as the record of T6's generalization and of the two-sided encoding.

## 5. Coverage table (37 PROPOSED items): 37 PASS, 0 FAIL

Every unit of comparison.tex L4-L104 and of the added model.tex ranges has exactly one item. I
checked line by line: blank lines, `\begin{proof}`, and `\end{proof}` aside, no line is left out.
Each EXCLUDED reason matches R5-R8 and D16.

| # | Item | Verdict | Note |
|---|---|---|---|
| 1 | transfer:remark-centering (changed) | PASS | L84-L86 feed integrand-centered-trace. L87-L88 carry no obligation under R6. |
| 2 | transfer:remark-massless (changed) | PASS | Now mapped to the frozen remark and its two steps. |
| 3 | model:lattice | PASS | |
| 4 | eq:hilbert | PASS (EXCLUDED, correct) | A4: the one-particle factor l^2(X) (x) C^4 is recorded in CONVENTIONS; the REASON may say so. |
| 5 | model:link-variables | PASS | A4: model:gauge-covariance also cites L13 and could be added. |
| 6 | model:wilson (changed) | PASS | |
| 7 | model:tensor-structure (changed) | PASS | A4: model:gauge-covariance also records m >= 0 and r >= 0 from L39. |
| 8 | eq:mass-bound | PASS | Stays accurate after N7: no other root uses the second assertion. |
| 9 | model:mass-bound-proof | PASS | |
| 10 | model:charge | PASS (EXCLUDED, correct) | R8 and R4. |
| 11 | eq:gauge-unitary | PASS | A4: the root thm:main#twisted-integrand also cites L64. |
| 12 | model:gauge-covariance | PASS | |
| 13 | eq:capacity | PASS | main.tex L96 places the "admissible sectors" in Section 2, where (2.9) characterizes the nonempty sectors by abs Q_nu <= 2N. |
| 14 | model:capacity-proof | PASS (EXCLUDED, correct) | The root takes abs Q <= 2N as a premise. |
| 15 | thm:main | PASS | A5: NODE thm:main#twisted-integrand is defensible because the REASON says that Theorem 4.1 has no node and that only its premises are used. EXCLUDED with the same REASON would separate it more sharply from the proof step (D16, audit A S0). |
| 16 | eq:main | PASS (EXCLUDED, correct) | |
| 17 | eq:thermal | PASS (EXCLUDED, correct) | Deviation 6. |
| 18 | comparison:proof-heat-kernel | PASS (EXCLUDED, correct) | |
| 19 | eq:heat | PASS (EXCLUDED, correct) | Nested in item 18, as displays nest in revision 4. |
| 20 | comparison:proof-dyson | PASS (EXCLUDED, correct) | |
| 21 | eq:fk | PASS (EXCLUDED, correct) | |
| 22 | comparison:proof-propagator | PASS | |
| 23 | comparison:proof-bridges | PASS (EXCLUDED, correct) | R5 leaves L50-L51 unformalized. |
| 24 | comparison:proof-gauge-insertion | PASS (EXCLUDED, correct) | R8. |
| 25 | eq:twisted | PASS | |
| 26 | comparison:proof-trace-formula | PASS (EXCLUDED, correct) | |
| 27 | comparison:proof-positivity | PASS | |
| 28 | comparison:cite-lem-transfer | PASS | |
| 29 | comparison:proof-projection | PASS (EXCLUDED, correct) | |
| 30 | comparison:proof-coordinates | PASS | The root site and L85-L86 are correctly set aside (R5, R6). |
| 31 | comparison:proof-fourier | PASS | |
| 32 | comparison:cite-lem-fourier | PASS | |
| 33 | comparison:proof-integration | PASS (EXCLUDED, correct) | |
| 34 | comparison:proof-ground-energy | PASS (EXCLUDED, correct) | |
| 35 | comparison:cite-sec-transfer | PASS | The cited remark is the root rem:nonneg-mass. The Wilson-level application at m = 0 is rightly left without a node. |
| 36 | comparison:proof-continuity | PASS (EXCLUDED, correct) | |
| 37 | comparison:proof-auxiliary | PASS (EXCLUDED, correct) | |

## 6. Summary

**Totals.**
- 19 nodes: 13 PASS, 6 FAIL.
- 37 coverage items: 37 PASS, 0 FAIL.
- Frozen-field identity holds for all 15 anchors.
- All three source hashes and the manifest pin match.

**Failures.**
- **T (1):**
  - `eq:mass-bound`. The frozen two-sided encoding of the norm bound needs h_W(U) Hermitian, but
    nothing in the anchor's closure provides it. Add edges to `thm:main#wilson-hopping-hermitian`
    and `lem:transfer#dirac-hermitian`.
- **S (3):** these nodes drop root premises that their prerequisites need to discharge Lemma 3.1
  and Lemma 3.2.
  - `thm:main#wilson-history` drops b > 0.
  - `thm:main#apply-transfer` drops the Clifford set, a > 0, r >= 0 and b > 0.
  - `thm:main#apply-fourier` drops the same four premises.
- **R (3):**
  - `eq:mass-bound#mass-lower-bound` and `eq:mass-bound#norm-bound`: "T_j(U) unitary" in
    SOURCE_HYPOTHESES restates shift-unitary's conclusion.
  - `eq:mass-bound`: the same restatement, folded into N7.
- **G, L and F:** none. All seven new SOURCE_GAP grades are [minor] and are justified under
  EXTERNAL_POLICY. No new node needs a gap that it lacks.

**Root closures.**
- They reach the sealed roots exactly where the source applies them:
  - `thm:main#apply-transfer` -> `lem:transfer` at comparison.tex L71-L72;
  - `thm:main#apply-fourier` -> `lem:fourier` at L88-L89;
  - `rem:nonneg-mass#apply-transfer` -> `lem:transfer` at transfer.tex L89-L90.
- No other new node reaches them.
- `model:gauge-covariance` is correctly a separate root.

**Outside the PROPOSED scope.**
- H1: the CORPUS extension makes text in two REVIEWED records stale.
  - `lem:fourier#twist-is-kick` says model.tex L8-12 and L36 are "outside the corpus". This needs
    an AMEND with SET_SOURCE_HYPOTHESES.
  - The REASON of `transfer:remark-prefactor` says "either root".
- H2-H4 are prose or header advisories. H5 is an optional convention that fixes all three S
  findings at once.

With fragments N7, N8, N9, N11, N14 and N15 applied, I would mark all 19 nodes and all 37 items
PASS.

## 7. Re-check after corrections

**Scope.**
- I re-read every record the writer changed after sections 1-6, against the same source spans.
- The hashes are unchanged: the three source files and the manifest pin `a9ab3a4a…` match.
- The linter (`--require-complete-coverage --require-initial-lean-status --require-all-reachable
  --check`) still exits 0.
- The graph now has six roots; the 15 frozen anchors and their identity fields are unchanged. The
  coverage file has 38 PROPOSED items: the 37 reviewed above plus `transfer:remark-prefactor`, which
  was reset.

| # | Changed record | Verdict | Finding |
|---|---|---|---|
| 1 | Header: title (graph and coverage) | PASS | "four finite-dimensional proof steps of Theorem 4.1". Advisory: `eq:mass-bound` and `model:gauge-covariance` are Section 2 statements that the proof uses, not steps written in it. D16 groups all four under "the finite-dimensional part of Theorem 4.1", so the title is acceptable. |
| 2 | Header: ROOTS adds `eq:mass-bound` | PASS | `eq:mass-bound` is a frozen anchor and now has no consumer. `norm-bound` and the Hermiticity edges reach a root only through it, and `--require-all-reachable` holds. This is the alternative from A1, so A1 is closed. |
| 3 | Header: CONVENTIONS clause on Q | PASS | With d = 2N, dGamma(I) - d = sum_x n_x - 2N = sum_x q_x. The kick phi·I on D = 4N has centering e^{-(i/2)·4N·phi} = e^{-2iN phi} = e^{-i d phi}. Q in `thm:main#*` is the Fourier index. All of this is correct. |
| 4 | Header: provenance paragraph | PASS | It is accurate about `eq:mass-bound` and its first assertion. Advisory H2 is still open: the application at transfer.tex L89-L90 (`rem:nonneg-mass#apply-transfer` -> `lem:transfer`) is not named alongside comparison.tex L71-L72 and L88-L89. |
| 5 | `eq:mass-bound` | PASS | SOURCE_HYPOTHESES, DEPS and the two new EDGEs at model.tex L43 are as in fragment N7. The NOTE correctly says the anchor is a root and how Hermiticity enters. Fixes N7 (T, R). |
| 6 | `eq:mass-bound#mass-lower-bound` | PASS | SOURCE_HYPOTHESES as in fragment N8. Its premises (a > 0, r >= 0, abs U = 1) are all supplied by the root through `thm:main#wilson-history`. |
| 7 | `eq:mass-bound#norm-bound` | PASS | SOURCE_HYPOTHESES as in fragment N9. The NOTE now points to the Hermiticity edges at `eq:mass-bound`. |
| 8 | `thm:main#wilson-history` | PASS | b > 0 is added (N11). The DEPS edge to `eq:mass-bound#mass-lower-bound` at L71-L72 is the direct use: "M(omega_t) >= mI". The `def:step-free-time` EDGE at L71-L72 lies in the node's own proof (A3 closed). |
| 9 | `thm:main#integrand-centered-trace` | PASS | The `def:history-step` EDGE at eq:twisted L61 cites where the free steps and the kick u form one history. |
| 10 | `thm:main#apply-transfer` | PASS | SOURCE_HYPOTHESES as in fragment N14, so every premise of `thm:main#wilson-history` is supplied. |
| 11 | `thm:main#apply-fourier` | PASS | SOURCE_HYPOTHESES as in fragment N15. |
| 12 | `thm:main#twisted-integrand` | PASS | SOURCE_HYPOTHESES and SOURCE_QUANTIFIERS now record the source's vartheta_root = 0 (comparison.tex L82-L83), with R6's generalization named. Source fields stay source-only. The new NOTE sentence is correct: the constant binom(4N, 2N + abs Q) e^{-bm abs Q} is positive for abs Q <= 2N, so abs F_Q <= c Re F_0 forces Re F_0 >= 0, which matches "nonnegative zeroth coefficient" (L91). |
| 13 | `rem:nonneg-mass` | PASS | The new NOTE sentence is correct: the frozen statement binds iota only, and lem_transfer_v1's 4 abs(iota) = 2d gives d = 2 abs(iota). |
| 14 | Coverage `comparison:proof-positivity` | PASS | The disposition now names `eq:mass-bound#mass-lower-bound`, the node `wilson-history` actually uses. |
| 15 | Coverage `eq:mass-bound` | PASS | The REASON is accurate: the anchor is a root, its first assertion is used through `mass-lower-bound`, and no other root uses the second. |
| 16 | Coverage `transfer:remark-prefactor` | PASS (EXCLUDED, correct) | Confirmed. transfer.tex L132-L134 only says that the prefactor of (3.4) need not be one and is retained until the ground-energy limit. It places no obligation on any of the six roots, and "any root" is now accurate. |

No new defect was found. The advisories A2, A4, A5, A6 and H2-H4 stay optional.

### 7.1 Amendment approved for verbatim insertion

- The block below replaces "None." under "## Append-only structural amendments".
- I dry-ran it on a scratch copy of `DEPGRAPH.md`:
  - `--write-dashboard` followed by `--check` with the flags above exits 0;
  - the effective `SOURCE_HYPOTHESES` of `lem:fourier#twist-is-kick` becomes the new text.
- Regenerate the dashboard after inserting it.
- Only a locator remark changes, not a hypothesis, so `CONTRACT_VERSION` stays 1. The node's
  `TOPOLOGY_STATUS` and `REVIEWER` stay as they are.

```
AMEND: amend-twist-is-kick-corpus-rev5
TARGET: lem:fourier#twist-is-kick
AUTHOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-2
ADD_DEPS: -
DROP_DEPS: -
ADD_ROUTES: -
DROP_ROUTES: -
SET_TITLE: -
SET_STATEMENT_SOURCE: -
SET_PROOF_SOURCE: -
SET_CONTRACT_ID: -
SET_CONTRACT_VERSION: -
SET_SOURCE_HYPOTHESES: Q = dGamma(I) - d (dGamma and the Fock space are in model.tex L8-12 and L36; eq:hilbert is EXCLUDED and H of (2.4) lies outside the frozen surface, R8); the history of Lemma 3.1; D = 2d
SET_SOURCE_QUANTIFIERS: -
SET_SOURCE_CONCLUSION: -
SET_CONSTANT_SCOPE: -
SET_ROUTE_FOR: -
NOTE: Revision 5 extends the CORPUS to model.tex L4-15 and L27-46, so the parenthetical 'outside the corpus' for model.tex L8-12 and L36 became false; only that locator remark changes, the hypotheses themselves do not, so CONTRACT_VERSION stays 1 (docs/audits/graph/TOPOLOGY_REVIEW_REV5.md, H1)
```

### 7.2 Final verdict

- All 19 revision-5 nodes and all 38 PROPOSED coverage items (the 37 above plus
  `transfer:remark-prefactor`) now PASS.
- Each may be marked `REVIEWED` with `REVIEWER: topology-reviewer-2`. Their extractor is
  `graph-writer-2`, which is distinct from me.
- This is a node-level verdict only. The global closure review is a separate reviewer's job.
