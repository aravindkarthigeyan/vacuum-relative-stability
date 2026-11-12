# Independent check of the lattice charge-gap / Gaussian-domination theorem in a 1+1D analogue:
# open Wilson chain, Gauss law solved exactly (links gauge-fixed), canonical charge sectors.
import numpy as np, itertools
rng=np.random.default_rng(7)
sx=np.array([[0,1],[1,0]]);sz=np.diag([1.,-1])
def fock(D):
    I=np.eye(2);Z=np.diag([1,-1]);lo=np.array([[0,1],[0,0]]);cs=[]
    for j in range(D):
        op=np.array([[1.]])
        for k in range(D): op=np.kron(op,Z if k<j else (lo if k==j else I))
        cs.append(op)
    return cs
Ns=4; D=2*Ns; cs=fock(D)
dG=lambda A: sum(A[i,j]*cs[i].conj().T@cs[j] for i in range(D) for j in range(D) if abs(A[i,j])>1e-14)
# site occupation operators: mode index = 2*x + s
nsite=[cs[2*x].conj().T@cs[2*x]+cs[2*x+1].conj().T@cs[2*x+1] for x in range(Ns)]
qop=[n-np.eye(2**D) for n in nsite]
Qtot=np.real(np.diag(sum(qop))).round().astype(int)
worst_gd=np.inf; worst_gap=np.inf
for trial in range(60):
    a=rng.uniform(0.5,2); m=rng.uniform(0,1.5); r=rng.uniform(0,1.5); g2=rng.uniform(0.2,6)
    T=np.diag(np.ones(Ns-1),1)          # forward shift, open BC
    v=(T-T.T)/(2j*a); M=m*np.eye(Ns)+(r/(2*a))*(2*np.eye(Ns)-T-T.T)
    h=np.kron(v,sx)+np.kron(M,sz)       # site (x) spin ordering matches mode 2x+s
    Hf=dG(h)
    def H(nu):
        E=0
        S=np.zeros_like(Hf); acc_q=0; acc_nu=0
        for l in range(Ns-1):           # link between site l and l+1
            acc_q=acc_q+qop[l]; acc_nu+=nu[l]
            F=acc_nu*np.eye(2**D)-acc_q
            S=S+F@F
        return Hf+0.5*g2/a*S
    def Emin(Hm,qq):
        idx=np.where(Qtot==qq)[0]
        return np.linalg.eigvalsh(Hm[np.ix_(idx,idx)])[0] if len(idx) else np.inf
    E0=Emin(H(np.zeros(Ns)),0)
    for _ in range(6):
        nu=rng.integers(-2,3,size=Ns)
        tot=nu.sum()
        if abs(tot)>Ns: continue
        En=Emin(H(nu),tot)
        if not nu.any(): continue
        worst_gd=min(worst_gd,En-E0)
        worst_gap=min(worst_gap,En-E0-m*abs(tot))
print("min E_nu - E_0             :",worst_gd)
print("min E_nu - E_0 - m|sum nu| :",worst_gap, "(theorem predicts >= 0)")
