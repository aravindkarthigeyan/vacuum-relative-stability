"""Deterministic checks for the mass-window and charge-gap audit.

The inequalities are proved in mass-gap.tex; this script only checks constants,
the elementary thermal counterexample, and searches for determinant warnings.
Run with --indefinite-search to run the optional finite-matrix diagnostic.
"""
import argparse
import json
import math
import numpy as np


def mass_deficit(lam, length, p, mass=1.0, alpha=1.0):
    h = 2 * math.pi / length
    n = math.ceil(lam / h)
    xyz = np.indices((2 * n + 1,) * 3).reshape(3, -1).T - n
    r = xyz * h
    r = r[np.sum(r * r, axis=1) <= lam * lam * (1 + 1e-14)]
    distance2 = np.sum((r - p) ** 2, axis=1)
    keep = distance2 > 1e-24
    return 2 * math.pi * alpha * mass / length**3 * np.sum(
        1 / (distance2[keep] * np.sqrt(mass * mass + np.sum(r[keep] ** 2, axis=1)))
    )


def indefinite_search(trials=20000):
    rng = np.random.default_rng(284711)
    pauli = [np.array([[0, 1], [1, 0]]), np.array([[0, -1j], [1j, 0]]),
             np.diag([1., -1.])]
    z = np.zeros((2, 2))
    aa = [np.block([[z, s], [s, z]]) for s in pauli]
    bb = np.diag([1., 1., -1., -1.])
    def hermitian():
        x = rng.normal(size=(2, 2)) + 1j * rng.normal(size=(2, 2))
        return (x + x.conj().T) / 2
    def exp_hermitian(a, scale):
        w, v = np.linalg.eigh(a)
        return (v * np.exp(scale * w)) @ v.conj().T
    smallest = 1.0
    witness = None
    for trial in range(trials):
        mass = np.diag([-1., 1.])
        h = np.kron(mass, bb) + sum(np.kron(hermitian(), a) for a in aa)
        step = exp_hermitian(h, -rng.uniform(.1, .8))
        u = np.eye(8, dtype=complex)
        phase = 0.
        kicks = []
        for _ in range(5):
            phi = np.kron(hermitian() * 2, np.eye(4))
            kicks.append(phi)
            u = exp_hermitian(phi, -1j) @ step @ u
            phase += np.trace(phi).real / 2
        value = np.exp(1j * phase) * np.linalg.det(np.eye(8) + u)
        normalized = value.real / max(1., abs(value))
        smallest = min(smallest, normalized)
        if value.real < -1e-5 and abs(value.imag) < 1e-6 * abs(value.real):
            witness = {"trial": trial, "centered_determinant_real": float(value.real),
                       "imaginary_residual": float(value.imag),
                       "condition_number": float(np.linalg.cond(u))}
            break
    return {"trials_requested": trials, "minimum_normalized_real": smallest,
            "negative_witness_diagnostic": witness,
            "status": "Diagnostic only; a numerical negative determinant is not a GD counterexample."}


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--indefinite-search", action="store_true")
    args = parser.parse_args()
    r = .01
    thermal_ratio = (2*r + 2*r**3) / (1 + 4*r**2 + r**4)
    assert thermal_ratio > r
    lam = 6000.
    length = 2 * math.pi / lam
    deficit = mass_deficit(lam, length, np.array([lam, 0., 0.]), alpha=1/137)
    zero_mode_lower = lam / (137 * 4 * math.pi**2)
    assert deficit >= zero_mode_lower and zero_mode_lower > 1
    assert (16/9)**5 < 18
    assert 13*math.pi**2/3 < 43
    assert math.sqrt(43*62) < 52
    assert 2*math.pi*math.sqrt(3) < 11
    assert (54 + 18*(43+26) + 11)/(4*math.pi**2) < 34
    result = {"thermal_prefactor_free_claim_false": {"r": r, "Z1_over_Z0": thermal_ratio},
              "coarse_box": {"Lambda_over_m": lam, "h_over_m": lam,
                             "deficit_over_m": float(deficit),
                             "r_zero_contribution_over_m": zero_mode_lower},
              "cubature_constants_verified": True}
    if args.indefinite_search:
        result["indefinite_search"] = indefinite_search()
    print(json.dumps(result, indent=2))


if __name__ == "__main__":
    main()
