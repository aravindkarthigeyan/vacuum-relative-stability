# Free dielectric estimate and independent audit of the photon-free relative proof

This report records proved estimates and an independent technical audit. It is not a claim of literature priority or formal proof-assistant verification.

## Free quadratic estimate

For the finite Dirac momentum cutoff, let `Phi=P_f phi P_f`, `B=P_+ Phi P_-`, and let `S(B)` denote the sum of `|B_ij|^2/(E_i+|E_j|)` over positive/negative free states. For any real `phi` in `H^1 ∩ L∞`, any `tau>0`, and `v=||phi||∞<tau m`, the full-Fock operator satisfies

`tau H_D+n(phi) >= -sum |B_ij|^2/[tau(E_i+|E_j|)-2v] >= -S(B)/(tau-v/m)`.

This is nonperturbative and applies to arbitrary correlated states and all charge sectors. The proof uses only the CAR implication `0<=gamma<=1`, the identity `Q=gamma-P_-`, and the operator inequality `Q^2<=Q_++-Q_--`; it does not assume quasi-freeness. The diagonal potential is absorbed by the rest-energy gap and the off-diagonal terms are bounded by explicit scalar square completion.

The exact scalar-projector trace is

`tr P_+(p+k)P_-(p) = [|k|^2-(E(p+k)-E(p))^2]/[2 E(p+k)E(p)]`.

It gives

`||B||HS^2 <= C2 ||grad phi||2^2`, with `C2=(1/(2V)) sum E(p)^(-2)`,

and

`S(B) <= C3 ||grad phi||2^2`, with `C3=(1/(4V)) sum E(p)^(-3)`.

For all `L>=L0>0`, explicit valid constants are

`C2 <= 1/(2 m^2 L0^3) + 13 Lambda/(8 pi^3)`,

`C3 <= 1/(4 m^3 L0^3) + 13[2+log_+(Lambda/m)]/(16 pi^3)`.

Both estimates retain the sharp cutoff. The commutator is taken inside the retained one-particle space; there `||[P_-,Phi]||HS^2=2||B||HS^2`. No claim about unretained modes is being made. The source file `photon-free-relative-stability-paper/free-dielectric.tex` contains complete proofs, a constant-shift refinement in fixed-charge sectors, and a threshold-penalty formula for potentials too large to absorb into the gap.

## Mean-field and exact heat core--tail consequences

If a separately proved mean-field exchange estimate supplies `E_HF,0(gamma)>=theta T(gamma)` with `theta>0`, the same argument gives a dielectric estimate with `tau=theta`. For the periodic Kato estimate with constant `c_*`, a sufficient uniform choice is `theta=1-alpha pi/4-alpha c_*/(2mL0)>0`. This assumption is explicitly stated in the source; the free result is independent of it.

For an exact heat splitting `G=G_s+h_s`, `s=R^2`, finite lattice-shell estimates give, for every box size,

`||h_s||1 <= 8 pi R^2`,

`||G_s||∞ <= a/R`, with `a=13/(2 pi^(3/2))`,

`||grad G_s||2^2 = 4 pi G_(2s)(0) <= b/R`, with `b=13 sqrt(2/pi)`.

For a single source of charge `Z`, use `phi_tail=-alpha Z G_s`. If `R>=2a alpha Z/(theta m)`, the tail obeys the dielectric gap condition with a factor two margin. The core is a bounded Fock perturbation because `||rho(x)||<=2d_L`; its norm is at most `16 pi alpha Z d_L R^2`. Consequently, with `d_*=(Lambda/pi+1/L0)^3`, a valid mean-field lower bound is

`-16 pi alpha Z d_* R^2 - 2 C3 b (alpha Z)^2/(theta R)`.

It is uniform in `L>=L0`, but is not sharper than the previously established mean-field electrostatic bound. The splitting is exact and preserves the point source; only the tail is smoothed.

A susceptibility estimate only at zero applied field does not by itself imply a finite-amplitude interacting dielectric inequality. A sufficient response-based assumption would have to control the curvature along the entire applied-potential path, with appropriate treatment of level crossings and the actual charge sector. The determinant route described below avoids needing such an assumption in its stated mass-positive range.

## Independent audit of the stronger photon-free Gaussian-domination route

No fatal gap was found in the following finite-regulator argument, provided the hypotheses and normalization stated here are maintained.

### Exact ordering identity

For `X_A=dGamma(A)-Tr(P_- A)`, Wick contraction gives

