/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core

-- Human-readable `#print axioms` for the supporting lemmas listed in status.json.
-- The authoritative check is scripts/Audit/AxiomAudit.lean, which audits every
-- declaration of the library. Standard Lean foundations (propext,
-- Classical.choice, Quot.sound) are allowed; sorryAx/custom axioms are not.
#print axioms QEDCore.preservesForm_mul
#print axioms QEDCore.preservesForm_one
#print axioms QEDCore.preservesForm_list_prod
#print axioms QEDCore.adjoint_eq_conjugate_inverse
#print axioms QEDCore.no_unit_factor_of_strict_drop
#print axioms QEDCore.stable_endpoint_positive
#print axioms QEDCore.unstable_endpoint_negative
#print axioms QEDCore.stable_annulus_from_endpoint
#print axioms QEDCore.unstable_annulus_from_endpoint
#print axioms QEDCore.inverse_eigenvector
#print axioms QEDCore.involution_mulVec_ne_zero
#print axioms QEDCore.adjoint_inverse_eigenvector
#print axioms QEDCore.elementary_zero
#print axioms QEDCore.norm_elementary_le
#print axioms QEDCore.correlation_zero
#print axioms QEDCore.one_le_vacuumWeight
#print axioms QEDCore.norm_correlation_le
#print axioms QEDCore.elementary_correlation_bound
#print axioms QEDCore.relative_correlation_bound
#print axioms QEDCore.positive_measure_comparison
#print axioms QEDCore.phase_preserves_bound
#print axioms QEDCore.scaled_coefficient_comparison
#print axioms QEDCore.canonical_integral_comparison
