import numpy as np
s=[np.array([[0,1],[1,0]]),np.array([[0,-1j],[1j,0]]),np.array([[1,0],[0,-1]])]
Z2=np.zeros((2,2));I2=np.eye(2)
a=[np.block([[Z2,si],[si,Z2]]) for si in s]; b=np.block([[I2,Z2],[Z2,-I2]])
m=1.0
def proj(p):
    D=sum(p[l]*a[l] for l in range(3))+m*b; E=np.sqrt(p@p+m*m)
    return (np.eye(4)+D/E)/2,(np.eye(4)-D/E)/2,E
def chi(q,Lam,n=36):
    # continuum integral via grid, q along e1, eps=e2
    g=np.linspace(-Lam,Lam,n); h=g[1]-g[0]; tot=0
    qv=np.array([q,0,0])
    for x in g:
      for y in g:
        for z in g:
          p=np.array([x,y,z])
          if p@p>Lam**2 or (p+qv)@(p+qv)>Lam**2: continue
          Pp,_,E1=proj(p+qv); _,Pm,E0=proj(p)
          tot+=np.trace(Pp@a[1]@Pm@a[1]).real/(E1+E0)
    return tot*h**3/(2*np.pi)**3
Lam=6
c0=Lam**3/(6*np.pi**2*np.sqrt(Lam**2+1))
for q in [0,0.25,0.5,1,2,4]:
    print(q, chi(q,Lam), "exact chi0", c0)
