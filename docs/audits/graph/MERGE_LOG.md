# Merge log: dependency graph of Paper A, Lemmas 3.1 and 3.2

Writer and extractor: `orchestrator-f3486c47` (the campaign orchestrator session).
Node reviewer: `topology-reviewer-1`
([TOPOLOGY_REVIEW_NODES.md](TOPOLOGY_REVIEW_NODES.md)).
Global reviewer: `global-reviewer-1` ([GLOBAL_REVIEW.md](GLOBAL_REVIEW.md)).
Both reviewers were fresh Opus sessions. Neither wrote or extracted any node, and the
global reviewer did no node review.

## Wave 1 (2026-11-12): proposed graph

The proposed graph had 49 nodes, 108 edges and 26 coverage items, with 16 `SOURCE_GAP` nodes. The
structural lint passed, without review status.

- Node review: 25 nodes PASS, 24 FAIL; 20 coverage items PASS, 6 FAIL, plus one missing item.
- Global review: both roots PASS on identity and support, with corrections C1–C12 required or
  recommended.

## Wave 2 (2026-11-12): merge of both reviews

The result is 52 nodes, 134 edges and 27 coverage items, with 20 `SOURCE_GAP` nodes.

### Adopted from both reviews (they agreed)

- **Shared hypothesis context.** CONVENTIONS now defines H31 (the hypotheses of Lemma 3.1 on a
  history) and H32 (the hypotheses of Lemma 3.2). Every Lemma 3.1 step is quantified over all
  H31 histories. The nodes that are re-applied to the deformed histories carry that quantifier
  explicitly: `centered-trace-real`, `det-nonvanishing` and `no-unit-modulus` (node review H1,
  global C1/C2).
- **Step-carrier reading.** CONVENTIONS now states how the ODE statements are read on step
  histories, and the convention that `Θ` is the full generator `Θ_sp ⊗ I_4`. The deformation
  parameter is renamed σ, so it no longer clashes with `s = e^{-bm_*}` (global C1, C6).
