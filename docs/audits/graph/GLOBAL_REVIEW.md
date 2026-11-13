# Global review: proof dependency graph for Paper A, Lemmas 3.1 and 3.2

Reviewed: `docs/graph/DEPGRAPH.md` (GRAPH_VERSION 4, 49 nodes, 108 edges, roots `lem:transfer`
and `lem:fourier`, 8 frozen anchors) and `docs/graph/DEPGRAPH_COVERAGE.md` (26 items).
Reviewer: fresh global reviewer. I did not write, extract or node-review this graph.
Date: 2026-11-12.

Read: `paper-a/transfer.tex` (whole file), `paper-a/model.tex` L1-48 and L99-129, the two
frozen theorem files and the six frozen definition files, the identity fields of
`lean/frozen-manifest.json`, `docs/DECISIONS.md` D11, and the header of `scripts/proof_depgraph.py`
(for field syntax only).
Not read: `lean/Core/PaperA/Provider/*`, other `lean/Core` files, proof bodies,
`docs/PROGRESS.md`, `docs/audits/**` (I only created this file), `docs/ERRATA-AND-DEVIATIONS.md`, `docs/CORRESPONDENCE.md`.
No Lean work and no proofs were attempted. Nothing other than this file was written.

## 1. Hashes and identity verified

| Object | Computed SHA-256 | Graph field | Result |
|---|---|---|---|
| `paper-a/transfer.tex` | `b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf` | CORPUS | match |
| `paper-a/model.tex` | `2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e` | CORPUS | match |
| `lean/frozen-manifest.json` | `8d6d837ec2c9b895de1a902a25002595ab5ac746d1567a759d3be192cc5eec69` | FROZEN_MANIFEST | match |

The manifest (`schema_version` 1, `manifest_state` AUTHOR_APPROVED) has 8 anchors. For each one,
`id`, `path`, `export`, `contract.id`, `contract.version` and `abi_sha256` equal the graph's
FROZEN_ANCHOR_ID, FROZEN_FILE, FROZEN_DECL, CONTRACT_ID, CONTRACT_VERSION and FROZEN_ABI_SHA256:

| Node | Anchor id | Export | ABI (prefix) |
|---|---|---|---|
| lem:transfer | lem_transfer_v1 | QEDCore.PaperA.positivity_and_transfer_annulus | 48c44cf3 |
| lem:fourier | lem_fourier_v1 | QEDCore.PaperA.canonical_fourier_bound | 7e2b22d0 |
| def:history-step | def_step_v1 | QEDCore.PaperA.Step | 1490cf38 |
| def:dirac-operator | def_dirac_operator_v1 | QEDCore.PaperA.diracOperator | 8e584268 |
| def:step-generator | def_step_generator_v1 | QEDCore.PaperA.Step.generator | 7a85dcbb |
| def:step-free-time | def_step_free_time_v1 | QEDCore.PaperA.Step.freeTime | f02bcd44 |
| def:transfer-matrix | def_transfer_matrix_v1 | QEDCore.PaperA.transferMatrix | e0943f9b |
| def:centered-trace | def_centered_trace_v1 | QEDCore.PaperA.centeredTrace | 0d9d1742 |

I compared the ABI hashes as strings and did not recompute them. The declaration in each FROZEN_FILE
has the exported name. The definition-anchor DEPS mirror the frozen import structure
(StepGenerator imports Step and DiracOperator; TransferMatrix imports StepGenerator;
CenteredTrace imports TransferMatrix; StepFreeTime imports Step).

Structural recomputation (independent parse of DEPS and EDGE): 49 nodes and 108 edges. Every DEPS
item has exactly one EDGE. There are no dangling ids and no cycles. Closure of `lem:transfer` = 37 nodes;
closure of `lem:fourier` = all 49 (it contains `lem:transfer`). No node lies outside both closures.
The 5 leaves are def:history-step, def:dirac-operator, def:c5, lem:transfer#norm-bounds-beta-form and
lem:fourier#paired-factor. The dashboard figures agree.

## 2. Root identity

### lem:transfer (Lemma 3.1, transfer.tex L9-36)

Source fields compared with the printed statement:

- STATEMENT_SOURCE L9-L36 and PROOF_SOURCE L37-L81 are correct.
- SOURCE_HYPOTHESES are faithful. The Clifford set (model.tex L27-28), the spatial and Dirac tensor structure
  (L39-40), time-dependent `h(t)` with bounded Hermitian spatial `v_j(t)`, `M(t) >= m_* I > 0`,
  spin-scalar unitary kicks with Hermitian spin-scalar `Phi` (L16, L26), `c >= 0` with `int c = b > 0`,
  `U' = -AU`, `D = 2d` (L6) and F of (3.1) are all present. The "Hermitian generator `Phi`" clause comes from
  L26 and was not imported from R4. Two items are omitted: the auxiliary interval `[0,T]`, and the permission
  that free and kick intervals may be separate (the source also allows them simultaneously). Neither omission
  changes the content.
- SOURCE_QUANTIFIERS are correct.
- SOURCE_CONCLUSION is correct, with one exception: the clause "U need not be normal or diagonalizable"
  is a remark that no such hypothesis is needed. It is not a conjunct, and the NOTE should say so (C9).
- CONSTANT_SCOPE `none` is correct.

Frozen statement (`positivity_and_transfer_annulus`). It specializes the source in these ways:
(i) piecewise-constant histories with separate instantaneous kicks (`List (Step ι)`, `0 <= τ`), R1(a);
(ii) any finite `ι`, including the empty type, with binder `4|ι| = 2d`, R2; (iii) kicks given by a Hermitian spatial
generator `Θ` with centering phase computed from the generator, R4.
It encodes the conclusion as follows: `F > 0` becomes `0 < Re F ∧ Im F = 0`; "exactly d" becomes the cardinality of the
charpoly-root filter `‖z‖ <= e^{-b m_*}`; "partners" becomes multiset equality of the complementary
filter with the image under `z ↦ (star z)⁻¹`; the modulus bound is stated for every root outside the
small disk. All of these are faithful.
Lean detail: if `0` were a root, `(star 0)⁻¹ = 0` would put it in both filters, so the frozen
partner clause itself excludes a zero root. The `0⁻¹ = 0` convention therefore causes no vacuity.

The graph's honesty here is good. The source fields keep the general time-dependent wording, and the NOTE records R1(a) and R2.
It does not mention R4 or the separate-kick restriction. It also does not say that the closure (with L78-80
excluded) supports only the frozen specialization, not the bounded-measurable reading of the
printed statement (C9).

### lem:fourier (Lemma 3.2, transfer.tex L93-104)

- STATEMENT_SOURCE L93-L104 and PROOF_SOURCE L105-L130 are correct.
- SOURCE_HYPOTHESES are faithful. They contain a history of Lemma 3.1, the appended twist `e^{iφQ}` with `Q = dΓ(I) - d`,
  F(φ) as its centered trace, and the normalization of F_q.
