# Proof dependency database: Paper A, Lemmas 3.1 and 3.2 and four finite-dimensional proof steps of Theorem 4.1

GRAPH_VERSION: 4
ROOTS: lem:transfer, lem:fourier, thm:main#twisted-integrand, rem:nonneg-mass, model:gauge-covariance, eq:mass-bound
CORPUS: paper-a/transfer.tex (sha256 b2dcc793552cfa284131c60d563703b462bb6c77112b9d2002c2bed5f7c698cf), paper-a/model.tex L4-15, L27-46, L62-71, L86-97 and L116-118 (sha256 2464b16fd9bbedce20aaf07991b2bfb7b9f24b922166d049c8f4d379dcdd961e), paper-a/comparison.tex L4-104 (sha256 1caaf36bb7ab5f90c15224be3bc0f1eb20baeae06f40fb7c340ad3145db13273); draft of 29 October 2026, pinned in lean/status.json
CONVENTIONS: Dirac matrices alpha_j, beta Hermitian 4x4 Clifford (model.tex L27-28); one-particle space l^2 (x) C^4, spatial factor first, D = 2d; U' = -A U with A = c h + i Phi, so later steps act on the left; Theta denotes the full spin-scalar generator Theta_sp (x) I_4 (QEDCore.PaperA.Step.kick carries Theta_sp; Tr Theta = 4 tr Theta_sp); a kick exp(i Theta) has int A = -i Theta and centering factor e^{-(i/2) Tr Theta}; B(t) = <f(t), (I (x) beta) f(t)>; s = e^{-b m_*} throughout, and the deformation parameter printed as s at transfer.tex L75 is written sigma; F_q = (2 pi)^{-1} int_0^{2 pi} e^{-i q phi} F(phi) d phi with q an integer; H31(hist) abbreviates the hypotheses of Lemma 3.1 on a history: a Hermitian 4x4 Clifford set on the spin factor (model.tex L27-28, L39-40), D = 2d, m_* > 0, b > 0, free steps with c >= 0, Hermitian spatial v_j and Hermitian M >= m_* I, kicks with Hermitian spin-scalar generator, total free time b (transfer.tex L6-L26); every lem:transfer#* node and eq:beta-form is stated for, and universally quantified over, all histories satisfying H31 (or the part of H31 its SOURCE_HYPOTHESES names), because lem:transfer#homotopy-nonvanishing reapplies centered-trace-real and det-nonvanishing, with their closures, to the deformed histories H_sigma; H32 abbreviates H31 for the history of Lemma 3.2 together with the definitions of F(phi) and F_q (transfer.tex L95-L98), assumed by every lem:fourier#* node; step-carrier reading of the ODE statements: a free step (tau, v, M) is an interval of length tau with c = 1, Phi = 0 and constant coefficients, a kick Theta_sp is a separate interval with c = 0 and int Phi = -(Theta_sp (x) I_4), and derivative statements are read on each free step, kicks being handled by lem:transfer#kick-preserves-beta-form and lem:transfer#c5-commutes-kick; the frozen statements specialize to piecewise-constant histories with separate instantaneous kicks (R1(a)), any finite spatial index (R2), Im F_0 = 0 (R3) and kicks by a Hermitian generator (R4), docs/DECISIONS.md D11; revision 5 (proof steps of Theorem 4.1, docs/DECISIONS.md D16): X = (Z/nZ)^3 with n >= 3, spacing a > 0 and N = n^3 sites (model.tex L4-L5), so the Wilson histories have spatial index X, D = 4N and d = 2N (comparison.tex L89; R2 with iota = X); q_x = n_x - 2 (model.tex L62) is a Fock-space charge and appears only in parts outside the frozen surface; Wilson conventions of (2.3): (T_j(U) f)(x) = conj(U_{xj}) f(x + e_j) with e_j = Pi.single j 1, U_{xj} the link variable on the link from x to x + e_j and j = 1, 2, 3 indexed by Fin 3, v_j(U) = (T_j(U) - T_j(U)^*)/(2ia), M(U) = m + (r/2a) sum_j (2 - T_j(U) - T_j(U)^*) with m and 2 read as multiples of I, and h_W(U) = sum_j alpha_j v_j(U) + beta M(U) is def:dirac-operator with these coefficients (spatial factor first); the frozen Wilson definitions accept any complex link array U, |U_{xj}| = 1 being a consumer premise; a gauge function u_x = e^{i theta_x}, equivalently u : X -> C with |u_x| = 1, acts on l^2(X) (x) C^4 as diag(u) (x) I_4, and U^u_{xj} = u_x U_{xj} conj(u_{x+e_j}) (model.tex L64-L66); the norm bound of (2.5) is frozen as h_* 1 - h_W(U) and h_* 1 + h_W(U) positive semidefinite; step-history convention (R5): a link history is a list of pairs (tau_k, U_k) with tau_k >= 0, |U_k(x, j)| = 1 and sum_k tau_k = b, each contributing the free step exp(-tau_k h_W(U_k)); it stands in for the bridge path omega on [0, b] of (4.4)-(4.5), without the endpoint conditions omega_0 = U, omega_b = U^u; V_omega is the ordered product of these free steps (later steps on the left), and the twisted history appends the gauge kick u = exp(i diag(theta) (x) I_4), so its transfer matrix is u V_omega; twist convention (R6): theta = vartheta + phi 1 with vartheta in R^X unrestricted (no root site, no reduction modulo 2 pi), F(phi) is the centered trace of the twisted history, F_Q = (2 pi)^{-1} int_0^{2 pi} e^{-i Q phi} F(phi) d phi with Q an integer (in thm:main#* nodes Q is the Fourier index Q_nu, Lemma 3.2's q, never Lemma 3.2's charge operator Q = dGamma(I) - d; with d = 2N that operator is sum_x q_x, outside the frozen surface, and the phi-part of the twist is Lemma 3.2's appended kick Step.kick (phi * 1) with centering e^{-i d phi} = e^{-2i N phi}), and F_0 real is stated as Im F_0 = 0 with the bound written against Re F_0; R8: the centered trace of the twisted Wilson history is the definition of the fermionic integrand e^{-2i sum_x theta_x} det(I + u V_omega) of (4.5), while the finite-CAR (Fock) identity Tr_F Gamma(A) = det(I + A), the identity e^{i sum_x theta_x q_x} = e^{-2i sum_x theta_x} Gamma(u) and the charge-sector reading of the phi-Fourier coefficient stay outside the frozen surface and the graph; rem:nonneg-mass is read in Lemma 3.1's frozen setting (R1(a), R2, R4) with every mass coefficient positive semidefinite and b > 0 retained (R7)
STANDING_ASSUMPTIONS: -
EXTERNAL_POLICY: transfer.tex cites no external result. Textbook facts the source names (determinant as the product of eigenvalues with multiplicity, Vandermonde's convolution, Gronwall integration, complex conjugation) are modeled inside the step that uses them; a step the source asserts without an argument, and without naming a method, is marked SOURCE_GAP, graded [minor] (a few lines from facts already stated) or [substantive] (needs a standard theorem or argument the source neither gives nor names); a gap is not an erratum unless the asserted step is false; Lean effort is not part of the grade; elementary calculus and linear algebra (intermediate and mean value theorems, exponentials of commuting matrices, determinants of triangular or diagonal matrices) count as stated facts; remarks about Lean live in NOTE because LEAN_NOTE stays initialized at this stage; revision 5: the added comparison.tex and model.tex lines cite no external result either, and the standard results used only by their excluded parts (Poisson summation in (4.3), the Dyson and Feynman-Kac representation, the finite-CAR identity) are excluded with those parts
FROZEN_ANCHORS: lem:transfer, lem:fourier, def:history-step, def:dirac-operator, def:step-generator, def:step-free-time, def:transfer-matrix, def:centered-trace, thm:main#twisted-integrand, rem:nonneg-mass, model:gauge-covariance, eq:mass-bound, def:lattice-shift, def:wilson-hopping, def:wilson-mass
FROZEN_MANIFEST: lean/frozen-manifest.json | sha256:3963096ef6449a8280d5179482d5b706a707c0d03c88b44dbef5854ad3e1cc30
WRITER: graph-writer-2
GLOBAL_REVIEWER: global-reviewer-2
GLOBAL_REVIEW_REF: docs/audits/graph/GLOBAL_REVIEW_REV5.md

The dependency direction is `NODE -> prerequisite`. `DEPS` is conjunctive; there are no
alternative routes. Lean fields are initialized planning metadata only. Source locators
point into the pinned LaTeX; frozen Lean paths are relative to `lean/` (see the header
of `scripts/proof_depgraph.py`). Revision 4 (roots `lem:transfer`, `lem:fourier`):
one slice (the corpus was transfer.tex plus 17 lines of model.tex), extracted and
written by the orchestrator. Every node was reviewed by a distinct fresh agent and the
root closure by a further distinct global reviewer; their reports are
`docs/audits/graph/TOPOLOGY_REVIEW_NODES.md` and `docs/audits/graph/GLOBAL_REVIEW.md`,
and the merge decisions are in `docs/audits/graph/MERGE_LOG.md`.

Revision 5 (2026-11-14; `GRAPH_VERSION` is the linter's schema version and stays 4):
`graph-writer-2` added the roots `thm:main#twisted-integrand`, `rem:nonneg-mass` and
`model:gauge-covariance` (anchors `main_twisted_integrand_v1`, `rem_nonneg_mass_v1` and
`gauge_covariance_v1`; rulings R5-R8 and T5-T6 of docs/DECISIONS.md D16), the frozen
display `eq:mass-bound` (`eq_mass_bound_v1`, a root; `thm:main#twisted-integrand` uses
only its first assertion, `eq:mass-bound#mass-lower-bound`), the frozen Wilson
definitions of (2.3) and the source closures of the new roots, which reach
`lem:transfer` and `lem:fourier` where comparison.tex L71-L72 and L88-L89 apply them.
The 19 nodes and the
coverage items that revision 5 added or changed are `PROPOSED` and await node reviews
and a fresh global review; `GLOBAL_REVIEWER` and `GLOBAL_REVIEW_REF` still record the
review of revision 4.

## Nodes

NODE: lem:transfer
KIND: lemma
TITLE: Positivity and the transfer annulus (Lemma 3.1)
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L9-L36
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L37-L81
CONTRACT_ID: paper-a.lem:transfer
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); an ordered history of free evolutions generated by h(t) = sum_j alpha_j v_j(t) + beta M(t) with bounded Hermitian spatial v_j(t) and M(t) >= m_* I, m_* > 0, interspersed with spin-scalar unitary kicks with Hermitian spin-scalar generator Phi; c >= 0 with int c = b > 0; U' = -A U, A = c h + i Phi; one-particle dimension D = 2d; U the ordered one-particle product of the history; F = exp((1/2) int Tr A) det(I + U); no normality or diagonalizability of U is assumed (L34-L35)
SOURCE_QUANTIFIERS: for all Clifford sets, d, m_* > 0, b > 0 and every admissible history
SOURCE_CONCLUSION: F > 0; exactly d eigenvalues of U, counted with algebraic multiplicity, satisfy |lambda| <= e^{-b m_*}; the remaining d are their partners 1/conj(lambda) and have modulus >= e^{b m_*}
CONSTANT_SCOPE: none
FROZEN_FILE: Frozen/PaperA/PositivityAndTransferAnnulus.lean
FROZEN_DECL: QEDCore.PaperA.positivity_and_transfer_annulus
FROZEN_ANCHOR_ID: lem_transfer_v1
FROZEN_ABI_SHA256: 48c44cf3675aa01e2380fb5c4370ce5b5bb2ec1b9bd78f50ba46e25e8e05280f
DEPS: lem:transfer#positivity, lem:transfer#eigenvalue-count, lem:transfer#unstable-gronwall, def:centered-trace, def:transfer-matrix, def:step-free-time, def:history-step, def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#positivity | paper-a/transfer.tex#lem:transfer@L27-L27 | 'Then F > 0'
EDGE: lem:transfer#eigenvalue-count | paper-a/transfer.tex#lem:transfer@L27-L33 | exactly d eigenvalues obey (3.2) and the remaining d are their partners
EDGE: lem:transfer#unstable-gronwall | paper-a/transfer.tex#lem:transfer@L33-L34 | the partners have modulus at least e^{b m_*}
EDGE: def:centered-trace | paper-a/transfer.tex#lem:transfer@L19-L23 | the statement is about F of (3.1)
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer@L17-L18 | the statement is about the eigenvalues of U
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer@L24-L26 | b is the total free time int c
EDGE: def:history-step | paper-a/transfer.tex#lem:transfer@L11-L16 | the statement quantifies over ordered histories of free steps and kicks
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer@L12-L14 | the generator h(t) of the free steps
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen lem_transfer_v1 specializes the source: piecewise-constant histories with separate instantaneous kicks (R1(a), deviation 7), any finite spatial index iota with 4|iota| = 2d, empty allowed (R2, deviation 8), kicks by a Hermitian spatial generator (R4). Encoding: F > 0 as 0 < Re F and Im F = 0; 'exactly d' as the card of the charpoly-root filter |z| <= e^{-b m_*}; partners as multiset equality of the complementary filter with the image under z -> (star z)^{-1}; the modulus bound for every root outside the small disk. The closure supports the frozen specialization; the printed statement for bounded measurable coefficients also needs transfer.tex L78-80 (excluded).

NODE: lem:fourier
KIND: lemma
TITLE: Canonical Fourier bound (Lemma 3.2)
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier@L93-L104
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L105-L130
CONTRACT_ID: paper-a.lem:fourier
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: a history satisfying the hypotheses of Lemma 3.1; the global charge twist e^{i phi Q}, Q = dGamma(I) - d, appended; F(phi) its centered trace; F_q = (2 pi)^{-1} int_0^{2 pi} e^{-i q phi} F(phi) d phi
SOURCE_QUANTIFIERS: for every history of Lemma 3.1 and every integer q with |q| <= d
SOURCE_CONCLUSION: |F_q| <= binom(2d, d+|q|) e^{-b m_* |q|} F_0, the right side presupposing F_0 real
CONSTANT_SCOPE: none
FROZEN_FILE: Frozen/PaperA/CanonicalFourierBound.lean
FROZEN_DECL: QEDCore.PaperA.canonical_fourier_bound
FROZEN_ANCHOR_ID: lem_fourier_v1
FROZEN_ABI_SHA256: 7e2b22d01f60c80db633656f9f12a19b5b7429d6656300750f12cbcdf3e388aa
DEPS: lem:fourier#vandermonde, lem:fourier#negative-q, lem:fourier#vacuum-real, lem:fourier#twist-is-kick, def:centered-trace, def:step-free-time, def:history-step
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#vandermonde | paper-a/transfer.tex#eq:fourier-bound@L100-L103 | (3.4) for 0 <= q <= d
EDGE: lem:fourier#negative-q | paper-a/transfer.tex#eq:fourier-bound@L100-L103 | (3.4) for -d <= q < 0, through ‖q‖
EDGE: lem:fourier#vacuum-real | paper-a/transfer.tex#eq:fourier-bound@L101-L101 | F_0 on the right of (3.4) is real
EDGE: lem:fourier#twist-is-kick | paper-a/transfer.tex#lem:fourier@L95-L97 | F(phi) is the centered trace of the twisted history
EDGE: def:centered-trace | paper-a/transfer.tex#lem:fourier@L97-L97 | 'Let F(phi) be its centered trace'
EDGE: def:step-free-time | paper-a/transfer.tex#eq:fourier-bound@L101-L101 | b in e^{-b m_* ‖q‖} is the total free time
EDGE: def:history-step | paper-a/transfer.tex#lem:fourier@L95-L96 | the twist is appended to the history as a further step
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen lem_fourier_v1: piecewise-constant histories (R1(a)); the twist is appended as Step.kick (phi * 1), its centering e^{-i d phi} computed from the generator (R4); q is an integer; states Im F_0 = 0 and bounds |F_q| by Re F_0 (R3).

NODE: def:history-step
KIND: definition
TITLE: Step of an ordered history
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L11-L16
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.history-step
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: a history is an ordered sequence of free evolutions generated by sum_j alpha_j v_j + beta M (free time tau) and spin-scalar unitary kicks exp(i Theta)
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/Step.lean
FROZEN_DECL: QEDCore.PaperA.Step
FROZEN_ANCHOR_ID: def_step_v1
FROZEN_ABI_SHA256: 1490cf38efb216eb9da8f3d68ba53a4db7c4418699b6f4786ff97c035b08a1d2
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen as QEDCore.PaperA.Step for piecewise-constant histories with separate instantaneous kicks (R1(a), deviation 7); SOURCE_CONCLUSION is phrased in that step reading, while the source (transfer.tex L4-5, L11-26) has time-dependent coefficients on [0,T] with A = c h + i Phi and permits simultaneous free and kick terms. Step.kick carries the spatial generator Theta_sp; the full generator is Theta_sp (x) I_4.

NODE: def:dirac-operator
KIND: definition
TITLE: Dirac operator h = sum_j alpha_j v_j + beta M
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L13-L13
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.dirac-operator
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: h = sum_j alpha_j v_j + beta M acting on l^2 (x) C^4, spatial matrices commuting with the Dirac matrices
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/DiracOperator.lean
FROZEN_DECL: QEDCore.PaperA.diracOperator
FROZEN_ANCHOR_ID: def_dirac_operator_v1
FROZEN_ABI_SHA256: 8e584268400dbaecd85eb507430893aa4d93bc820ac79cc26fb533f8eb250ac8
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Also model.tex L27-28 (Dirac matrices), L34 (h_W), L39-40 (tensor structure).

NODE: def:step-generator
KIND: definition
TITLE: Integrated generator int A of one step
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L20-L26
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.step-generator
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: A = c h + i Phi in U' = -A U; integrated over one step, int A = tau h for a free step of duration tau and int A = -i Theta for a kick e^{i Theta} (U' = -i Phi U on the kick interval, Theta = -int Phi)
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/StepGenerator.lean
FROZEN_DECL: QEDCore.PaperA.Step.generator
FROZEN_ANCHOR_ID: def_step_generator_v1
FROZEN_ABI_SHA256: 7a85dcbb051d0baf976ef29b296bffb73b9f512f7e297d5d79920ff7c82b1f79
DEPS: def:history-step, def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: def:history-step | paper-a/transfer.tex#lem:transfer@L24-L26 | free and kick intervals of the history
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer@L21-L21 | A = c(t) h(t) + i Phi(t)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The kick notation e^{i Theta} is fixed at transfer.tex L83. The kick centering factor e^{-(i/2) Tr Theta} (L83-L84) follows from def:centered-trace and is not part of this definition.

