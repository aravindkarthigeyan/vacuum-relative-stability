import numpy as np
m=1.0
def shift(Lam,L,p):
    n=int(Lam*L/(2*np.pi))+1; g=np.arange(-n,n+1)*2*np.pi/L
    X,Y,Zc=np.meshgrid(g,g,g,indexing='ij'); R=np.stack([X,Y,Zc],-1).reshape(-1,3)
    R=R[(R**2).sum(1)<=Lam**2]
    d2=((R-p)**2).sum(1); mask=d2>1e-12
    E=np.sqrt((R**2).sum(1)+m*m)
    return 0.5*np.sum(4*np.pi/d2[mask]*m/E[mask])/L**3   # divide by alpha
for Lam in [10,30,100]:
    L=2*np.pi*18/Lam
    vals=[shift(Lam,L,np.array([x,0,0])) for x in [0,Lam/2,Lam*0.99]]
    print(f"Lam={Lam}: (M_eff deficit)/alpha at |p|=0,L/2,~L:",np.round(vals,3)," continuum (1/pi)asinh:",round(np.arcsinh(Lam)/np.pi,3), " crude 13Lam/pi^2:", round(13*Lam/np.pi**2,1))