- SOURCE_QUANTIFIERS say "every integer q with |q| <= d". The source leaves integrality implicit, and the frozen
  statement uses `q : ℤ`. This is acceptable.
- SOURCE_CONCLUSION is the printed (3.4), and it states that the right side presupposes F_0 is real. This is honest.
- CONSTANT_SCOPE `none` is correct, because the binomial and exponential constants are explicit.

Frozen statement (`canonical_fourier_bound`). It defines `F φ = centeredTrace (hist ++ [Step.kick (φ • 1)])`
and `Fhat p = (2π)⁻¹ ∫_0^{2π} exp(-i p φ) F φ`. Its conclusion is `Im Fhat 0 = 0 ∧ ‖Fhat q‖ <= C(2d, d+|q|)
e^{-b m_* |q|} Re Fhat 0` (R3). I checked the conventions. The twist's one-particle propagator is
`exp(i φ I) = e^{iφ} I` and it is placed on the left. Its centering is `exp(½ Tr(-i φ 1 ⊗ 1_4)) = e^{-(i/2)·φ·4|ι|} = e^{-i d φ}`.
This is exactly the `-d` in `Q`, counted once. That is consistent with transfer.tex L83-84 and L107-108.
The NOTE records R1(a) and R3. It should also record R4: the twist enters as a generator-parameterized kick (C9).

## 3. Root closure traces

### lem:transfer: verdict PASS (the identity is exact and every conjunct is supported); C1-C3 required before REVIEWED, C4, C6-C8 recommended

| Conjunct | Supporting path (top-down) |
|---|---|
| F > 0, with Im F = 0 in the frozen form | positivity ← homotopy-continuity (← homotopy-admissible, def:centered-trace), homotopy-nonvanishing (← homotopy-admissible, centered-trace-real ← det-conjugation, liouville, trace-h-zero; det-nonvanishing ← no-unit-modulus ← endpoint-relation, strict-decrease ← eq:beta-form, kick-preserves-beta-form, propagator-invertible, def:step-free-time), homotopy-endpoint |
| exactly d in the small disk, with algebraic multiplicity | eigenvalue-count ← spectral-pairing (← inverse-adjoint ← form-preservation ← generator-c5-relation ← c5-anticommutes-h, c5-commutes-kick ← def:c5; c5-involution; propagator-invertible), no-unit-modulus, stable-gronwall (← stable-trajectory, norm-bounds-beta-form, eq:beta-form, endpoint-relation, def:step-free-time) |
| remaining d are the partners 1/conj λ | eigenvalue-count ← spectral-pairing, no-unit-modulus |
| remaining eigenvalues have modulus >= e^{b m_*} | unstable-gronwall ← unstable-trajectory, norm-bounds-beta-form, eq:beta-form, endpoint-relation, def:step-free-time. "Remaining" (outside the small disk) is the same as `|λ| > 1` by no-unit-modulus and stable-gronwall, which are in the closure through eigenvalue-count |

Every proof paragraph that creates an obligation is represented: L38-43, L44-50, L52-60, L61-71 and L73-77.
L78-80 (bounded measurable histories) is excluded. That is correct for the frozen root, but it is
needed for the printed statement in its own generality (see §9 Q1).

Edge-level omissions inside the closure. These are not closure holes, because the nodes are present, but they are missing obligations:

1. **Re-application to other histories (most significant).** Positivity applies the lemma's own
   intermediate results (centered-trace-real, det-nonvanishing, and through them no-unit-modulus,
   strict-decrease, eq:beta-form, the C5 chain, liouville and trace-h-zero) to every deformed history
   H_σ. The graph writes those steps with `SOURCE_QUANTIFIERS: none` or "for every eigenvalue", as if
   they concern a single fixed history. They must be quantified over every history that satisfies the
   hypotheses of lem:transfer, with the instantiation at H_σ made explicit (C1, C2). Without this, a planner could
   state the Lean step lemmas for one fixed history and then be unable to discharge homotopy-nonvanishing.
2. homotopy-endpoint uses three facts without edges. First, the centering phase is 1 because `Tr(I ⊗ β) = 0`,
   an instance of trace-h-zero at H_1. Second, the free steps' exponents add to `b m_* β`, which needs def:step-free-time
   and the fact that the steps commute. Third, H_1 is the endpoint of the deformation (homotopy-admissible) (C3).
3. stable-gronwall and unstable-gronwall integrate across the whole history. In the step carrier,
   kicks are jumps, so the integrated bound also needs kick-preserves-beta-form. That node is
   reached today only through stable-trajectory and unstable-trajectory (C4).
4. homotopy-admissible claims "the same b and m_*" but has no edge to def:step-free-time (C6).
5. Optional: form-preservation in the step carrier, computed as `exp(-X)* C5 exp(-X) = C5` from
   `X* = -C5 X C5`, uses `C5² = I`. Add an edge to c5-involution if the per-step algebraic route is
   intended. The ODE route does not need it (C7).

### lem:fourier: verdict PASS (the identity is exact and every conjunct is supported); C5 and the C8 twist-is-kick gap required before REVIEWED, C9 recommended

| Conjunct | Supporting path |
|---|---|
| Im F_0 = 0 (R3) | vacuum-real ← coefficient-identification ← factorization (← twist-is-kick, apply-transfer → **lem:transfer**, paired-factor), constant-positive |
| bound for 0 <= q <= d, against Re F_0 | vandermonde ← coefficient-identification, elementary-bound (← apply-transfer), vacuum-lower-bound, constant-positive; F_0 = Re F_0 via vacuum-real (root edge) |
| bound for -d <= q < 0 | negative-q ← vandermonde, apply-transfer (F(φ) real for every φ) |
| meaning of F(φ) | twist-is-kick (statement-level edge) |

The q = 0 case lies inside vandermonde. All three paragraphs of the proof (L106-116, L117-122 and L123-129)
are represented.

## 4. Conventions and carriers

Consistent:
- Time ordering: `U' = -AU`, later steps on the left. Lean `transferMatrix` takes the reversed product of
  `exp(-generator)`, and the twist is appended at the end, so it multiplies on the left.
- Kick: `int A = -iΘ` gives centering `e^{-(i/2)TrΘ}`. Lean `Step.generator (.kick Θ) = -(I • (Θ ⊗ 1))`.
  The local-twist check at L85-86 (`TrΘ = 4Σθ_x`) agrees.
- `D = 2d` agrees with Lean `4|ι| = 2d`. `s = e^{-b m_*}`. The Fourier normalization is `(2π)⁻¹ ∫_0^{2π} e^{-iqφ}`, and
  Lean uses `exp(-(p φ I))`. Spatial factor first (`v ⊗ α`) matches ℓ²(X) ⊗ C⁴.

