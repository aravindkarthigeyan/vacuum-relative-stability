"""Exact rational checks used in the analytic Ewald certificate.

The analytic reductions are proved in continuation-meanfield.tex.
No floating-point sample is used to certify the sign of the Green-function
remainder. Decimal output here is only a convenience for reading the margins.
"""
from fractions import Fraction as F
from math import factorial
import json

z = F(53, 500)
t = F(669, 2000)
image = F(800, 177) * (z + z*z) + F(3200, 1593) * z**3 + 9*z**9/(1-z**16)
counts = [(1, 6), (2, 12), (3, 8), (4, 6), (5, 24),
          (6, 24), (8, 12), (9, 24), (12, 8)]
fourier = F(50,157) * (
    sum(F(count, square)*t**square for square, count in counts)
    + 26*t**9/(1-t**7))
exp_image = sum(F(9,4)**j / factorial(j) for j in range(8))
exp_fourier = sum(F(24649,22500)**j / factorial(j) for j in range(9))
erf_lower = F(15,13)*F(2999,3000)
assert exp_image > F(500,53)
assert exp_fourier > F(2000,669)
assert image < F(8,15)
assert fourier < F(9,10)
assert z**3/F(4) < F(1,3000)
assert erf_lower > F(23,20)
assert F(8,15)+F(9,10)-F(1,3)-F(23,20) == -F(1,20)
assert F(157,50)**2 > F(9)
assert F(177,100)**2 < F(157,50)
assert F(4,3) > F(225,169)
print(json.dumps({
    "method": "exact rational arithmetic after the analytic Ewald estimates",
    "all_assertions_passed": True,
    "image_upper_decimal": float(image),
    "image_target": "8/15",
    "fourier_upper_decimal": float(fourier),
    "fourier_target": "9/10",
    "green_remainder_certified_upper": "-1/20",
    "periodic_kato_constant": "6 + 3*pi*sqrt(6)/2 < 18",
}, indent=2))