NODE: def:step-free-time
KIND: definition
TITLE: Free time of a step; total free time b
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L24-L26
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.step-free-time
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: c >= 0 with int_0^T c dt = b: free steps carry their duration, kicks carry none
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/StepFreeTime.lean
FROZEN_DECL: QEDCore.PaperA.Step.freeTime
FROZEN_ANCHOR_ID: def_step_free_time_v1
FROZEN_ABI_SHA256: f02bcd442e5bdf66e08f4bf50f40cfda7db2571b0c86501fb63804252c4748f5
DEPS: def:history-step
ROUTES: -
ROUTE_FOR: -
EDGE: def:history-step | paper-a/transfer.tex#lem:transfer@L24-L26 | free time is defined on the steps of a history
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: def:transfer-matrix
KIND: definition
TITLE: Transfer matrix U
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer@L17-L21
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.transfer-matrix
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: U is the ordered one-particle product of the free evolutions and kicks, i.e. the solution at time T of U' = -A(t) U, U(0) = I
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/TransferMatrix.lean
FROZEN_DECL: QEDCore.PaperA.transferMatrix
FROZEN_ANCHOR_ID: def_transfer_matrix_v1
FROZEN_ABI_SHA256: e0943f9b548d2149cf282079e0ffa2e203867c2cc8d0cd90b1505bebb99cc828
DEPS: def:step-generator
ROUTES: -
ROUTE_FOR: -
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer@L21-L21 | U' = -A U
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: def:centered-trace
KIND: definition
TITLE: Centered finite-CAR trace F (3.1)
STATEMENT_SOURCE: paper-a/transfer.tex#eq:centered-trace@L19-L23
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.centered-trace
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: F = exp((1/2) int Tr A dt) det(I + U)
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/CenteredTrace.lean
FROZEN_DECL: QEDCore.PaperA.centeredTrace
FROZEN_ANCHOR_ID: def_centered_trace_v1
FROZEN_ABI_SHA256: 0d9d1742126502473e4d81eacf516b99e48b8f967c8313524755926fbc69a31f
DEPS: def:transfer-matrix, def:step-generator
ROUTES: -
ROUTE_FOR: -
EDGE: def:transfer-matrix | paper-a/transfer.tex#eq:centered-trace@L20-L20 | det(I + U)
EDGE: def:step-generator | paper-a/transfer.tex#eq:centered-trace@L20-L20 | the centering exponent int Tr A
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: def:c5
KIND: definition
TITLE: C5 = alpha_1 alpha_2 alpha_3 beta
STATEMENT_SOURCE: paper-a/model.tex#lem:operator-proof@L116-L117
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.c5
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: C5 = alpha_1 alpha_2 alpha_3 beta
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Defined inside the proof of Lemma 2.1; transfer.tex L38 uses C5 without restating it.

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
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] never stated; used for A* = c h - i Phi (L40) and in (3.3) (L57).

NODE: lem:transfer#c5-involution
KIND: step
TITLE: C5 is a Hermitian unitary involution
STATEMENT_SOURCE: paper-a/model.tex#lem:operator-proof@L116-L117
PROOF_SOURCE: paper-a/model.tex#lem:operator-proof@L116-L117
CONTRACT_ID: paper-a.lem:transfer#c5-involution
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40)
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: C5* = C5 and C5 C5 = I
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:c5
ROUTES: -
ROUTE_FOR: -
EDGE: def:c5 | paper-a/model.tex#lem:operator-proof@L116-L117 | the product whose adjoint and square are taken
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] model.tex asserts 'the Hermitian unitary C5' without the sign count for reversing and squaring a product of four pairwise anticommuting Hermitian involutions.

NODE: lem:transfer#c5-anticommutes-h
KIND: step
TITLE: C5 anticommutes with every Dirac operator h
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L38-L38
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L38-L38
CONTRACT_ID: paper-a.lem:transfer#c5-anticommutes-h
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); h = sum_j alpha_j v_j + beta M with spatial v_j, M
SOURCE_QUANTIFIERS: for every such h
SOURCE_CONCLUSION: C5 h + h C5 = 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:c5, def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: def:c5 | paper-a/transfer.tex#lem:transfer-proof@L38-L38 | C5 is the matrix that anticommutes
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer-proof@L38-L38 | the form of h
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] asserted at transfer.tex L38 (and for h_W at model.tex L116-117) without showing that C5 anticommutes with each alpha_j and with beta and commutes with spatial matrices.

NODE: lem:transfer#c5-commutes-kick
KIND: step
TITLE: C5 commutes with spin-scalar generators
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L38-L38
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L38-L38
CONTRACT_ID: paper-a.lem:transfer#c5-commutes-kick
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Phi spin scalar (acts as the identity on C^4)
SOURCE_QUANTIFIERS: for every spin-scalar Phi
SOURCE_CONCLUSION: C5 Phi = Phi C5
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:c5
ROUTES: -
ROUTE_FOR: -
EDGE: def:c5 | paper-a/transfer.tex#lem:transfer-proof@L38-L38 | C5 acts on the spin factor only
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Immediate from the tensor structure; not a gap.

NODE: lem:transfer#generator-c5-relation
KIND: step
TITLE: A* C5 + C5 A = 0
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L39-L40
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L38-L40
CONTRACT_ID: paper-a.lem:transfer#generator-c5-relation
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); A = c h + i Phi with c >= 0, h = sum_j alpha_j v_j + beta M with Hermitian spatial v_j, M (transfer.tex L13-L15), and Phi Hermitian and spin scalar (transfer.tex L26)
SOURCE_QUANTIFIERS: for all t
SOURCE_CONCLUSION: A* C5 + C5 A = 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#c5-anticommutes-h, lem:transfer#c5-commutes-kick, def:step-generator, lem:transfer#dirac-hermitian
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#c5-anticommutes-h | paper-a/transfer.tex#lem:transfer-proof@L38-L38 | the c h part
EDGE: lem:transfer#c5-commutes-kick | paper-a/transfer.tex#lem:transfer-proof@L38-L38 | the i Phi part
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer-proof@L40-L40 | A = c h + i Phi
EDGE: lem:transfer#dirac-hermitian | paper-a/transfer.tex#lem:transfer-proof@L39-L40 | A* = c h - i Phi needs h Hermitian
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#form-preservation
KIND: step
TITLE: U* C5 U = C5
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L40-L40
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L40-L40
CONTRACT_ID: paper-a.lem:transfer#form-preservation
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31 (Clifford alpha_j, beta on the spin factor; Hermitian spatial v_j, M; Hermitian spin-scalar kick generators); U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every history satisfying the Clifford and Hermiticity part of H31
SOURCE_CONCLUSION: U* C5 U = C5
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#generator-c5-relation, def:transfer-matrix
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#generator-c5-relation | paper-a/transfer.tex#lem:transfer-proof@L40-L40 | the generator relation that is integrated
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer-proof@L40-L40 | U solves U' = -A U
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the passage from A* C5 + C5 A = 0 to U* C5 U = C5 (d/dt (U* C5 U) = 0; for a step X, C5 X = -X* C5 gives C5 exp(-X) = exp(X*) C5, hence exp(-X)* C5 exp(-X) = C5, without using C5 C5 = I) is not written.

NODE: lem:transfer#transport
KIND: step
TITLE: Transport of a vector along the history
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L52-L53
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L52-L53
CONTRACT_ID: paper-a.lem:transfer#transport
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: a history (no part of H31 is needed); v a vector of the one-particle space
SOURCE_QUANTIFIERS: for every history and every v
SOURCE_CONCLUSION: f(t) = U(t) v, with U(t) the propagator of the history up to time t (for steps: the ordered product of the first k step propagators), satisfies f(0) = v, f(T) = U v, f' = -A f inside free intervals, and f -> e^{i Theta} f across a kick
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
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: A construction the source names; not a gap.

NODE: lem:transfer#propagator-invertible
KIND: step
TITLE: The propagator is invertible
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L42-L42
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L42-L42
CONTRACT_ID: paper-a.lem:transfer#propagator-invertible
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: U and every partial propagator solve U' = -A U with bounded A
SOURCE_QUANTIFIERS: for every history (bounded generators suffice; no part of H31 is needed)
SOURCE_CONCLUSION: U is invertible; in particular 0 is not an eigenvalue and a transported nonzero vector never vanishes
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:transfer-matrix, lem:transfer#transport
ROUTES: -
ROUTE_FOR: -
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer-proof@L42-L42 | U^{-1} is written for the propagator
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L62-L62 | 'a nonzero solution never vanishes' concerns f(t) = U(t) v
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] invertibility is used (U^{-1} at L42, nonvanishing at L62, lambda != 0 at L64-65) but never stated or proved.