Silent or unrecorded changes. Each needs a convention line:
1. **Θ full vs spatial.** In the graph's CONVENTIONS, def:history-step, def:step-generator and twist-is-kick,
   "Θ" means the full one-particle generator, for example "Θ = φ I" with `Tr Θ = 2dφ`. Lean `Step.kick Θ` carries the
   spatial factor `Θ_sp`, with full generator `Θ_sp ⊗ I_4`. Applying `e^{-(i/2)TrΘ}` to the Lean Θ would put the phase
   off by a factor of 4. The graph should state `Θ = Θ_sp ⊗ I_4` and `Tr Θ = 4 tr Θ_sp` (C1).
2. **ODE carrier vs step carrier.** The source argues on `[0,T]` with `c(t)` and `Φ(t)`; it differentiates B and
   uses Liouville and `d/dt(U*C5U) = 0`. The frozen carrier is a list of steps. Nodes mix the two readings
   (eq:beta-form says "for almost every t"; def:step-generator says "int A of one step"; homotopy-continuity
   mentions both). The translation (a free step is an interval with `c = 1` and `Φ = 0`; a kick `Θ` is a separate
   interval with `c = 0` and `∫Φ = -Θ`) is used throughout but appears nowhere (C1).
3. **Symbol `s`.** The source uses `s` both for the deformation parameter (L75) and for `e^{-b m_*}`
   (L118). The graph declares `s = e^{-b m_*}` globally but still writes the homotopy nodes with `s ∈ [0,1]`
   (C1, C6).
4. **Fock vs one-particle at the twist.** `Q = dΓ(I) - d` is a Fock-space object. Its `dΓ` and Fock space live in model.tex
   L8-12 and L36, which are outside CORPUS. twist-is-kick turns it into the one-particle kick `e^{iφ}` with centering
   `e^{-idφ}`. The reading is correct and is the only one consistent with L107-108 (one `e^{-idφ}` factor,
   no double centering). It is still an interpretive step that the source does not state (gap added in §7).
5. def:history-step's SOURCE_CONCLUSION ("free time τ") uses the R1(a) step reading rather than the
   ODE wording of L11-26. Its NOTE records the specialization, but this is the one place where a source field
   is phrased in the frozen reading (C10).

Role of model.tex. L27-28 supplies the Clifford premises, which are binders in both frozen roots. L39-40 supplies the spatial and Dirac commutation,
which the Kronecker carrier of def:dirac-operator builds in. L116-117 supplies C5; this is proof-internal and comes from the
proof of Lemma 2.1, a different lemma. L118 (the pairing `λ ↦ -λ` for h_W) is correctly unused. L29-38 (Wilson operator, Hamiltonian) is inside
CORPUS L27-40 but has no coverage disposition (§8). L41-46 (`M(U) >= mI`) matters only when Lemma 3.1 is applied to the model, which is downstream.

## 5. Cross-root edge and premise discharge

The single cross-root edge is lem:fourier#apply-transfer → lem:transfer. It is applied to two instances:

| Instance | Premise | Supplied by |
|---|---|---|
| H (untwisted), to get λ_j, `|λ_j| <= s`, partners and `λ_j ≠ 0` | Clifford set, d, m_* > 0, b > 0, free and kick steps, total free time b | lem:fourier's own hypotheses (the frozen binder lists are identical) |
| H ++ [kick φ], every real φ, to get F(φ) > 0 | same Clifford set, d, m_*, b; free steps unchanged | lem:fourier's hypotheses |
| | new kick is Hermitian and spin scalar | twist-is-kick (φ real) |
| | total free time still b | def:step-free-time: a kick has free time 0. This appears only in the NOTE and has **no edge** (C5) |

Other conditional applications:
- homotopy-nonvanishing applies centered-trace-real and det-nonvanishing at H_σ. Its premises (M_σ >= m_* I,
  Hermitian v_σ and Θ_σ, b unchanged) come from homotopy-admissible (C1, C2, C6).
- paired-factor (`λ ≠ 0`) is discharged at factorization by apply-transfer: partners presuppose `λ ≠ 0`, and
  the frozen partner clause excludes a zero root (§2).
- constant-positive needs `λ_j ≠ -1`. This follows from `|λ_j| <= s < 1`, and `s < 1` comes from b > 0 and m_* > 0.
- vandermonde needs `s <= 1`. It comes from lem:fourier's hypotheses and is recorded as a node hypothesis, not as an edge.
  This is acceptable; spell out the source in SOURCE_HYPOTHESES (C8).
- The apply-transfer EDGE to twist-is-kick cites L114-L115 ("the remaining constant is positive"). That text does not
  support admissibility. The correct locator is `lem:fourier@L95-L97` (C5).

## 6. AND/OR structure, reachability, cycles

