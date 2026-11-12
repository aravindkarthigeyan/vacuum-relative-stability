"""Independent finite-matrix checks of identities used in the proof.

Numerics are diagnostics, not substitutes for the analytic arguments.
Uses NumPy only. Run with the bundled Python runtime.
"""
from pathlib import Path
import json
import numpy as np

rng = np.random.default_rng(20261028)
I2 = np.eye(2)
s = [np.array([[0, 1], [1, 0]], complex),
     np.array([[0, -1j], [1j, 0]], complex),
     np.diag([1., -1.])]
alpha = [np.kron(s[0], a) for a in s]
beta = np.kron(s[2], I2)
C5 = alpha[0] @ alpha[1] @ alpha[2] @ beta

def herm(n):
    a = rng.normal(size=(n, n)) + 1j*rng.normal(size=(n, n))
    return (a+a.conj().T)/2

def hexp(a, scale):
    e, u = np.linalg.eigh(a)
    return (u*np.exp(scale*e)) @ u.conj().T

def dg(a):
    n = len(a)
    out = np.zeros((1 << n, 1 << n), complex)
    for state in range(1 << n):
        for j in range(n):
            if not (state >> j) & 1:
                continue
            middle = state ^ (1 << j)
            sign1 = (-1)**((state & ((1 << j)-1)).bit_count())
            for i in range(n):
                if (middle >> i) & 1:
                    continue
                final = middle | (1 << i)
                sign2 = (-1)**((middle & ((1 << i)-1)).bit_count())
                out[final, state] += sign1*sign2*a[i, j]
    return out

trace_imag = 0.
trace_min = float("inf")
indefinite_error = 0.
beta_margin = float("inf")
for trial in range(100):
    mass = 1.2*np.eye(2) + 0.1*herm(2)
    assert np.linalg.eigvalsh(mass)[0] > 0
    h = np.kron(mass, beta)
    for a in alpha:
        h += 0.2*np.kron(herm(2), a)
    U = np.eye(8, dtype=complex)
    phase = 0j
    for step in range(4):
        U = hexp(h, -0.07) @ U
        phi = 2*np.kron(herm(2), np.eye(4))
        U = hexp(phi, -1j) @ U
        phase += 0.5j*np.trace(phi)
    theta = rng.uniform(-np.pi, np.pi)
    U = np.exp(1j*theta)*U
    phase -= 4j*theta
    z = np.exp(phase)*np.linalg.det(np.eye(8)+U)
    trace_imag = max(trace_imag, abs(z.imag)/(1+abs(z.real)))
    trace_min = min(trace_min, z.real)
    c = np.kron(np.eye(2), C5)
    b = np.kron(np.eye(2), beta)
    indefinite_error = max(indefinite_error, np.linalg.norm(U.conj().T@c@U-c))
    beta_margin = min(beta_margin, np.linalg.eigvalsh(b-U.conj().T@b@U)[0])
assert trace_min > 0 and trace_imag < 1e-10 and beta_margin > 0

# Direct diagonalization of all charge blocks, independently of HS traces.
minimum_energy_margin = float("inf")
for trial in range(6):
    mass = 0.8*np.eye(2)+0.1*herm(2)
    h = np.kron(mass, beta)
    for a in alpha:
        h += 0.15*np.kron(herm(2), a)
    R = []
    for j in range(3):
        a = np.kron(herm(2), np.eye(4))
        R.append(dg(a)-np.trace(a)/2*np.eye(256))
    weights = rng.uniform(0.1, 1.5, 3)
    H = dg(h) + sum(w/2*(r@r) for w, r in zip(weights, R))
    counts = np.array([i.bit_count() for i in range(256)])
    def ground(block):
        return np.linalg.eigvalsh(block)[0]
    ix = np.flatnonzero(counts == 4)
    e0 = ground(H[np.ix_(ix, ix)])
    for source in range(8):
        eta = rng.normal(size=3)*2
        shifted = H + sum(w*x*r for w, x, r in zip(weights, eta, R))
        shifted += sum(weights*eta**2)/2*np.eye(256)
        for number in range(9):
            ix = np.flatnonzero(counts == number)
            margin = ground(shifted[np.ix_(ix, ix)])-e0
            minimum_energy_margin = min(minimum_energy_margin, margin)
assert minimum_energy_margin > -1e-9

# Exact Wick rewriting tested against quasifree expectation formula.
p = [np.array([0., 0., 0.]), np.array([1., .4, -.3])]
D0 = np.zeros((8, 8), complex)
for j, momentum in enumerate(p):
    D0[4*j:4*j+4, 4*j:4*j+4] = beta + sum(x*a for x, a in zip(momentum, alpha))
e, u = np.linalg.eigh(D0)
P = u[:, e < 0] @ u[:, e < 0].conj().T
T = np.kron(np.array([[0., 1.], [0., 0.]]), np.eye(4))
operators = [(T, T.conj().T), (T.conj().T, T)]
coupling = .2
KI = sum(a@b for a,b in operators)
KP = sum(a@P@b for a,b in operators)
heff = D0-coupling/2*(KI-2*KP)
constant = -np.trace(P@D0)-coupling/2*sum(np.trace(P@a@P@b) for a,b in operators)
wick_error = 0.
for trial in range(50):
    _, u = np.linalg.eigh(herm(8))
    gamma = (u*rng.uniform(0,1,8))@u.conj().T
    Q = gamma-P
    direct = np.trace(D0@Q)+coupling/2*sum(
        np.trace(Q@a)*np.trace(Q@b)-np.trace(Q@a@Q@b)
        for a,b in operators)
    rewrite = constant+np.trace(heff@gamma)+coupling/2*sum(
        np.trace(gamma@a)*np.trace(gamma@b)
        +np.trace(gamma@a@(np.eye(8)-gamma)@b)
        for a,b in operators)
    wick_error = max(wick_error, abs(direct-rewrite))
assert wick_error < 1e-10
result = dict(seed=20261028, determinant_trials=100,
              exact_canonical_energy_comparisons=6*8*9,
              minimum_centered_trace=trace_min,
              maximum_relative_imaginary_part=trace_imag,
              maximum_C5_preservation_error=indefinite_error,
              minimum_beta_decrease_eigenvalue=beta_margin,
              minimum_completed_square_energy_margin=minimum_energy_margin,
              maximum_Wick_expectation_error=wick_error,
              status="passed; finite numerical checks, not a proof")
path = Path(__file__).with_name("gaussian_domination_checks.json")
path.write_text(json.dumps(result, indent=2), encoding="utf-8")
print(json.dumps(result, indent=2))