NODE: lem:transfer#inverse-adjoint
KIND: step
TITLE: U* = C5 U^{-1} C5
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L42-L42
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L42-L42
CONTRACT_ID: paper-a.lem:transfer#inverse-adjoint
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31 (Clifford alpha_j, beta on the spin factor; Hermitian spatial v_j, M; Hermitian spin-scalar kick generators); U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every history satisfying the Clifford and Hermiticity part of H31
SOURCE_CONCLUSION: U* = C5 U^{-1} C5
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#form-preservation, lem:transfer#c5-involution, lem:transfer#propagator-invertible
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#form-preservation | paper-a/transfer.tex#lem:transfer-proof@L42-L42 | 'Thus' follows U* C5 U = C5
EDGE: lem:transfer#c5-involution | paper-a/transfer.tex#lem:transfer-proof@L42-L42 | C5^{-1} = C5
EDGE: lem:transfer#propagator-invertible | paper-a/transfer.tex#lem:transfer-proof@L42-L42 | U^{-1} exists
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#spectral-pairing
KIND: step
TITLE: Spectrum paired under lambda -> 1/conj(lambda) with multiplicity
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L42-L43
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L42-L43
CONTRACT_ID: paper-a.lem:transfer#spectral-pairing
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31 (Clifford alpha_j, beta on the spin factor; Hermitian spatial v_j, M; Hermitian spin-scalar kick generators); U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every history satisfying the Clifford and Hermiticity part of H31
SOURCE_CONCLUSION: the eigenvalues of U with algebraic multiplicity form a multiset invariant under lambda -> 1/conj(lambda)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#inverse-adjoint, lem:transfer#propagator-invertible, lem:transfer#c5-involution
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#inverse-adjoint | paper-a/transfer.tex#lem:transfer-proof@L42-L43 | U* is similar to U^{-1}
EDGE: lem:transfer#propagator-invertible | paper-a/transfer.tex#lem:transfer-proof@L42-L43 | U^{-1} and nonzero eigenvalues
EDGE: lem:transfer#c5-involution | paper-a/transfer.tex#lem:transfer-proof@L42-L43 | C5^{-1} = C5 makes U* = C5 U^{-1} C5 a similarity
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [substantive] the multiplicity claim is drawn from U* = C5 U^{-1} C5 with 'Thus'; the characteristic-polynomial argument (similar matrices share it; that of U* is the conjugate of that of U; that of U^{-1} is the scaled reverse) is neither given nor named.

NODE: lem:transfer#det-conjugation
KIND: step
TITLE: conj det(I+U) = det(U)^{-1} det(I+U)
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L46-L46
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L46-L46
CONTRACT_ID: paper-a.lem:transfer#det-conjugation
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the Clifford and Hermiticity part of H31 (Clifford alpha_j, beta on the spin factor; Hermitian spatial v_j, M; Hermitian spin-scalar kick generators); U the transfer matrix of the history
SOURCE_QUANTIFIERS: for every history satisfying the Clifford and Hermiticity part of H31
SOURCE_CONCLUSION: conj(det(I + U)) = det(U)^{-1} det(I + U)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#inverse-adjoint, lem:transfer#c5-involution, lem:transfer#propagator-invertible
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#inverse-adjoint | paper-a/transfer.tex#lem:transfer-proof@L46-L46 | det(I + U*) = det(I + U^{-1})
EDGE: lem:transfer#c5-involution | paper-a/transfer.tex#lem:transfer-proof@L46-L46 | conjugation by C5 preserves the determinant
EDGE: lem:transfer#propagator-invertible | paper-a/transfer.tex#lem:transfer-proof@L46-L46 | det(I + U^{-1}) = det(U)^{-1} det(I + U)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] stated after 'Also' without the computation conj det(I+U) = det(I+U*) = det(C5 (I+U^{-1}) C5) = det(I+U^{-1}) = det(U)^{-1} det(I+U).

NODE: lem:transfer#liouville
KIND: step
TITLE: det U = exp(-int Tr A)
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L47-L47
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L47-L47
CONTRACT_ID: paper-a.lem:transfer#liouville
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: U' = -A U, U(0) = I
SOURCE_QUANTIFIERS: for every history (no part of H31 is needed)
SOURCE_CONCLUSION: det U = e^{-int Tr A}
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:transfer-matrix, def:step-generator
ROUTES: -
ROUTE_FOR: -
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer-proof@L47-L47 | U is the propagator
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer-proof@L47-L47 | int Tr A
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [substantive] Liouville's formula is used without proof, name or citation; for a step history it is det(exp X) = exp(tr X) per step (a TODO in Mathlib v4.35.0).

NODE: lem:transfer#trace-h-zero
KIND: step
TITLE: Tr h = 0, so int Tr A is purely imaginary
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L49-L49
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L49-L49
CONTRACT_ID: paper-a.lem:transfer#trace-h-zero
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); Phi Hermitian
SOURCE_QUANTIFIERS: for every h of the history
SOURCE_CONCLUSION: Tr h = 0 and int Tr A = i int Tr Phi is purely imaginary
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:dirac-operator, def:step-generator
ROUTES: -
ROUTE_FOR: -
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer-proof@L49-L49 | the form of h
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer-proof@L49-L49 | A = c h + i Phi
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] Tr h = 0 needs Tr alpha_j = Tr beta = 0, a consequence of the Clifford relations that is not shown.

NODE: lem:transfer#centered-trace-real
KIND: step
TITLE: F is real
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L49-L50
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L44-L50
CONTRACT_ID: paper-a.lem:transfer#centered-trace-real
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); free steps with c >= 0 and Hermitian spatial v_j, M; kicks with Hermitian spin-scalar generator (transfer.tex L13-L16, L26); no mass bound or free-time condition is needed
SOURCE_QUANTIFIERS: for every such history (lem:transfer#homotopy-nonvanishing applies it to each deformed history H_sigma)
SOURCE_CONCLUSION: the centered trace F of that history is real
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#det-conjugation, lem:transfer#liouville, lem:transfer#trace-h-zero, def:centered-trace
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#det-conjugation | paper-a/transfer.tex#lem:transfer-proof@L49-L50 | conjugate of det(I + U)
EDGE: lem:transfer#liouville | paper-a/transfer.tex#lem:transfer-proof@L49-L50 | det U in terms of int Tr A
EDGE: lem:transfer#trace-h-zero | paper-a/transfer.tex#lem:transfer-proof@L49-L50 | the centering exponent is imaginary
EDGE: def:centered-trace | paper-a/transfer.tex#lem:transfer-proof@L49-L50 | the quantity shown real
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#kick-preserves-beta-form
KIND: step
TITLE: Scalar kicks preserve the beta-form
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L54-L55
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L54-L55
CONTRACT_ID: paper-a.lem:transfer#kick-preserves-beta-form
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the kick is unitary and spin scalar (transfer.tex L16); under R4 it is exp(i Theta (x) I) with Theta Hermitian, so its unitarity is derived; beta acts on the spin factor (model.tex L39-40)
SOURCE_QUANTIFIERS: for every kick and every transported vector
SOURCE_CONCLUSION: B = <f, beta f> is unchanged across a kick
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:step-generator, lem:transfer#transport
ROUTES: -
ROUTE_FOR: -
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer-proof@L54-L55 | kicks are exp of a spin-scalar generator
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L52-L55 | across a kick the transported vector f becomes e^{i Theta} f
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: eq:beta-form
KIND: display
TITLE: beta-form derivative (3.3)
STATEMENT_SOURCE: paper-a/transfer.tex#eq:beta-form@L56-L60
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L56-L60
CONTRACT_ID: paper-a.eq:beta-form
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28); spatial matrices commute with them (model.tex L39-40); Hermitian spatial v_j and M(t) >= m_* I; c >= 0; Phi Hermitian and spin scalar (transfer.tex L26); f the transported vector, f' = -A f
SOURCE_QUANTIFIERS: for every t at which f is differentiable along a transported vector (every t inside a free step for the frozen piecewise-constant carrier)
SOURCE_CONCLUSION: B'(t) = -2 c(t) <f, M f> <= -2 m_* c(t) |f|^2
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:dirac-operator, def:step-generator, lem:transfer#transport, lem:transfer#dirac-hermitian
ROUTES: -
ROUTE_FOR: -
EDGE: def:dirac-operator | paper-a/transfer.tex#lem:transfer-proof@L56-L58 | beta h + h beta = 2 M
EDGE: def:step-generator | paper-a/transfer.tex#lem:transfer-proof@L56-L58 | f' = -A f with A = c h + i Phi
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L52-L58 | B(t) is taken along the transported f with f' = -A f
EDGE: lem:transfer#dirac-hermitian | paper-a/transfer.tex#lem:transfer-proof@L56-L58 | <h f, beta f> = <f, h beta f> uses h Hermitian
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the derivative identity is stated without its computation (beta h + h beta = 2 M (x) I from the Clifford relations; [beta, Phi] = 0). 'Almost every t' belongs to the excluded extension transfer.tex L78-L80 and is not used.

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
EDGE: eq:beta-form | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | B' <= -2 m_* c ‖f‖^2 <= 0 on free intervals
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | B is unchanged at kicks
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | B is evaluated along the transported f
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] used for 'the entire trajectory' at L64-L65 and L67 but never stated.

NODE: lem:transfer#endpoint-relation
KIND: step
TITLE: B(T) = |lambda|^2 B(0)
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L61-L61
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L52-L61
CONTRACT_ID: paper-a.lem:transfer#endpoint-relation
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: v an eigenvector of U with eigenvalue lambda; f(0) = v
SOURCE_QUANTIFIERS: for every eigenpair
SOURCE_CONCLUSION: B(T) = |lambda|^2 B(0)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:transfer-matrix, lem:transfer#transport
ROUTES: -
ROUTE_FOR: -
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer-proof@L52-L53 | f(T) = U v = lambda v
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L52-L61 | f(0) = v and f(T) = U v
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#strict-decrease
KIND: step
TITLE: Strict decrease of the beta-form
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L61-L62
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L61-L62
CONTRACT_ID: paper-a.lem:transfer#strict-decrease
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: b > 0; m_* > 0; v != 0
SOURCE_QUANTIFIERS: for every eigenvector
SOURCE_CONCLUSION: B(T) < B(0)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: eq:beta-form, lem:transfer#kick-preserves-beta-form, lem:transfer#propagator-invertible, def:step-free-time, lem:transfer#transport
ROUTES: -
ROUTE_FOR: -
EDGE: eq:beta-form | paper-a/transfer.tex#lem:transfer-proof@L61-L62 | B' <= -2 m_* c ‖f‖^2
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L61-L62 | kicks do not change B
EDGE: lem:transfer#propagator-invertible | paper-a/transfer.tex#lem:transfer-proof@L62-L62 | a nonzero solution never vanishes
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L62-L62 | int c = b > 0
EDGE: lem:transfer#transport | paper-a/transfer.tex#lem:transfer-proof@L61-L62 | the total decrease of B along the transported f
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#no-unit-modulus
KIND: step
TITLE: No eigenvalue of modulus 1
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L63-L63
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L61-L63
CONTRACT_ID: paper-a.lem:transfer#no-unit-modulus
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H31 for the history
SOURCE_QUANTIFIERS: for every history satisfying H31 and every eigenvalue of its U
SOURCE_CONCLUSION: |lambda| != 1
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#endpoint-relation, lem:transfer#strict-decrease
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#endpoint-relation | paper-a/transfer.tex#lem:transfer-proof@L63-L63 | B(T) = B(0) if ‖lambda‖ = 1
EDGE: lem:transfer#strict-decrease | paper-a/transfer.tex#lem:transfer-proof@L63-L63 | B(T) < B(0)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#norm-bounds-beta-form
KIND: step
TITLE: |f|^2 >= |B|
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L65-L65
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L65-L68
CONTRACT_ID: paper-a.lem:transfer#norm-bounds-beta-form
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: beta Hermitian with beta^2 = I
SOURCE_QUANTIFIERS: for every vector f
SOURCE_CONCLUSION: |f|^2 >= B and |f|^2 >= -B
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] |f|^2 >= B (L65) and |f|^2 >= -B (L68) are used without argument (|<f, beta f>| <= |f|^2, beta being a Hermitian involution, hence unitary).

NODE: lem:transfer#stable-trajectory
KIND: step
TITLE: |lambda| < 1 forces B > 0 along the trajectory
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L64-L65
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L64-L65
CONTRACT_ID: paper-a.lem:transfer#stable-trajectory
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: |lambda| < 1
SOURCE_QUANTIFIERS: for every eigenvector with |lambda| < 1
SOURCE_CONCLUSION: B(0) > 0, B(T) > 0 and B(t) > 0 along the whole history
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#endpoint-relation, lem:transfer#strict-decrease, lem:transfer#beta-form-monotone, lem:transfer#propagator-invertible
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#endpoint-relation | paper-a/transfer.tex#lem:transfer-proof@L64-L64 | B(T) = ‖lambda‖^2 B(0)
EDGE: lem:transfer#strict-decrease | paper-a/transfer.tex#lem:transfer-proof@L64-L64 | (‖lambda‖^2 - 1) B(0) < 0 gives B(0) > 0
EDGE: lem:transfer#beta-form-monotone | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | 'the entire trajectory'
EDGE: lem:transfer#propagator-invertible | paper-a/transfer.tex#lem:transfer-proof@L64-L65 | lambda != 0 gives B(T) > 0
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the sign of B(0) from (|lambda|^2 - 1) B(0) = B(T) - B(0) < 0 and lambda != 0 for B(T) > 0 are not spelled out.