- All DEPS are conjunctive, and there are no ROUTES. The source has no alternative proof that needs an OR node. There are three places with
  logically redundant but source-faithful choices, none of them an error:
  (a) the modulus bound >= e^{b m_*} follows from unstable-gronwall (the source's route) or from pairing plus stable-gronwall;
  (b) F(φ) real follows from apply-transfer or from the factorization with real C;
  (c) F_0 real follows from either of the same two.
- eigenvalue-count → unstable-gronwall is logically redundant for the count and partner claims. It is faithful to
  the source's "each region", so keep it and annotate it (C8).
- There are no unreachable nodes and no definition-consequence cycles. Definitions depend only on definitions, and the display
  eq:beta-form depends only on definitions. norm-bounds-beta-form is a leaf whose hypotheses carry the
  properties of β; this is acceptable.
- Status observation: every TOPOLOGY_STATUS is PROPOSED and every node REVIEWER field is `-`, so no node reviews are
  recorded in the graph yet. GLOBAL_REVIEWER and GLOBAL_REVIEW_REF are `-`.

## 7. SOURCE_GAP assessment

The policy as I apply it uniformly: a step is a SOURCE_GAP when the source asserts it with no argument,
or with nothing beyond naming a method or saying "thus"/"so", and filling it needs at least one fact that is not
stated at that point. A gap is [substantive] if it needs an idea, a non-standard fact or an input the source does not
supply. Otherwise it is [minor]. Lean or Mathlib effort is not a grade and belongs in LEAN_NOTE.

Problems with the graph's grading:
- The policy offers only [minor] or [substantive]. The grade "[substantive for Lean]" (form-preservation, spectral-pairing,
  liouville, coefficient-identification) mixes formalization effort into a source-rigour field.
  Mathematically each of these steps is a standard one-to-three-line fact: `d/dt(U*C5U) = 0`, the charpoly of an adjoint
  or inverse, Liouville or `det exp = exp tr`, and Fourier orthogonality. Regrade all four to [minor].
- homotopy-continuity is graded [substantive]. In the frozen carrier it is continuity of finitely many matrix
  exponentials, products and a determinant. Even in the ODE carrier it is standard continuous dependence on
  parameters. Regrade it to [minor]. The only analytic content that might merit more is the bounded-measurable
  extension, which sits in the excluded L78-80.
- The graph is inconsistent about method-only assertions. negative-q ("follows by complex conjugation") is flagged, but
  eigenvalue-count ("Spectral pairing gives exactly d eigenvalues in each region") is not; its NOTE's
  reason ("a substantive Lean lemma, not a gap") is a Lean reason.
- factorization's NOTE says "(minor)" without the `SOURCE_GAP:` tag, so the generator does not count it. det-conjugation's NOTE
  describes a gap ("stated without the one-line computation") but does not flag it.

Additions:
- lem:transfer#det-conjugation [minor]. The identity follows "Also" with no derivation; it needs
  `det(I+U*) = det(I + C5U⁻¹C5) = det(I+U⁻¹) = det(U)⁻¹det(I+U)` and `det C5² = 1`.
- lem:transfer#eigenvalue-count [minor]. The counting argument is not given: the eigenvalues have no unit-modulus fixed points, so the involution
  exchanges inside and outside, there are 2d roots in total, and inside the unit disk equals inside e^{-b m_*} by stable-gronwall.
- lem:fourier#factorization [minor]. The φ-independence of C (the d factors e^{iφ} cancel e^{-idφ}) is not written out.
- lem:fourier#twist-is-kick [minor]. The source states nowhere that e^{iφQ} is the centered lift of the one-particle kick
  e^{iφ}, nor the computation `e^{-(i/2)Tr(φI)} = e^{-idφ}` with `Tr I = D = 2d`. The source says only "including the phase e^{-idφ}".

Considered and not flagged:
- stable-gronwall and vandermonde: the inequality to integrate and the summation chain are both displayed.
- endpoint-relation, no-unit-modulus, strict-decrease and stable-trajectory's B(0) > 0: a reason is given.
- norm-bounds-beta-form, elementary-bound and vacuum-lower-bound: one-line inequalities from facts just stated.
- kick-preserves-beta-form: the reason "scalar" is named, at the same weight as c5-commutes-kick, which is also unflagged.
- vacuum-real: immediate from the displayed `F_0 = C Σ|e_j|²` with C > 0.
- positivity: nonvanishing and the endpoint sign are argued; the intermediate value theorem is implicit and homotopy-continuity is already flagged.

### Final source-gap list (20; none substantive)

| Node | Grade | Graph's grade |
|---|---|---|
| lem:transfer#c5-involution | minor | minor |
| lem:transfer#c5-anticommutes-h | minor | minor |
| lem:transfer#form-preservation | minor | substantive for Lean |
| lem:transfer#propagator-invertible | minor | minor |
| lem:transfer#spectral-pairing | minor | substantive for Lean |
| lem:transfer#det-conjugation | minor | not flagged |
| lem:transfer#liouville | minor | substantive for Lean |
| lem:transfer#trace-h-zero | minor | minor |
| eq:beta-form | minor | minor |
| lem:transfer#stable-trajectory | minor | minor |
| lem:transfer#unstable-trajectory | minor | minor |
| lem:transfer#eigenvalue-count | minor | not flagged |
| lem:transfer#homotopy-admissible | minor | minor |
| lem:transfer#homotopy-continuity | minor | substantive |
| lem:transfer#homotopy-endpoint | minor | minor |
| lem:fourier#twist-is-kick | minor | not flagged |
| lem:fourier#factorization | minor | not flagged; "(minor)" untagged |
| lem:fourier#constant-positive | minor | minor |
| lem:fourier#coefficient-identification | minor | substantive for Lean |
| lem:fourier#negative-q | minor | minor |

Outside the frozen scope: transfer.tex L78-80 asserts the bounded-measurable extension by naming
absolute continuity alone. It does not address continuity of F along the homotopy for measurable coefficients.
I would grade it [minor]; it is excluded and correctly so.

## 8. Coverage manifest findings

- CORPUS includes model.tex L27-40, but no item disposes of L29-38 (the link convention, eq:wilson and
  eq:hamiltonian). Either add an EXCLUDED item or narrow CORPUS to L27-28, L39-40 and L116-118 (C11).
- `transfer:proof-measurable` (L78-80): the REASON should say that the paragraph is needed for the printed statement in
  its bounded-measurable generality and is excluded only because the frozen roots are R1(a) (C11).
- All other ranges of transfer.tex L1-134 are disposed of exactly once. The counts (26 items, 4 excluded) are correct.

## 9. Unresolved source questions

- Q1. The regularity class in the printed Lemma 3.1 is unspecified. The statement says only "bounded" coefficients, the main
  proof differentiates B, and L78-80 extends to bounded measurable histories by assertion. Which class is meant,
  and is continuity of F along the homotopy claimed for measurable coefficients? This is not needed for the
  frozen statements (R1(a)) but is open for the source statement.
- Q2. Simultaneous free evolution and kicks (`c h` and `iΦ` nonzero at the same t) are permitted by
  the source and excluded by R1(a). The specialization is documented in D11 but not in the root NOTE.
- Q3. The symbol `s` is used for both the deformation parameter (L75) and `e^{-b m_*}` (L118). This is a source notation clash,
  harmless in context but inherited by the graph.
- Q4. Lemma 3.2: the integrality of q and the reality of F_0 are implicit. Both are resolved by the frozen statement
  (`q : ℤ`, R3).
- Q5. Lemma 3.2: the source never says that the Fock operator e^{iφQ} is the centered lift of the one-particle kick
  e^{iφ}, or that its `-d` is the kick's centering phase rather than an extra factor. L107-108 supports the
  single-phase reading, which both the graph and the frozen statement adopt. The reading is consistent and checked in §2.
- Q6. "Finite-CAR trace": transfer.tex never states that the Fock trace equals `det(I+U)`. (3.1) serves as the definition, which is
  sufficient for both frozen roots. Any downstream consumer that identifies F with a Fock trace needs this identity
  separately.
- Q7. Positive finding: for spin-scalar `Θ = Θ_sp ⊗ I_4`, the phase `e^{-(i/2)TrΘ}` is invariant under 2π shifts of the
  eigenvalues of Θ_sp, because a shift changes it by `e^{-4πi} = 1`. So the centering phase is a function of the unitary kick alone,
  and R4 loses no generality. The homotopy still needs a continuous generator path, which R4 provides.
- Q8. C5 and its Hermitian unitary property are taken from inside the proof of Lemma 2.1 (model.tex) and reused in
  Lemma 3.1 without restatement. Nothing is wrong; it is a cross-section dependency on proof-internal text.
- Frozen provability: I found no conjunct of either frozen statement that needs input the source does not
  supply beyond standard facts (det-exp-trace, charpoly of adjoint and inverse, the intermediate value theorem, Fourier
  orthogonality, Vandermonde, the triangle inequality). The edge cases of an empty `ι` (d = 0, F = 1) and free steps with τ = 0 are
  benign. I found no mathematical error in transfer.tex L9-130.

## 10. Proposed correction fragments (graph field syntax)

The graph is still entirely PROPOSED, with no amendments, so these are written as in-place replacements.
If any are applied after review, each DEPS change must become an `AMEND:` block carrying every
AMEND_FIELD (`-` where unused) and exactly one EDGE per added dependency; a template is at the end.
Source and contract fields of frozen anchors cannot be amended, so C10 is a NOTE-only change.

**C1. Header CONVENTIONS (replacement line)**
```
CONVENTIONS: Dirac matrices alpha_j, beta Hermitian 4x4 Clifford (model.tex L27-28); one-particle space l^2 (x) C^4, spatial factor first, D = 2d; U' = -A U with A = c h + i Phi, so later steps act on the left; Theta denotes the full spin-scalar generator Theta_sp (x) I_4 (QEDCore.PaperA.Step.kick carries Theta_sp; Tr Theta = 4 tr Theta_sp); a kick exp(i Theta) has int A = -i Theta and centering factor e^{-(i/2) Tr Theta}; B(t) = <f(t), (I (x) beta) f(t)>; s = e^{-b m_*} throughout, and the deformation parameter printed as s at transfer.tex L75 is written sigma; F_q = (2 pi)^{-1} int_0^{2 pi} e^{-i q phi} F(phi) d phi with q an integer; step-carrier reading of the ODE statements: a free step (tau, v, M) is an interval of length tau with c = 1, Phi = 0 and constant coefficients, a kick Theta_sp is a separate interval with c = 0 and int Phi = -(Theta_sp (x) I_4), and derivative statements (eq:beta-form, form-preservation, liouville, stable-gronwall, unstable-gronwall) are read on each free step, kicks being handled by lem:transfer#kick-preserves-beta-form and lem:transfer#c5-commutes-kick; every lem:transfer#* step and eq:beta-form is quantified over all histories satisfying the hypotheses of lem:transfer, and the lem:transfer#homotopy-* steps instantiate them at the deformed histories H_sigma; the frozen statements specialize to piecewise-constant histories with separate instantaneous kicks (R1(a)), any finite spatial index (R2), Im F_0 = 0 (R3) and kicks by a Hermitian generator (R4), docs/DECISIONS.md D11
```

**C2. Quantifiers of reused steps (replacement lines)**
```
NODE: lem:transfer#centered-trace-real
SOURCE_QUANTIFIERS: for every history satisfying the hypotheses of lem:transfer
NODE: lem:transfer#det-nonvanishing
SOURCE_QUANTIFIERS: for every history satisfying the hypotheses of lem:transfer
NODE: lem:transfer#no-unit-modulus
SOURCE_QUANTIFIERS: for every history satisfying the hypotheses of lem:transfer and every eigenvalue of its U
NODE: lem:transfer#homotopy-nonvanishing
EDGE: lem:transfer#centered-trace-real | paper-a/transfer.tex#lem:transfer-proof@L75-L75 | applied to H_sigma: the real centered trace
EDGE: lem:transfer#det-nonvanishing | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | applied to H_sigma: 'In particular det(I + U) != 0'
```

**C3. lem:transfer#homotopy-endpoint**
```
DEPS: def:centered-trace, def:transfer-matrix, lem:transfer#homotopy-admissible, lem:transfer#trace-h-zero, def:step-free-time
EDGE: lem:transfer#homotopy-admissible | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | H_1 has no kicks, v_j = 0 and M = m_* I
EDGE: lem:transfer#trace-h-zero | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | centering phase 1: Tr h = 0 at H_1, i.e. Tr (I (x) beta) = 0
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | the commuting free steps multiply to exp(-b m_* beta)
```

**C4. Gronwall steps (add one dependency each)**
```
NODE: lem:transfer#stable-gronwall
DEPS: lem:transfer#stable-trajectory, lem:transfer#norm-bounds-beta-form, eq:beta-form, lem:transfer#endpoint-relation, def:step-free-time, lem:transfer#kick-preserves-beta-form
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L65-L66 | B does not jump at kicks in the integrated bound
NODE: lem:transfer#unstable-gronwall
DEPS: lem:transfer#unstable-trajectory, lem:transfer#norm-bounds-beta-form, eq:beta-form, lem:transfer#endpoint-relation, def:step-free-time, lem:transfer#kick-preserves-beta-form
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L68-L69 | B does not jump at kicks in the integrated bound
```

**C5. lem:fourier#apply-transfer**
```
DEPS: lem:transfer, lem:fourier#twist-is-kick, def:step-free-time
EDGE: lem:fourier#twist-is-kick | paper-a/transfer.tex#lem:fourier@L95-L97 | the appended twist is a Hermitian spin-scalar kick, so the twisted history is admissible
EDGE: def:step-free-time | paper-a/transfer.tex#lem:fourier@L95-L95 | a kick has free time 0, so the twisted history keeps total free time b
```

**C6. lem:transfer#homotopy-admissible (σ rename and b edge)**
```
SOURCE_HYPOTHESES: the deformation H_sigma: kicks Theta -> (1 - sigma) Theta, v_j -> (1 - sigma) v_j, M_sigma = (1 - sigma) M + sigma m_* I, free durations unchanged
SOURCE_QUANTIFIERS: for every sigma in [0,1]
DEPS: def:history-step, def:step-free-time
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | free durations, hence b, are unchanged
```
Use σ likewise in homotopy-continuity (`sigma -> F_sigma is continuous on [0,1]`), homotopy-nonvanishing
(`for every sigma in [0,1]`; `F_sigma is real and nonzero`) and homotopy-endpoint (`sigma = 1`; `F_1 = ...`).

**C7 (optional). lem:transfer#form-preservation**
```
DEPS: lem:transfer#generator-c5-relation, def:transfer-matrix, lem:transfer#c5-involution
EDGE: lem:transfer#c5-involution | paper-a/transfer.tex#lem:transfer-proof@L40-L40 | per step, exp(-X)* = C5 exp(X) C5 uses C5^2 = I
```

**C8. SOURCE_GAP notes, regrades, and annotations (replacement NOTE / field lines)**
```
NODE: lem:transfer#form-preservation
NOTE: SOURCE_GAP: [minor] the passage from A* C5 + C5 A = 0 to U* C5 U = C5 (d/dt (U* C5 U) = 0; per step exp(-X)* C5 exp(-X) = C5) is not written.
LEAN_NOTE: per-step algebraic route needs exp of a C5-conjugate; check Mathlib before tasking
NODE: lem:transfer#spectral-pairing
NOTE: SOURCE_GAP: [minor] the multiplicity claim is drawn with 'Thus'; the characteristic-polynomial argument (similarity invariance; charpoly of U* is the conjugate, that of U^{-1} the scaled reverse) is not given.
NODE: lem:transfer#liouville
NOTE: SOURCE_GAP: [minor] Liouville's formula (per step det(exp X) = exp(tr X)) is used without proof or citation; a standard fact.
LEAN_NOTE: det(exp X) = exp(tr X) reported missing from Mathlib v4.35.0 (unverified by the global reviewer)
NODE: lem:transfer#homotopy-continuity
NOTE: SOURCE_GAP: [minor] continuity of sigma -> F_sigma is used but not argued; for step histories it is continuity of finitely many exp, products and det; for measurable coefficients it belongs to the excluded L78-80.
NODE: lem:fourier#coefficient-identification
NOTE: SOURCE_GAP: [minor] the coefficient formula is not derived; expanding |P(e^{i phi})|^2 and integrating over [0, 2 pi] (orthogonality of e^{i n phi}) is left implicit.
NODE: lem:transfer#det-conjugation
NOTE: SOURCE_GAP: [minor] the identity follows 'Also' without the computation det(I + U*) = det(I + C5 U^{-1} C5) = det(I + U^{-1}) = det(U)^{-1} det(I + U), which uses det(C5)^2 = 1.
NODE: lem:transfer#eigenvalue-count
NOTE: SOURCE_GAP: [minor] 'Spectral pairing gives' only names the method; the count (no fixed point on |lambda| = 1, the involution exchanges the regions, 2d roots in total, |lambda| < 1 iff |lambda| <= e^{-b m_*}) is not written.
EDGE: lem:transfer#unstable-gronwall | paper-a/transfer.tex#lem:transfer-proof@L70-L71 | the outer region of 'each region'; logically redundant given spectral pairing and stable-gronwall
NODE: lem:fourier#factorization
NOTE: SOURCE_GAP: [minor] the phi-independence of C (the d factors e^{i phi} of the pairs cancel e^{-i d phi}) is left to the reader; det(I + zU) as the product over eigenvalues with algebraic multiplicity is named at L115-116.
NODE: lem:fourier#twist-is-kick
SOURCE_HYPOTHESES: Q = dGamma(I) - d (dGamma and the Fock space are in model.tex L8-12, L36, outside CORPUS); the history of Lemma 3.1; D = 2d
NOTE: SOURCE_GAP: [minor] the source does not state that e^{i phi Q} is the centered lift of the one-particle kick e^{i phi} (its -d being the kick's centering phase e^{-(i/2) Tr(phi I)} = e^{-i d phi}, counted once); only 'including the phase e^{-i d phi}' (L107-108). Lean: Step.kick (phi • 1) with Theta_sp = phi I.
NODE: lem:fourier#vandermonde
SOURCE_HYPOTHESES: 0 <= q <= d; 0 < s < 1 (from b > 0 and m_* > 0 in the hypotheses of lem:fourier)
```
Header EXTERNAL_POLICY: append "; SOURCE_GAP grades are [minor] (standard fact or routine computation,
nothing hidden) or [substantive] (needs an idea, a non-standard fact or an input the source does not supply); a
step justified only by naming a method is a gap; Lean effort goes in LEAN_NOTE, not in the grade".

