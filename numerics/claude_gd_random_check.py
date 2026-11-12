# Independent test of the Gaussian-domination comparison on random small instances.
import numpy as np, itertools
rng=np.random.default_rng(1)
s=[np.array([[0,1],[1,0]]),np.array([[0,-1j],[1j,0]]),np.array([[1,0],[0,-1]])]
Z2=np.zeros((2,2));I2=np.eye(2)
a=[np.block([[Z2,si],[si,Z2]]) for si in s]; b=np.block([[I2,Z2],[Z2,-I2]])
def herm(n): X=rng.normal(size=(n,n))+1j*rng.normal(size=(n,n)); return (X+X.conj().T)/2
def fock_ops(D):
    # Jordan-Wigner annihilators on 2^D space
    I=np.eye(2); sz=np.diag([1,-1]); lo=np.array([[0,1],[0,0]])
    cs=[]
    for j in range(D):
        op=np.array([[1.]])
        for k in range(D):
            op=np.kron(op, sz if k<j else (lo if k==j else I))
        cs.append(op)
    return cs
def dG(A,cs):
    return sum(A[i,j]*cs[i].conj().T@cs[j] for i in range(len(cs)) for j in range(len(cs)) if abs(A[i,j])>1e-14)
n=2; D=4*n; cs=fock_ops(D); N=dG(np.eye(D),cs)
def trial(scalar=0.0, nsq=3, nsrc=True):
    v=[herm(n) for _ in range(3)]; M=herm(n); w,U=np.linalg.eigh(M); M=U@np.diag(np.abs(w)+0.3)@U.conj().T
    h=sum(np.kron(v[j],a[j]) for j in range(3))+np.kron(M,b)+scalar*np.kron(herm(n),np.eye(4))
    H=dG(h,cs)
    Rs=[]
    for _ in range(nsq):
        A=np.kron(herm(n),np.eye(4)); R=dG(A,cs)-np.trace(A).real/2*np.eye(2**D); Rs.append(R)
    lam=rng.uniform(0.5,2,nsq)
    def Ham(eta): return H+sum(0.5*l*(R+e*np.eye(2**D))@(R+e*np.eye(2**D)) for l,R,e in zip(lam,Rs,eta))
    Nd=np.real(np.diag(N)).round().astype(int)
    def Emin(Hm,q):
        idx=np.where(Nd==q)[0]; return np.linalg.eigvalsh(Hm[np.ix_(idx,idx)])[0]
    E0=Emin(Ham(np.zeros(nsq)),D//2)
    worst=np.inf
    for _ in range(4):
        eta=rng.normal(scale=2,size=nsq)
        for q in range(D+1):
            worst=min(worst,Emin(Ham(eta),q)-E0)
    return worst
print("min over random instances of E_q(eta)-E_0(0) (should be >=0):")
print(" proper h :", min(trial() for _ in range(15)))
print(" h with scalar part :", min(trial(scalar=1.5) for _ in range(15)))
def trial_mass(shift):
    global herm
    v=[herm(n) for _ in range(3)]; M=herm(n); w,U=np.linalg.eigh(M); M=U@np.diag(np.abs(w)+shift)@U.conj().T
    return v,M
# indefinite mass: replace M by matrix with a negative eigenvalue
def trial_indef(nsq=3):
    v=[herm(n) for _ in range(3)]; M=np.diag([-0.8,0.5])
    h=sum(np.kron(v[j],a[j]) for j in range(3))+np.kron(M,b)
    H=dG(h,cs); Rs=[];lam=rng.uniform(0.5,3,nsq)
    for _ in range(nsq):
        A=np.kron(herm(n),np.eye(4)); Rs.append(dG(A,cs)-np.trace(A).real/2*np.eye(2**D))
    Nd=np.real(np.diag(N)).round().astype(int)
    Ham=lambda eta: H+sum(0.5*l*(R+e*np.eye(2**D))@(R+e*np.eye(2**D)) for l,R,e in zip(lam,Rs,eta))
    Em=lambda Hm,q: np.linalg.eigvalsh(Hm[np.ix_(np.where(Nd==q)[0],np.where(Nd==q)[0])])[0]
    E0=Em(Ham(np.zeros(nsq)),D//2)
    return min(Em(Ham(rng.normal(scale=2,size=nsq)),q)-E0 for q in range(D+1) for _ in range(3))
print(" indefinite mass :", min(trial_indef() for _ in range(15)))