NODE: lem:transfer#stable-gronwall
KIND: step
TITLE: Small eigenvalues satisfy |lambda| <= e^{-b m_*} (3.2)
STATEMENT_SOURCE: paper-a/transfer.tex#eq:annulus@L29-L32
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L65-L66
CONTRACT_ID: paper-a.lem:transfer#stable-gronwall
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: |lambda| < 1
SOURCE_QUANTIFIERS: for every eigenvalue with |lambda| < 1
SOURCE_CONCLUSION: |lambda| <= e^{-b m_*}
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#stable-trajectory, lem:transfer#norm-bounds-beta-form, eq:beta-form, lem:transfer#endpoint-relation, def:step-free-time, lem:transfer#kick-preserves-beta-form
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#stable-trajectory | paper-a/transfer.tex#lem:transfer-proof@L65-L65 | B > 0 on the trajectory
EDGE: lem:transfer#norm-bounds-beta-form | paper-a/transfer.tex#lem:transfer-proof@L65-L65 | ‖f‖^2 >= B
EDGE: eq:beta-form | paper-a/transfer.tex#lem:transfer-proof@L65-L66 | B' <= -2 m_* c B
EDGE: lem:transfer#endpoint-relation | paper-a/transfer.tex#lem:transfer-proof@L65-L66 | B(T) = ‖lambda‖^2 B(0)
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L65-L66 | int c = b in the integrated bound
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L65-L66 | the integration over [0, T] passes the kicks, where B is unchanged
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Gronwall integration; the source names the method ('integration of'), so not a gap.

NODE: lem:transfer#unstable-trajectory
KIND: step
TITLE: |lambda| > 1 forces B < 0 along the trajectory
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L67-L68
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L67-L68
CONTRACT_ID: paper-a.lem:transfer#unstable-trajectory
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: |lambda| > 1
SOURCE_QUANTIFIERS: for every eigenvector with |lambda| > 1
SOURCE_CONCLUSION: B(t) < 0 along the whole history
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#endpoint-relation, lem:transfer#strict-decrease, lem:transfer#beta-form-monotone
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#endpoint-relation | paper-a/transfer.tex#lem:transfer-proof@L67-L67 | B(T) = ‖lambda‖^2 B(0)
EDGE: lem:transfer#strict-decrease | paper-a/transfer.tex#lem:transfer-proof@L67-L67 | (‖lambda‖^2 - 1) B(0) < 0 gives B(0) < 0
EDGE: lem:transfer#beta-form-monotone | paper-a/transfer.tex#lem:transfer-proof@L67-L67 | 'the entire trajectory'
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the source states the conclusion only; B(0) < 0 from the strict drop is left implicit.

NODE: lem:transfer#unstable-gronwall
KIND: step
TITLE: Large eigenvalues satisfy |lambda| >= e^{b m_*}
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L68-L70
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L67-L70
CONTRACT_ID: paper-a.lem:transfer#unstable-gronwall
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: |lambda| > 1
SOURCE_QUANTIFIERS: for every eigenvalue with |lambda| > 1
SOURCE_CONCLUSION: |lambda| >= e^{b m_*}
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#unstable-trajectory, lem:transfer#norm-bounds-beta-form, eq:beta-form, lem:transfer#endpoint-relation, def:step-free-time, lem:transfer#kick-preserves-beta-form
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#unstable-trajectory | paper-a/transfer.tex#lem:transfer-proof@L67-L68 | B < 0 on the trajectory
EDGE: lem:transfer#norm-bounds-beta-form | paper-a/transfer.tex#lem:transfer-proof@L68-L68 | ‖f‖^2 >= -B
EDGE: eq:beta-form | paper-a/transfer.tex#lem:transfer-proof@L68-L68 | B' <= 2 m_* c B
EDGE: lem:transfer#endpoint-relation | paper-a/transfer.tex#lem:transfer-proof@L69-L70 | dividing by B(0) < 0 reverses the inequality
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L69-L69 | int c = b in the integrated bound
EDGE: lem:transfer#kick-preserves-beta-form | paper-a/transfer.tex#lem:transfer-proof@L68-L69 | the integration passes the kicks, where B is unchanged
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#eigenvalue-count
KIND: step
TITLE: Exactly d eigenvalues in each region; partners
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L70-L71
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L70-L71
CONTRACT_ID: paper-a.lem:transfer#eigenvalue-count
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: D = 2d
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: exactly d eigenvalues (with algebraic multiplicity) satisfy |lambda| <= e^{-b m_*}, and the remaining d are their partners 1/conj(lambda)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#spectral-pairing, lem:transfer#no-unit-modulus, lem:transfer#stable-gronwall, lem:transfer#unstable-gronwall
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#spectral-pairing | paper-a/transfer.tex#lem:transfer-proof@L70-L71 | 'Spectral pairing gives'
EDGE: lem:transfer#no-unit-modulus | paper-a/transfer.tex#lem:transfer-proof@L70-L71 | no eigenvalue is fixed by the pairing
EDGE: lem:transfer#stable-gronwall | paper-a/transfer.tex#lem:transfer-proof@L70-L71 | the inner region is ‖lambda‖ <= e^{-b m_*}
EDGE: lem:transfer#unstable-gronwall | paper-a/transfer.tex#lem:transfer-proof@L70-L71 | the outer region; logically redundant given spectral pairing and the stable bound, kept because the source proves it directly
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The source names the method ('Spectral pairing gives'), so not a gap. Implicit textbook facts: U has exactly D eigenvalues with multiplicity, and every eigenvalue has an eigenvector, so the per-eigenvector bounds reach every root of the characteristic polynomial. The multiset count is a substantive Lean lemma.

NODE: lem:transfer#det-nonvanishing
KIND: step
TITLE: det(I + U) != 0
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L73
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L73
CONTRACT_ID: paper-a.lem:transfer#det-nonvanishing
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H31 for the history
SOURCE_QUANTIFIERS: for every history satisfying H31 (lem:transfer#homotopy-nonvanishing applies it to each deformed history H_sigma)
SOURCE_CONCLUSION: det(I + U) != 0 for the transfer matrix U of that history
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#no-unit-modulus
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#no-unit-modulus | paper-a/transfer.tex#lem:transfer-proof@L73-L73 | -1 is not an eigenvalue
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#homotopy-admissible
KIND: step
TITLE: Deformation stays admissible
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L75
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L75
CONTRACT_ID: paper-a.lem:transfer#homotopy-admissible
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the deformation H_sigma: kicks Theta -> (1 - sigma) Theta, v_j -> (1 - sigma) v_j, M_sigma = (1 - sigma) M + sigma m_* I, free durations unchanged
SOURCE_QUANTIFIERS: for every sigma in [0,1]
SOURCE_CONCLUSION: H_sigma satisfies H31 with the same b and m_*; H_0 is the given history
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:history-step, def:step-free-time
ROUTES: -
ROUTE_FOR: -
EDGE: def:history-step | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | the deformed objects are histories
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | free durations, hence b, are unchanged
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the path is described only in words ('continuously turn off'); its parameterization and admissibility (M_sigma >= m_* I) are not checked in the text. The source writes s for the deformation parameter; it is sigma here.

NODE: lem:transfer#homotopy-continuity
KIND: step
TITLE: F is continuous along the deformation
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L75-L76
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L77
CONTRACT_ID: paper-a.lem:transfer#homotopy-continuity
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the deformation H_sigma of homotopy-admissible
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: sigma -> F_sigma is continuous on [0,1]
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#homotopy-admissible, def:centered-trace
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#homotopy-admissible | paper-a/transfer.tex#lem:transfer-proof@L73-L75 | the deformation
EDGE: def:centered-trace | paper-a/transfer.tex#lem:transfer-proof@L75-L76 | F_sigma
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] continuity is used but not argued; for step histories it is continuity of finitely many exponentials, a product, a determinant and exp of a trace. For the source's time-dependent histories it would need continuous dependence of the propagator on parameters, a standard but unnamed theorem.

NODE: lem:transfer#homotopy-nonvanishing
KIND: step
TITLE: F never vanishes along the deformation
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L75-L76
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L76
CONTRACT_ID: paper-a.lem:transfer#homotopy-nonvanishing
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the deformation H_sigma of homotopy-admissible
SOURCE_QUANTIFIERS: for every sigma in [0,1]
SOURCE_CONCLUSION: F_sigma is real and nonzero
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#homotopy-admissible, lem:transfer#centered-trace-real, lem:transfer#det-nonvanishing
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#homotopy-admissible | paper-a/transfer.tex#lem:transfer-proof@L75-L75 | each deformed history H_sigma is admissible
EDGE: lem:transfer#centered-trace-real | paper-a/transfer.tex#lem:transfer-proof@L75-L75 | applied to H_sigma: the real centered trace
EDGE: lem:transfer#det-nonvanishing | paper-a/transfer.tex#lem:transfer-proof@L75-L76 | applied to H_sigma: 'In particular det(I + U) != 0'
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:transfer#homotopy-endpoint
KIND: step
TITLE: Endpoint value det(I + e^{-b m_* beta}) > 0
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L76-L77
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L76-L77
CONTRACT_ID: paper-a.lem:transfer#homotopy-endpoint
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the sigma = 1 history of lem:transfer#homotopy-admissible: free steps with v_j = 0, M = m_* I and the original free times (total b), kicks turned off (Theta = 0); beta Hermitian with beta^2 = I (model.tex L27-28)
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: F_1 = det(I + e^{-b m_* beta}) > 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:centered-trace, def:transfer-matrix, lem:transfer#homotopy-admissible, def:step-free-time, lem:transfer#trace-h-zero
ROUTES: -
ROUTE_FOR: -
EDGE: def:centered-trace | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | F at the endpoint
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | U_1 = exp(-b m_* beta)
EDGE: lem:transfer#homotopy-admissible | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | 'At its endpoint': the sigma = 1 member of the deformation
EDGE: def:step-free-time | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | commuting free steps of total free time b multiply to exp(-b m_* beta)
EDGE: lem:transfer#trace-h-zero | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | Tr h = 0 for h = m_* beta, so the centering factor is 1
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the endpoint value and its positivity (e^{-b m_* beta} positive definite) are asserted.

NODE: lem:transfer#positivity
KIND: step
TITLE: F > 0
STATEMENT_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L77-L77
PROOF_SOURCE: paper-a/transfer.tex#lem:transfer-proof@L73-L77
CONTRACT_ID: paper-a.lem:transfer#positivity
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H31 for the history
SOURCE_QUANTIFIERS: for every history satisfying H31
SOURCE_CONCLUSION: F > 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer#homotopy-continuity, lem:transfer#homotopy-nonvanishing, lem:transfer#homotopy-endpoint
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer#homotopy-continuity | paper-a/transfer.tex#lem:transfer-proof@L75-L77 | connectedness of [0,1]
EDGE: lem:transfer#homotopy-nonvanishing | paper-a/transfer.tex#lem:transfer-proof@L75-L77 | F_sigma real and nonzero
EDGE: lem:transfer#homotopy-endpoint | paper-a/transfer.tex#lem:transfer-proof@L76-L77 | the sign at sigma = 1
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Intermediate value theorem on [0,1], implicit in 'which proves its sign'; the structure is given, not a gap.

NODE: lem:fourier#twist-is-kick
KIND: step
TITLE: The charge twist is a scalar kick with centering e^{-i d phi}
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier@L95-L97
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L107-L108
CONTRACT_ID: paper-a.lem:fourier#twist-is-kick
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Q = dGamma(I) - d (dGamma and the Fock space are in model.tex L8-12, L36, outside the corpus); the history of Lemma 3.1; D = 2d
SOURCE_QUANTIFIERS: for every real phi
SOURCE_CONCLUSION: appending e^{i phi Q} appends the spin-scalar kick with Hermitian generator Theta = phi I, whose centering is e^{-(i/2) Tr(phi I_D)} = e^{-i d phi}; the twisted transfer matrix is e^{i phi} U; hence F(phi) = e^{-i d phi} w det(I + e^{i phi} U), w the centering factor of the history, and F(0) = F
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:step-generator, def:centered-trace, def:transfer-matrix, def:history-step
ROUTES: -
ROUTE_FOR: -
EDGE: def:step-generator | paper-a/transfer.tex#lem:fourier-proof@L107-L108 | centering e^{-(i/2) Tr(phi I)} = e^{-i d phi}
EDGE: def:centered-trace | paper-a/transfer.tex#lem:fourier@L97-L97 | 'its centered trace'
EDGE: def:transfer-matrix | paper-a/transfer.tex#lem:fourier-proof@L107-L108 | the twisted transfer matrix is e^{i phi} U
EDGE: def:history-step | paper-a/transfer.tex#lem:fourier@L95-L96 | the twist is appended to the history as a further kick step
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the source does not state that e^{i phi Q} is the centered lift of the one-particle kick e^{i phi} (its -d being the kick's centering phase, counted once); only 'including the phase e^{-i d phi}' (L107-108). In the frozen statement F(phi) is defined as the centered trace of hist ++ [Step.kick (phi * 1)], so this identification is not a Lean obligation.

NODE: lem:fourier#apply-transfer
KIND: application
TITLE: Lemma 3.1 applied to the history
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier@L95-L95
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L106-L115
CONTRACT_ID: paper-a.lem:fourier#apply-transfer
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the history of Lemma 3.2 is a history of Lemma 3.1 (transfer.tex L95)
SOURCE_QUANTIFIERS: none (one application, to the untwisted history)
SOURCE_CONCLUSION: U has exactly d eigenvalues lambda_1..lambda_d, with algebraic multiplicity, of modulus <= e^{-b m_*}; they are nonzero, and the remaining d eigenvalues are 1/conj(lambda_j); F(0) = F > 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer, lem:fourier#twist-is-kick
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer | paper-a/transfer.tex#lem:fourier-proof@L106-L115 | the small-disk eigenvalues (L106-L107) and F(0) > 0 (L115)
EDGE: lem:fourier#twist-is-kick | paper-a/transfer.tex#lem:fourier-proof@L114-L115 | F(0) is the centered trace of the untwisted history
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Lemma 3.1 is applied once, to the untwisted history, whose premises are those of Lemma 3.2; the source never applies it at phi != 0. lambda_j != 0 follows from the partner relation.

NODE: lem:fourier#paired-factor
KIND: step
TITLE: Paired determinant factor
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L112-L114
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L112-L114
CONTRACT_ID: paper-a.lem:fourier#paired-factor
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: lambda != 0
SOURCE_QUANTIFIERS: for every phi
SOURCE_CONCLUSION: (1 + e^{i phi} lambda)(1 + e^{i phi}/conj(lambda)) = e^{i phi} conj(lambda)^{-1} |1 + e^{i phi} lambda|^2
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:fourier#factorization
KIND: step
TITLE: F(phi) = C prod_j |1 + e^{i phi} lambda_j|^2
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L106-L111
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L106-L116
CONTRACT_ID: paper-a.lem:fourier#factorization
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H32; lambda_1..lambda_d the small-disk eigenvalues
SOURCE_QUANTIFIERS: for every phi
SOURCE_CONCLUSION: F(phi) = C prod_{j=1}^d |1 + e^{i phi} lambda_j|^2 with C independent of phi
CONSTANT_SCOPE: C = w prod_j conj(lambda_j)^{-1} depends on the history only, not on phi
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#twist-is-kick, lem:fourier#apply-transfer, lem:fourier#paired-factor
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#twist-is-kick | paper-a/transfer.tex#lem:fourier-proof@L107-L108 | the phase e^{-i d phi}
EDGE: lem:fourier#apply-transfer | paper-a/transfer.tex#lem:fourier-proof@L106-L108 | the eigenvalues pair as lambda_j, 1/conj(lambda_j)
EDGE: lem:fourier#paired-factor | paper-a/transfer.tex#lem:fourier-proof@L112-L114 | each pair of determinant factors
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: det(I + zU) = prod over eigenvalues with algebraic multiplicity is named at L115-L116; the d factors e^{i phi} of the paired factors cancel the phase e^{-i d phi} (L108, L113-L114), so C is phi-independent. Not a gap.

NODE: lem:fourier#constant-positive
KIND: step
TITLE: C > 0
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L114-L115
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L114-L115
CONTRACT_ID: paper-a.lem:fourier#constant-positive
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H32
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: C > 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#factorization, lem:fourier#apply-transfer
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#factorization | paper-a/transfer.tex#lem:fourier-proof@L114-L115 | C = F(0) / prod_j ‖1 + lambda_j‖^2
EDGE: lem:fourier#apply-transfer | paper-a/transfer.tex#lem:fourier-proof@L115-L115 | F(0) > 0
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] needs prod_j |1 + lambda_j|^2 != 0, i.e. lambda_j != -1, true since |lambda_j| < 1 but not stated.