- **Gronwall steps.** Both now depend on `kick-preserves-beta-form` (node #29/#31, global C4).
- **`homotopy-endpoint`.** It gains edges to `homotopy-admissible`, `def:step-free-time` and
  `trace-h-zero` (node #37, global C3).
- **`homotopy-admissible`.** It gains an edge to `def:step-free-time` (node #34, global C6).
- **`det-conjugation`.** It is now a `[minor]` gap, with an edge to `propagator-invertible`
  (node #18, global C8).
- **Coverage.**
  - New item `model:wilson` (model.tex L29-38), disposed to `def:dirac-operator` as the node
    reviewer proposed. The global reviewer's alternative was EXCLUDED; the node version is
    used because the frozen `def_dirac_operator_v1` cites model.tex 27–38.
  - Corrected dispositions for `transfer:history`, `transfer:ode-interval`,
    `transfer:proof-transport`, `transfer:remark-centering`, `model:dirac-matrices` and
    `model:c5`.
  - A fuller reason for `transfer:proof-measurable`.
- **Root notes and `def:history-step`.** The notes now record the R1(a)–R4 specialization
  honestly; the frozen source fields are unchanged (global C9, C10).

### Adopted from the node review

- **New nodes.**
  - `lem:transfer#transport`: the construction f(t) = U(t)v at L52-53. Not a gap.
  - `lem:transfer#dirac-hermitian`: h is Hermitian. Never stated in the source; a `[minor]` gap.
  - `lem:transfer#beta-form-monotone`: B is nonincreasing along the whole history. A `[minor]`
    gap. It now carries the monotonicity half of the two trajectory nodes.
- **Edges to the new nodes.**
  - `transport`: from `propagator-invertible`, `kick-preserves-beta-form`, `eq:beta-form`,
    `endpoint-relation` and `strict-decrease`.
  - `dirac-hermitian`: from `generator-c5-relation` and `eq:beta-form`.
- **`spectral-pairing`.** It gains an edge to `c5-involution`: without C5² = I the claim fails.
- **Root edges.** The root EDGE locators now point at the statement lines that use each
  prerequisite. Both roots gain statement edges to the definitions.
- **`def:step-generator`.** Its conclusion no longer claims the centering factor, which belongs
  to `def:centered-trace`.
- **`eq:beta-form`.** It records the source premises (Φ Hermitian and spin scalar; Hermitian
  `v_j`, `M`). It no longer quantifies over "almost every t", which comes from the excluded
  L78-80.
- **`lem:fourier#apply-transfer`.** Lemma 3.1 is applied once, to the untwisted history, which
  is all the source does. Its conclusion now includes λ_j ≠ 0 and F(0) = F > 0. This replaces
  the earlier application at every φ, whose admissibility premise had no edge.
- **`lem:fourier#elementary-bound`.** Now a `[minor]` gap: it is stated without argument.
- **`lem:fourier#negative-q`.** No longer a gap: the source names complex conjugation. The
  reality of F(φ) now comes from `factorization` and `constant-positive`, the route the source
  actually uses (L110), instead of from `apply-transfer`.
- **`lem:fourier#factorization`.** The untagged "(minor)" remark is withdrawn, because the
  source shows the cancellation at L108 and L113-114. `CONSTANT_SCOPE` now records that C
  depends on the history only.

### Disagreements and how they were settled

| Question | Node review | Global review | Decision |
|---|---|---|---|
| Gap grading | minor = a few lines from stated facts; substantive = a standard theorem the source neither gives nor names | everything minor unless an idea or a non-standard input is needed | **Node review's criterion** (now in EXTERNAL_POLICY). Spectral pairing with multiplicity and Liouville's formula are `[substantive]`; all other gaps are `[minor]`. Lean effort is not part of the grade. |
| A step whose method the source names ("integration of", "by complex conjugation", "Spectral pairing gives") | not a gap | a gap | **Not a gap**, applied consistently: `negative-q` is unflagged, and `eigenvalue-count` stays unflagged, with a NOTE on its implicit textbook facts (D eigenvalues with multiplicity; every eigenvalue has an eigenvector). |
| `twist-is-kick` | not a proof obligation (absorbed into the frozen definition of F(φ)) | `[minor]` gap: the source never says that e^{iφQ} is the centered lift of the kick | **`[minor]` gap**, with a note that it creates no Lean obligation. It is a place where the source skips a step, which is what the author asked to see. |
| `form-preservation` edge to `c5-involution` (global C7, optional) | — | optional | **Not added.** The source's argument (d/dt(U*C5U) = 0) does not need C5² = I; the per-step route does, as the NOTE says. |
| `homotopy-continuity` grade | minor under R1(a) | minor | **`[minor]`**. The NOTE says that the source's time-dependent setting would need continuous dependence on parameters. |

### Final source gaps (20)

| Grade | Count | Nodes |
|---|---|---|
| `[substantive]` | 2 | `lem:transfer#spectral-pairing`, `lem:transfer#liouville` |
| `[minor]` | 18 | `lem:transfer#c5-involution`, `#c5-anticommutes-h`, `#dirac-hermitian`, `#form-preservation`, `#propagator-invertible`, `#det-conjugation`, `#trace-h-zero`, `eq:beta-form`, `lem:transfer#beta-form-monotone`, `#stable-trajectory`, `#unstable-trajectory`, `#homotopy-admissible`, `#homotopy-continuity`, `#homotopy-endpoint`, `lem:fourier#twist-is-kick`, `#constant-positive`, `#coefficient-identification`, `#elementary-bound` |

Neither review found a mathematical error in transfer.tex, so no erratum was opened.

## Wave 3 (2026-11-12): confirmation by both reviewers

- **Node review.** 50 of 52 nodes PASS and all 27 items PASS. The two remaining FAILs were
  NOTE-level and are adopted verbatim:
  - `form-preservation`: the per-step route does not need C5² = I, because C5 X = −X* C5 gives
    C5 exp(−X) = exp(X*) C5. The wave-2 NOTE and this log were wrong on that point.
  - `norm-bounds-beta-form`: "‖f‖² ≥ ±B" is used at L65 and L68 without argument, so it is now
    a `[minor]` gap, consistent with `elementary-bound`.
- **Global review.** Both roots PASS. C1–C4, C6 and C8–C11 are applied; the node review's
  re-route of `apply-transfer` supersedes C5; the reviewer accepts that C7 was not added; C12
  is done below. One consistency fix is adopted: `transport`, `propagator-invertible` and
  `liouville` now hold for every history, without H31, so that nodes with weaker hypotheses
  can depend on them.
- **Rulings.** Both reviewers accept every ruling in the wave 2 table.

Objections and their resolution:

- **Root source fields edited (global O1).** In wave 2 the source fields of the frozen root
  `lem:transfer` changed: "no normality or diagonalizability of U is assumed" moved from
  `SOURCE_CONCLUSION` to `SOURCE_HYPOTHESES`, at `CONTRACT_VERSION` 1. This happened while every
  record was still `PROPOSED`, before publication, which the skill allows ("During initial
  one-writer drafting, edit proposed records normally"). The content is equivalent, and the
  frozen Lean statement, manifest contract and ABI are untouched. From publication on, a
  frozen node's source fields can only change through a new versioned anchor.
- **`elementary-bound` disagreement missing from the table (node O2).** The node review marked it
  a `[minor]` gap; the global review's wave-1 list did not include it. Decision: `[minor]` gap,
  because the source states it without argument and names no method.
- **Lean remarks belong in `LEAN_NOTE` (node O3; global, cosmetic).** Declined. The linter's
  initial-Lean gate (`--require-initial-lean-status`, run in CI) requires `LEAN_NOTE: -` at
  this stage, so Lean remarks stay in `NOTE`; EXTERNAL_POLICY now says so.
- **Grading reproducibility (global suggestion).** EXTERNAL_POLICY now counts elementary
  calculus and linear algebra (intermediate and mean value theorems, exponentials of commuting
  matrices, determinants of triangular or diagonal matrices) as stated facts.

Final counts: 52 nodes, 134 edges, 27 coverage items, 21 `SOURCE_GAP` nodes (2
`[substantive]`, 19 `[minor]`). The 21st gap is `norm-bounds-beta-form`, added in this wave.

Unresolved source questions carried forward to the author (global review §9):

1. Lemma 3.1 does not state the regularity class of its histories; L78-80 asserts the
   bounded-measurable extension without argument. Under R1(a) this does not affect the frozen
   statements.
2. The source never says that e^{iφQ} is the centered lift of the one-particle kick; recorded
   as the `[minor]` gap at `lem:fourier#twist-is-kick`, and not a Lean obligation.
3. The source never states that the Fock-space trace equals det(I + U); (3.1) serves as the
   definition. Not a Lean obligation.
4. The symbol `s` is used both for e^{−bm_*} and for the deformation parameter; the graph
   writes σ for the latter.
