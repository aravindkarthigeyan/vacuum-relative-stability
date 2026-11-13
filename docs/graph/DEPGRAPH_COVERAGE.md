# Proof-source coverage manifest: Paper A, Lemmas 3.1 and 3.2

CORPUS: paper-a/transfer.tex (sha256 b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf), paper-a/model.tex L27-40 and L116-118 (sha256 2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e); draft of 29 October 2026, pinned in lean/status.json

Every theorem-like unit, reused display, citation and proof paragraph of the corpus has one disposition.

## Inventory

ITEM: transfer:section-heading
KIND: heading
SOURCE: paper-a/transfer.tex#sec:transfer@L1-L2
DISPOSITION: EXCLUDED
REASON: section heading and label
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:intro
KIND: proof-region
SOURCE: paper-a/transfer.tex#sec:transfer-intro@L4-L7
DISPOSITION: NODE lem:transfer, def:history-step
REASON: fixes D = 2d and time-dependent coefficients; recorded in the root and the history definition (R1(a) note)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: lem:transfer
KIND: lemma
SOURCE: paper-a/transfer.tex#lem:transfer@L9-L36
DISPOSITION: NODE lem:transfer
REASON: the frozen root
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:history
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer@L11-L18
DISPOSITION: NODE lem:transfer, def:history-step, def:dirac-operator, def:step-free-time, def:transfer-matrix, lem:transfer#dirac-hermitian
REASON: history, generator and product; the premises of L13-L16 are recorded in lem:transfer; h Hermitian (from L15) in lem:transfer#dirac-hermitian
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: eq:centered-trace
KIND: display
SOURCE: paper-a/transfer.tex#eq:centered-trace@L19-L23
DISPOSITION: NODE def:centered-trace, def:transfer-matrix, def:step-generator
REASON: the centered trace and the ODE U' = -AU
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:ode-interval
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer@L24-L26
DISPOSITION: NODE lem:transfer, def:step-generator, def:step-free-time
REASON: A = c h + i Phi, c >= 0, int c = b; c >= 0 and Phi Hermitian spin scalar are premises recorded in lem:transfer
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: eq:annulus
KIND: display
SOURCE: paper-a/transfer.tex#eq:annulus@L29-L32
DISPOSITION: NODE lem:transfer#stable-gronwall
REASON: the annulus bound (3.2)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:proof-form
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer-proof@L38-L43
DISPOSITION: NODE lem:transfer#c5-anticommutes-h, lem:transfer#c5-commutes-kick, lem:transfer#generator-c5-relation, lem:transfer#form-preservation, lem:transfer#propagator-invertible, lem:transfer#inverse-adjoint, lem:transfer#spectral-pairing
REASON: form preservation and spectral pairing
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:proof-reality
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer-proof@L44-L50
DISPOSITION: NODE lem:transfer#det-conjugation, lem:transfer#liouville, lem:transfer#trace-h-zero, lem:transfer#centered-trace-real
REASON: reality of F
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:proof-transport
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer-proof@L52-L55
DISPOSITION: NODE lem:transfer#transport, lem:transfer#endpoint-relation, lem:transfer#kick-preserves-beta-form
REASON: transport and the beta-form
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: eq:beta-form
KIND: display
SOURCE: paper-a/transfer.tex#eq:beta-form@L56-L60
DISPOSITION: NODE eq:beta-form
REASON: the derivative identity (3.3)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:proof-annulus
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer-proof@L61-L71
DISPOSITION: NODE lem:transfer#endpoint-relation, lem:transfer#strict-decrease, lem:transfer#no-unit-modulus, lem:transfer#norm-bounds-beta-form, lem:transfer#beta-form-monotone, lem:transfer#stable-trajectory, lem:transfer#stable-gronwall, lem:transfer#unstable-trajectory, lem:transfer#unstable-gronwall, lem:transfer#eigenvalue-count
REASON: endpoint relation, strict drop, monotonicity, both cases and the count
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:proof-positivity
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L77
DISPOSITION: NODE lem:transfer#det-nonvanishing, lem:transfer#homotopy-admissible, lem:transfer#homotopy-continuity, lem:transfer#homotopy-nonvanishing, lem:transfer#homotopy-endpoint, lem:transfer#positivity
REASON: the homotopy argument for the sign of F
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:proof-measurable
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:transfer-proof@L78-L80
DISPOSITION: EXCLUDED
REASON: extension to bounded measurable histories; needed for the printed Lemma 3.1 in that generality, excluded because the frozen roots cover piecewise-constant histories only (R1(a))
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:remark-centering
KIND: proof-region
SOURCE: paper-a/transfer.tex#sec:transfer-remark@L83-L88
DISPOSITION: NODE def:step-generator, def:centered-trace, lem:fourier#twist-is-kick
REASON: L83-L84 fix the kick notation e^{i Theta} and its centering factor e^{-(i/2) Tr Theta}; L84-L88 (local gauge twist, single-valuedness) concern later sections and impose no obligation on either root
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:remark-massless
KIND: proof-region
SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L91
DISPOSITION: EXCLUDED
REASON: the m_* = 0 limit is used only by Theorem 4.1 (m = 0); outside both roots
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: lem:fourier
KIND: lemma
SOURCE: paper-a/transfer.tex#lem:fourier@L93-L104
DISPOSITION: NODE lem:fourier
REASON: the frozen root
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:cite-lem-transfer
KIND: citation
SOURCE: paper-a/transfer.tex#lem:fourier@L95-L95
DISPOSITION: NODE lem:fourier#apply-transfer
REASON: the cross-reference to Lemma 3.1
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: eq:fourier-bound
KIND: display
SOURCE: paper-a/transfer.tex#eq:fourier-bound@L100-L103
DISPOSITION: NODE lem:fourier
REASON: the printed bound (3.4)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: fourier:proof-factorization
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:fourier-proof@L106-L116
DISPOSITION: NODE lem:fourier#twist-is-kick, lem:fourier#apply-transfer, lem:fourier#paired-factor, lem:fourier#factorization, lem:fourier#constant-positive
REASON: factorization and C > 0
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: fourier:proof-coefficients
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:fourier-proof@L117-L122
DISPOSITION: NODE lem:fourier#coefficient-identification, lem:fourier#vacuum-lower-bound, lem:fourier#vacuum-real, lem:fourier#elementary-bound
REASON: F_0, the elementary symmetric bound
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: fourier:proof-vandermonde
KIND: proof-region
SOURCE: paper-a/transfer.tex#lem:fourier-proof@L123-L129
DISPOSITION: NODE lem:fourier#vandermonde, lem:fourier#negative-q
REASON: the bound for q >= 0 and q < 0
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: transfer:remark-prefactor
KIND: proof-region
SOURCE: paper-a/transfer.tex#sec:transfer-remark@L132-L134
DISPOSITION: EXCLUDED
REASON: remark about Theorem 4.1's ground-energy limit; no obligation for either root
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: model:dirac-matrices
KIND: definition
SOURCE: paper-a/model.tex#sec:model@L27-L28
DISPOSITION: NODE lem:transfer, def:dirac-operator
REASON: standing Dirac conventions; premises inside the root statements, not a separate assumption node
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: model:wilson
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L29-L38
DISPOSITION: NODE def:dirac-operator
REASON: the Wilson operator h_W(U) of (2.3) is the model instance of h = sum_j alpha_j v_j + beta M, and only its form (L34) is used (the frozen def_dirac_operator_v1 cites model.tex:27-38); Lemmas 3.1-3.2 take v_j and M as abstract Hermitian spatial matrices, and T_j, M(U), the link convention and H of (2.4) impose no obligation on either root
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: model:tensor-structure
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L39-L40
DISPOSITION: NODE def:dirac-operator
REASON: spatial matrices commute with the Dirac matrices; the first sentence of L39 (m >= 0, r >= 0) is Wilson-specific
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: model:c5
KIND: definition
SOURCE: paper-a/model.tex#lem:operator-proof@L116-L118
DISPOSITION: NODE def:c5, lem:transfer#c5-involution, lem:transfer#c5-anticommutes-h
REASON: C5 and its asserted properties; the pairing lambda -> -lambda of L118 concerns h_W, not U, and is not used
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