NODE: lem:fourier#coefficient-identification
KIND: step
TITLE: F_q as a correlation of elementary symmetric functions
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L117-L120
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L117-L125
CONTRACT_ID: paper-a.lem:fourier#coefficient-identification
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H32; e_j the elementary symmetric polynomials in lambda_1..lambda_d
SOURCE_QUANTIFIERS: for every integer q with 0 <= q <= d
SOURCE_CONCLUSION: F_q = C sum_j e_{j+q} conj(e_j); in particular F_0 = C sum_j |e_j|^2
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#factorization
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#factorization | paper-a/transfer.tex#lem:fourier-proof@L117-L120 | F(phi) = C ‖sum_j e_j e^{i j phi}‖^2
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the coefficient formula is not derived; F_0 = C sum |e_j|^2 is stated and the general sum appears inside the bound at L125, while expanding |P(e^{i phi})|^2 and integrating over [0, 2 pi] (orthogonality of e^{i n phi}) is left implicit.

NODE: lem:fourier#vacuum-lower-bound
KIND: step
TITLE: F_0 >= C
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L120-L120
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L120-L120
CONTRACT_ID: paper-a.lem:fourier#vacuum-lower-bound
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H32
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: F_0 >= C
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#coefficient-identification, lem:fourier#constant-positive
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#coefficient-identification | paper-a/transfer.tex#lem:fourier-proof@L120-L120 | F_0 = C sum ‖e_j‖^2 with e_0 = 1
EDGE: lem:fourier#constant-positive | paper-a/transfer.tex#lem:fourier-proof@L120-L120 | C > 0
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: lem:fourier#vacuum-real
KIND: step
TITLE: F_0 is real
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L120-L120
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L120-L120
CONTRACT_ID: paper-a.lem:fourier#vacuum-real
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H32
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: F_0 is real (and positive)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#coefficient-identification, lem:fourier#constant-positive
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#coefficient-identification | paper-a/transfer.tex#lem:fourier-proof@L120-L120 | F_0 = C sum ‖e_j‖^2
EDGE: lem:fourier#constant-positive | paper-a/transfer.tex#lem:fourier-proof@L120-L120 | C real
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Implicit in the printed inequality; the frozen statement states Im F_0 = 0 (R3).

NODE: lem:fourier#elementary-bound
KIND: step
TITLE: |e_j| <= binom(d, j) s^j
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L121-L121
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L117-L121
CONTRACT_ID: paper-a.lem:fourier#elementary-bound
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: H32; lambda_1..lambda_d the small-disk eigenvalues of L106
SOURCE_QUANTIFIERS: for every j
SOURCE_CONCLUSION: |e_j| <= binom(d, j) s^j
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#apply-transfer
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#apply-transfer | paper-a/transfer.tex#lem:fourier-proof@L117-L118 | ‖lambda_k‖ <= s
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] |e_j| <= binom(d, j) s^j is stated without argument (e_j is a sum of binom(d, j) products of j eigenvalues of modulus <= s).

NODE: lem:fourier#vandermonde
KIND: step
TITLE: Bound for 0 <= q <= d via Vandermonde
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L123-L128
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L123-L128
CONTRACT_ID: paper-a.lem:fourier#vandermonde
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: 0 <= q <= d; 0 < s < 1 (from b > 0 and m_* > 0 in the hypotheses of lem:fourier)
SOURCE_QUANTIFIERS: for every such q
SOURCE_CONCLUSION: |F_q| <= C s^q sum_j binom(d, j+q) binom(d, j) s^{2j} <= C s^q binom(2d, d+q) <= s^q binom(2d, d+q) F_0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#coefficient-identification, lem:fourier#elementary-bound, lem:fourier#vacuum-lower-bound, lem:fourier#constant-positive
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#coefficient-identification | paper-a/transfer.tex#lem:fourier-proof@L125-L125 | the sum for F_q
EDGE: lem:fourier#elementary-bound | paper-a/transfer.tex#lem:fourier-proof@L125-L125 | termwise bounds
EDGE: lem:fourier#vacuum-lower-bound | paper-a/transfer.tex#lem:fourier-proof@L126-L126 | C <= F_0
EDGE: lem:fourier#constant-positive | paper-a/transfer.tex#lem:fourier-proof@L125-L126 | C > 0
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Vandermonde's convolution is named in the source; s <= 1 drops s^{2j}. Not a gap.

NODE: lem:fourier#negative-q
KIND: step
TITLE: Negative q by conjugation
STATEMENT_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L129-L129
PROOF_SOURCE: paper-a/transfer.tex#lem:fourier-proof@L129-L129
CONTRACT_ID: paper-a.lem:fourier#negative-q
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: -d <= q < 0
SOURCE_QUANTIFIERS: for every such q
SOURCE_CONCLUSION: the bound for q < 0, from F_{-q} = conj(F_q)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier#vandermonde, lem:fourier#factorization, lem:fourier#constant-positive
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier#vandermonde | paper-a/transfer.tex#lem:fourier-proof@L129-L129 | the bound for ‖q‖
EDGE: lem:fourier#factorization | paper-a/transfer.tex#lem:fourier-proof@L129-L129 | F(phi) = C prod ‖1 + e^{i phi} lambda_j‖^2 is real, so F_{-q} = conj(F_q)
EDGE: lem:fourier#constant-positive | paper-a/transfer.tex#lem:fourier-proof@L129-L129 | C is real
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: orchestrator-f3486c47
REVIEWER: topology-reviewer-1
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The source names the method ('by complex conjugation'); the reality of F(phi) is established by the factorization at L110. Not a gap.

NODE: thm:main#twisted-integrand
KIND: claim
TITLE: Twisted Wilson integrand: positivity and canonical Fourier bound (proof step of Theorem 4.1)
STATEMENT_SOURCE: paper-a/comparison.tex#thm:main-proof@L54-L91
PROOF_SOURCE: paper-a/comparison.tex#thm:main-proof@L70-L89
CONTRACT_ID: paper-a.thm:main.twisted-integrand
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: X = (Z/nZ)^3 with n >= 3 and N = n^3 sites (model.tex L4-L5); alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28), commuting with spatial matrices (model.tex L39-40); a > 0 and r >= 0 (comparison.tex L6-L7); m > 0 (L13, L70); b > 0 (L12); a link path omega on [0, b] with U(1) link variables (model.tex L13; comparison.tex L43-L49), here a step history of pairs (tau_k, U_k) with tau_k >= 0, |U_k(x, j)| = 1 and sum_k tau_k = b (R5); V_omega the ordered one-particle propagator generated by -h_W(omega_t), h_W of (2.3) (L48-L49); a gauge function u_x = e^{i theta_x} with theta_x = vartheta_x + phi and vartheta_root = 0 at a fixed root site (model.tex L64; comparison.tex L82-L83; R6 drops the root-site condition and takes vartheta in R^X); F(phi) the fermionic integrand e^{-2i sum_x theta_x} det(I + u V_omega) of (4.5) (L61), taken under R8 to be the centered trace of the history followed by the kick u; F_Q = (2 pi)^{-1} int_0^{2 pi} e^{-i Q phi} F(phi) d phi (transfer.tex L98); Q = Q_nu for an admissible integer source nu (L7, L86-L88), that is, by (2.9), an integer with |Q| <= 2N
SOURCE_QUANTIFIERS: for all n >= 3, Clifford sets, a > 0, m > 0, r >= 0, b > 0, step histories of total time b, relative twists vartheta with vartheta_root = 0 (R6: every vartheta in R^X) and integers Q with |Q| <= 2N; the positivity conjunct for every real phi
SOURCE_CONCLUSION: F(phi) > 0 for every phi (L70-L72); F_0 is real and |F_Q| <= binom(4N, 2N + |Q|) e^{-b m |Q|} F_0 (L86-L89: Lemma 3.2 with D = 4N, d = 2N, m_* = m)
CONSTANT_SCOPE: the factor binom(4N, 2N + |Q|) e^{-b m |Q|} depends only on n, Q, b and m
FROZEN_FILE: Frozen/PaperA/WilsonTwistedTraceBound.lean
FROZEN_DECL: QEDCore.PaperA.wilson_twisted_trace_pos_and_fourier_bound
FROZEN_ANCHOR_ID: main_twisted_integrand_v1
FROZEN_ABI_SHA256: b83a0c8ad43792560d5ef61bc2495ea76a58285a6bb4dfda4de724acbded421c
DEPS: thm:main#apply-transfer, thm:main#apply-fourier, def:centered-trace, def:history-step, def:step-free-time, def:dirac-operator, def:wilson-hopping, def:wilson-mass
ROUTES: -
ROUTE_FOR: -
EDGE: thm:main#apply-transfer | paper-a/comparison.tex#thm:main-proof@L70-L72 | 'For m > 0 every integrand in (4.5) is positive': the positivity conjunct
EDGE: thm:main#apply-fourier | paper-a/comparison.tex#thm:main-proof@L86-L89 | the Q_nu Fourier coefficient bounded by Lemma 3.2: F_0 real and the bound
EDGE: def:centered-trace | paper-a/comparison.tex#thm:main-proof@L86-L88 | the integrand is 'the centered trace for e^{i vartheta} V_omega' (R8)
EDGE: def:history-step | paper-a/comparison.tex#eq:twisted@L59-L61 | the integrand is built from the path propagator V_omega and the gauge kick u: a step history ending in a kick (R5)
EDGE: def:step-free-time | paper-a/comparison.tex#eq:twisted@L59-L60 | the path runs over [0, b]: total free time b (R5)
EDGE: def:dirac-operator | paper-a/comparison.tex#thm:main-proof@L48-L49 | V_omega is generated by -h_W(omega_t), h_W = sum_j alpha_j v_j + beta M (model.tex L34)
EDGE: def:wilson-hopping | paper-a/comparison.tex#thm:main-proof@L48-L49 | the spatial coefficients v_j(omega_t) of h_W(omega_t), (2.3)
EDGE: def:wilson-mass | paper-a/comparison.tex#thm:main-proof@L71-L72 | 'the time-dependent Wilson mass M(omega_t)', (2.3)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen main_twisted_integrand_v1 (D16, deviation 9): a proof step of thm:main, not Theorem 4.1, which has no node (audit A, S0). Piecewise-constant link histories without the bridge endpoint conditions omega_0 = U, omega_b = U^u (R5); theta = vartheta + phi with vartheta in R^X unrestricted, no root site and no reduction modulo 2 pi (R6); F(phi) is defined as the centered trace of the Wilson free steps followed by Step.kick (diagonal (vartheta + phi)) (R8), so the finite-CAR identity, e^{i sum theta q} = e^{-2i sum theta} Gamma(u) and the charge-sector reading of F_Q are outside the closure. Encoding: F(phi) > 0 as 0 < Re F(phi) and Im F(phi) = 0; F_0 real as Im F_0 = 0, with the bound against Re F_0 (R6, as R3); the positivity conjunct sits under the binders Q and |Q| <= 2N, harmless since Q = 0 qualifies. The positive scalar factors K_b and e^{-int H_B} of (4.5) (L70-L71) are not part of the claim. The statement is read from L54-L91 together with the definition of V_omega at L48-L49. 'the nonnegative zeroth coefficient' (L91) is implied: the frozen bound, whose constant is positive for |Q| <= 2N, forces Re F_0 >= 0.