**C9. Root NOTEs (replacement lines)**
```
NODE: lem:transfer
NOTE: Frozen lem_transfer_v1 specializes the source: piecewise-constant histories with separate instantaneous kicks (R1(a), deviation 7), any finite spatial index iota with 4|iota| = 2d, empty allowed (R2, deviation 8), kicks by a Hermitian spatial generator Theta (R4). Encoding: F > 0 as 0 < Re F and Im F = 0; 'exactly d' as the card of the charpoly-root filter |z| <= e^{-b m_*}; partners as multiset equality of the complementary filter with the image under z -> (star z)^{-1} (which also excludes a zero root); the modulus bound for every root outside the small disk. 'U need not be normal or diagonalizable' is a remark, not a conjunct. The closure supports the frozen specialization; the printed statement for bounded measurable coefficients also needs transfer.tex L78-80 (excluded).
NODE: lem:fourier
NOTE: Frozen lem_fourier_v1: piecewise-constant histories (R1(a)); the twist is appended as Step.kick (phi • 1), its centering e^{-i d phi} computed from the generator (R4); q : Z; states Im F_0 = 0 and bounds |F_q| by Re F_0 (R3).
```

**C10. def:history-step NOTE (replacement line; source fields of a frozen anchor are not amendable)**
```
NOTE: Frozen as QEDCore.PaperA.Step for piecewise-constant histories with separate instantaneous kicks (R1(a), deviation 7); SOURCE_CONCLUSION is phrased in that step reading, while the source (transfer.tex L4-5, L11-26) has time-dependent coefficients on [0,T] with A = c h + i Phi and permits simultaneous free and kick terms. Step.kick carries the spatial generator Theta_sp; the full generator is Theta_sp (x) I_4.
```

