import numpy as np
# Pauli-Dirac matrices
s=[np.array([[0,1],[1,0]]),np.array([[0,-1j],[1j,0]]),np.array([[1,0],[0,-1]])]
Z2=np.zeros((2,2));I2=np.eye(2)
a=[np.block([[Z2,si],[si,Z2]]) for si in s]; b=np.block([[I2,Z2],[Z2,-I2]])
m=1.0
def chi_direct(Lam,L):
    n=int(np.floor(Lam*L/(2*np.pi)))
    tot=0.0
    rng=np.arange(-n,n+1)
    for i in rng:
      for j in rng:
        for k in rng:
          p=2*np.pi/L*np.array([i,j,k]); 
          if p@p>Lam**2: continue
          D=sum(p[l]*a[l] for l in range(3))+m*b
          w,U=np.linalg.eigh(D); E=w[-1]
          Pp=U[:,w>0]@U[:,w>0].conj().T; Pm=np.eye(4)-Pp
          # second-order k->0 susceptibility: sum over pairs tr(P+ a2 P- a2)/(2E)
          tot+=np.trace(Pp@a[1]@Pm@a[1]).real/(2*E)
    return tot/L**3
def chi_formula(Lam):
    p=np.linspace(1e-6,Lam,200001); E=np.sqrt(p**2+m**2)
    return np.trapezoid(p**2*(1-p**2/(3*E**2))/E,p)/(2*np.pi**2)
for Lam,L in [(5,12),(8,10)]:
    print(Lam,L,chi_direct(Lam,L),chi_formula(Lam),Lam**2/(6*np.pi**2))
alpha=1/137; 
for Lam in [5,10,100]:
    mu2=2*4*np.pi*alpha*chi_formula(Lam); print("Lam",Lam,"mu_ind^2",mu2,"4aL^2/3pi",4*alpha*Lam**2/(3*np.pi),"L*=2pi/mu",2*np.pi/np.sqrt(mu2))
