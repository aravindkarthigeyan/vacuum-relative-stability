import numpy as np, itertools, math
az=math.radians(-34); el=math.radians(23); Dcam=9.0
c=np.array([math.cos(el)*math.cos(az), math.cos(el)*math.sin(az), math.sin(el)])
r=np.array([-math.sin(az), math.cos(az), 0.0]); u=np.cross(c,r)
S=2.25
def depth(p): return (np.array(p,float)-1.0)@c      # larger = closer
def persp(p): return Dcam/(Dcam-depth(p))
def P(p):
    q=np.array(p,float)-1.0; f=persp(p)
    return np.array([S*f*(q@r), S*f*(q@u)])
def fmt(xy): return f"({xy[0]:.3f},{xy[1]:.3f})"
def fade(d): return min(1,max(0,(d+1.9)/3.8))
n=3; sites=list(itertools.product(range(n),repeat=3))
N=(1,1,2); e1=(1,0,2); e2=(2,1,2); Pp=(2,0,0); Qe=(2,0,1)
flux={(N,e1):1,(N,e2):1,(Pp,Qe):1}
loop=[(0,0,0),(0,1,0),(0,1,1),(0,0,1)]
for a_,b_ in zip(loop,loop[1:]+loop[:1]): flux[(a_,b_)]=1
mag=[(1,2,0),(2,2,0),(2,2,1),(1,2,1)]
charge={N:'nuc',e1:'e',e2:'e',Pp:'p',Qe:'e'}
rad={'nuc':0.33,'e':0.16,'p':0.16,None:0.105}
flowlinks=set(frozenset(k) for k in flux)
items=[]
for s in sites:
    for d in range(3):
        t=list(s); t[d]+=1; t=tuple(t)
        if t[d]<n:
            if frozenset((s,t)) in flowlinks: continue
            dd=(depth(s)+depth(t))/2; g=int(62-30*fade(dd))
            items.append((dd-0.3, f"\\draw[line width={0.35+0.45*fade(dd):.2f}pt,draw=black!{100-g}!white] {fmt(P(s))} -- {fmt(P(t))};"))
        for sign in (+1,-1):
            if (sign==1 and s[d]==n-1) or (sign==-1 and s[d]==0):
                t2=list(s); t2[d]+=0.40*sign
                items.append((depth(s)-0.35, f"\\draw[line width=0.45pt,draw=black!28,dash pattern=on 1.5pt off 1.5pt] {fmt(P(s))} -- {fmt(P(t2))};"))
cen=np.mean([P(p) for p in mag],axis=0); dcen=np.mean([depth(p) for p in mag])
pts=" -- ".join(fmt(P(p)) for p in mag)
items.append((dcen-0.32, f"\\fill[violet!50,opacity=0.22] {pts} -- cycle; \\draw[violet!65!black,line width=0.8pt,opacity=0.85] {pts} -- cycle;"))
items.append((dcen-0.2, f"\\draw[violet!75!black,line width=1pt,-{{Stealth[length=4.5pt]}}] ($ {fmt(cen)} + (25:0.45) $) arc[start angle=25,end angle=325,radius=0.45]; \\node[violet!75!black,font=\\small] at {fmt(cen)} {{$\\Phi_B$}};"))
for (a_,b_),val in flux.items():
    A=P(a_); B=P(b_); dvec=(B-A)/np.linalg.norm(B-A)
    ra=rad[charge.get(a_)]*persp(a_)+0.03; rb=rad[charge.get(b_)]*persp(b_)+0.03
    A2=A+dvec*ra; B2=B-dvec*rb
    dd=(depth(a_)+depth(b_))/2
    isloop=a_ in loop and b_ in loop
    col='teal!75!black' if isloop else 'flux'
    w=1.6+1.0*fade(dd)
    items.append((dd-0.05, f"\\draw[line width={w:.2f}pt,draw={col},postaction={{decorate}},decoration={{markings,mark=at position 0.6 with {{\\arrow{{Stealth[length={5+3*fade(dd):.1f}pt,width={4.5+2.5*fade(dd):.1f}pt]}}}}}}] {fmt(A2)} -- {fmt(B2)};"))
for s in sites:
    d=depth(s); xy=P(s); f=persp(s); k=charge.get(s)
    if k=='nuc':
        items.append((d, f"\\fill[red!60,opacity=0.08] {fmt(xy)} circle ({0.66*f:.3f}); \\fill[red!60,opacity=0.10] {fmt(xy)} circle ({0.48*f:.3f}); \\shade[ball color=red!78!black] {fmt(xy)} circle ({0.33*f:.3f}); \\node[white,font=\\bfseries] at {fmt(xy)} {{$+2$}};"))
    elif k=='e':
        items.append((d, f"\\fill[blue!55,opacity=0.10] {fmt(xy)} circle ({0.44*f:.3f}); \\fill[blue!55,opacity=0.14] {fmt(xy)} circle ({0.31*f:.3f}); \\shade[ball color=blue!72] {fmt(xy)} circle ({0.16*f:.3f});"))
    elif k=='p':
        items.append((d, f"\\fill[orange!70,opacity=0.10] {fmt(xy)} circle ({0.44*f:.3f}); \\fill[orange!70,opacity=0.15] {fmt(xy)} circle ({0.31*f:.3f}); \\shade[ball color=orange!90!red] {fmt(xy)} circle ({0.16*f:.3f});"))
    else:
        items.append((d, f"\\shade[ball color=black!{int(15+25*fade(d))}] {fmt(xy)} circle ({0.105*f:.3f});"))
items.sort(key=lambda t:t[0])
open('lattice_body.tex','w').write("\n".join(c_ for _,c_ in items))
anch={'N':P(N),'e1':P(e1),'e2':P(e2),'P':P(Pp),'Q':P(Qe),'loop':np.mean([P(p) for p in loop],axis=0),
      'mag':cen,'a0':P((0,0,0)),'a1':P((1,0,0)),'top':P((0,2,2)),'c000':P((0,0,0)),'c200':P((2,0,0)),'c022':P((0,2,2)),'c220':P((2,2,0))}
open('anchors.tex','w').write("".join(f"\\coordinate ({k}) at {fmt(v)};\n" for k,v in anch.items()))
for k,v in anch.items(): print(k, np.round(v,2))