NODE: rem:nonneg-mass
KIND: claim
TITLE: Nonnegative mass: the centered trace is nonnegative (remark after Lemma 3.1)
STATEMENT_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L91
PROOF_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L91
CONTRACT_ID: paper-a.rem:nonneg-mass
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the hypotheses of Lemma 3.1 with the mass bound replaced by a nonnegative mass coefficient M >= 0 (transfer.tex L89, m_* = 0): alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (model.tex L27-28), commuting with spatial matrices (model.tex L39-40); D = 2d; free steps with c >= 0, Hermitian spatial v_j and Hermitian M >= 0; kicks with Hermitian spin-scalar generator; total free time b > 0 (transfer.tex L11-L26)
SOURCE_QUANTIFIERS: for every such history
SOURCE_CONCLUSION: the centered trace F of the history is real and nonnegative
CONSTANT_SCOPE: none
FROZEN_FILE: Frozen/PaperA/CenteredTraceNonneg.lean
FROZEN_DECL: QEDCore.PaperA.centeredTrace_nonneg_of_posSemidef_mass
FROZEN_ANCHOR_ID: rem_nonneg_mass_v1
FROZEN_ABI_SHA256: 8da711bd44595add34e9f40de2ef6a89d94d7ca311ff955d94f11d4fe3e42316
DEPS: rem:nonneg-mass#apply-transfer, rem:nonneg-mass#continuity, def:centered-trace, def:history-step, def:step-free-time, def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: rem:nonneg-mass#apply-transfer | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | 'replace M by M + epsilon I': F_epsilon > 0 for every epsilon > 0
EDGE: rem:nonneg-mass#continuity | paper-a/transfer.tex#sec:transfer-remark@L90-L91 | 'pass to the finite-dimensional limit': F = lim F_epsilon, a limit of positive reals, is real and >= 0
EDGE: def:centered-trace | paper-a/transfer.tex#sec:transfer-remark@L91-L91 | 'The centered trace is then nonnegative'
EDGE: def:history-step | paper-a/transfer.tex#sec:transfer-remark@L89-L89 | the remark concerns the histories of Lemma 3.1 with a nonnegative mass coefficient
EDGE: def:step-free-time | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | the history keeps Lemma 3.1's total free time b > 0 (R7)
EDGE: def:dirac-operator | paper-a/transfer.tex#sec:transfer-remark@L89-L89 | M is the mass coefficient of h = sum_j alpha_j v_j + beta M
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen rem_nonneg_mass_v1 (D16, R7, deviation 10): Lemma 3.1's frozen setting (R1(a), R2, R4) with M positive semidefinite on every free step; b > 0 is retained from L15 although the conclusion holds without it (audit A, section 4). Encoding: Im F = 0 and 0 <= Re F. 'May vanish' (L91) is a comment, not a claim. Used for m = 0 in the proof of Theorem 4.1 (comparison.tex L98-L99); that Wilson-level application, which also needs (2.5) at m = 0, is outside the frozen surface and has no node. The frozen statement has no d binder: 4|iota| is even, and Lemma 3.1 is applied with d = 2|iota|.

NODE: def:lattice-shift
KIND: definition
TITLE: Link shift T_j(U) of (2.3)
STATEMENT_SOURCE: paper-a/model.tex#eq:wilson@L29-L31
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.lattice-shift
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: on l^2(X), X = (Z/nZ)^3, (T_j(U) f)(x) = conj(U_{xj}) f(x + e_j), U_{xj} the link variable on the positively oriented link from x to x + e_j (the link convention for negative fermionic electric charge)
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/LatticeShift.lean
FROZEN_DECL: QEDCore.PaperA.latticeShift
FROZEN_ANCHOR_ID: def_lattice_shift_v1
FROZEN_ABI_SHA256: 3400f002d5aa6dba1b2e5843c41b6959b754287669291486b058c2922bb7b960
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Also model.tex L4-L6 (the torus X and the link orientation). The frozen definition takes any complex link array U : X -> Fin 3 -> C, with e_j = Pi.single j 1 and j = 1, 2, 3 indexed by Fin 3; |U_{xj}| = 1 is a consumer premise (R5). The manifest cites model.tex:27-32.

NODE: def:wilson-hopping
KIND: definition
TITLE: Wilson hopping coefficient v_j(U) of (2.3)
STATEMENT_SOURCE: paper-a/model.tex#eq:wilson@L32-L32
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.wilson-hopping
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: v_j(U) = (T_j(U) - T_j(U)^*)/(2ia)
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/WilsonHopping.lean
FROZEN_DECL: QEDCore.PaperA.wilsonHopping
FROZEN_ANCHOR_ID: def_wilson_hopping_v1
FROZEN_ABI_SHA256: 7349b3eb37adb3ad34023013a75d2b208b60a8e4b5112efce66e168a558a7435
DEPS: def:lattice-shift
ROUTES: -
ROUTE_FOR: -
EDGE: def:lattice-shift | paper-a/model.tex#eq:wilson@L32-L32 | v_j(U) is built from T_j(U) and its adjoint
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The source fixes a > 0 (model.tex L4); the frozen definition is total in a (Lean's inverse gives v_j = 0 at a = 0), so consumers carry a > 0. The manifest cites model.tex:27-32.

NODE: def:wilson-mass
KIND: definition
TITLE: Wilson mass M(U) of (2.3)
STATEMENT_SOURCE: paper-a/model.tex#eq:wilson@L33-L33
PROOF_SOURCE: -
CONTRACT_ID: paper-a.def.wilson-mass
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: none
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: M(U) = m + (r/2a) sum_{j=1}^3 (2 - T_j(U) - T_j(U)^*), m and 2 read as multiples of the identity
CONSTANT_SCOPE: none
FROZEN_FILE: Core/PaperA/Defs/WilsonMass.lean
FROZEN_DECL: QEDCore.PaperA.wilsonMass
FROZEN_ANCHOR_ID: def_wilson_mass_v1
FROZEN_ABI_SHA256: 4e71de782982987004ca088fe93e4f7509d30b3c8fc56d402f9d89405c188787
DEPS: def:lattice-shift
ROUTES: -
ROUTE_FOR: -
EDGE: def:lattice-shift | paper-a/model.tex#eq:wilson@L33-L33 | M(U) is built from T_j(U) and its adjoint
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The bare parameters m >= 0 and r >= 0 (model.tex L39) and a > 0 (L4) are consumer premises; the frozen definition takes any real m, r, a. The manifest cites model.tex:27-35.

NODE: eq:mass-bound#shift-unitary
KIND: step
TITLE: T_j(U) is unitary for U(1) link variables
STATEMENT_SOURCE: paper-a/model.tex#sec:model@L40-L40
PROOF_SOURCE: paper-a/model.tex#sec:model@L40-L40
CONTRACT_ID: paper-a.eq:mass-bound#shift-unitary
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: |U_{xj}| = 1 for every link (U_e = e^{i varphi_e}, model.tex L13); X = (Z/nZ)^3
SOURCE_QUANTIFIERS: for every link configuration U in U(1)^E and every j
SOURCE_CONCLUSION: T_j(U)^* T_j(U) = T_j(U) T_j(U)^* = I
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:lattice-shift
ROUTES: -
ROUTE_FOR: -
EDGE: def:lattice-shift | paper-a/model.tex#sec:model@L40-L40 | 'Since T_j(U) is unitary': the shift of (2.3)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] asserted without argument; T_j(U) is a unit-modulus diagonal matrix times the permutation x -> x + e_j of X. Used by both assertions of (2.5).

NODE: eq:mass-bound
KIND: display
TITLE: Wilson mass and norm bound (2.5)
STATEMENT_SOURCE: paper-a/model.tex#eq:mass-bound@L39-L45
PROOF_SOURCE: paper-a/model.tex#sec:model@L40-L46
CONTRACT_ID: paper-a.eq:mass-bound
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: X = (Z/nZ)^3 with n >= 3 (model.tex L4); alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I and pairwise anticommuting (L27-28), commuting with spatial matrices (L39-40); a > 0 (L4); m >= 0 and r >= 0 (L39); U in U(1)^E, |U_{xj}| = 1 for every link (L13)
SOURCE_QUANTIFIERS: for all n >= 3, Clifford sets, a > 0, m >= 0, r >= 0 and every U in U(1)^E
SOURCE_CONCLUSION: M(U) >= m I and ||h_W(U)|| <= h_* := m + (3 + 6r)/a
CONSTANT_SCOPE: h_* = m + (3 + 6r)/a depends only on m, r and a
FROZEN_FILE: Frozen/PaperA/WilsonMassBound.lean
FROZEN_DECL: QEDCore.PaperA.wilson_mass_bound
FROZEN_ANCHOR_ID: eq_mass_bound_v1
FROZEN_ABI_SHA256: 218a74588ce44905592eaf7ad7850a4e9fc3618f39a40435f3af38a6e1343880
DEPS: eq:mass-bound#mass-lower-bound, eq:mass-bound#norm-bound, thm:main#wilson-hopping-hermitian, lem:transfer#dirac-hermitian, def:wilson-mass, def:wilson-hopping, def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: eq:mass-bound#mass-lower-bound | paper-a/model.tex#eq:mass-bound@L42-L42 | the first assertion M(U) >= m I
EDGE: eq:mass-bound#norm-bound | paper-a/model.tex#eq:mass-bound@L43-L43 | the second assertion ‖h_W(U)‖ <= h_*
EDGE: thm:main#wilson-hopping-hermitian | paper-a/model.tex#eq:mass-bound@L43-L43 | v_j(U) Hermitian: the frozen two-sided form h_* 1 -/+ h_W(U) >= 0 is the norm bound only for Hermitian h_W(U)
EDGE: lem:transfer#dirac-hermitian | paper-a/model.tex#eq:mass-bound@L43-L43 | h_W(U) = sum_j alpha_j v_j(U) + beta M(U) is Hermitian for Hermitian v_j(U) and M(U), as the frozen two-sided form needs
EDGE: def:wilson-mass | paper-a/model.tex#eq:mass-bound@L42-L42 | M(U) of (2.3)
EDGE: def:wilson-hopping | paper-a/model.tex#eq:mass-bound@L43-L43 | the spatial coefficients v_j(U) of h_W(U)
EDGE: def:dirac-operator | paper-a/model.tex#eq:mass-bound@L43-L43 | h_W(U) = sum_j alpha_j v_j(U) + beta M(U)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen eq_mass_bound_v1 (D16, T5): for unit link variables U : X -> Fin 3 -> C, M(U) - m 1 positive semidefinite, and the norm bound encoded as h_* 1 - h_W(U) and h_* 1 + h_W(U) positive semidefinite, h_W(U) = diracOperator alpha beta (wilsonHopping n a U) (wilsonMass n a m r U). A root: thm:main#wilson-history consumes only its first assertion, through eq:mass-bound#mass-lower-bound (comparison.tex L71-L72); its second assertion serves the Dyson bound (comparison.tex L33-L36, excluded) and Lemma 2.1 (outside the corpus). The two-sided encoding equals the source's norm bound only for Hermitian h_W(U) (deviation 11); that Hermiticity, which the source never states, reaches this anchor through thm:main#wilson-hopping-hermitian (v_j(U), SOURCE_GAP [minor]), eq:mass-bound#mass-lower-bound (M(U)) and lem:transfer#dirac-hermitian (h, SOURCE_GAP [minor]).

NODE: eq:mass-bound#mass-lower-bound
KIND: step
TITLE: Wilson mass bound M(U) >= m I (first assertion of (2.5))
STATEMENT_SOURCE: paper-a/model.tex#eq:mass-bound@L40-L42
PROOF_SOURCE: paper-a/model.tex#sec:model@L46-L46
CONTRACT_ID: paper-a.eq:mass-bound#mass-lower-bound
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: a > 0 (model.tex L4); m >= 0 and r >= 0 (L39; only r >= 0 is used); U in U(1)^E, |U_{xj}| = 1 for every link (L13)
SOURCE_QUANTIFIERS: for every link configuration U in U(1)^E
SOURCE_CONCLUSION: M(U) >= m I (in particular M(U) is Hermitian)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:wilson-mass, eq:mass-bound#shift-unitary
ROUTES: -
ROUTE_FOR: -
EDGE: def:wilson-mass | paper-a/model.tex#sec:model@L46-L46 | 2 - T - T^* is the summand of M(U), with coefficient r/(2a) >= 0
EDGE: eq:mass-bound#shift-unitary | paper-a/model.tex#sec:model@L46-L46 | 2 - T - T^* = (I - T)^*(I - T) needs T^* T = I
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The source names the method ('follows from 2 - T - T^* = (I - T)^*(I - T)'), so not a gap; r/(2a) >= 0 from r >= 0 and a > 0 is implicit. The second assertion of (2.5) is eq:mass-bound#norm-bound.

NODE: eq:mass-bound#norm-bound
KIND: step
TITLE: Wilson operator norm bound ||h_W(U)|| <= h_* (second assertion of (2.5))
STATEMENT_SOURCE: paper-a/model.tex#eq:mass-bound@L43-L43
PROOF_SOURCE: paper-a/model.tex#sec:model@L40-L43
CONTRACT_ID: paper-a.eq:mass-bound#norm-bound
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: alpha_1, alpha_2, alpha_3, beta Hermitian 4x4 matrices squaring to I (model.tex L27-28), commuting with spatial matrices (L39-40); a > 0 (L4); m >= 0 and r >= 0 (L39); U in U(1)^E, |U_{xj}| = 1 for every link (L13)
SOURCE_QUANTIFIERS: for every link configuration U in U(1)^E
SOURCE_CONCLUSION: ||h_W(U)|| <= h_* := m + (3 + 6r)/a
CONSTANT_SCOPE: h_* depends only on m, r and a
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: eq:mass-bound#shift-unitary, def:dirac-operator, def:wilson-hopping, def:wilson-mass
ROUTES: -
ROUTE_FOR: -
EDGE: eq:mass-bound#shift-unitary | paper-a/model.tex#sec:model@L40-L43 | 'Since T_j(U) is unitary': ‖T_j(U)‖ = 1 bounds every term
EDGE: def:dirac-operator | paper-a/model.tex#eq:mass-bound@L43-L43 | h_W(U) = sum_j alpha_j v_j(U) + beta M(U), estimated term by term
EDGE: def:wilson-hopping | paper-a/model.tex#eq:mass-bound@L43-L43 | ‖v_j(U)‖ <= 1/a
EDGE: def:wilson-mass | paper-a/model.tex#eq:mass-bound@L43-L43 | ‖M(U)‖ <= m + 6r/a
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] asserted from 'Since T_j(U) is unitary' alone; the triangle inequality with ||alpha_j|| = ||beta|| = 1 (Hermitian involutions), ||v_j(U)|| <= 1/a and ||M(U)|| <= m + (r/2a) 3 4 = m + 6r/a (using m >= 0, r >= 0) is not written. The frozen two-sided form h_* 1 -/+ h_W(U) positive semidefinite is equivalent for Hermitian h_W(U); that Hermiticity, which the source does not state, enters at eq:mass-bound through thm:main#wilson-hopping-hermitian, eq:mass-bound#mass-lower-bound and lem:transfer#dirac-hermitian.

