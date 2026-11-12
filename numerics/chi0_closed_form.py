import sympy as sp
p,L,m=sp.symbols('p Lambda m',positive=True)
E=sp.sqrt(p**2+m**2)
I=sp.integrate(p**2/E - p**4/(3*E**3),(p,0,L))
I=sp.simplify(I); print(I)
print(sp.series(I.subs(m,1),L,sp.oo,3))
