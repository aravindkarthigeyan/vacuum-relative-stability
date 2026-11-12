exec(open(__import__('os').path.join(__import__('os').path.dirname(__file__),'claude_gd_random_check.py')).read().split('print("min over')[0])
worst=np.inf
for t in range(40):
    mm=rng.uniform(0.2,1.5)
    v=[herm(n)*rng.uniform(0,3) for _ in range(3)]
    h=sum(np.kron(v[j],a[j]) for j in range(3))+np.kron(mm*np.eye(n),b)
    H=dG(h,cs); nsq=4; lam=rng.uniform(0.2,5,nsq); Rs=[]
    for _ in range(nsq):
        A=np.kron(herm(n),np.eye(4)); Rs.append(dG(A,cs)-np.trace(A).real/2*np.eye(2**D))
    Hm=H+sum(0.5*l*R@R for l,R in zip(lam,Rs))
    Nd=np.real(np.diag(N)).round().astype(int)
    Em=lambda q: np.linalg.eigvalsh(Hm[np.ix_(np.where(Nd==q)[0],np.where(Nd==q)[0])])[0]
    E0=Em(D//2)
    for q in range(D+1):
        if q!=D//2: worst=min(worst,(Em(q)-E0)/(abs(q-D//2)*mm))
print("min (E_q-E_0)/(m|q|) over trials:",worst)
