# Topology review: proof dependency graph for Paper A, Lemmas 3.1 and 3.2 (nodes and coverage)

- Graph reviewed: `docs/graph/DEPGRAPH.md` (GRAPH_VERSION 4, 49 node blocks, 108 edges) and
  `docs/graph/DEPGRAPH_COVERAGE.md` (26 items, 4 EXCLUDED).
- Reviewer: fresh adversarial topology reviewer (subagent of session f3486c47). I did not write or
  extract the graph. Date 2026-11-12.
- Method: every node's source fields and edges were rebuilt from the raw LaTeX it cites. I made no
  proof attempts and no Lean judgments, and edited no other file. Git was not run.
- Verdict classes used below:
  - **T**: topology (a missing, reversed, transitive or unnecessary edge, or a missing node).
  - **S**: source fields (a dropped premise, a wrong quantifier, or a strengthened or weakened
    conclusion or scope).
  - **G**: SOURCE_GAP marking or grade.
  - **L**: EDGE locator.
  - **R**: framing only. A SOURCE_HYPOTHESES entry restates the conclusion of another node (a proof
    ingredient); the same fact also arrives through an existing edge.

  A node FAILs if it has at least one T, S, G, L or R defect that survives the global convention
  fix H1 (section 3).

## 1. Hashes verified

| File | SHA-256 computed | Expected (graph header) | Result |
|---|---|---|---|
| `paper-a/transfer.tex` (134 lines) | `b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf` | CORPUS | match |
| `paper-a/model.tex` (129 lines, whole-file hash) | `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e` | CORPUS | match |
| `lean/frozen-manifest.json` | `8d6d837ec2c9b895de1a902a25002595ab5ac746d1567a759d3be192cc5eec69` | FROZEN_MANIFEST | match |

Frozen-anchor identity: for all 8 FROZEN_ANCHORS, the graph fields FROZEN_FILE, FROZEN_DECL,
FROZEN_ANCHOR_ID, FROZEN_ABI_SHA256 and CONTRACT_ID equal the manifest's `path`, `export`, `id`,
`abi_sha256` and `contract.id`. The anchors are `lem_transfer_v1` 48c44cf3…, `lem_fourier_v1` 7e2b22d0…,
`def_step_v1` 1490cf38…, `def_dirac_operator_v1` 8e584268…, `def_step_generator_v1` 7a85dcbb…,
`def_step_free_time_v1` f02bcd44…, `def_transfer_matrix_v1` e0943f9b… and
`def_centered_trace_v1` 0d9d1742…. All are state SEALED, except the two theorems, which are DRAFT_SORRY.

## 2. Source spans re-read

- `paper-a/transfer.tex` L1-L134 (the whole file).
- `paper-a/model.tex` L20-L124. This covers the requested L27-L48 and L116-L119. Findings on the
  extra lines:
  - L41-L48 contain (2.4) `M(U) >= mI`, `||h_W|| <= h_*`, the one-line proof of (2.4) and the Wilson
    remark.
  - L119 is the `dGamma(h_W)` lower bound.
  - Neither root consumes any of these: Lemma 3.1 assumes `M(t) >= m_* I` directly. The graph's
    CORPUS restriction to L27-40 and L116-118 is therefore sound.
  - **However, model.tex L29-L38 (eq. (2.3) Wilson operator and (2.4) Hamiltonian) lie inside the
    declared CORPUS span L27-40 and have no coverage item** (section 5).
- Frozen anchors (identification only): `lean/Frozen/PaperA/PositivityAndTransferAnnulus.lean`,
  `lean/Frozen/PaperA/CanonicalFourierBound.lean` and
  `lean/Core/PaperA/Defs/{Step,DiracOperator,StepGenerator,StepFreeTime,TransferMatrix,CenteredTrace}.lean`.
- `lean/frozen-manifest.json`, identity fields only.
- `docs/DECISIONS.md` L132-L154 (D11, rulings R1(a) to R4).

## 3. Global (header) findings

**H1 (S, affects about 30 nodes). Implicit lemma context and missing universal quantification.**

- STANDING_ASSUMPTIONS is `-`. Yet most step nodes leave out the lemma's hypotheses: they say
  `SOURCE_HYPOTHESES: none`, or give only a local case premise such as `|lambda| < 1`.
- Read literally, `lem:transfer#positivity` (`none` ⇒ `F > 0`) or `lem:transfer#no-unit-modulus` is
  false.
- The context also cannot be a single fixed history. `lem:transfer#homotopy-nonvanishing` (L75-L76)
  re-applies `det-nonvanishing` and `centered-trace-real`, and with them their whole closure
  (no-unit-modulus, strict-decrease, eq:beta-form, …), to every deformed history.

Replacement fragment (append to CONVENTIONS):

```
CONVENTIONS: <existing text>; H31(hist) abbreviates the hypotheses of Lemma 3.1 on a history hist: a Hermitian 4x4 Clifford set alpha_1..alpha_3, beta acting on the spin factor (model.tex L27-28, L39-40), D = 2d, m_* > 0, b > 0, free steps with c >= 0 (tau >= 0), Hermitian spatial v_j and Hermitian M >= m_* I, kicks with Hermitian spin-scalar generator, total free time b (transfer.tex L6-L26); every lem:transfer#* node is stated for, and universally quantified over, all histories satisfying H31 (or the subset of H31 its SOURCE_HYPOTHESES names), because lem:transfer#homotopy-nonvanishing reapplies lem:transfer#det-nonvanishing and lem:transfer#centered-trace-real, and hence their closures, to deformed histories; H32 abbreviates H31 for the history of Lemma 3.2 together with the definitions of F(phi) and F_q (transfer.tex L95-L98), assumed by every lem:fourier#* node
```

Nodes whose only defect is this implicit context PASS once H1 is adopted. `det-nonvanishing` and
`centered-trace-real` still FAIL: their re-use at deformed histories must be explicit in their own
records.

**H2 (T). Mixed carriers for the beta-form.**

