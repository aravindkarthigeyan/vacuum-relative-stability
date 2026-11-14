# Proof-source coverage manifest: Paper A, Lemmas 3.1 and 3.2 and four finite-dimensional proof steps of Theorem 4.1

CORPUS: paper-a/transfer.tex (sha256 b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf), paper-a/model.tex L4-15, L27-46, L62-71, L86-97 and L116-118 (sha256 2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e), paper-a/comparison.tex L4-104 (sha256 1caaf36bb7ab5f90c15224be3bc0f1eb20baeae06f40fb7c340ad3145db13273); draft of 29 October 2026, pinned in lean/status.json

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
DISPOSITION: NODE def:step-generator, def:centered-trace, lem:fourier#twist-is-kick, thm:main#integrand-centered-trace
REASON: L83-L84 fix the kick notation e^{i Theta} and its centering factor e^{-(i/2) Tr Theta}; L84-L86 compute it for a local gauge twist (Tr Theta = 4 sum_x theta_x, factor e^{-2i sum_x theta_x}), used by thm:main#integrand-centered-trace, while its match with the Fock phase from q_x = n_x - 2 is outside the frozen surface (R8); L87-L88 (single-valuedness under theta_x -> theta_x + 2 pi) impose no obligation on any root, the frozen twist being unrestricted in R^X (R6)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: transfer:remark-massless
KIND: proof-region
SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L91
DISPOSITION: NODE rem:nonneg-mass, rem:nonneg-mass#apply-transfer, rem:nonneg-mass#continuity
REASON: the nonnegative-mass remark, frozen as rem_nonneg_mass_v1 (R7): the shift M -> M + epsilon I with Lemma 3.1 applied, and the limit epsilon -> 0; 'may vanish' is a comment, not a claim
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

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
REASON: remark about Theorem 4.1's ground-energy limit; no obligation for any root
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:lattice
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L4-L6
DISPOSITION: NODE def:lattice-shift, thm:main#twisted-integrand, eq:mass-bound, model:gauge-covariance
REASON: the torus X = (Z/nZ)^3 with n >= 3, spacing a > 0 and N = n^3 sites, and the orientation of the link (x, j) from x to x + e_j: the carrier and link orientation of def:lattice-shift, and premises (n >= 3, a > 0, N = n^3) of thm:main#twisted-integrand, eq:mass-bound and model:gauge-covariance
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:hilbert
KIND: display
SOURCE: paper-a/model.tex#eq:hilbert@L7-L12
DISPOSITION: EXCLUDED
REASON: the auxiliary Hilbert space L^2(U(1)^E) (x) F_a(l^2(X) (x) C^4); the frozen surface is one-particle and the Fock space stays outside it (R8)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:link-variables
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L13-L15
DISPOSITION: NODE eq:mass-bound#shift-unitary, eq:mass-bound, thm:main#twisted-integrand
REASON: U_e = e^{i varphi_e} gives |U_e| = 1, the premise of eq:mass-bound and eq:mass-bound#shift-unitary and the root's |U_k(x, j)| = 1 (R5); the Haar normalization, E_e and the absence of truncation concern the auxiliary space and are outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

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
DISPOSITION: NODE def:lattice-shift, def:wilson-hopping, def:wilson-mass, def:dirac-operator
REASON: the link convention (L29) and T_j, v_j, M of (2.3) are the frozen Wilson definitions; h_W(U) (L34) is the instance of def:dirac-operator with these coefficients (Lemmas 3.1-3.2 take v_j and M abstractly, the frozen def_dirac_operator_v1 cites model.tex:27-38); H of (2.4) (L36) is the auxiliary-space Hamiltonian and is outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:tensor-structure
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L39-L40
DISPOSITION: NODE def:dirac-operator, thm:main#twisted-integrand, eq:mass-bound, eq:mass-bound#shift-unitary
REASON: spatial matrices commute with the Dirac matrices (L39-L40); the bare-parameter premises m >= 0 and r >= 0 (L39) are recorded in eq:mass-bound and in thm:main#twisted-integrand (with m > 0 there); 'Since T_j(U) is unitary' (L40) is eq:mass-bound#shift-unitary
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:mass-bound
KIND: display
SOURCE: paper-a/model.tex#eq:mass-bound@L41-L45
DISPOSITION: NODE eq:mass-bound, eq:mass-bound#mass-lower-bound, eq:mass-bound#norm-bound
REASON: (2.5), frozen as eq_mass_bound_v1, a root: the first assertion M(U) >= m I (eq:mass-bound#mass-lower-bound), used by thm:main#wilson-history, and the second, ||h_W(U)|| <= h_*, which no other root uses (it serves the excluded Dyson bound and Lemma 2.1)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:mass-bound-proof
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L46-L46
DISPOSITION: NODE eq:mass-bound#mass-lower-bound
REASON: the proof of the first assertion of (2.5) from 2 - T - T^* = (I - T)^*(I - T)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:charge
KIND: definition
SOURCE: paper-a/model.tex#sec:model@L62-L63
DISPOSITION: EXCLUDED
REASON: n_x, q_x = n_x - 2 and the physical charge -g q_x are Fock-space operators; they enter only through e^{i sum theta q} = e^{-2i sum theta} Gamma(u) and the charge-sector reading of the phi-coefficient, outside the frozen surface (R8); the frozen twist's centering is computed from its one-particle generator (R4)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:gauge-unitary
KIND: display
SOURCE: paper-a/model.tex#eq:gauge-unitary@L64-L70
DISPOSITION: NODE thm:main#integrand-centered-trace, model:gauge-covariance, model:gauge-covariance#shift-covariance
REASON: the gauge function u_x = e^{i theta_x} (L64), whose one-particle action diag(e^{i theta}) (x) I_4 is the final kick of the twisted history, and the gauge action U^u_{xj} = u_x U_{xj} conj(u_{x+e_j}) (L66), which enters model:gauge-covariance; R_u and W(u) act on the auxiliary space and enter only the gauge insertion and projection (comparison.tex L54, L73-L79, L85-L86), outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:gauge-covariance
KIND: claim
SOURCE: paper-a/model.tex#sec:model@L71-L71
DISPOSITION: NODE model:gauge-covariance, model:gauge-covariance#shift-covariance
REASON: the covariance h_W(U^u) = u^* h_W(U) u, frozen as gauge_covariance_v1, a root because no other root uses it; its consequence that W(u) commutes with each term of H serves only the gauge insertion and the sector projection, outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:capacity
KIND: display
SOURCE: paper-a/model.tex#eq:capacity@L86-L91
DISPOSITION: NODE thm:main#twisted-integrand
REASON: H_nu != 0 iff |Q_nu| <= 2N turns the admissibility of nu (comparison.tex L7) into the root's premise |Q| <= 2N, which is Lemma 3.2's |q| <= d at comparison.tex L89; sum_x q_x = Q_nu serves only the charge-sector reading of the phi-coefficient, outside the frozen surface (R8)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:capacity-proof
KIND: proof-region
SOURCE: paper-a/model.tex#sec:model@L92-L97
DISPOSITION: EXCLUDED
REASON: the proof of (2.9) by Gauss's law, an integer flow on a spanning tree and occupation vectors, on the auxiliary space; the root takes |Q| <= 2N as its premise
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: model:c5
KIND: definition
SOURCE: paper-a/model.tex#lem:operator-proof@L116-L118
DISPOSITION: NODE def:c5, lem:transfer#c5-involution, lem:transfer#c5-anticommutes-h
REASON: C5 and its asserted properties; the pairing lambda -> -lambda of L118 concerns h_W, not U, and is not used
COVERAGE_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1

ITEM: thm:main
KIND: theorem
SOURCE: paper-a/comparison.tex#thm:main@L4-L21
DISPOSITION: NODE thm:main#twisted-integrand
REASON: Theorem 4.1 itself is not frozen and has no node (audit A, S0); its premises a > 0, r >= 0 (L6-L7), b > 0 (L12) and the case m > 0 (L13) are recorded in the frozen proof step thm:main#twisted-integrand, and admissibility (L7) gives its |Q| <= 2N through (2.9); the conclusions (4.1), 0 < Z_nu(b) <= Z_0(b), (4.2) and the ground-energy statement concern H on the auxiliary space and are outside the frozen surface; g > 0 does not enter the fermionic integrand
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:main
KIND: display
SOURCE: paper-a/comparison.tex#eq:main@L8-L11
DISPOSITION: EXCLUDED
REASON: the ground-energy comparison (4.1) for H on the auxiliary space; not frozen
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:thermal
KIND: display
SOURCE: paper-a/comparison.tex#eq:thermal@L14-L18
DISPOSITION: EXCLUDED
REASON: the heat-trace bound (4.2); its finite-dimensional input is thm:main#twisted-integrand, and the integration against the path and angle measure (deviation 6) is not a frozen anchor
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-heat-kernel
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L23-L30
DISPOSITION: EXCLUDED
REASON: the electric heat kernel on a link; outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:heat
KIND: display
SOURCE: paper-a/comparison.tex#eq:heat@L25-L30
DISPOSITION: EXCLUDED
REASON: the positive wrapped Gaussian (4.3); heat kernel, outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-dyson
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L31-L41
DISPOSITION: EXCLUDED
REASON: the Dyson series and its norm bound for the bounded matrix Feynman-Kac formula; outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:fk
KIND: display
SOURCE: paper-a/comparison.tex#eq:fk@L42-L47
DISPOSITION: EXCLUDED
REASON: the Feynman-Kac representation (4.4) with the Markov bridge expectation; path measure, outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-propagator
KIND: definition
SOURCE: paper-a/comparison.tex#thm:main-proof@L48-L49
DISPOSITION: NODE thm:main#integrand-centered-trace, thm:main#wilson-history
REASON: V_omega, the ordered one-particle propagator generated by -h_W(omega_t): for the step histories of R5 the ordered product of the free steps exp(-tau_k h_W(U_k)), the free part of the twisted history
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-bridges
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L49-L52
DISPOSITION: EXCLUDED
REASON: continuity of the circle Brownian bridges, step approximations and dominated convergence: path measure; R5 replaces the bridge paths by step histories and leaves this passage unformalized
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-gauge-insertion
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L54-L55
DISPOSITION: EXCLUDED
REASON: the kernel argument U^u after inserting W(u) (auxiliary space) and the finite-CAR identity Tr_F Gamma(A) = det(I + A), outside the frozen surface (R8)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: eq:twisted
KIND: display
SOURCE: paper-a/comparison.tex#eq:twisted@L56-L63
DISPOSITION: NODE thm:main#integrand-centered-trace, thm:main#twisted-integrand
REASON: the fermionic factor e^{-2i sum_x theta_x} det(I + u V_omega) (L61) is, under R8, the centered trace of the twisted history and the integrand of the root; the Haar integral, K_b(U^u, U), the bridge expectation and e^{-int H_B} are outside the frozen surface (heat kernel, path measure)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-trace-formula
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L64-L68
DISPOSITION: EXCLUDED
REASON: the justification of the trace formula (Hilbert-Schmidt factorization) and the uniform Dyson domination; outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-positivity
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L70-L72
DISPOSITION: NODE thm:main#apply-transfer, thm:main#wilson-history, eq:mass-bound#mass-lower-bound, thm:main#wilson-hopping-hermitian
REASON: positivity for m > 0 by Lemma 3.1 with M(omega_t) >= m I; the positivity of the scalar factors K_b and e^{-int H_B} is outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:cite-lem-transfer
KIND: citation
SOURCE: paper-a/comparison.tex#thm:main-proof@L71-L72
DISPOSITION: NODE thm:main#apply-transfer
REASON: the cross-reference to Lemma 3.1
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-projection
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L73-L80
DISPOSITION: EXCLUDED
REASON: the angle function F_b(theta), the exact gauge projection Z_nu = int e^{-i theta . nu} F_b, |Z_nu| <= Z_0 and the positivity of nonempty sector traces: integration over gauge angles and paths on the auxiliary space, outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-coordinates
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L82-L86
DISPOSITION: NODE thm:main#twist-split
REASON: theta_x = vartheta_x + phi (L82-L83) is the split of the twist; the root site with vartheta_root = 0 and the measure-preserving change of torus coordinates (L83-L84) belong to the angle integration and are not imposed (R6); that U^u and the bridge weight depend only on vartheta (L85-L86) concerns the bridge measure and is not needed when the history does not depend on phi (R5)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-fourier
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L86-L89
DISPOSITION: NODE thm:main#apply-fourier, thm:main#integrand-centered-trace, thm:main#wilson-history
REASON: the phi-integral as the Q_nu Fourier coefficient of the centered trace for e^{i vartheta} V_omega, and Lemma 3.2 with D = 4N, d = 2N, m_* = m; the charge-sector reading of the coefficient is outside the frozen surface (R8)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:cite-lem-fourier
KIND: citation
SOURCE: paper-a/comparison.tex#thm:main-proof@L88-L89
DISPOSITION: NODE thm:main#apply-fourier
REASON: the cross-reference to Lemma 3.2
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-integration
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L90-L93
DISPOSITION: EXCLUDED
REASON: removal of e^{-i vartheta . nu} by absolute value and integration of the zeroth coefficient against the angle and path measure, giving the vacuum partition function; outside the frozen surface (the abstract integration step is deviation 6, not a frozen anchor)
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-ground-energy
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L95-L97
DISPOSITION: EXCLUDED
REASON: the ground-energy limit E_nu = -lim b^{-1} log Z_nu(b); outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:cite-sec-transfer
KIND: citation
SOURCE: paper-a/comparison.tex#thm:main-proof@L98-L99
DISPOSITION: NODE rem:nonneg-mass
REASON: 'For m = 0, determinants are nonnegative by the limit in Section 3' cites the remark frozen as rem_nonneg_mass_v1; its application to the Wilson integrand at m = 0, which also needs (2.5) at m = 0, belongs to the m = 0 case of Theorem 4.1 and is outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-continuity
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L99-L101
DISPOSITION: EXCLUDED
REASON: the alternative route for m = 0, ||H_epsilon - H_0|| <= 2N epsilon and continuity of every sector ground energy: operator statements on the auxiliary space, outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2

ITEM: comparison:proof-auxiliary
KIND: proof-region
SOURCE: paper-a/comparison.tex#thm:main-proof@L101-L103
DISPOSITION: EXCLUDED
REASON: the auxiliary space as the direct sum of joint integer Gauss sectors and its global minimality; outside the frozen surface
COVERAGE_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