**C11. Coverage manifest**
```
ITEM: model:wilson-hamiltonian
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L29-L38
DISPOSITION: EXCLUDED
REASON: link convention, Wilson operator h_W and Hamiltonian; h_W is one instance of the h of Lemma 3.1 and is not used by either root
COVERAGE_STATUS: PROPOSED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: -
```
For `transfer:proof-measurable`:
`REASON: extension to bounded measurable histories; needed for the printed Lemma 3.1 in that generality, excluded because the frozen roots cover piecewise-constant histories only (R1(a))`.

**C12. Header (after acceptance)**
```
GLOBAL_REVIEW_REF: docs/audits/graph/GLOBAL_REVIEW.md
```
GLOBAL_REVIEWER: set by the orchestrator to this reviewer's agent id, which must differ from WRITER and from every node EXTRACTOR.

Cosmetic: the non-frozen CONTRACT_IDs mix `paper-a.def:c5` (colon) with the frozen style `paper-a.def.history-step` (dot).

AMEND template (if C3-C7 land after review). Repeat for each target:
```
AMEND: ga-homotopy-endpoint-edges
TARGET: lem:transfer#homotopy-endpoint
AUTHOR: <writer id>
REVIEWER: <independent reviewer id>
ADD_DEPS: lem:transfer#homotopy-admissible, lem:transfer#trace-h-zero, def:step-free-time
DROP_DEPS: -
ADD_ROUTES: -
DROP_ROUTES: -
SET_TITLE: -
SET_STATEMENT_SOURCE: -
SET_PROOF_SOURCE: -
SET_CONTRACT_ID: -
SET_CONTRACT_VERSION: -
SET_SOURCE_HYPOTHESES: -
SET_SOURCE_QUANTIFIERS: -
SET_SOURCE_CONCLUSION: -
SET_CONSTANT_SCOPE: -
SET_ROUTE_FOR: -
NOTE: global review C3: the endpoint value uses Tr(I (x) beta) = 0, total free time b, and the deformation's endpoint
EDGE: lem:transfer#homotopy-admissible | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | H_1 has no kicks, v_j = 0 and M = m_* I
EDGE: lem:transfer#trace-h-zero | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | centering phase 1
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | exponents sum to b m_* beta
```

## 11. Verdict summary