`X_A X_B = :X_A X_B: + X_[A(1-P_-)B-BP_-A] + Tr[P_- A(1-P_-)B]`.

After summing the symmetric Coulomb Fourier weights and changing `q` to `-q` in one term, the exact free-Wick-ordered Hamiltonian is

`H0 = C I + dGamma(h_eff) + (alpha/2) D(rho,rho)`,

`h_eff = D0-(alpha/2)K_sign`,

`K_sign = (1/V) sum_(q!=0) (4pi/|q|^2) T_-q sign(D0) T_q`.

Thus the sign and factor one-half in the effective one-body correction are correct. This is an algebraic rewrite, not an added counterterm. The scalar `C` is the same in the vacuum and every source problem.

The effective matrix is diagonal in momentum and has the form `a·v(p)+b M(p)`, without a spin-scalar term. It is traceless in spin. Extending the Coulomb sum to all `0<|q|<=2Lambda` gives `kappa<=26Lambda/pi^2`; hence `M(p)>=m-alpha kappa/2>0` follows from `13alpha Lambda<pi^2 m`.

### Centered fermion trace positivity, including finite kicks

Let `S5=a1 a2 a3 b`. It is a Hermitian unitary, anticommutes with `h_eff`, and commutes with every Hermitian spin-scalar matrix `Phi`. Products `U` of free factors `exp(-dt h_eff)` and scalar unitary kicks `exp(i Phi)` therefore obey `U* S5 U=S5`. Together with the determinant trace formula, this makes the centered CAR trace real. Its centering phase is the explicit exponential from second quantization, not an arbitrarily chosen square-root branch.

A particularly clean proof that this trace never vanishes uses the mass matrix and works directly for instantaneous kicks. Along any free interval,

`d <f,b f>/dt = -<f,(h_eff b+b h_eff)f> = -2<f,M f> < 0`

for every nonzero solution. Each scalar unitary kick preserves `<f,b f>` because it commutes with `b`. Thus `U* b U-b` is strictly negative definite whenever the total free-evolution time is positive. In particular `U` cannot have an eigenvalue of modulus one, and cannot have eigenvalue `-1`. This excludes zeros of `det(1+U)` without a distributional argument for delta-function kicks.

Scaling all kicks continuously to zero then makes the real nonvanishing centered trace strictly positive, since its zero-kick value is positive. The argument also covers a final charge twist `exp(i theta Q)`, which is another centered scalar kick. The physical charge is integral because the free sea has exactly half of the `4M_L` one-particle modes occupied.

### Gaussian domination and charge-sector selection

The positive Coulomb quadratic form must first be written as a sum of squares of Hermitian cosine and sine densities, with the `q,-q` pair kept together. Componentwise Trotter splitting then permits a scalar Hubbard--Stratonovich integral for each square even though the density operators do not commute. A real source shift adds only a unit-modulus phase to that integral. The fermion factor is positive by the preceding argument. The triangle inequality gives domination at every finite Trotter level, and finite-dimensional trace convergence gives the desired partition-function inequality. It is not necessary to exchange a limiting fermion path measure with an integral.

For the source-free twisted partition function, the same positive determinant proves `Z_beta(theta)>=0`. Its exact-charge Fourier coefficients satisfy `Z_beta,q<=Z_beta,0`. Taking the zero-temperature limit therefore proves that the global source-free minimum equals the actual neutral-sector vacuum minimum. This canonical comparison is essential; replacing the neutral vacuum by an unconstrained minimum without proving this fact would leave a gap.

Smooth source Fourier modes beyond the finite density support contribute only a nonnegative scalar square and can be separated before applying the finite-dimensional Gaussian argument.

Finally, combining domination with the exact heat identity gives the audited lower-bound error

`24 pi alpha d_L s Z_tot + (alpha/2)G_(2s)(0) sum_i Z_i^2`.

The first coefficient is `16pi` from the core coupling plus `8pi` from the negative periodic heat-kernel remainder and the capacity constraint `Z_tot<=2d_L V`. For `s=Lambda^(-2)` and `L>=Lambda^(-1)` it is uniform in volume and proportional to the number of bounded-charge nuclei. These statements remain restricted to the specified photon-free model and the positive effective-mass hypothesis.

## Files authored

- `photon-free-relative-stability-paper/free-dielectric.tex`
- `FREE_DIELECTRIC_AGENT_REPORT.md`

No other files were changed for this assignment.

## Additional adversarial audit: finitely many quantized transverse photon modes

