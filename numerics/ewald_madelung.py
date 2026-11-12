"""Exploratory Ewald values and a finite grid scan, not a global certificate."""
import numpy as np
from math import erfc
# zero-mean periodic Green fn on unit torus: -Lap G = 4pi(delta - 1)
def G(x,a=3.0,N=4):
    x=np.array(x,float); s=0.0
    r=np.arange(-N,N+1)
    for i in r:
      for j in r:
        for k in r:
          d=np.linalg.norm(x-np.array([i,j,k]))
          if d>1e-12: s+=erfc(a*d)/d
          kv=2*np.pi*np.array([i,j,k]); k2=kv@kv
          if k2>0: s+=4*np.pi/k2*np.exp(-k2/(4*a*a))*np.cos(kv@x)
    s-=np.pi/a**2
    return s
def reg(x,a=3.0):
    d=np.linalg.norm(x)
    if d<1e-12:
        r=np.arange(-4,5); s=0
        for i in r:
          for j in r:
            for k in r:
              n=np.array([i,j,k]); dn=np.linalg.norm(n)
              if dn>0: s+=erfc(a*dn)/dn
              kv=2*np.pi*n;k2=kv@kv
              if k2>0: s+=4*np.pi/k2*np.exp(-k2/(4*a*a))
        return s-np.pi/a**2-2*a/np.sqrt(np.pi)
    return G(x,a)-1/d
print("xi =",-reg([0,0,0]))
# sup over cell of G-1/|x|
best=-1e9;arg=None
g=np.linspace(0,0.5,11)
for x in g:
  for y in g:
    for z in g:
      if x<=y<=z:
        v=reg([x,y,z])
        if v>best: best,arg=v,(x,y,z)
print("Largest sampled value of G1-1/|x| (not a certified supremum) =",best,"at",arg)
# min of G1 (negative somewhere)
print("G1 at corner",G([0.5,0.5,0.5]))