- **lem:transfer: PASS.** The identity is exact. All four conjuncts (and Im F = 0) have supporting paths, and the R1(a), R2 and R4
  specializations are recorded honestly without altering the source fields. C1-C3 are required before REVIEWED: the
  quantification needed to re-apply steps to H_σ, the step-carrier, Θ and σ conventions, and the missing edges of homotopy-endpoint.
  C4 and C6-C8 are recommended. C10 and C11 are recommended for the definition node and the coverage manifest.
- **lem:fourier: PASS.** The identity is exact (R3 is encoded faithfully). The q >= 0, q < 0 and Im F_0 = 0 conjuncts are
  supported, and the single cross-root application has every premise supplied. C5 (an edge locator and a missing
  def:step-free-time edge) and the twist-is-kick gap are required. C9 is recommended.
- Source gaps: 20, all minor. The graph lists 16; I add det-conjugation, eigenvalue-count, factorization and twist-is-kick, and regrade five
  (four "substantive for Lean" and one "substantive") to minor.
- No mathematical error found in the source. The open items are source questions Q1-Q6.

## Confirmation pass (wave 3)

Date: 2026-11-12. Re-read: `docs/graph/DEPGRAPH.md` (52 nodes, 134 edges), `docs/graph/DEPGRAPH_COVERAGE.md` (27 items),
`docs/audits/graph/MERGE_LOG.md` and `docs/audits/graph/TOPOLOGY_REVIEW_NODES.md` (the parts the merge cites).
The corpus and manifest hashes are unchanged: transfer.tex `b2dcc793…98cf`, model.tex `2464b16f…961e`,
frozen-manifest.json `8d6d837e…ec69`. The frozen anchor fields are unchanged.

Independent re-parse: 52 nodes and 134 DEPS, each with exactly one EDGE. There are no dangling ids and no cycles.
The closure of lem:transfer has 40 nodes; the closure of lem:fourier has all 52; no node lies outside both. The 5 leaves are unchanged.
There are 20 SOURCE_GAP nodes (2 substantive), and they match MERGE_LOG.

### W3.1 Status of corrections C1-C12

| # | Status | Comment |
|---|---|---|
| C1 | Applied | CONVENTIONS records: Θ = Θ_sp ⊗ I_4 with Step.kick carrying Θ_sp; σ for the deformation and s = e^{-b m_*}; the step-carrier reading; H31 and H32 with universal quantification of every lem:transfer#* node and of eq:beta-form; and R1(a)-R4. |
| C2 | Applied | centered-trace-real, det-nonvanishing and no-unit-modulus carry explicit quantifiers. The homotopy-nonvanishing edges say "applied to H_sigma". Residual scope inconsistency: R-W3-1 below. |
| C3 | Applied | homotopy-endpoint now depends on homotopy-admissible, def:step-free-time and trace-h-zero. |
| C4 | Applied | Both Gronwall steps now depend on kick-preserves-beta-form. |
| C5 | Superseded, accepted | apply-transfer now applies Lemma 3.1 once, to the untwisted history; F(0) = F comes through twist-is-kick, and the reality of F(φ) comes from factorization + constant-positive. The twisted-history admissibility premise therefore no longer arises, and neither the def:step-free-time edge nor the old locator fix is needed. The twist-is-kick edge at L114-L115 now supports "F(0) is the centered trace of the untwisted history", which is correct. |
| C6 | Applied | σ rename; homotopy-admissible depends on def:step-free-time, and its conclusion includes "H_0 is the given history". |
| C7 | Not added; ruling accepted | Under the adopted step-carrier reading, neither the per-free-step derivative route nor the kick case needs C5² = I. The NOTE records where the per-step algebraic route would use it. |
| C8 | Applied in substance, under the adopted criterion | EXTERNAL_POLICY is rewritten. det-conjugation and twist-is-kick are added. The vandermonde hypothesis source, the twist-is-kick hypotheses and the eigenvalue-count redundancy note are in place. Not done, cosmetic: the liouville NOTE still carries the Mathlib remark, which belongs in LEAN_NOTE (the node review advised the same). I have not verified that remark. |
| C9 | Applied, with a side effect | The root NOTEs record R1(a)-R4 and the encodings. See objection O1 for the lem:transfer source fields. |
| C10 | Applied | def:history-step NOTE. |
| C11 | Applied, variant accepted | model.tex L29-38 is disposed to def:dirac-operator (justified: the frozen def cites model.tex 27-38). The proof-measurable reason is corrected. |
| C12 | Pending | GLOBAL_REVIEWER and GLOBAL_REVIEW_REF are still `-`. Set them after wave 3: `GLOBAL_REVIEW_REF: docs/audits/graph/GLOBAL_REVIEW.md`, `GLOBAL_REVIEWER: global-reviewer-1`. |

### W3.2 Root closures re-traced

**lem:transfer (closure 40).**

| Conjunct | Path |
|---|---|
| F > 0 and Im F = 0 | positivity (H31) ← homotopy-continuity, homotopy-nonvanishing, homotopy-endpoint. homotopy-nonvanishing ← homotopy-admissible + centered-trace-real@H_σ + det-nonvanishing@H_σ. centered-trace-real ← det-conjugation ← inverse-adjoint ← form-preservation ← generator-c5-relation ← c5-anticommutes-h, c5-commutes-kick, def:step-generator, **dirac-hermitian**; it also needs c5-involution, propagator-invertible ← **transport**, liouville and trace-h-zero. det-nonvanishing ← no-unit-modulus ← endpoint-relation (← transport), strict-decrease (← eq:beta-form ← transport, dirac-hermitian; kick-preserves ← transport; propagator-invertible; def:step-free-time). |
| exactly d in the small disk | eigenvalue-count ← spectral-pairing (← inverse-adjoint, propagator-invertible, c5-involution), no-unit-modulus, stable-gronwall (← stable-trajectory ← endpoint, strict-decrease, **beta-form-monotone**, propagator-invertible; norm-bounds; eq:beta-form; kick-preserves; def:step-free-time). |
| partners | eigenvalue-count ← spectral-pairing, no-unit-modulus. |
| modulus >= e^{b m_*} | unstable-gronwall ← unstable-trajectory (← endpoint, strict-decrease, beta-form-monotone), norm-bounds, eq:beta-form, kick-preserves, def:step-free-time. "Remaining" means outside the small disk; that this equals \|λ\| > 1 follows from no-unit-modulus and stable-gronwall, both in the closure. |

The three new nodes are correctly placed. transport is a construction the source names, and it carries the step-carrier jump
`f → e^{iΘ} f`. dirac-hermitian supplies `A* = c h − iΦ` and the symmetric form of (3.3). beta-form-monotone isolates
"the entire trajectory" for both trajectory nodes. None of them creates a cycle or an unsupported conjunct.

Homotopy re-applications under the H31 convention:
- centered-trace-real at H_σ needs the Clifford premises and Hermitian `v_σ = (1−σ)v`, `M_σ`, `Θ_σ = (1−σ)Θ`.
- det-nonvanishing at H_σ needs H31(H_σ) with the same b and m_*.