The subsequently proposed extension of the Gaussian-domination argument to the full photon Fock space was checked independently. No fatal gap was found under the following explicit implementation and limiting requirements.

1. **Real photon coordinates.** Pair every nonzero momentum with its negative and choose identical real transverse polarization vectors for the pair. A unitary cosine/sine mixing of the two annihilation modes puts the vector potential in the form of a real linear function of oscillator coordinates. This mixing preserves the photon Hamiltonian because the paired frequencies are equal. The basis change is important: in the original traveling-wave quadratures the sine component involves a momentum quadrature. The photon zero mode must remain excluded, so all finitely many oscillator frequencies are strictly positive.

2. **No hidden current-ordering scalar.** For the specified symmetric free sea, the expectation of the projected current coupling is zero. In particular every retained photon mode has nonzero spatial momentum, so its diagonal momentum matrix element vanishes. Thus the normally ordered current interaction is exactly the corresponding second-quantized one-body vector coupling. Multiplying that coupling by a real cutoff in oscillator-coordinate space preserves this fact.

3. **The determinant identities survive arbitrary photon configurations.** If `h(x)=h_eff+g a·A_R(x)`, then `{S5,h(x)}=0` and `b h(x)+h(x)b=2M>0` for every coordinate configuration. The vector potential need not commute with `M`; the Dirac anticommutation relations are sufficient. Along a path with varying coordinates, each real-vector Dirac evolution strictly decreases the `b` form, and every scalar Hubbard--Stratonovich kick preserves it. The earlier real/nonvanishing/connected-sign argument therefore still proves positive centered fermion traces, including a final exact-charge twist.

4. **Mehler positivity and trace convergence.** At a fixed coordinate cutoff, the photon-dependent fermion matrix potential is bounded. The oscillator heat kernel is a positive Mehler kernel. Finite Trotter traces can consequently be written as integrals over oscillator loops and scalar Hubbard--Stratonovich variables, with the positive centered fermion trace as their fermionic factor. The source contributes only a phase, giving the same domination inequality. One must invoke trace convergence here, not merely strong Trotter convergence. It follows from bounded-matrix-potential semigroup approximation with the trace-class oscillator heat kernel, for example through a Dyson expansion or the dominated matrix-valued Feynman--Kac representation. The scalar-kick matrices are unitary, so their norm bounds are independent of the Gaussian integration variables.

5. **Removal of the coordinate cutoff.** Choose `0<=chi_R<=1`, equal to one on `|x|<=R`. At each fixed physical regulator the current matrices are bounded, and

   `|H_I-H_I,R| <= C |x|^2/R <= epsilon_R (H_osc+c0)`, with `epsilon_R -> 0`.

   Both the original and truncated Hamiltonians obey `H,H_R >= H_osc/2-C`, uniformly in the coordinate cutoff. These inequalities imply comparisons of the form

   `H >= (1-2epsilon_R) H_R-O(epsilon_R)` and the reverse comparison.

   Taking infima in each exact-charge sector proves convergence of the sector ground energies. This is sufficient to pass both the source comparison and the selection of the neutral vacuum sector to the untruncated current interaction. Convergence is needed separately at each fixed box and cutoff; it need not be uniform in the infrared regulator for the already uniform final stability inequality to persist.

6. **What the extension would and would not establish.** The mass-positive hypothesis on `h_eff` is unchanged. The domination concerns energies relative to the actual interacting vacuum, including its photon contribution. It therefore does not contradict the previously constructed `-c L^5` absolute vacuum-energy upper bound for the same gauge-noncovariant sharp-cutoff model. It gives no ultraviolet limit, physical renormalization prescription, or absolute vacuum extensivity.

The completed `photon-extension.tex` was subsequently read end to end. Its improved many-nucleus coefficient `20pi` is valid and supersedes the earlier sufficient `24pi` estimate above. It splits the positive density-square kernel itself into `G_short+G_long`, retains the original effective Dirac operator and Wick scalar, and shifts only the long-range squares. The short core costs `16pi`, and the short nuclear remainder costs `4pi`; the long nuclear cross terms cancel the full smooth source square except for the individual diagonals. The omitted high Fourier tail is nonnegative. Its explicit scalar `C_L=-Tr(D0 P)-alpha Ex(P)/2` agrees with direct Wick contraction. The canonical projection plus the triangle inequality directly proves the source-sector partition bound against the neutral vacuum partition function. The source's Schatten-Hölder/Dyson proof of trace-norm Trotter convergence and its coordinate-cutoff removal were also checked without finding an error.