NODE: thm:main#wilson-hopping-hermitian
KIND: step
TITLE: The Wilson hopping coefficients v_j(U) are Hermitian
STATEMENT_SOURCE: paper-a/model.tex#eq:wilson@L32-L32
PROOF_SOURCE: paper-a/comparison.tex#thm:main-proof@L71-L72
CONTRACT_ID: paper-a.thm:main#wilson-hopping-hermitian
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: a real and nonzero (a > 0, model.tex L4); no property of T_j(U) is needed
SOURCE_QUANTIFIERS: for every link configuration U and every j
SOURCE_CONCLUSION: v_j(U) = (T_j(U) - T_j(U)^*)/(2ia) is Hermitian
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:wilson-hopping
ROUTES: -
ROUTE_FOR: -
EDGE: def:wilson-hopping | paper-a/model.tex#eq:wilson@L32-L32 | the form (T_j - T_j^*)/(2ia)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] never stated; Lemma 3.1 requires Hermitian spatial coefficients (transfer.tex L15), and comparison.tex L71-L72 applies it citing only the mass bound; (T - T^*)/(2ia) is Hermitian for any T when a is real and nonzero. Hermiticity of M(U) is part of eq:mass-bound#mass-lower-bound.

NODE: thm:main#wilson-history
KIND: step
TITLE: The twisted Wilson step history satisfies the hypotheses of Lemma 3.1
STATEMENT_SOURCE: paper-a/comparison.tex#thm:main-proof@L71-L72
PROOF_SOURCE: paper-a/comparison.tex#thm:main-proof@L71-L89
CONTRACT_ID: paper-a.thm:main#wilson-history
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the hypotheses of thm:main#twisted-integrand on n, the Clifford set, a > 0, m > 0, r >= 0, b > 0 and the step history; theta in R^X
SOURCE_QUANTIFIERS: for every step history and every theta in R^X
SOURCE_CONCLUSION: the history of free steps exp(-tau_k h_W(U_k)), h_W(U) = sum_j alpha_j v_j(U) + beta M(U), followed by the kick exp(i diag(theta) (x) I_4), satisfies H31 on l^2(X) (x) C^4 with D = 4N, d = 2N, m_* = m and total free time b: v_j(U_k) Hermitian, M(U_k) >= m I with m > 0, tau_k >= 0, and the kick generator diag(theta) Hermitian and spin scalar
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: eq:mass-bound#mass-lower-bound, thm:main#wilson-hopping-hermitian, def:dirac-operator, def:history-step, def:step-free-time
ROUTES: -
ROUTE_FOR: -
EDGE: eq:mass-bound#mass-lower-bound | paper-a/comparison.tex#thm:main-proof@L71-L72 | 'the time-dependent Wilson mass M(omega_t) >= m I': the first assertion of (2.5), with m > 0
EDGE: thm:main#wilson-hopping-hermitian | paper-a/comparison.tex#thm:main-proof@L71-L72 | Lemma 3.1 requires Hermitian spatial coefficients
EDGE: def:dirac-operator | paper-a/comparison.tex#thm:main-proof@L48-L49 | the free steps are generated by h_W(omega_t), a Dirac operator with spatial coefficients v_j(omega_t) and mass M(omega_t)
EDGE: def:history-step | paper-a/comparison.tex#thm:main-proof@L87-L88 | e^{i vartheta} V_omega: free evolutions followed by a spin-scalar kick
EDGE: def:step-free-time | paper-a/comparison.tex#thm:main-proof@L71-L72 | Lemma 3.1 is applied with total free time b, the length of the path interval [0, b] (R5: sum_k tau_k = b)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: D = 4|X| = 4N and d = 2N (R2 with iota = X, |X| = n^3); m_* = m (L89). The kick generator diag(theta) is Hermitian for real theta (R4). Used with theta = vartheta + phi by thm:main#apply-transfer and with theta = vartheta by thm:main#apply-fourier. Not a gap: the source states the mass and dimension matching (L72, L89); the unstated Hermiticity of v_j is the gap of thm:main#wilson-hopping-hermitian.

NODE: thm:main#integrand-centered-trace
KIND: step
TITLE: The fermionic integrand of (4.5) is the centered trace of the twisted history
STATEMENT_SOURCE: paper-a/comparison.tex#thm:main-proof@L87-L88
PROOF_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L83-L86
CONTRACT_ID: paper-a.thm:main#integrand-centered-trace
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the step history of thm:main#twisted-integrand (Clifford set; real a, m, r); theta in R^X and u = e^{i theta} acting as diag(e^{i theta_x}) (x) I_4 (model.tex L64)
SOURCE_QUANTIFIERS: for every step history and every theta in R^X
SOURCE_CONCLUSION: the kick u = exp(i Theta), Theta = diag(theta) (x) I_4, has Tr Theta = 4 sum_x theta_x and centering factor e^{-2i sum_x theta_x}; the free steps contribute no centering phase since Tr h_W = 0; the transfer matrix of the history followed by u is u V_omega; hence e^{-2i sum_x theta_x} det(I + u V_omega) is the centered trace F of that history
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:centered-trace, def:transfer-matrix, def:step-generator, def:history-step, lem:transfer#trace-h-zero
ROUTES: -
ROUTE_FOR: -
EDGE: def:centered-trace | paper-a/comparison.tex#thm:main-proof@L87-L88 | 'the centered trace for e^{i vartheta} V_omega'
EDGE: def:transfer-matrix | paper-a/comparison.tex#eq:twisted@L61-L61 | det(I + u V_omega): the kick acts after the path, so the transfer matrix is u V_omega
EDGE: def:step-generator | paper-a/transfer.tex#sec:transfer-remark@L83-L86 | the kick centering e^{-(i/2) Tr Theta} with Tr Theta = 4 sum_x theta_x
EDGE: def:history-step | paper-a/comparison.tex#eq:twisted@L61-L61 | det(I + u V_omega): the free steps exp(-tau_k h_W(U_k)) of V_omega followed by the kick u form one history
EDGE: lem:transfer#trace-h-zero | paper-a/comparison.tex#eq:twisted@L61-L61 | the factor carries no phase from the free evolutions: Tr h_W(omega_t) = 0
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the source writes the factor e^{-2i sum theta_x} det(I + u V_omega) (L61), computes the centering of a local gauge twist (transfer.tex L83-L86) and calls the integrand 'the centered trace' (L87-L88), but never states that the free evolutions contribute no centering phase (Tr h_W = 0) or that the factor is the centered trace of the path followed by u. Under R8 the frozen statement defines the integrand as this centered trace, so the identification is not a Lean obligation; its Fock-space side (e^{i sum theta q} = e^{-2i sum theta} Gamma(u) from q_x = n_x - 2, and Tr_F Gamma(A) = det(I + A)) is outside the frozen surface.

NODE: thm:main#twist-split
KIND: step
TITLE: The twist e^{i(vartheta + phi)} is the relative kick e^{i vartheta} followed by the global twist e^{i phi}
STATEMENT_SOURCE: paper-a/comparison.tex#thm:main-proof@L82-L88
PROOF_SOURCE: paper-a/comparison.tex#thm:main-proof@L82-L88
CONTRACT_ID: paper-a.thm:main#twist-split
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: a history (no part of H31 is needed); theta_x = vartheta_x + phi with vartheta in R^X and phi real
SOURCE_QUANTIFIERS: for every history, every vartheta in R^X and every real phi
SOURCE_CONCLUSION: the centered trace of the history followed by the kick exp(i diag(vartheta + phi) (x) I_4) equals the centered trace of the history followed by the kick exp(i diag(vartheta) (x) I_4) and then the kick exp(i phi I), Lemma 3.2's appended global twist
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:centered-trace, def:transfer-matrix, def:step-generator, def:history-step
ROUTES: -
ROUTE_FOR: -
EDGE: def:centered-trace | paper-a/comparison.tex#thm:main-proof@L86-L88 | the phi-dependence of 'the centered trace for e^{i vartheta} V_omega'
EDGE: def:transfer-matrix | paper-a/comparison.tex#thm:main-proof@L82-L83 | the commuting kicks e^{i vartheta} and e^{i phi} compose to e^{i theta} in the transfer matrix
EDGE: def:step-generator | paper-a/comparison.tex#thm:main-proof@L82-L83 | the generators add, so the centering factors multiply: e^{-2i sum theta_x} = e^{-2i sum vartheta_x} e^{-2iN phi}
EDGE: def:history-step | paper-a/comparison.tex#thm:main-proof@L86-L88 | the history ending in the kick e^{i vartheta}, to which Lemma 3.2 appends its twist
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] the source writes theta_x = vartheta_x + phi (L83) and takes the phi-coefficient of 'the centered trace for e^{i vartheta} V_omega' (L87-L88), treating e^{i theta} as the relative kick e^{i vartheta} followed by Lemma 3.2's twist; that the two commuting kicks compose to e^{i theta} and that their centering factors multiply (e^{-2i sum vartheta_x} e^{-i d phi}, d = 2N) is not stated. A Lean obligation: the frozen root has the single kick diagonal (vartheta + phi), while lem_fourier_v1 appends Step.kick (phi * 1) to a history.

NODE: thm:main#apply-transfer
KIND: application
TITLE: Lemma 3.1 applied to the twisted Wilson history
STATEMENT_SOURCE: paper-a/comparison.tex#thm:main-proof@L70-L72
PROOF_SOURCE: paper-a/comparison.tex#thm:main-proof@L70-L72
CONTRACT_ID: paper-a.thm:main#apply-transfer
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the hypotheses of thm:main#twisted-integrand on n, the Clifford set, a > 0, m > 0, r >= 0, b > 0 and the step history; the gauge kick u = e^{i theta}, theta in R^X, appended to the step history
SOURCE_QUANTIFIERS: for every step history and every theta in R^X (one application per theta)
SOURCE_CONCLUSION: the fermionic integrand e^{-2i sum_x theta_x} det(I + u V_omega), the centered trace of the twisted history, is > 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer, thm:main#wilson-history, thm:main#integrand-centered-trace
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer | paper-a/comparison.tex#thm:main-proof@L71-L72 | 'Lemma 3.1 applies': F > 0 for the twisted history
EDGE: thm:main#wilson-history | paper-a/comparison.tex#thm:main-proof@L71-L72 | the premises of Lemma 3.1, with m_* = m from M(omega_t) >= m I
EDGE: thm:main#integrand-centered-trace | paper-a/comparison.tex#thm:main-proof@L70-L71 | the integrand of (4.5) is the centered trace to which Lemma 3.1 applies
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Lemma 3.1 is applied at every twist theta = vartheta + phi, since its history includes the kick u; only its positivity conclusion is used. The positivity of the scalar factors K_b and e^{-int H_B} (L70-L71) is excluded (heat kernel, path measure). Not a gap: the source names the lemma and its mass premise.