Both are supplied by homotopy-admissible ("H_σ satisfies H31 with the same b and m_*"). homotopy-endpoint uses the
σ = 1 member: trace-h-zero at h = m_* β, and def:step-free-time for the total exponent. **Every premise is discharged.**

**lem:fourier (closure 52).**

| Conjunct | Path |
|---|---|
| Im F_0 = 0 | vacuum-real ← coefficient-identification ← factorization ← twist-is-kick, apply-transfer → lem:transfer, paired-factor; and ← constant-positive. |
| 0 <= q <= d | vandermonde ← coefficient-identification, elementary-bound (← apply-transfer), vacuum-lower-bound, constant-positive; Re F_0 = F_0 via vacuum-real. |
| −d <= q < 0 | negative-q ← vandermonde, factorization, constant-positive. F(φ) = C·Π\|1+e^{iφ}λ_j\|², with C φ-independent and C > 0, so F is real for every φ and `F_{−q} = conj F_q`. This is the source's own route (L110) and needs no application of Lemma 3.1 at φ ≠ 0. |

Premise discharge at each application:
- apply-transfer → lem:transfer at the untwisted H: all premises are lem:fourier's own (H32 includes H31, and the frozen binder lists are identical). Output: λ_j, \|λ_j\| <= s, λ_j ≠ 0, partners, and F > 0.
- F(0) = F comes from twist-is-kick (a zero kick has identity propagator and zero trace).
- paired-factor's premise λ ≠ 0 comes from apply-transfer.
- constant-positive's premise λ_j ≠ −1 comes from \|λ_j\| <= s < 1, with s < 1 from H32 (b, m_* > 0).
- vandermonde's premise s <= 1 comes from H32.

**All premises are discharged.**

### W3.3 Source gaps and the writer's rulings

The final list is 20: [substantive] spectral-pairing and liouville; [minor] the other 18, including the new dirac-hermitian, beta-form-monotone and elementary-bound.
It matches MERGE_LOG and the dashboard.

My rulings on the merge decisions:
- **Grading criterion: accepted.** Read with the evident qualifier that "a standard theorem" means something beyond elementary real analysis and linear algebra, it yields exactly these two substantive gaps. Liouville's formula is an unnamed ODE or matrix-analysis theorem, and the multiplicity pairing is an unstated algebraic-multiplicity argument. Applied literally, the criterion would also catch some unnamed elementary facts: the intermediate value theorem in positivity, the mean value theorem in beta-form-monotone, and `exp(X)exp(Y) = exp(X+Y)` for commuting X, Y in homotopy-endpoint. The writer treats these as elementary, and I agree. Suggestion, non-blocking: append to EXTERNAL_POLICY "; elementary calculus and linear algebra (intermediate and mean value theorems, the exponential law for commuting matrices) count as facts already stated" so that the grades can be reproduced.
- **A named method is not a gap: accepted.** It is now applied consistently (negative-q, eigenvalue-count, stable-gronwall and vandermonde are all unflagged). For eigenvalue-count, "Spectral pairing gives" names the input result rather than the count, and the NOTE records the implicit textbook facts. That is acceptable.
- **twist-is-kick kept as [minor]: accepted.** This was my original position. The note that it creates no Lean obligation is correct.
- **C7 not added: accepted.**
- **homotopy-continuity [minor]: accepted.**
- **factorization unflagged: accepted.** The cancellation is visible at L108 and L113-114.

### W3.4 Remaining correction and objections

**R-W3-1 (required for internal consistency; it does not affect either root).** Several nodes are scoped to a weaker hypothesis set:
centered-trace-real says "no mass bound or free-time condition is needed", and det-conjugation, inverse-adjoint, spectral-pairing
and form-preservation say "the Clifford and Hermiticity part of H31". These nodes depend on transport,
propagator-invertible and liouville, which are quantified over full H31 histories. None of those three needs any part of H31.
A Lean task stated with the weaker hypotheses could therefore not call those dependencies. The fix is to weaken the three quantifiers:
```
NODE: lem:transfer#transport
SOURCE_HYPOTHESES: a history (no part of H31 is needed); v a vector of the one-particle space
SOURCE_QUANTIFIERS: for every history and every v
NODE: lem:transfer#propagator-invertible
SOURCE_QUANTIFIERS: for every history (bounded generators suffice; no part of H31 is needed)
NODE: lem:transfer#liouville
SOURCE_QUANTIFIERS: for every history (no part of H31 is needed)
```
The alternative is to raise the five weaker-scoped nodes to "for every history satisfying H31". All applications are to H31 histories, so either fix is sound.

**O1 (objection, non-blocking).** MERGE_LOG says "the frozen source fields are unchanged (global C9, C10)". In fact, lem:transfer's
SOURCE_CONCLUSION lost the clause "U need not be normal or diagonalizable", and SOURCE_HYPOTHESES gained "no normality or
diagonalizability of U is assumed (L34-L35)". This is node-review fragment #1, made at CONTRACT_VERSION 1. The content is equivalent,
and the move is an improvement, since the clause is a scope remark. Still, it is an edit to a frozen anchor's contract text that the log does not
record. Either record it in MERGE_LOG and confirm that the anchor-contract policy (D12/D14) allows a pre-review wording change at version 1, or revert it
and keep the remark in the NOTE as C9 proposed.

**Cosmetic.** Move the Mathlib remark in the liouville NOTE to LEAN_NOTE. kick-preserves-beta-form's SOURCE_HYPOTHESES cites R4, which is a frozen
reading inside a source field. It is harmless on a non-anchor node.

### W3.5 Final verdicts

- **lem:transfer: PASS.** The identity is exact and every conjunct is supported. The H_σ re-applications are now explicit, and every premise is discharged by homotopy-admissible. R-W3-1 and O1 are open but do not block.
- **lem:fourier: PASS.** The identity is exact and every conjunct is supported. Lemma 3.1 is applied once with all premises supplied, and the negative-q reality route is the source's own.

### W3.6 Unresolved source questions (final)

1. Q1. The regularity class of the histories in the printed Lemma 3.1 is unstated; L78-80 extends to bounded measurable histories by assertion. This is outside the frozen R1(a) scope and remains open for the source.
2. Q5. The source does not say that e^{iφQ} is the centered lift of the one-particle kick e^{iφ}. It is recorded as the twist-is-kick [minor] gap, and the single-phase reading is confirmed.
3. Q6. transfer.tex never states that the finite-CAR (Fock) trace equals det(I+U); (3.1) acts as the definition. This is needed only by downstream consumers that identify F with a Fock trace.
4. Q3. Notation: `s` is used both as the deformation parameter and as e^{-b m_*}. The graph resolves it with σ; it remains a presentation point for the author.

Resolved or documented since wave 2: Q2 (simultaneous kicks, recorded in CONVENTIONS and the def:history-step NOTE), Q4 (integer q and real F_0, settled by the frozen statement and R3), Q7 (positive finding) and Q8 (C5 taken from Lemma 2.1, noted).
