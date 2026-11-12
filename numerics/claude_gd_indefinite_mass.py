exec(open(__import__('os').path.join(__import__('os').path.dirname(__file__),'claude_gd_random_check.py')).read().split('print("min over')[0])
def run(Mdiag,nsq=4,trials=40):
    worst=np.inf
    for _ in range(trials):
        v=[herm(n)*rng.uniform(0,2) for _ in range(3)]; Uu=np.linalg.qr(rng.normal(size=(n,n))+1j*rng.normal(size=(n,n)))[0]
        M=Uu@np.diag(Mdiag)@Uu.conj().T
        h=sum(np.kron(v[j],a[j]) for j in range(3))+np.kron(M,b)
        H=dG(h,cs); Rs=[];lam=rng.uniform(0.2,4,nsq)
        for _ in range(nsq):
            A=np.kron(herm(n),np.eye(4)); Rs.append(dG(A,cs)-np.trace(A).real/2*np.eye(2**D))
        Nd=np.real(np.diag(N)).round().astype(int)
        Ham=lambda eta: H+sum(0.5*l*(R+e*np.eye(2**D))@(R+e*np.eye(2**D)) for l,R,e in zip(lam,Rs,eta))
        Em=lambda Hm,q: np.linalg.eigvalsh(Hm[np.ix_(np.where(Nd==q)[0],np.where(Nd==q)[0])])[0]
        E0=Em(Ham(np.zeros(nsq)),D//2)
        for _ in range(3):
            eta=rng.normal(scale=3,size=nsq)
            for q in range(D+1): worst=min(worst,Em(Ham(eta),q)-E0)
    return worst
for Md in ([0.5,0.5],[-1,1],[0,0],[-0.05,0.05],[0,1]):
    print(Md, run(np.array(Md,float)))