- `eq:beta-form` follows the source's ODE framing: `f' = -A f` with `A = c h + i Phi`, holding "for
  almost every t". In that framing (3.3) also covers kick intervals.
- `strict-decrease`, `stable-trajectory` and `unstable-trajectory` instead treat kicks as separate,
  instantaneous steps through `kick-preserves-beta-form`. This is the frozen R1(a) carrier fixed in
  CONVENTIONS.
- `stable-gronwall` and `unstable-gronwall`, which integrate across the whole history, lack that
  edge.
- Fix: adopt the R1(a) step carrier consistently. (3.3) applies on free steps and
  kick-preserves-beta-form at kicks. Every node that integrates B across the history depends on
  both (node fixes 29 and 31).

**H3 (G). Grade vocabulary.** The header defines two grades, minor and substantive. Four notes use
`[substantive for Lean]`, which is not a source-level grade. Normalizing it is covered in section 7.

## 4. Node table (49 nodes): 25 PASS, 24 FAIL

| # | Node | Verdict | Class | Finding |
|---|---|---|---|---|
| 1 | lem:transfer | FAIL | T, L, S | No direct statement edge to def:history-step or def:dirac-operator. Three EDGE locators (positivity L77, eigenvalue-count L70-71, unstable-gronwall L67-70) cite where the prerequisites are proved, not where the statement uses them. "U need not be normal or diagonalizable" is a scope remark, not a conclusion. |
| 2 | lem:fourier | FAIL | T, L | No direct statement edges to def:centered-trace, def:step-free-time or def:history-step (the frozen statement uses centeredTrace, Step.kick and Step.freeTime). Locators of vandermonde (L123-128), negative-q (L129) and vacuum-real (L120) cite where those nodes are proved. |
| 3 | def:history-step | PASS | | Matches L11-L16 and the R1(a)/R4 note. |
| 4 | def:dirac-operator | PASS | | |
| 5 | def:step-generator | FAIL | S | The conclusion adds "so its centering factor is e^{-(i/2) Tr Theta}". That is a consequence of def:centered-trace and is stated at L83-L84, outside the cited span L20-L26. |
| 6 | def:step-free-time | PASS | | |
| 7 | def:transfer-matrix | PASS | | |
| 8 | def:centered-trace | PASS | | |
| 9 | def:c5 | PASS | | Advisory: CONTRACT_ID `paper-a.def:c5` breaks the `paper-a.def.<name>` pattern. |
| 10 | lem:transfer#c5-involution | PASS | | The gap [minor] is justified (model.tex L116 only asserts "Hermitian unitary"). |
| 11 | lem:transfer#c5-anticommutes-h | PASS | | The gap [minor] is justified. |
| 12 | lem:transfer#c5-commutes-kick | PASS | | Commutation of 1⊗C5 with Theta⊗1 is definitional; no gap. |
| 13 | lem:transfer#generator-c5-relation | FAIL | S, T | The hypotheses give "h Hermitian" but drop the Dirac form and the Clifford relations, which the conclusion needs (via c5-anticommutes-h). "h Hermitian" is supplied by no edge; it is never stated in the source (new node dirac-hermitian). |
| 14 | lem:transfer#form-preservation | FAIL | R, G | Its hypothesis is the conclusion of generator-c5-relation. Grade label (section 7). |
| 15 | lem:transfer#propagator-invertible | FAIL | T | The conclusion speaks of "a transported nonzero vector" (L62), but no node constructs the transport (new node transport). |
| 16 | lem:transfer#inverse-adjoint | FAIL | R | Its hypotheses are conclusions of form-preservation, c5-involution and propagator-invertible. |
| 17 | lem:transfer#spectral-pairing | FAIL | T, S, R | Reading U* = C5 U^{-1} C5 as a similarity needs C5^{-1} = C5. Without C5² = I the claim is false, and that premise is dropped, with no edge to c5-involution. |
| 18 | lem:transfer#det-conjugation | FAIL | T, G, R | Uses det(U)^{-1} and U^{-1} directly, but has no edge to propagator-invertible. The source asserts the identity after "Also" with no computation (the NOTE admits this), but it is not marked SOURCE_GAP. |
| 19 | lem:transfer#liouville | PASS | | Gap justified. Advisory: grade `[substantive]` (section 7); move the Mathlib remark out of NOTE into LEAN_NOTE. |
| 20 | lem:transfer#trace-h-zero | PASS | | |
| 21 | lem:transfer#centered-trace-real | FAIL | S, R | The hypotheses are "the three identities of L46-L49" (proof ingredients). The quantifier `none` blocks its re-use at deformed histories (L75). It needs only the Clifford and Hermiticity data, not the mass bound. |
| 22 | lem:transfer#kick-preserves-beta-form | FAIL | T, S | No edge to the transport construction. Under R4 the kick is exp(i Theta⊗I) with Theta Hermitian, so unitarity is derived; the record should say so. |
| 23 | eq:beta-form | FAIL | S, T | Drops the source premises Phi Hermitian and spin scalar (L26, needed for the i Phi term of (3.3)) and Hermitian v_j, M. The quantifier "almost every t" comes from the EXCLUDED L78-L80. Missing edges to transport and dirac-hermitian. |
| 24 | lem:transfer#endpoint-relation | FAIL | T | f(0) = v and f(T) = Uv come from the transport (L52-L53), which has no node. |
| 25 | lem:transfer#strict-decrease | FAIL | T | B is integrated along the transported f, which has no node. |
| 26 | lem:transfer#no-unit-modulus | PASS | | Under H1. |
| 27 | lem:transfer#norm-bounds-beta-form | PASS | | A generic lemma with a source premise (beta Hermitian involution). |
| 28 | lem:transfer#stable-trajectory | PASS | | Edges complete; gap justified. Optional re-route via beta-form-monotone (section 6). |
| 29 | lem:transfer#stable-gronwall | FAIL | T | Integrating B' <= -2 m_* c B over [0,T] crosses the kicks, but there is no edge to kick-preserves-beta-form (H2). |
| 30 | lem:transfer#unstable-trajectory | PASS | | Gap justified. |
| 31 | lem:transfer#unstable-gronwall | FAIL | T | Same as #29. |
| 32 | lem:transfer#eigenvalue-count | PASS | | "Spectral pairing gives" names the method, so no gap. Advisory NOTE: the count also uses that U has exactly D = 2d eigenvalues with multiplicity, and that every eigenvalue has an eigenvector (so the per-eigenvector bounds of L52-L70 reach every root of the characteristic polynomial). Both are implicit textbook facts. |
| 33 | lem:transfer#det-nonvanishing | FAIL | S | Hypotheses and quantifier are `none`. It is applied at every deformed history (L75), so it must be explicitly for every H31 history. |
| 34 | lem:transfer#homotopy-admissible | FAIL | T | Concludes "with the same b" but has no edge to def:step-free-time. |
| 35 | lem:transfer#homotopy-continuity | PASS | | Edges fine. Grade advisory: [minor] under R1(a) (section 7). |
| 36 | lem:transfer#homotopy-nonvanishing | PASS | | Premises are supplied by homotopy-admissible, provided nodes #21 and #33 are fixed. Locator nit: the det-nonvanishing use is L75-L76, not L73. |
| 37 | lem:transfer#homotopy-endpoint | FAIL | T, S | "At its endpoint it equals det(I+e^{-b m_* beta})" uses the s = 1 member of the deformation, total free time b (commuting free steps multiply to exp(-b m_* beta)) and Tr h = 0 (centering factor 1). The edges to homotopy-admissible, def:step-free-time and trace-h-zero are all missing. The hypotheses omit beta Hermitian. |
| 38 | lem:transfer#positivity | PASS | | IVT is implicit but the argument structure is given; under H1. |
| 39 | lem:fourier#twist-is-kick | FAIL | T, S | Appending a step uses def:history-step directly; no edge. The conclusion should record that Theta = phi·I is Hermitian, and F(0) = F, which apply-transfer needs. |
| 40 | lem:fourier#apply-transfer | FAIL | S, T, L | Applies Lemma 3.1 to the twisted history for every phi. Its premise (twisted history admissible with the same b) is supplied by no edge: twist-is-kick does not conclude it, and there is no def:step-free-time edge. The conclusion "F(phi) > 0 for every phi" goes beyond what the source uses: the source uses only the small-disk eigenvalues of U and F(0) > 0 (L106, L115). The twist-is-kick EDGE reason ("twisted history is admissible") does not match its locator L114-L115. λ_j ≠ 0, needed by paired-factor, is not concluded. |
| 41 | lem:fourier#paired-factor | PASS | | A generic identity under a local premise. |
| 42 | lem:fourier#factorization | FAIL | S, G | CONSTANT_SCOPE `none`, although the node introduces C, which depends on the history and not on phi. The NOTE calls the phi-independence "left to the reader (minor)" without a SOURCE_GAP mark. The source does show it (L108, L113-L114), so the note should be withdrawn. |
| 43 | lem:fourier#constant-positive | PASS | | Gap [minor] justified (λ_j ≠ -1 unstated). |
| 44 | lem:fourier#coefficient-identification | PASS | | Gap justified. Grade advisory [minor]. |
| 45 | lem:fourier#vacuum-lower-bound | PASS | | Advisory: "e_0 = 1" is definitional, not a hypothesis. |
| 46 | lem:fourier#vacuum-real | PASS | | |
| 47 | lem:fourier#elementary-bound | FAIL | G, R | "\|e_j\| <= binom(d,j) s^j" is stated without argument (L121) but not marked SOURCE_GAP. The hypothesis "\|lambda_k\| <= s" is apply-transfer's conclusion. |
| 48 | lem:fourier#vandermonde | PASS | | Vandermonde is named; edges complete. |
| 49 | lem:fourier#negative-q | FAIL | T, G | Rests on apply-transfer's "F(phi) real for every phi", which the source never establishes that way. The source has F(phi) = C prod\|…\|², C > 0 at L110. The SOURCE_GAP is unjustified: the method is named ("by complex conjugation") and the reality is established at L110. |

### 4.1 Replacement fragments for every FAIL

Only the changed fields are shown. DEPS lines are complete. EDGE lines marked "(new)" are added;
EDGE lines that replace an existing one say so. All other EDGE lines stay.

**#1 lem:transfer**
```
SOURCE_HYPOTHESES: <existing text>; no normality or diagonalizability of U is assumed (transfer.tex L34-L35)
SOURCE_CONCLUSION: F > 0; exactly d eigenvalues of U, counted with algebraic multiplicity, satisfy |lambda| <= e^{-b m_*}; the remaining d are their partners 1/conj(lambda) and have modulus >= e^{b m_*}
DEPS: lem:transfer#positivity, lem:transfer#eigenvalue-count, lem:transfer#unstable-gronwall, def:centered-trace, def:transfer-matrix, def:step-free-time, def:history-step, def:dirac-operator
EDGE: lem:transfer#positivity | paper-a/transfer.tex#lem:transfer@L27-L27 | 'Then F > 0'                      (replaces the L77 locator)
EDGE: lem:transfer#eigenvalue-count | paper-a/transfer.tex#lem:transfer@L27-L33 | exactly d eigenvalues obey (3.2) and the remaining d are their partners   (replaces L70-L71)
EDGE: lem:transfer#unstable-gronwall | paper-a/transfer.tex#lem:transfer@L33-L34 | the partners have modulus at least e^{b m_*}   (replaces L67-L70)
EDGE: def:history-step | paper-a/transfer.tex#lem:transfer@L11-L16 | the statement quantifies over ordered histories of free steps and kicks   (new)
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer@L12-L14 | the generator h(t) of the free steps   (new)
```

**#2 lem:fourier**
```
DEPS: lem:fourier#vandermonde, lem:fourier#negative-q, lem:fourier#vacuum-real, lem:fourier#twist-is-kick, def:centered-trace, def:step-free-time, def:history-step
EDGE: lem:fourier#vandermonde | paper-a/transfer.tex#eq:fourier-bound@L100-L103 | (3.4) for 0 <= q <= d   (replaces L123-L128)
EDGE: lem:fourier#negative-q | paper-a/transfer.tex#eq:fourier-bound@L100-L103 | (3.4) for -d <= q < 0, through |q|   (replaces L129)
EDGE: lem:fourier#vacuum-real | paper-a/transfer.tex#eq:fourier-bound@L101-L101 | F_0 on the right of (3.4) is real   (replaces L120)
EDGE: def:centered-trace | paper-a/transfer.tex#lem:fourier@L97-L97 | 'Let F(phi) be its centered trace'   (new)
EDGE: def:step-free-time | paper-a/transfer.tex#eq:fourier-bound@L101-L101 | b in e^{-b m_* |q|} is the total free time   (new)
EDGE: def:history-step | paper-a/transfer.tex#lem:fourier@L95-L96 | the twist is appended to the history as a further step   (new)
```

**#5 def:step-generator**
```
SOURCE_CONCLUSION: A = c h + i Phi in U' = -A U; integrated over one step, int A = tau h for a free step of duration tau and int A = -i Theta for a kick e^{i Theta} (U' = -i Phi U on the kick interval, Theta = -int Phi)
NOTE: The kick notation e^{i Theta} is fixed at transfer.tex L83. The kick centering factor e^{-(i/2) Tr Theta} (L83-L84) follows from def:centered-trace and is not part of this definition.
```

**#13 lem:transfer#generator-c5-relation**
```
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28), commuting with spatial matrices (model.tex L39-40); A = c h + i Phi with c >= 0, h = sum_j alpha_j v_j + beta M with Hermitian spatial v_j, M (transfer.tex L13-L15), and Phi Hermitian and spin scalar (transfer.tex L26)
DEPS: lem:transfer#c5-anticommutes-h, lem:transfer#c5-commutes-kick, def:step-generator, lem:transfer#dirac-hermitian
EDGE: lem:transfer#dirac-hermitian | paper-a/transfer.tex#lem:transfer-proof@L39-L40 | A* = c h - i Phi needs h Hermitian   (new)
```

**#14 lem:transfer#form-preservation**
```
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31 (Clifford alpha, beta on the spin factor; Hermitian spatial v_j, M; Hermitian spin-scalar kick generators); U the transfer matrix of the history (U' = -A U, U(0) = I)
SOURCE_QUANTIFIERS: for every such history
NOTE: SOURCE_GAP: [minor] the passage from A* C5 + C5 A = 0 to U* C5 U = C5 (d/dt (U* C5 U) = 0; for a step, exp(-X)* C5 exp(-X) = C5) is not written.
```

**#15 lem:transfer#propagator-invertible**
```
DEPS: def:transfer-matrix, lem:transfer#transport
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L62-L62 | 'a nonzero solution never vanishes' concerns the transported f(t) = U(t) v   (new)
```

**#16 lem:transfer#inverse-adjoint**
```
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31; U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every such history
```

**#17 lem:transfer#spectral-pairing**
```
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31; U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every such history
DEPS: lem:transfer#inverse-adjoint, lem:transfer#propagator-invertible, lem:transfer#c5-involution
EDGE: lem:transfer#c5-involution | paper-a/transfer.tex#lem:transfer-proof@L42-L43 | C5^{-1} = C5 makes U* = C5 U^{-1} C5 a similarity   (new)
NOTE: SOURCE_GAP: [substantive] <existing text unchanged>
```

**#18 lem:transfer#det-conjugation**
```
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31; U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every such history
DEPS: lem:transfer#inverse-adjoint, lem:transfer#c5-involution, lem:transfer#propagator-invertible
EDGE: lem:transfer#propagator-invertible | paper-a/transfer.tex#lem:transfer-proof@L46-L46 | det(I + U^{-1}) = det(U)^{-1} det(I + U)   (new)
NOTE: SOURCE_GAP: [minor] stated after 'Also' without the computation conj det(I+U) = det(I+U*) = det(C5 (I+U^{-1}) C5) = det(I+U^{-1}) = det(U)^{-1} det(I+U).
```

**#21 lem:transfer#centered-trace-real**
```
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta a Hermitian 4x4 Clifford set (model.tex L27-28) acting on the spin factor (model.tex L39-40); free steps with c >= 0 and Hermitian spatial v_j, M; kicks with Hermitian spin-scalar generator (transfer.tex L13-L16, L26); no mass bound or free-time condition is needed
SOURCE_QUANTIFIERS: for every such history (lem:transfer#homotopy-nonvanishing applies it to each deformed history)
SOURCE_CONCLUSION: the centered trace F of that history is real
```

**#22 lem:transfer#kick-preserves-beta-form**
```
SOURCE_HYPOTHESES: the kick is unitary and spin scalar (transfer.tex L16); under R4 it is exp(i Theta (x) I) with Theta Hermitian, so its unitarity is derived; beta acts on the spin factor (model.tex L39-40)
DEPS: def:step-generator, lem:transfer#transport
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L52-L55 | across a kick the transported vector f becomes e^{i Theta} f   (new)
```

**#23 eq:beta-form**
```
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); Hermitian spatial v_j and M(t) >= m_* I; c >= 0; Phi Hermitian and spin scalar (transfer.tex L26); f the transported vector, f' = -A f
SOURCE_QUANTIFIERS: for every t at which f is differentiable along a transported vector (every t inside a free step for the frozen piecewise-constant carrier)
DEPS: def:dirac-operator, def:step-generator, lem:transfer#transport, lem:transfer#dirac-hermitian
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L52-L58 | B(t) is taken along the transported f with f' = -A f   (new)
EDGE: lem:transfer#dirac-hermitian | paper-a/transfer.tex#lem:transfer-proof@L56-L58 | <h f, beta f> = <f, h beta f> uses h Hermitian   (new)
NOTE: SOURCE_GAP: [minor] <existing text>. 'Almost every t' belongs to the excluded extension transfer.tex L78-L80 and is not used.
```

**#24 lem:transfer#endpoint-relation**
```
DEPS: def:transfer-matrix, lem:transfer#transport
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L52-L61 | f(0) = v and f(T) = U v = lambda v   (new)
```

**#25 lem:transfer#strict-decrease**
```
DEPS: eq:beta-form, lem:transfer#kick-preserves-beta-form, lem:transfer#propagator-invertible, def:step-free-time, lem:transfer#transport
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L61-L62 | the total decrease of B along the transported f   (new)
```

**#29 lem:transfer#stable-gronwall**
```
DEPS: lem:transfer#stable-trajectory, lem:transfer#norm-bounds-beta-form, eq:beta-form, lem:transfer#endpoint-relation, def:step-free-time, lem:transfer#kick-preserves-beta-form
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L65-L66 | the integration over [0, T] passes the kicks, where B is unchanged   (new)
```

**#31 lem:transfer#unstable-gronwall**
```
DEPS: lem:transfer#unstable-trajectory, lem:transfer#norm-bounds-beta-form, eq:beta-form, lem:transfer#endpoint-relation, def:step-free-time, lem:transfer#kick-preserves-beta-form
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L68-L69 | the integration passes the kicks, where B is unchanged   (new)
```

**#33 lem:transfer#det-nonvanishing**
```
SOURCE_HYPOTHESES: H31 for the history
SOURCE_QUANTIFIERS: for every history satisfying H31 (lem:transfer#homotopy-nonvanishing applies it to each deformed history)
SOURCE_CONCLUSION: det(I + U) != 0 for the transfer matrix U of that history
```

**#34 lem:transfer#homotopy-admissible**
```
SOURCE_CONCLUSION: for every s in [0,1] the deformed history satisfies H31 with the same b and m_*; at s = 0 it is the given history
DEPS: def:history-step, def:step-free-time
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | the deformation does not touch the free times, so the total free time stays b   (new)
```

**#37 lem:transfer#homotopy-endpoint**
```
SOURCE_HYPOTHESES: the s = 1 history of lem:transfer#homotopy-admissible: free steps with v_j = 0, M = m_* I and the original free times (total b), kicks turned off (Theta = 0); beta Hermitian with beta^2 = I (model.tex L27-28)
DEPS: def:centered-trace, def:transfer-matrix, lem:transfer#homotopy-admissible, def:step-free-time, lem:transfer#trace-h-zero
EDGE: lem:transfer#homotopy-admissible | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | 'At its endpoint': the s = 1 member of the deformation   (new)
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | commuting free steps of total free time b multiply to exp(-b m_* beta)   (new)
EDGE: lem:transfer#trace-h-zero | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | Tr h = 0 for h = m_* beta, so the centering factor is 1   (new)
```

**#39 lem:fourier#twist-is-kick**
```
SOURCE_CONCLUSION: appending e^{i phi Q} appends the spin-scalar kick with Hermitian generator Theta = phi I (phi real), whose centering is e^{-(i/2) Tr(phi I_D)} = e^{-i d phi} since D = 2d; the twisted transfer matrix is e^{i phi} U; hence F(phi) = e^{-i d phi} w det(I + e^{i phi} U), w the centering factor of the history, and F(0) = F
DEPS: def:step-generator, def:centered-trace, def:transfer-matrix, def:history-step
EDGE: def:history-step | paper-a/transfer.tex#lem:fourier@L95-L96 | the twist is appended to the history as a further kick step   (new)
NOTE: Uses D = 2d; cf. the remark at transfer.tex L83-88. The identification of the Fock twist e^{i phi Q} with this one-particle kick and phase is absorbed into the frozen statement's definition of F(phi) and is not a proof obligation.
```

**#40 lem:fourier#apply-transfer**
```
SOURCE_HYPOTHESES: the history of Lemma 3.2 is a history of Lemma 3.1 (transfer.tex L95)
SOURCE_QUANTIFIERS: none (one application, to the untwisted history)
SOURCE_CONCLUSION: U has exactly d eigenvalues lambda_1..lambda_d, with algebraic multiplicity, of modulus <= e^{-b m_*}; they are nonzero, and the remaining d eigenvalues are 1/conj(lambda_j); F(0) = F > 0
DEPS: lem:transfer, lem:fourier#twist-is-kick
EDGE: lem:transfer | paper-a/transfer.tex#lem:fourier-proof@L106-L115 | the small-disk eigenvalues (L106-L107) and F(0) > 0 (L115)   (replaces L106-L107)
EDGE: lem:fourier#twist-is-kick | paper-a/transfer.tex#lem:fourier-proof@L114-L115 | F(0) is the centered trace of the untwisted history   (replaces the reason 'the twisted history is admissible')
NOTE: Lemma 3.1 is applied once, to the untwisted history, whose premises are those of Lemma 3.2; the source never applies it at phi != 0. lambda_j != 0 follows from the partner relation.
```

**#42 lem:fourier#factorization**
```
CONSTANT_SCOPE: C = w prod_j conj(lambda_j)^{-1} depends on the history only, not on phi
NOTE: det(I + zU) = prod over eigenvalues with algebraic multiplicity, named at L115-L116; the d factors e^{i phi} of the paired factors cancel the phase e^{-i d phi} (L108, L113-L114), so C is phi-independent. Not a gap.
```

**#47 lem:fourier#elementary-bound**
```
SOURCE_HYPOTHESES: H32; lambda_1..lambda_d the small-disk eigenvalues of L106
NOTE: SOURCE_GAP: [minor] |e_j| <= binom(d, j) s^j is stated without argument (e_j is a sum of binom(d, j) products of j eigenvalues of modulus <= s).
```

**#49 lem:fourier#negative-q**
```
DEPS: lem:fourier#vandermonde, lem:fourier#factorization, lem:fourier#constant-positive
EDGE: lem:fourier#factorization | paper-a/transfer.tex#lem:fourier-proof@L129-L129 | F(phi) = C prod |1 + e^{i phi} lambda_j|^2 is real, so F_{-q} = conj(F_q)   (replaces the apply-transfer edge)
EDGE: lem:fourier#constant-positive | paper-a/transfer.tex#lem:fourier-proof@L129-L129 | C is real   (new)
NOTE: The source names the method ('by complex conjugation'); the reality of F(phi) is established by the factorization at L110. Not a gap.
```

## 5. Coverage table (26 items): 20 PASS, 6 FAIL, plus 1 missing item

| # | Item | Verdict | Finding / fix |
|---|---|---|---|
| 1 | transfer:section-heading | PASS | Correctly EXCLUDED. |
| 2 | transfer:intro | PASS | |
| 3 | lem:transfer | PASS | |
| 4 | transfer:history | FAIL | The premises M(t) >= m_* I > 0 (L13), Hermitian coefficients and b > 0 (L15), and unitary spin-scalar kicks (L16) live in lem:transfer, which is not listed. Neither is h Hermitian (new node). Fix: `DISPOSITION: NODE lem:transfer, def:history-step, def:dirac-operator, def:step-free-time, def:transfer-matrix, lem:transfer#dirac-hermitian` and `REASON: history, generator and product; the premises of L13-L16 are recorded in lem:transfer; h Hermitian (from L15) in lem:transfer#dirac-hermitian` |
| 5 | eq:centered-trace | PASS | |
| 6 | transfer:ode-interval | FAIL | The premises c >= 0 and Phi Hermitian and spin scalar (L25-L26) live in lem:transfer. Fix: `DISPOSITION: NODE lem:transfer, def:step-generator, def:step-free-time` and append to REASON `; c >= 0 and Phi Hermitian spin scalar are premises recorded in lem:transfer` |
| 7 | eq:annulus | PASS | |
| 8 | transfer:proof-form | PASS | |
| 9 | transfer:proof-reality | PASS | |
| 10 | transfer:proof-transport | FAIL | The explicit construction at L52-L53 has no node. Fix: `DISPOSITION: NODE lem:transfer#transport, lem:transfer#endpoint-relation, lem:transfer#kick-preserves-beta-form` |
| 11 | eq:beta-form | PASS | |
| 12 | transfer:proof-annulus | PASS | Add lem:transfer#beta-form-monotone if the recommended node is adopted. |
| 13 | transfer:proof-positivity | PASS | |
| 14 | transfer:proof-measurable | PASS | Correctly EXCLUDED under R1(a). Its "almost everywhere" must not leak into eq:beta-form (node #23). |
| 15 | transfer:remark-centering | FAIL | The disposition implies that the whole of L83-L88 is covered. L84-L88 (local gauge twist, Tr Theta = 4 sum theta_x, single-valuedness under 2 pi shifts) impose no obligation on either root. Fix: `DISPOSITION: NODE def:step-generator, def:centered-trace, lem:fourier#twist-is-kick` and `REASON: L83-L84 fix the kick notation e^{i Theta} and its centering factor e^{-(i/2) Tr Theta}; L84-L88 (local gauge twist, single-valuedness) concern later sections and impose no obligation on either root` |
| 16 | transfer:remark-massless | PASS | Correctly EXCLUDED: m_* = 0 lies outside both roots. |
| 17 | lem:fourier | PASS | |
| 18 | transfer:cite-lem-transfer | PASS | |
| 19 | eq:fourier-bound | PASS | |
| 20 | fourier:proof-factorization | PASS | |
| 21 | fourier:proof-coefficients | PASS | |
| 22 | fourier:proof-vandermonde | PASS | |
| 23 | transfer:remark-prefactor | PASS | Correctly EXCLUDED. |
| 24 | model:dirac-matrices | FAIL | The REASON says the premises sit in the root statements, but the disposition lists only def:dirac-operator, which carries no Clifford relation (the frozen def is relation-free). Fix: `DISPOSITION: NODE lem:transfer, def:dirac-operator` |
| 25 | model:tensor-structure | PASS | Advisory: L39's first sentence (m >= 0, r >= 0) is Wilson-specific and has no root obligation. |
| 26 | model:c5 | FAIL | L116-L117 also assert that C5 anticommutes with h_W(U), which is the content of lem:transfer#c5-anticommutes-h (its NOTE cites these lines). Fix: `DISPOSITION: NODE def:c5, lem:transfer#c5-involution, lem:transfer#c5-anticommutes-h` |

Missing item. model.tex L29-L38 lie inside the declared CORPUS span (L27-40) and have no
disposition:

```
ITEM: model:wilson
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L29-L38
DISPOSITION: NODE def:dirac-operator
REASON: the Wilson operator h_W(U) of (2.3) is the model instance of h = sum_j alpha_j v_j + beta M, and only its form (L34) is used (the frozen def_dirac_operator_v1 cites model.tex:27-38); Lemmas 3.1-3.2 take v_j and M as abstract Hermitian spatial matrices, and T_j, M(U), the link convention and H of (2.4) impose no obligation on either root
COVERAGE_STATUS: PROPOSED
EXTRACTOR: <writer>
REVIEWER: -
```

An alternative is `DISPOSITION: EXCLUDED` with the same reason. Either way the item count becomes 27.

## 6. Missing nodes (proposed blocks)

The first two are required. The third is recommended.

**N1 (required): `lem:transfer#transport`.** The source builds this explicitly ("transport it along
the successive intervals and kicks, obtaining f(t)", L52-L53). Six nodes are about f(t), yet no node
constructs it: endpoint-relation, eq:beta-form, kick-preserves-beta-form, strict-decrease,
propagator-invertible and, through them, the trajectory and Gronwall nodes. For the frozen carrier
it is the prefix products of the step propagators, a separate Lean construction with its own list
lemmas.

```
NODE: lem:transfer#transport
KIND: step
TITLE: Transport of a vector along the history
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L52-L53
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L52-L53
CONTRACT_ID: paper-a.lem:transfer#transport
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H31 for the history; v a vector of the one-particle space
SOURCE_QUANTIFIERS: for every history satisfying H31 and every v
SOURCE_CONCLUSION: f(t) = U(t) v, with U(t) the propagator of the history up to time t (for steps: the ordered product of the first k step propagators), satisfies f(0) = v, f(T) = U v, f' = -A f inside free intervals (f = e^{-t h} f_k at time t into a free step), and f -> e^{i Theta} f across a kick
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:transfer-matrix, def:step-generator
ROUTES: -
ROUTE_FOR: -
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer-proof@L52-L53 | f(T) = U v
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer-proof@L52-L53 | 'along the successive intervals and kicks'
TOPOLOGY_STATUS: PROPOSED
EXTRACTOR: <writer>
REVIEWER: -
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: A construction the source names; not a gap.
```

Consumers: #15, #22, #23, #24 and #25 (fragments in section 4.1).

**N2 (required): `lem:transfer#dirac-hermitian`.** The source never states that h is Hermitian, but
the proof uses it:
- A* = c h - i Phi at L40;
- the symmetric beta-form derivative (3.3) at L57.

Today it appears only as an unsupplied hypothesis of generator-c5-relation. It is a natural separate
Lean lemma (Hermiticity of a Kronecker sum of Hermitian factors).

```
NODE: lem:transfer#dirac-hermitian
KIND: step
TITLE: The Dirac operator h is Hermitian
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L13-L15
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer@L13-L15
CONTRACT_ID: paper-a.lem:transfer#dirac-hermitian
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian (model.tex L27-28), commuting with spatial matrices (model.tex L39-40); v_j and M Hermitian spatial matrices (transfer.tex L13-L15)
SOURCE_QUANTIFIERS: for every such v_j, M
SOURCE_CONCLUSION: h = sum_j alpha_j v_j + beta M is Hermitian
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer@L13-L13 | the form of h
TOPOLOGY_STATUS: PROPOSED
EXTRACTOR: <writer>
REVIEWER: -
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] never stated; used for A* = c h - i Phi (L40) and in (3.3) (L57).
```

Consumers: #13 and #23.

**N3 (recommended): `lem:transfer#beta-form-monotone`.** Three nodes need B to be nonincreasing over
the whole history, combining (3.3) with c >= 0 and kick preservation:
- stable-trajectory ("the entire trajectory", L64-L65);
- unstable-trajectory (L67);
- implicitly, strict-decrease.

Each node currently re-derives it, and two gap notes cite it as unstated.

```
NODE: lem:transfer#beta-form-monotone
KIND: step
TITLE: B is nonincreasing along the transported trajectory
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L64-L67
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L54-L60
CONTRACT_ID: paper-a.lem:transfer#beta-form-monotone
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H31 for the history
SOURCE_QUANTIFIERS: for every history satisfying H31, every v and all 0 <= t_1 <= t_2 <= T
SOURCE_CONCLUSION: B(t_2) <= B(t_1) along f(t) = U(t) v
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: eq:beta-form, lem:transfer#kick-preserves-beta-form, lem:transfer#transport
ROUTES: -
ROUTE_FOR: -
EDGE: eq:beta-form | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | B' <= -2 m_* c ||f||^2 <= 0 on free intervals
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | B is unchanged at kicks
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | B is evaluated along the transported f
TOPOLOGY_STATUS: PROPOSED
EXTRACTOR: <writer>
REVIEWER: -
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] used for 'the entire trajectory' at L64-L65 and L67 but never stated.
```

If N3 is adopted, stable-trajectory and unstable-trajectory replace their eq:beta-form and
kick-preserves-beta-form edges with `lem:transfer#beta-form-monotone` (locators L64-L65 and L67).
Their gap notes then shrink to "B(0) has the sign of (|lambda|^2 - 1)^{-1}(B(T) - B(0)); lambda != 0
for B(T) > 0".

Considered and not proposed as nodes:
- **Kick unitarity under R4:** folded into #22.
- **The eigenvalue-to-eigenvector bridge and the total count D:** an advisory NOTE on #32.
- **F(0) = F:** folded into #39.
- **det(I + zU) as a product over eigenvalues:** named by the source at L115-L116 and modeled
  inside factorization per EXTERNAL_POLICY.
- **IVT in positivity:** the argument's structure is given.

## 7. SOURCE_GAP additions, removals and grades

Grading criterion used:
- **minor:** a few lines from facts already stated.
- **substantive:** needs a standard theorem or argument that the source neither gives nor names.

Additions:

| Node | Mark |
|---|---|
| lem:transfer#det-conjugation | `[minor]`: the identity is asserted after "Also" without the computation; the NOTE already admits it. |
| lem:fourier#elementary-bound | `[minor]`: L121 is stated without argument. |
| lem:transfer#dirac-hermitian (new N2) | `[minor]`: used but never stated. |
| lem:transfer#beta-form-monotone (new N3, if adopted) | `[minor]`: absorbs the monotonicity half of the stable-trajectory and unstable-trajectory notes. |
| Optional: lem:transfer#eigenvalue-count | `[minor]` for the unstated facts that U has exactly D eigenvalues with multiplicity and that each eigenvalue has an eigenvector. Otherwise record them in NOTE as implicit textbook facts. |

Removals:

| Node | Reason |
|---|---|
| lem:fourier#negative-q | The method is named ("by complex conjugation"), and the reality of F(phi) is established by the factorization F = C prod\|…\|², C > 0 (L110). |
| lem:fourier#factorization | The NOTE's "(minor)" is not marked SOURCE_GAP and is not a gap: phi-independence follows from L108 and L113-L114. Drop the phrase. |

Grades. The header allows only minor and substantive, so the label `[substantive for Lean]`
should be retired.

| Node | Current | Proposed | Reason |
|---|---|---|---|
| form-preservation | substantive for Lean | minor | Two exp-conjugation identities per step. |
| spectral-pairing | substantive for Lean | substantive | Needs characteristic-polynomial facts for similar, adjoint and inverse matrices. |
| liouville | substantive for Lean | substantive | An unnamed standard theorem (det exp = exp tr). Move the Mathlib remark to LEAN_NOTE. |
| coefficient-identification | substantive for Lean | minor | The F_0 case is printed and the general sum appears at L125; the rest is orthogonality of e^{ik phi}. |
| homotopy-continuity | substantive | minor under R1(a) | Continuity of finitely many exponentials, a product, a determinant and exp of a trace. It is substantive only for the excluded time-dependent carrier. |

Kept as justified: c5-involution, c5-anticommutes-h, propagator-invertible, trace-h-zero,
eq:beta-form, stable-trajectory, unstable-trajectory, homotopy-admissible, homotopy-endpoint and
constant-positive (all [minor]).

Checked and not gaps: c5-commutes-kick, kick-preserves-beta-form (the reason "scalar" is given),
stable-gronwall and unstable-gronwall ("integration of" is named), eigenvalue-count's multiset
counting ("spectral pairing" is named), positivity, and vandermonde.

## 8. Conditional premises at applications (check 5)

| Application | Premise | Supplied by an edge? |
|---|---|---|
| lem:fourier#apply-transfer (Lemma 3.1 on the twisted history, for all phi) | Twisted history admissible: Theta = phi I Hermitian; free time still b | **No.** twist-is-kick does not conclude it and there is no def:step-free-time edge. Fix #40 avoids the twisted application: the source applies Lemma 3.1 only to the untwisted history. |
| apply-transfer, then paired-factor | lambda_j != 0 | **Not explicit.** Fix #40 adds it to the conclusion. |
| apply-transfer, then constant-positive | lambda_j != -1 | Yes: \|lambda_j\| <= e^{-b m_*} < 1 through the existing edge. |
| homotopy-nonvanishing, then centered-trace-real and det-nonvanishing at deformed histories | Each deformed history satisfies H31 with the same b and m_* | **Partly.** The homotopy-admissible edge exists, but it lacks def:step-free-time (#34). The two applied nodes are not stated for arbitrary histories (#21, #33, H1). |
| homotopy-endpoint | The s = 1 history; total time b; Tr h = 0 | **No** (#37). |
| spectral-pairing | C5² = I | **No** (#17). |
| det-conjugation | U invertible | Only transitively (#18). |
| generator-c5-relation and eq:beta-form | h Hermitian | **No** (N2). |
| stable-gronwall and unstable-gronwall | B unchanged at kicks | **No** (#29, #31). |
| stable-trajectory | lambda != 0 | Yes (propagator-invertible). |
| vandermonde | 0 < s <= 1 | Yes, from b > 0 and m_* > 0 (H32). |

## 9. AND/OR (check 7)

The source offers no explicit alternative routes. No node models alternatives as a conjunction.
Three latent alternatives:

1. **Reality of F(phi).** It can come from Lemma 3.1 applied to every twisted history, or from the
   factorization with C > 0.
   - The graph used the first route in negative-q and the second in vacuum-real.
   - Only the second appears in the text.
   - Fix #49 uses it throughout. If both routes are wanted, model them as ROUTES, not as joint DEPS.
2. **The outer bound |lambda| >= e^{b m_*}.** It follows either from unstable-gronwall (L67-L70)
   or from spectral pairing plus stable-gronwall.
   - The source uses the first and only then counts by pairing.
   - The conjunctive DEPS of eigenvalue-count and the root mirror the text and are acceptable.
   - Suggested NOTE on eigenvalue-count: "unstable-gronwall is logically redundant given
     spectral-pairing and stable-gronwall; kept because the source proves the bound directly".
3. **Invertibility of U.** It can come from Liouville, from U* C5 U = C5, or per step. The graph
   uses one gap node, which is acceptable.

## 10. Totals

- Nodes: 25 PASS, 24 FAIL.
  - The FAILs break down as T in 17 nodes, S in 12, G in 5, L in 3 and R in 6; most nodes carry more
    than one class.
  - inverse-adjoint (R only) and form-preservation (R plus grade) fail on framing alone.
- Coverage: 20 PASS, 6 FAIL, 1 missing item (model.tex L29-L38).
- Header: H1 (implicit context and universal quantification), H2 (mixed carriers for the
  beta-form), H3 (grade vocabulary).
- New nodes: 2 required (transport, dirac-hermitian) and 1 recommended (beta-form-monotone).
- SOURCE_GAP changes: 3 or 4 additions, 1 removal plus 1 withdrawn note, and 5 regrades.

## Confirmation pass (wave 3)

Same reviewer, 2026-11-12. I re-read the merged `docs/graph/DEPGRAPH.md` (52 nodes, 134 edges)
and `docs/graph/DEPGRAPH_COVERAGE.md` (27 items) in full, together with
`docs/audits/graph/MERGE_LOG.md` and, for the other side of each disagreement, sections 4-10 of
`docs/audits/graph/GLOBAL_REVIEW.md`. Read restrictions were as before. I edited nothing except
by appending this section, and did not run git.

**Hashes and structure.**
- transfer.tex, model.tex and frozen-manifest.json still hash to the CORPUS and FROZEN_MANIFEST
  values listed in section 1.
- An independent parse finds 52 nodes and 134 edges, with DEPS equal to the EDGE targets in every
  block, no unknown targets and no cycles.
- Every node is named in some coverage disposition, and no disposition names a missing node.
- The 26 added edges match the merge log.

**Erratum to my wave-1 text.** In section 2 I called model.tex L41-L46 "(2.4) `M(U) >= mI`". By the
labels, eq:mass-bound is (2.5); eq:wilson is (2.3) and eq:hamiltonian is (2.4). The REASON of
`model:wilson` uses the correct numbers.

### C1. My 24 wave-1 FAIL nodes

| # | Node | Now | Evidence in the merged graph |
|---|---|---|---|
| 1 | lem:transfer | PASS | Statement edges to def:history-step and def:dirac-operator; locators at L27, L27-33, L33-34; the normality remark moved into SOURCE_HYPOTHESES. |
| 2 | lem:fourier | PASS | Edges to def:centered-trace, def:step-free-time and def:history-step; locators on eq:fourier-bound. |
| 5 | def:step-generator | PASS | The centering clause is gone; the conclusion now matches the frozen `Step.generator` exactly, so no contract change is implied. |
| 13 | generator-c5-relation | PASS | Dirac form and Clifford premises restored; dirac-hermitian edge. |
| 14 | form-preservation | **FAIL (new, NOTE only)** | My R and grade findings are resolved. The new NOTE wrongly says the per-step route "also uses C5 C5 = I" (see O1). |
| 15 | propagator-invertible | PASS | transport edge; H31 quantifier. |
| 16 | inverse-adjoint | PASS | Hypotheses rewritten to the H31 data. |
| 17 | spectral-pairing | PASS | c5-involution edge; [substantive]. |
| 18 | det-conjugation | PASS | propagator-invertible edge; [minor] gap. |
| 21 | centered-trace-real | PASS | Source premises given; quantifier names the H_sigma re-use. |
| 22 | kick-preserves-beta-form | PASS | transport edge; R4 wording. |
| 23 | eq:beta-form | PASS | Phi and Hermitian premises restored; per-free-step quantifier; transport and dirac-hermitian edges. |
| 24 | endpoint-relation | PASS | transport edge. |
| 25 | strict-decrease | PASS | transport edge. |
| 29 | stable-gronwall | PASS | kick-preserves-beta-form edge. |
| 31 | unstable-gronwall | PASS | kick-preserves-beta-form edge. |
| 33 | det-nonvanishing | PASS | Explicit H31 and quantifier over H_sigma. |
| 34 | homotopy-admissible | PASS | def:step-free-time edge; sigma; "H_0 is the given history". |
| 37 | homotopy-endpoint | PASS | Edges to homotopy-admissible, def:step-free-time and trace-h-zero; beta Hermitian in the hypotheses. |
| 39 | twist-is-kick | PASS | def:history-step edge; conclusion records Theta = phi I Hermitian and F(0) = F. |
| 40 | apply-transfer | PASS | A single application to the untwisted history; conclusion includes lambda_j != 0 and F(0) = F > 0; locators fixed. |
| 42 | factorization | PASS | CONSTANT_SCOPE records C; "not a gap" NOTE. |
| 47 | elementary-bound | PASS | [minor] gap; H32. See O2 for the consistency consequence. |
| 49 | negative-q | PASS | Rests on factorization and constant-positive; gap removed. |

Corrected fragment for #14 (NOTE only; DEPS stay as merged):

```
NOTE: SOURCE_GAP: [minor] the passage from A* C5 + C5 A = 0 to U* C5 U = C5 (d/dt (U* C5 U) = 0; for a step X, C5 X = -X* C5 gives C5 X^n = (-X*)^n C5, hence C5 exp(-X) = exp(X*) C5 and exp(-X)* C5 exp(-X) = C5, without using C5 C5 = I) is not written.
```

My 6 FAIL coverage items and the missing item are all resolved (PASS):
- `transfer:history`, `transfer:ode-interval`, `transfer:proof-transport`,
  `transfer:remark-centering`, `model:dirac-matrices` and `model:c5` carry the dispositions and
  reasons I proposed.
- `model:wilson` (model.tex L29-L38) was added, with NODE def:dirac-operator.

### C2. New and globally changed nodes

- **`lem:transfer#transport`: PASS.** The construction at L52-53. Its conclusion uses the full-Theta
  convention. Consumers: propagator-invertible, kick-preserves-beta-form, eq:beta-form,
  endpoint-relation, strict-decrease and beta-form-monotone.
- **`lem:transfer#dirac-hermitian`: PASS.** The [minor] gap is justified (never stated; used at L40
  and L57).
- **`lem:transfer#beta-form-monotone`: PASS.** Both trajectory nodes now use it in place of their
  separate eq:beta-form and kick edges. Their narrowed gap notes (sign of B(0); lambda != 0) remain
  correct.
- **CONVENTIONS: PASS.**
  - H31 and H32 with universal quantification over histories.
  - `Theta = Theta_sp (x) I_4` with `Tr Theta = 4 tr Theta_sp`, consistent with the frozen
    `Step.generator`.
  - Kick interval: `int Phi = -(Theta_sp (x) I_4)`, consistent with `U' = -i Phi U` giving
    `e^{i Theta}`.
  - `B = <f, (I (x) beta) f>`; the sigma/s split; integer q.
  - Step-carrier reading: derivative statements on free steps, kicks through kick-preserves and
    c5-commutes-kick.
- **homotopy-admissible, homotopy-continuity, homotopy-nonvanishing, homotopy-endpoint (sigma):
  PASS.** Premise flow is complete: homotopy-admissible concludes H31 for H_sigma with the same b
  and m_*. centered-trace-real and det-nonvanishing are quantified over all such histories, and so
  are their closures by the H31 convention. The det-nonvanishing locator is now L75-L76.
- **Quantifiers of centered-trace-real, det-nonvanishing and no-unit-modulus: PASS.**
- **Root NOTEs (lem:transfer, lem:fourier): PASS.** They agree with the frozen binders and
  conclusions: 0 < Re F and Im F = 0, charpoly-root filters, the multiset image under
  `z -> (star z)^{-1}`, `Step.kick ((phi : C) • 1)`, and R3.
- **def:history-step NOTE: PASS.** SOURCE_CONCLUSION is unchanged; the NOTE records the step
  reading and Theta_sp.
- **twist-is-kick as a [minor] SOURCE_GAP: PASS.** I accept the ruling. L107-108 assert "including
  the phase e^{-i d phi}" and give neither the identification of e^{i phi Q} with the centered lift
  of the kick nor the computation e^{-(i/2) Tr(phi I_D)} = e^{-i d phi}. Under EXTERNAL_POLICY as now
  written, that is a gap. The NOTE correctly says it creates no Lean obligation.

### C3. Re-check of my 25 wave-1 PASS nodes and 20 PASS items

- **No regression from the merge.** Fields changed in def:c5 (CONTRACT_ID `paper-a.def.c5`),
  c5-commutes-kick (NOTE), liouville (H31 quantifier, [substantive]), stable-trajectory and
  unstable-trajectory (monotone re-route), eigenvalue-count (NOTE and edge annotation),
  homotopy-continuity ([minor]), homotopy-nonvanishing (locator), positivity, constant-positive,
  coefficient-identification, vacuum-lower-bound, vacuum-real and vandermonde (H31/H32 hypotheses).
  All still pass.
- **One correction of my own wave-1 verdict: `lem:transfer#norm-bounds-beta-form` now FAILs (G).**
  "Since ‖f‖² >= B" (L65) and "‖f‖² >= -B" (L68) are asserted without argument and need Cauchy-Schwarz
  with ‖beta‖ = 1, the same weight as elementary-bound's triangle inequality, which is now a [minor]
  gap. EXTERNAL_POLICY now flags any step "asserted without an argument, and without naming a
  method", so the two must be treated alike. Fragment (preferred):

  ```
  NOTE: SOURCE_GAP: [minor] ||f||^2 >= B (L65) and ||f||^2 >= -B (L68) are used without argument (|<f, beta f>| <= ||f|| ||beta f|| = ||f||^2, beta being a Hermitian involution, hence unitary).
  ```

  The alternative is to drop elementary-bound's gap mark, which was the global reviewer's position.
  Either restores consistency.
- **Borderline, no FAIL: `lem:fourier#paired-factor`.** It is a displayed one-variable identity,
  checkable by direct expansion with no fact beyond complex arithmetic. I leave it unflagged. If the
  author wants a bright line, append to EXTERNAL_POLICY: "a displayed identity verifiable by direct
  expansion of the displayed quantities is not a gap".
- **All 20 PASS coverage items still pass.** `transfer:proof-annulus` now includes
  beta-form-monotone. `transfer:proof-measurable` and `model:tensor-structure` have fuller reasons.
  The four EXCLUDED items are unchanged and correct.

### C4. Rulings on the disagreements

| Ruling (MERGE_LOG) | My position |
|---|---|
| Gap grading by the node review's criterion; spectral-pairing and liouville [substantive], the rest [minor] | Accept. |
| A step whose method the source names is not a gap (negative-q, eigenvalue-count) | Accept. |
| twist-is-kick is a [minor] gap, not a Lean obligation | Accept (C2). |
| No form-preservation → c5-involution edge | **Accept the decision; object to its rationale (O1).** The per-step route does not need C5² = I either: C5 X = -X* C5 implies C5 exp(-X) = exp(X*) C5. The NOTE and the merge-log sentence "the per-step route does" are inaccurate, and a planner reading them would infer a missing edge. Fragment above. |
| homotopy-continuity [minor] | Accept. |
| model:wilson disposed to def:dirac-operator rather than EXCLUDED | Accept. |
| apply-transfer applied once to the untwisted history (node review) over global C5 (twisted, with a def:step-free-time edge) | Accept. Both are sound; the adopted route is the one the text uses. |
| factorization not a gap (node review) over global ([minor]) | Accept. |

Further objections (non-blocking):
- **O2.** The divergence on `elementary-bound` (node review: gap; global review: not a gap) was
  adopted without appearing in the disagreement table. Its consequence for norm-bounds-beta-form
  (C3) should be settled there.
- **O3 (advisory).** The Mathlib remark in liouville's NOTE ("a TODO in Mathlib v4.35.0") and
  "a substantive Lean lemma" in eigenvalue-count's NOTE are Lean-effort remarks. EXTERNAL_POLICY now
  excludes Lean effort from source grades, and both reviews advised moving them to LEAN_NOTE.

### Final verdict tables (wave 3)

Nodes: 50 PASS, 2 FAIL.

| # | Node | Verdict |
|---|---|---|
| 1 | lem:transfer | PASS |
| 2 | lem:fourier | PASS |
| 3 | def:history-step | PASS |
| 4 | def:dirac-operator | PASS |
| 5 | def:step-generator | PASS |
| 6 | def:step-free-time | PASS |
| 7 | def:transfer-matrix | PASS |
| 8 | def:centered-trace | PASS |
| 9 | def:c5 | PASS |
| 10 | lem:transfer#dirac-hermitian | PASS |
| 11 | lem:transfer#c5-involution | PASS |
| 12 | lem:transfer#c5-anticommutes-h | PASS |
| 13 | lem:transfer#c5-commutes-kick | PASS |
| 14 | lem:transfer#generator-c5-relation | PASS |
| 15 | lem:transfer#form-preservation | **FAIL** (NOTE only; fragment in C1) |
| 16 | lem:transfer#transport | PASS |
| 17 | lem:transfer#propagator-invertible | PASS |
| 18 | lem:transfer#inverse-adjoint | PASS |
| 19 | lem:transfer#spectral-pairing | PASS |
| 20 | lem:transfer#det-conjugation | PASS |
| 21 | lem:transfer#liouville | PASS (O3 advisory) |
| 22 | lem:transfer#trace-h-zero | PASS |
| 23 | lem:transfer#centered-trace-real | PASS |
| 24 | lem:transfer#kick-preserves-beta-form | PASS |
| 25 | eq:beta-form | PASS |
| 26 | lem:transfer#beta-form-monotone | PASS |
| 27 | lem:transfer#endpoint-relation | PASS |
| 28 | lem:transfer#strict-decrease | PASS |
| 29 | lem:transfer#no-unit-modulus | PASS |
| 30 | lem:transfer#norm-bounds-beta-form | **FAIL** (G consistency; fragment in C3) |
| 31 | lem:transfer#stable-trajectory | PASS |
| 32 | lem:transfer#stable-gronwall | PASS |
| 33 | lem:transfer#unstable-trajectory | PASS |
| 34 | lem:transfer#unstable-gronwall | PASS |
| 35 | lem:transfer#eigenvalue-count | PASS (O3 advisory) |
| 36 | lem:transfer#det-nonvanishing | PASS |
| 37 | lem:transfer#homotopy-admissible | PASS |
| 38 | lem:transfer#homotopy-continuity | PASS |
| 39 | lem:transfer#homotopy-nonvanishing | PASS |
| 40 | lem:transfer#homotopy-endpoint | PASS |
| 41 | lem:transfer#positivity | PASS |
| 42 | lem:fourier#twist-is-kick | PASS |
| 43 | lem:fourier#apply-transfer | PASS |
| 44 | lem:fourier#paired-factor | PASS (borderline note in C3) |
| 45 | lem:fourier#factorization | PASS |
| 46 | lem:fourier#constant-positive | PASS |
| 47 | lem:fourier#coefficient-identification | PASS |
| 48 | lem:fourier#vacuum-lower-bound | PASS |
| 49 | lem:fourier#vacuum-real | PASS |
| 50 | lem:fourier#elementary-bound | PASS |
| 51 | lem:fourier#vandermonde | PASS |
| 52 | lem:fourier#negative-q | PASS |

Coverage items: 27 PASS, 0 FAIL.

| # | Item | Verdict |
|---|---|---|
| 1 | transfer:section-heading | PASS (EXCLUDED, correct) |
| 2 | transfer:intro | PASS |
| 3 | lem:transfer | PASS |
| 4 | transfer:history | PASS |
| 5 | eq:centered-trace | PASS |
| 6 | transfer:ode-interval | PASS |
| 7 | eq:annulus | PASS |
| 8 | transfer:proof-form | PASS |
| 9 | transfer:proof-reality | PASS |
| 10 | transfer:proof-transport | PASS |
| 11 | eq:beta-form | PASS |
| 12 | transfer:proof-annulus | PASS |
| 13 | transfer:proof-positivity | PASS |
| 14 | transfer:proof-measurable | PASS (EXCLUDED, correct) |
| 15 | transfer:remark-centering | PASS |
| 16 | transfer:remark-massless | PASS (EXCLUDED, correct) |
| 17 | lem:fourier | PASS |
| 18 | transfer:cite-lem-transfer | PASS |
| 19 | eq:fourier-bound | PASS |
| 20 | fourier:proof-factorization | PASS |
| 21 | fourier:proof-coefficients | PASS |
| 22 | fourier:proof-vandermonde | PASS |
| 23 | transfer:remark-prefactor | PASS (EXCLUDED, correct) |
| 24 | model:dirac-matrices | PASS |
| 25 | model:wilson | PASS |
| 26 | model:tensor-structure | PASS |
| 27 | model:c5 | PASS |

Both remaining FAILs are NOTE-level: one wrong claim in a NOTE, and one missing gap mark. Neither
changes a DEPS line, an edge or a premise flow. With the two fragments above applied, I would mark
the whole graph and the coverage manifest PASS.

### Wave 3b

I re-read five nodes in `docs/graph/DEPGRAPH.md`; the graph now has 52 nodes, 134 edges and 21 source gaps. All five PASS:
- `form-preservation`: its NOTE is my fragment.
- `norm-bounds-beta-form`: now a SOURCE_GAP [minor], with my fragment.
- `transport`, `propagator-invertible` and `liouville`: each is now quantified over every history, with no part of H31. Each claim holds for any step history:
  - prefix products give the transport;
  - a product of exponentials is invertible;
  - det(exp X) = exp(tr X).

  Every consumer of these three assumes at least a history: inverse-adjoint, spectral-pairing, det-conjugation, centered-trace-real, strict-decrease, stable-trajectory, kick-preserves-beta-form, eq:beta-form, beta-form-monotone and endpoint-relation. No consumer is therefore stated over a wider class than its prerequisite, which removes the earlier quantifier mismatch.

I accept the new EXTERNAL_POLICY clauses, which resolve O3. det(exp X) = exp(tr X) is not among the listed elementary facts, so liouville's [substantive] grade still stands.

Final tally: 52 of 52 nodes and 27 of 27 coverage items PASS. My objection O1 is resolved by the corrected NOTE. O2 is resolved in substance, because norm-bounds-beta-form and elementary-bound are now marked alike.