NODE: thm:main#apply-fourier
KIND: application
TITLE: Lemma 3.2 applied with D = 4N, d = 2N, m_* = m
STATEMENT_SOURCE: paper-a/comparison.tex#thm:main-proof@L86-L89
PROOF_SOURCE: paper-a/comparison.tex#thm:main-proof@L82-L89
CONTRACT_ID: paper-a.thm:main#apply-fourier
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the hypotheses of thm:main#twisted-integrand on n, the Clifford set, a > 0, m > 0, r >= 0, b > 0 and the step history; the relative kick e^{i vartheta}, vartheta in R^X, appended to the step history; an integer Q with |Q| <= 2N
SOURCE_QUANTIFIERS: for every step history, every vartheta in R^X and every integer Q with |Q| <= 2N
SOURCE_CONCLUSION: with F(phi) the twisted integrand (by thm:main#twist-split, the centered trace of the history ending in e^{i vartheta} with Lemma 3.2's twist appended): F_0 is real and |F_Q| <= binom(4N, 2N + |Q|) e^{-b m |Q|} F_0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:fourier, thm:main#wilson-history, thm:main#twist-split, thm:main#integrand-centered-trace
ROUTES: -
ROUTE_FOR: -
EDGE: lem:fourier | paper-a/comparison.tex#thm:main-proof@L88-L89 | 'Lemma 3.2 applies': (3.4) for q = Q, with F_0 real
EDGE: thm:main#wilson-history | paper-a/comparison.tex#thm:main-proof@L88-L89 | the history ending in the kick e^{i vartheta} is a Lemma 3.1 history with D = 4N, d = 2N, m_* = m
EDGE: thm:main#twist-split | paper-a/comparison.tex#thm:main-proof@L82-L88 | with theta = vartheta + phi, the phi-dependence is Lemma 3.2's global twist appended to the history ending in e^{i vartheta}
EDGE: thm:main#integrand-centered-trace | paper-a/comparison.tex#thm:main-proof@L86-L88 | the integrand integrated in phi is 'the centered trace for e^{i vartheta} V_omega'
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Lemma 3.2's premise |q| <= d is |Q| <= 2N, supplied by admissibility through (2.9) and recorded in the root's hypotheses; the source does not mention it at L89. binom(2d, d + |q|) e^{-b m_* |q|} with d = 2N, m_* = m is binom(4N, 2N + |Q|) e^{-b m |Q|}. The phi-integral is taken at fixed relative twist and path (L85-L87); a step history does not depend on phi (R5), so the claim that U^u and the bridge weight depend only on vartheta (L85-L86) is not needed and is excluded with the bridge measure. The charge-sector reading of the coefficient is outside the frozen surface (R8). Not a gap: the source names the lemma and its parameters.

NODE: model:gauge-covariance
KIND: claim
TITLE: Gauge covariance of the Wilson operator h_W(U^u) = u^* h_W(U) u
STATEMENT_SOURCE: paper-a/model.tex#sec:model@L64-L71
PROOF_SOURCE: paper-a/model.tex#sec:model@L71-L71
CONTRACT_ID: paper-a.model.gauge-covariance
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: X = (Z/nZ)^3 with n >= 3 (model.tex L4); the Wilson operator h_W of (2.3) with a > 0, m >= 0, r >= 0 (L4, L39) and a Hermitian Clifford set (L27-28); U in U(1)^E (L13); a gauge function u_x = e^{i theta_x} (L64), acting on the spatial factor; U^u_{xj} = u_x U_{xj} conj(u_{x+e_j}) (L66)
SOURCE_QUANTIFIERS: for every gauge function u and every link configuration U
SOURCE_CONCLUSION: h_W(U^u) = u^* h_W(U) u
CONSTANT_SCOPE: none
FROZEN_FILE: Frozen/PaperA/WilsonGaugeCovariance.lean
FROZEN_DECL: QEDCore.PaperA.wilson_gauge_covariance
FROZEN_ANCHOR_ID: gauge_covariance_v1
FROZEN_ABI_SHA256: a9c88dba21a22f42a995d0324d6f025daec649649709fa10ded792094271864b
DEPS: model:gauge-covariance#shift-covariance, def:dirac-operator, def:wilson-hopping, def:wilson-mass
ROUTES: -
ROUTE_FOR: -
EDGE: model:gauge-covariance#shift-covariance | paper-a/model.tex#sec:model@L71-L71 | T_j(U^u) = u^* T_j(U) u, from which v_j and M follow
EDGE: def:dirac-operator | paper-a/model.tex#sec:model@L71-L71 | h_W = sum_j alpha_j v_j + beta M, with u acting on the spatial factor and so commuting with alpha_j and beta
EDGE: def:wilson-hopping | paper-a/model.tex#sec:model@L71-L71 | v_j(U^u) = u^* v_j(U) u
EDGE: def:wilson-mass | paper-a/model.tex#sec:model@L71-L71 | M(U^u) = u^* M(U) u, using u^* u = I for the terms m and 2
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Frozen gauge_covariance_v1 (D16, T6) is stronger than the source: it assumes only |u_x| = 1, with no Clifford relations, no unit link variables and no sign conditions (U is any complex link array; a, m, r are any reals); u acts as diagonal(u) (x) I_4. A root of its own: no node of the other roots uses it, since the gauge insertion (comparison.tex L54) and the sector projection lie on the excluded side, and the step histories of thm:main#twisted-integrand carry no bridge endpoint conditions (R5). The consequence that W(u) commutes with each term of H (L71-L72) is outside the frozen surface.

NODE: model:gauge-covariance#shift-covariance
KIND: step
TITLE: The link shift is gauge covariant: T_j(U^u) = u^* T_j(U) u
STATEMENT_SOURCE: paper-a/model.tex#sec:model@L71-L71
PROOF_SOURCE: paper-a/model.tex#sec:model@L66-L71
CONTRACT_ID: paper-a.model.gauge-covariance#shift-covariance
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: a gauge function u on X (|u_x| = 1 is not needed for this identity); U^u_{xj} = u_x U_{xj} conj(u_{x+e_j}) (L66)
SOURCE_QUANTIFIERS: for every gauge function u, every link configuration U and every j
SOURCE_CONCLUSION: T_j(U^u) = u^* T_j(U) u, u the multiplication by u_x on l^2(X)
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:lattice-shift
ROUTES: -
ROUTE_FOR: -
EDGE: def:lattice-shift | paper-a/model.tex#sec:model@L66-L71 | (T_j(U^u) f)(x) = conj(u_x U_{xj} conj(u_{x+e_j})) f(x + e_j) = (u^* T_j(U) u f)(x)
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] h_W(U^u) = u^* h_W(U) u is asserted ('Then', L71) without the computation; it reduces to this identity for T_j, from which v_j(U^u) = u^* v_j(U) u and, using u^* u = I for the terms m and 2, M(U^u) = u^* M(U) u follow, u commuting with the Dirac matrices.

NODE: rem:nonneg-mass#apply-transfer
KIND: application
TITLE: Lemma 3.1 applied to the shifted history M + epsilon I
STATEMENT_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L90
PROOF_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L90
CONTRACT_ID: paper-a.rem:nonneg-mass#apply-transfer
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the hypotheses of rem:nonneg-mass; epsilon > 0
SOURCE_QUANTIFIERS: for every such history and every epsilon > 0 (one application per epsilon)
SOURCE_CONCLUSION: the history with every mass coefficient M replaced by M + epsilon I satisfies H31 with m_* = epsilon and the same b, so its centered trace F_epsilon is > 0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: lem:transfer, def:history-step, def:step-free-time
ROUTES: -
ROUTE_FOR: -
EDGE: lem:transfer | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | positivity of Lemma 3.1 at m_* = epsilon: F_epsilon > 0
EDGE: def:history-step | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | the shifted history replaces M by M + epsilon I on every free step and keeps the kicks
EDGE: def:step-free-time | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | the free times, hence b > 0, are unchanged
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The premise M + epsilon I >= epsilon I > 0 follows from M >= 0; only the positivity conclusion of Lemma 3.1 is used. The source names the method; not a gap.

NODE: rem:nonneg-mass#continuity
KIND: step
TITLE: The centered trace is continuous in the mass shift epsilon
STATEMENT_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L90-L90
PROOF_SOURCE: paper-a/transfer.tex#sec:transfer-remark@L89-L90
CONTRACT_ID: paper-a.rem:nonneg-mass#continuity
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: the hypotheses of rem:nonneg-mass; F_epsilon the centered trace of the history with every M replaced by M + epsilon I
SOURCE_QUANTIFIERS: none
SOURCE_CONCLUSION: epsilon -> F_epsilon is continuous on [0, infinity) and F_0 = F, so F = lim_{epsilon -> 0+} F_epsilon
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: def:centered-trace, def:history-step, def:dirac-operator
ROUTES: -
ROUTE_FOR: -
EDGE: def:centered-trace | paper-a/transfer.tex#sec:transfer-remark@L90-L90 | F_epsilon is the centered trace of the shifted history
EDGE: def:history-step | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | M + epsilon I on each free step, the kicks unchanged
EDGE: def:dirac-operator | paper-a/transfer.tex#sec:transfer-remark@L89-L90 | replacing M by M + epsilon I changes h by epsilon beta
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: graph-writer-2
REVIEWER: topology-reviewer-2
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: [minor] 'pass to the finite-dimensional limit' asserts the limit without arguing continuity; for step histories it is continuity in epsilon of finitely many exponentials, a product, a determinant and the exponential of a trace (as for lem:transfer#homotopy-continuity); for the source's time-dependent histories it needs continuous dependence of the propagator on a parameter. The closing step, that a limit of positive reals is real and >= 0, is routine.

## Append-only structural amendments

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

<!-- BEGIN PROOF DEPGRAPH GENERATED -->
Regenerated by `proof_depgraph.py`; do not hand-edit.

### Dashboard

* Total nodes: **71**
* Frozen anchors: **15**
* Versioned statement contracts: **71**
* Total edges: **197**
* Root-closure nodes: **71**
* Dependency leaves in root closure: **6**
* Assumption boundary leaves: **0**
* External boundary leaves: **0**
* Alternative routes: **0**
* Topology review queue: **0**
* Explicit source gaps: **28**
* Coverage items: **60**; excluded: **20**

### Roots

* `lem:transfer` [REVIEWED; frozen] — contract `paper-a.lem:transfer@1`
* `lem:fourier` [REVIEWED; frozen] — contract `paper-a.lem:fourier@1`
* `thm:main#twisted-integrand` [REVIEWED; frozen] — contract `paper-a.thm:main.twisted-integrand@1`
* `rem:nonneg-mass` [REVIEWED; frozen] — contract `paper-a.rem:nonneg-mass@1`
* `model:gauge-covariance` [REVIEWED; frozen] — contract `paper-a.model.gauge-covariance@1`
* `eq:mass-bound` [REVIEWED; frozen] — contract `paper-a.eq:mass-bound@1`

### Topology review queue

* _(none)_

### Dependency leaves in root closure

* `def:c5` [REVIEWED] — C5 = alpha_1 alpha_2 alpha_3 beta
* `def:dirac-operator` [REVIEWED] — Dirac operator h = sum_j alpha_j v_j + beta M
* `def:history-step` [REVIEWED] — Step of an ordered history
* `def:lattice-shift` [REVIEWED] — Link shift T_j(U) of (2.3)
* `lem:fourier#paired-factor` [REVIEWED] — Paired determinant factor
* `lem:transfer#norm-bounds-beta-form` [REVIEWED] — |f|^2 >= |B|

### Assumption boundary leaves

* _(none)_

### External boundary leaves

* _(none)_

### Uncovered graph nodes

* _(none)_

### Nodes outside every root closure

* _(none)_

### Explicit source gaps

* `eq:beta-form` [REVIEWED] — beta-form derivative (3.3)
* `eq:mass-bound#norm-bound` [REVIEWED] — Wilson operator norm bound ||h_W(U)|| <= h_* (second assertion of (2.5))
* `eq:mass-bound#shift-unitary` [REVIEWED] — T_j(U) is unitary for U(1) link variables
* `lem:fourier#coefficient-identification` [REVIEWED] — F_q as a correlation of elementary symmetric functions
* `lem:fourier#constant-positive` [REVIEWED] — C > 0
* `lem:fourier#elementary-bound` [REVIEWED] — |e_j| <= binom(d, j) s^j
* `lem:fourier#twist-is-kick` [REVIEWED] — The charge twist is a scalar kick with centering e^{-i d phi}
* `lem:transfer#beta-form-monotone` [REVIEWED] — B is nonincreasing along the transported trajectory
* `lem:transfer#c5-anticommutes-h` [REVIEWED] — C5 anticommutes with every Dirac operator h
* `lem:transfer#c5-involution` [REVIEWED] — C5 is a Hermitian unitary involution
* `lem:transfer#det-conjugation` [REVIEWED] — conj det(I+U) = det(U)^{-1} det(I+U)
* `lem:transfer#dirac-hermitian` [REVIEWED] — The Dirac operator h is Hermitian
* `lem:transfer#form-preservation` [REVIEWED] — U* C5 U = C5
* `lem:transfer#homotopy-admissible` [REVIEWED] — Deformation stays admissible
* `lem:transfer#homotopy-continuity` [REVIEWED] — F is continuous along the deformation
* `lem:transfer#homotopy-endpoint` [REVIEWED] — Endpoint value det(I + e^{-b m_* beta}) > 0
* `lem:transfer#liouville` [REVIEWED] — det U = exp(-int Tr A)
* `lem:transfer#norm-bounds-beta-form` [REVIEWED] — |f|^2 >= |B|
* `lem:transfer#propagator-invertible` [REVIEWED] — The propagator is invertible
* `lem:transfer#spectral-pairing` [REVIEWED] — Spectrum paired under lambda -> 1/conj(lambda) with multiplicity
* `lem:transfer#stable-trajectory` [REVIEWED] — |lambda| < 1 forces B > 0 along the trajectory
* `lem:transfer#trace-h-zero` [REVIEWED] — Tr h = 0, so int Tr A is purely imaginary
* `lem:transfer#unstable-trajectory` [REVIEWED] — |lambda| > 1 forces B < 0 along the trajectory
* `model:gauge-covariance#shift-covariance` [REVIEWED] — The link shift is gauge covariant: T_j(U^u) = u^* T_j(U) u
* `rem:nonneg-mass#continuity` [REVIEWED] — The centered trace is continuous in the mass shift epsilon
* `thm:main#integrand-centered-trace` [REVIEWED] — The fermionic integrand of (4.5) is the centered trace of the twisted history
* `thm:main#twist-split` [REVIEWED] — The twist e^{i(vartheta + phi)} is the relative kick e^{i vartheta} followed by the global twist e^{i phi}
* `thm:main#wilson-hopping-hermitian` [REVIEWED] — The Wilson hopping coefficients v_j(U) are Hermitian
<!-- END PROOF DEPGRAPH GENERATED -->
