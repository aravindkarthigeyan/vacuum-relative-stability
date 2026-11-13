# Mathlib API reference for proof workers

Lean v4.35.0, Mathlib at commit 56a005855ea1. Every row below was elaborated with `#check @Name`
(or an `example`) unless the "Verified" column says otherwise. `open Matrix` makes short names
resolve. Matrices are `Matrix n n ℂ` with `[Fintype n] [DecidableEq n]`. `exp` is `NormedSpace.exp`
(no field argument). `#check` output often shows `Matrix.` and `NormedSpace.` prefixes stripped
because of `open`.

Instance idiom for norms on matrices. It is needed ONLY for analysis lemmas on the matrix itself
(continuity of exp, derivatives of `exp (t • A)`, `SemiconjBy.exp_right`), NOT for the algebraic
`Matrix.exp_*` lemmas, which only need a `NormedRing` on the entry type:

```lean
import Mathlib.Analysis.Matrix.Normed   -- Matrix.linftyOpNormedRing / linftyOpNormedAlgebra
attribute [local instance] Matrix.linftyOpNormedRing Matrix.linftyOpNormedAlgebra
-- Frobenius alternative (also local-only): Matrix.frobeniusNormedRing / frobeniusNormedAlgebra.
```
Verified: with these two local instances, `NormedSpace.exp_continuous`, `hasDerivAt_exp_smul_const`
(with 𝕂 = ℝ and with 𝕂 = ℂ) and `SemiconjBy.exp_right` elaborate for `Matrix n n ℂ`.

## A. Matrix exponential

Imports: `Mathlib.Analysis.Normed.Algebra.MatrixExponential` (Matrix.exp_*),
`Mathlib.Analysis.Normed.Algebra.Exponential` (NormedSpace.exp_*),
`Mathlib.Analysis.SpecialFunctions.Exponential` (derivatives).

| Name | Signature (abridged) | Module | Verified | Note |
|---|---|---|---|---|
| `Matrix.exp_conjTranspose` | `[Ring 𝔸] [TopologicalSpace 𝔸] [IsTopologicalRing 𝔸] [T2Space 𝔸] [StarRing 𝔸] [ContinuousStar 𝔸] (A : Matrix m m 𝔸) : exp Aᴴ = (exp A)ᴴ` | Analysis.Normed.Algebra.MatrixExponential | yes | no norm needed |
| `NormedSpace.star_exp` | `[StarRing 𝔸] [ContinuousStar 𝔸] (x : 𝔸) : star (exp x) = exp (star x)` | Analysis.Normed.Algebra.Exponential | yes | `star = ᴴ` on matrices |
| `Matrix.exp_neg` | `[NormedCommRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸] (A : Matrix m m 𝔸) : exp (-A) = (exp A)⁻¹` | MatrixExponential | yes | `⁻¹` is the matrix inverse; 𝔸 = ℂ fine |
| `Matrix.isUnit_exp` | `[NormedRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸] (A) : IsUnit (exp A)` | MatrixExponential | yes | |
| `Matrix.exp_add_of_commute` | `(A B : Matrix m m 𝔸) : Commute A B → exp (A + B) = exp A * exp B` | MatrixExponential | yes | explicit `A B`; also `NormedSpace.exp_add_of_commute {x y}` |
| `Matrix.exp_sum_of_commute` | `(s : Finset ι) (f : ι → Matrix m m 𝔸) (h : (↑s).Pairwise (Commute on f)) : exp (∑ i ∈ s, f i) = s.noncommProd (fun i => exp (f i)) ⋯` | MatrixExponential | yes | `noncommProd`, not `∏` |
| `Matrix.exp_conj` | `[NormedCommRing 𝔸] (U A : Matrix m m 𝔸) : IsUnit U → exp (U * A * U⁻¹) = U * exp A * U⁻¹` | MatrixExponential | yes | |
| `Matrix.exp_units_conj` | `(U : (Matrix m m 𝔸)ˣ) (A) : exp (↑U * A * ↑U⁻¹) = ↑U * exp A * ↑U⁻¹` | MatrixExponential | yes | also `NormedSpace.exp_units_conj`, `NormedSpace.exp_conj` (division rings) |
| `Matrix.exp_diagonal` | `(v : m → 𝔸) : exp (diagonal v) = diagonal (exp v)` | MatrixExponential | yes | RHS is the Pi-exp, i.e. entrywise exp; for ℂ use `Complex.exp_eq_exp_ℂ : Complex.exp = NormedSpace.exp` (SpecialFunctions.Exponential; not `#check`ed). Also `Matrix.exp_blockDiagonal`, `Matrix.exp_transpose` |
| `NormedSpace.algebraMap_exp_comm` | `[NontriviallyNormedField 𝕂] [CharZero 𝕂] [CompleteSpace 𝕂] [NormedRing 𝔸] [NormedAlgebra 𝕂 𝔸] (x : 𝕂) : algebraMap 𝕂 𝔸 (exp x) = exp (algebraMap 𝕂 𝔸 x)` | Analysis.Normed.Algebra.Exponential | yes | scalar matrix: with `Algebra.algebraMap_eq_smul_one`, `exp (c • (1 : Matrix n n ℂ)) = exp c • 1`. Verified by example: `have := NormedSpace.algebraMap_exp_comm (𝕂 := ℂ) (𝔸 := Matrix n n ℂ) c; rw [Algebra.algebraMap_eq_smul_one, Algebra.algebraMap_eq_smul_one] at this; exact this.symm` (needs local linfty instances) |
| `NormedSpace.exp_smul` | `[Monoid G] [MulSemiringAction G 𝔸] [ContinuousConstSMul G 𝔸] (g : G) (x) : exp (g • x) = g • exp x` | Exponential | yes | group-action version, NOT scalar-in-exponent |
| `NormedSpace.exp_nsmul` | `(n : ℕ) (x) : exp (n • x) = exp x ^ n` | Exponential | yes | |
| `SemiconjBy.exp_right` | `[NormedRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸] {x a b} : SemiconjBy x a b → SemiconjBy x (exp a) (exp b)` | Exponential | yes | `SemiconjBy x a b` is `x * a = b * x`. Verified: `example (C X Y : Matrix n n ℂ) (h : C * X = Y * C) : C * exp X = exp Y * C := SemiconjBy.exp_right (show SemiconjBy C X Y from h)` (local linfty instances) |
| `SemiconjBy.exp_neg_mul_mul_exp_eq_self` | `SemiconjBy x a b → exp (-b) * x * exp a = x` | Exponential | yes | |
| `Commute.exp_right` | `[Ring 𝔸] [TopologicalSpace 𝔸] [IsTopologicalRing 𝔸] [T2Space 𝔸] : Commute x y → Commute x (exp y)` | Exponential | yes | |
| `NormedSpace.exp_zero` | `exp 0 = 1` | Exponential | yes | |
| `NormedSpace.exp_continuous` | `[NormedRing 𝔸] [NormedAlgebra ℚ 𝔸] [CompleteSpace 𝔸] : Continuous (exp : 𝔸 → 𝔸)` | Exponential | yes | for matrices needs local linfty instances (verified) |
| `hasDerivAt_exp_smul_const` | `[RCLike 𝕂] [NormedRing 𝔸] [NormedAlgebra 𝕂 𝔸] [CompleteSpace 𝔸] (x : 𝔸) (t : 𝕂) : HasDerivAt (fun u : 𝕂 => exp (u • x)) (exp (t • x) * x) t` | Analysis.SpecialFunctions.Exponential | yes | ROOT namespace (not `NormedSpace.`). 𝕂 is implicit: write `(𝕂 := ℝ)`. Verified with t : ℝ and 𝔸 = `Matrix n n ℂ` (ℝ-algebra via `linftyOpNormedAlgebra`), and with 𝕂 = ℂ |
| `hasDerivAt_exp_smul_const'` | same, derivative `x * exp (t • x)` | same | yes | |
| `differentiable_exp_smul_const` | `(𝕂) (x : 𝔸) : Differentiable 𝕂 (fun t : 𝕂 => exp (t • x))` | same | yes | 𝕂 explicit here. Also `hasStrictDerivAt_exp_smul_const`, `hasFDerivAt_exp_smul_const` (not `#check`ed) |
| `NormedSpace.exp_eq_tsum` | `(𝕂) : exp = fun x => ∑' n, ((n !)⁻¹ : 𝕂) • x ^ n` | Exponential | yes | |

## B. Hermitian, spectral theorem, positivity

Imports: `Mathlib.Analysis.Matrix.Spectrum`, `Mathlib.Analysis.Matrix.Order` (PosSemidef.kronecker),
`Mathlib.LinearAlgebra.Matrix.PosDef`. Here `A : Matrix n n 𝕜`, `[RCLike 𝕜]`, `hA : A.IsHermitian`.

| Name | Signature (abridged) | Module | Verified | Note |
|---|---|---|---|---|
| `Matrix.IsHermitian.spectral_theorem` | `hA : A.IsHermitian → A = (Unitary.conjStarAlgAut 𝕜 (Matrix n n 𝕜) hA.eigenvectorUnitary) (diagonal (RCLike.ofReal ∘ hA.eigenvalues))` | Analysis.Matrix.Spectrum | yes | unfold with `Unitary.conjStarAlgAut_apply : conjStarAlgAut S R u x = ↑u * x * star ↑u`, so `A = U * diagonal (↑∘λ) * star U`. Also `IsHermitian.conjStarAlgAut_star_eigenvectorUnitary : conjStarAlgAut (star U) A = diagonal (ofReal ∘ eigenvalues)` |
| `Matrix.IsHermitian.eigenvalues` | `hA : A.IsHermitian → n → ℝ` (needs `[DecidableEq n]`) | Spectrum | yes | real-valued |
| `Matrix.IsHermitian.eigenvectorUnitary` | `hA → ↥(Matrix.unitaryGroup n 𝕜)` | Spectrum | yes | `eigenvectorUnitary_coe`, `eigenvectorUnitary_apply : ↑U i j = (hA.eigenvectorBasis j).ofLp i`, `eigenvectorUnitary_mulVec`, `star_eigenvectorUnitary_mulVec` |
| `Matrix.IsHermitian.eigenvectorBasis` | `hA → OrthonormalBasis n 𝕜 (EuclideanSpace 𝕜 n)` | Spectrum | yes | |
| `Matrix.IsHermitian.mulVec_eigenvectorBasis` | `(j) : A *ᵥ (hA.eigenvectorBasis j).ofLp = hA.eigenvalues j • (hA.eigenvectorBasis j).ofLp` | Spectrum | yes | |
| `Matrix.IsHermitian.eigenvalues_eq` | `(i) : hA.eigenvalues i = RCLike.re (star (hA.eigenvectorBasis i).ofLp ⬝ᵥ A *ᵥ (hA.eigenvectorBasis i).ofLp)` | Spectrum | yes | |
| `Matrix.IsHermitian.det_eq_prod_eigenvalues` | `A.det = ∏ i, ↑(hA.eigenvalues i)` | Spectrum | yes | |
| `Matrix.IsHermitian.trace_eq_sum_eigenvalues` | `A.trace = ∑ i, ↑(hA.eigenvalues i)` | Spectrum | yes | the route to "trace of a Hermitian matrix is real" |
| `Matrix.IsHermitian.charpoly_eq` | `A.charpoly = ∏ i, (X - C ↑(hA.eigenvalues i))` | Spectrum | yes | |
| `Matrix.IsHermitian.roots_charpoly_eq_eigenvalues` | `A.charpoly.roots = Multiset.map (RCLike.ofReal ∘ hA.eigenvalues) Finset.univ.val` | Spectrum | yes | also `splits_charpoly : A.charpoly.Splits`, `eigenvalues_mem_spectrum_real`, `spectrum_real_eq_range_eigenvalues`, `eigenvalues_eq_zero_iff` |
| `Matrix.trace_conjTranspose` | `[StarAddMonoid R] (A) : Aᴴ.trace = star A.trace` | LinearAlgebra.Matrix.Trace | yes | with `hA.eq : Aᴴ = A` gives `star A.trace = A.trace` |
| `Matrix.IsHermitian.im_star_dotProduct_mulVec_self` | `hA → ∀ x, RCLike.im (star x ⬝ᵥ A *ᵥ x) = 0` | Analysis.Matrix.* | yes | the quadratic form is written `star x ⬝ᵥ A *ᵥ x` (i.e. `star x ⬝ᵥ (A *ᵥ x)`); it is real for Hermitian A |
| `Matrix.IsHermitian.eq`, `.add`, `.neg`, `.sub`, `.smul`, `.conjTranspose`, `.transpose` | `.smul : hA → IsSelfAdjoint k → (k • A).IsHermitian`; `.eq : Aᴴ = A` | LinearAlgebra.Matrix.Hermitian | yes for add, smul, conjTranspose; others from source | `Matrix.isHermitian_diagonal`, `isHermitian_zero` |
| `Matrix.PosSemidef` | `Matrix.PosSemidef (M : Matrix n n R)` (`[Ring R] [PartialOrder R] [StarRing R]`) | LinearAlgebra.Matrix.PosDef | yes | |
| `Matrix.posSemidef_iff_dotProduct_mulVec` | `M.PosSemidef ↔ M.IsHermitian ∧ ∀ x, 0 ≤ star x ⬝ᵥ M *ᵥ x` | PosDef | yes | `PosSemidef.of_dotProduct_mulVec_nonneg : IsHermitian → (∀ x, 0 ≤ star x ⬝ᵥ M *ᵥ x) → PosSemidef` |
| `Matrix.PosSemidef.dotProduct_mulVec_nonneg` | `M.PosSemidef → ∀ x, 0 ≤ star x ⬝ᵥ M *ᵥ x` | PosDef | yes | |
| `Matrix.PosSemidef.re_dotProduct_nonneg` | `[RCLike 𝕜] A.PosSemidef → ∀ x, 0 ≤ RCLike.re (star x ⬝ᵥ A *ᵥ x)` | PosDef | yes | |
| `Matrix.PosSemidef.add` | `A.PosSemidef → B.PosSemidef → (A + B).PosSemidef` | PosDef | yes | `.smul : x.PosSemidef → 0 ≤ a → (a • x).PosSemidef`, `.one`, `.pow`, `.isHermitian`, `.trace_nonneg` all verified |
| `Matrix.PosSemidef.kronecker` | `[RCLike 𝕜] [Finite n] [Finite m] : x.PosSemidef → y.PosSemidef → (x ⊗ₖ y).PosSemidef` | Analysis.Matrix.Order | yes | needs `import Mathlib.Analysis.Matrix.Order`. With `PosSemidef.one` this covers `1 ⊗ₖ A` and `A ⊗ₖ 1`. Also `PosDef.kronecker` |
| `Matrix.posSemidef_conjTranspose_mul_self` | `(A : Matrix m n R) : (Aᴴ * A).PosSemidef` | PosDef | yes | `PosSemidef.conjTranspose_mul_mul_same : A.PosSemidef → ∀ B, (Bᴴ * A * B).PosSemidef`, `mul_mul_conjTranspose_same` |
| `Matrix.PosSemidef.det_nonneg` | `[RCLike 𝕜] A.PosSemidef → 0 ≤ A.det` | PosDef/Order | yes | |
| `Matrix.PosSemidef.eigenvalues_nonneg` | `(hA : A.PosSemidef) (i) : 0 ≤ hA.isHermitian.eigenvalues i` | Spectrum | yes | |
| `Matrix.PosDef.det_pos` | `[CommRing R'] [PartialOrder R'] [StarRing R'] [Nontrivial R'] [IsOrderedRing R'] [PosMulReflectLT R'] A.PosDef → 0 < A.det` | PosDef | yes | also `PosDef.posSemidef`, `PosDef.dotProduct_mulVec_pos`, `posDef_iff_dotProduct_mulVec`, `PosDef.eigenvalues_pos`, `PosSemidef.posDef_iff_isUnit` |
| `Matrix.dotProduct_mulVec` | `v ⬝ᵥ A *ᵥ w = v ᵥ* A ⬝ᵥ w` | Matrix.Vec | yes | `Matrix.star_mulVec : star (M *ᵥ v) = star v ᵥ* Mᴴ`, `Matrix.mulVec_conjTranspose` |

## C. Determinant, charpoly, roots

| Name | Signature (abridged) | Module | Verified | Note |
|---|---|---|---|---|
| `Matrix.det_conjTranspose` | `[CommRing R] [StarRing R] (M) : Mᴴ.det = star M.det` | LinearAlgebra.Matrix.Determinant | yes | |
| `Matrix.det_mul` | `(M N) : (M * N).det = M.det * N.det` | same | yes | |
| `Matrix.det_one_add_smul` | `[CommRing R] (r : R) (M) : (1 + r • M).det = 1 + M.trace * r + eval r (1 + X • M.map C).det.divX.divX * r ^ 2` | Matrix.Charpoly/Determinant | yes | only a first-order expansion; no product formula (see Gaps) |
| `Matrix.charpolyRev` | `Matrix.charpolyRev (M) : R[X]`, defined as `det (1 - (X : R[X]) • M.map C)` | Charpoly.Coeff | yes | `eval_charpolyRev : eval 0 M.charpolyRev = 1`, `coeff_charpolyRev_eq_neg_trace : coeff 1 = -trace`, `isUnit_charpolyRev_of_isNilpotent` |
| `Matrix.reverse_charpoly` | `M.charpoly.reverse = M.charpolyRev` | Charpoly.Coeff | yes | |
| `Matrix.charpoly_inv` | `IsUnit A → A⁻¹.charpoly = (-1) ^ Fintype.card n * C (Ring.inverse A.det) * A.charpolyRev` | Charpoly.Coeff | yes | |
| `Matrix.charpoly_map` | `(M : Matrix n n R) (f : R →+* S) : (M.map f).charpoly = Polynomial.map f M.charpoly` | Charpoly.Basic/Univ | yes | |
| `Matrix.charpoly_transpose` | `Mᵀ.charpoly = M.charpoly` | Charpoly.Basic | yes | |
| `Matrix.charpoly_units_conj` | `(M : (Matrix n n R)ˣ) (N) : (↑M * N * (↑M)⁻¹).charpoly = N.charpoly` | Charpoly.Basic | yes | |
| `Matrix.charpoly_mul_comm` | `(A B) : (A * B).charpoly = (B * A).charpoly` | Charpoly.Basic | yes | handles conjugation by non-units too |
| `Matrix.charpoly_reindex`, `Matrix.charpoly_toLin'`, `LinearMap.charpoly_toMatrix` | as named | Charpoly.* | yes | |
| `Matrix.charpoly_monic` | `M.charpoly.Monic` | Charpoly.Coeff | yes | |
| `Matrix.charpoly_natDegree_eq_dim` | `[Nontrivial R] M.charpoly.natDegree = Fintype.card n` | Charpoly.Coeff | yes | |
| `Matrix.det_eq_sign_charpoly_coeff` | `M.det = (-1) ^ Fintype.card n * M.charpoly.coeff 0` | Charpoly.Coeff | yes | |
| `Matrix.eval_charpoly` | `(M) (t) : eval t M.charpoly = (scalar m t - M).det` | Charpoly.Basic | yes | |
| `Matrix.mem_spectrum_iff_isRoot_charpoly` | `[Field K] {r} : r ∈ spectrum K A ↔ A.charpoly.IsRoot r` | Charpoly.Eigs | yes | |
| `Matrix.det_eq_prod_roots_charpoly` | `(A : Matrix n n K) [IsAlgClosed K] : A.det = A.charpoly.roots.prod` | Charpoly.Eigs | yes | |
| `Matrix.trace_eq_sum_roots_charpoly` | `[IsAlgClosed K] : A.trace = A.charpoly.roots.sum` | Charpoly.Eigs | yes | `det_eq_prod_roots_charpoly_of_splits` / `trace_eq_sum_roots_charpoly_of_splits` take `B.charpoly.Splits`, `[IsDomain R]` |
| `Matrix.exists_mulVec_eq_zero_iff` | `[IsDomain A] {M} : (∃ v, v ≠ 0 ∧ M *ᵥ v = 0) ↔ M.det = 0` | Determinant | yes | |
| root of charpoly to eigenvector | no single lemma | | yes, by example | For `A : Matrix n n ℂ`, `h : A.charpoly.IsRoot r`: `have h1 : ((scalar n) r - A).det = 0 := by rw [← Matrix.eval_charpoly]; exact h`; `obtain ⟨v, hv, hv0⟩ := Matrix.exists_mulVec_eq_zero_iff.mpr h1`; `rw [Matrix.sub_mulVec] at hv0`; `simpa [Matrix.scalar_apply, Matrix.smul_eq_diagonal_mul, sub_eq_zero, eq_comm] using hv0` closes `A *ᵥ v = r • v` (compiled) |
| `Module.End.hasEigenvalue_iff_isRoot` | `[IsDomain R] [Module.Finite R M] [Module.IsTorsionFree R M] : f.HasEigenvalue μ ↔ (minpoly R f).IsRoot μ` | LinearAlgebra.Eigenspace.Minpoly | yes | minpoly, not charpoly. Also verified: `hasEigenvalue_of_isRoot`, `Module.End.hasEigenvalue_iff_mem_spectrum` (field, finite-dim), `HasEigenvalue.exists_hasEigenvector`, `hasEigenvector_iff : ↔ x ∈ eigenspace μ ∧ x ≠ 0`, `mem_eigenspace_iff : ↔ f x = μ • x`; `Matrix.toLin'_apply : toLin' M v = M *ᵥ v` |
| `Matrix.isUnit_iff_isUnit_det`, `Matrix.mulVec_injective_iff_isUnit` | as named | Matrix.Determinant/Nondegenerate | yes | |
| `Polynomial.reverse_mul_of_domain` | `[Semiring R] [NoZeroDivisors R] (f g) : (f * g).reverse = f.reverse * g.reverse` | Algebra.Polynomial.Reverse | yes | `reverse_mul` needs `leadingCoeff` product nonzero |
| `Polynomial.reverse_add_C`, `reverse_C`, `reverse_X_mul`, `reverse_mul_X` | e.g. `(p + C t).reverse = p.reverse + C t * X ^ p.natDegree` | Reverse | yes (`reverse_neg` from source) | `(X - C a).reverse = 1 - C a * X` has no named lemma; `rw [sub_eq_add_neg, ← C_neg, reverse_add_C]` leaves `X.reverse = 1`, which `simp` did not close (use `reverse_X_mul` on `X * 1`) |
| `Polynomial.coeff_reverse`, `reverse_natDegree`, `reverse_leadingCoeff`, `reflect_mul`, `eval₂_reverse_eq_zero_iff` | `eval₂ i (⅟x) f.reverse = 0 ↔ eval₂ i x f = 0` | Reverse | yes | root correspondence reverse polynomial <-> inverses of roots (needs `Invertible x`) |
| `Polynomial.Splits` | `Splits (f : R[X]) : Prop`, a unary predicate (`f ∈ Submonoid.closure ...`); NEW API, no ring-hom argument | Algebra.Polynomial.Splits | yes | `Splits.map f i`, `Splits.eq_prod_roots_of_monic : f = (map (X - C ·) f.roots).prod`, `Splits.eq_prod_roots`, `Splits.natDegree_eq_card_roots : f.natDegree = f.roots.card`, `Splits.eval_eq_prod_roots_of_monic` |
| `Polynomial.splits_iff_card_roots` | `[IsDomain R] : f.Splits ↔ f.roots.card = f.natDegree` | Splits | yes | |
| `IsAlgClosed.splits` | `[IsAlgClosed k] (p : k[X]) : p.Splits` | FieldTheory.IsAlgClosed.Basic | yes | |
| `Polynomial.prod_multiset_X_sub_C_of_monic_of_roots_card_eq` | `p.Monic → p.roots.card = p.natDegree → (map (X - C ·) p.roots).prod = p` | Roots | yes | |
| `Polynomial.Splits.roots_map_of_injective` | `f.Splits → Function.Injective i → (map i f).roots = Multiset.map i f.roots` | Splits | yes | NO `Polynomial.roots_map` exists. Others verified: `Splits.roots_map_of_ne_zero (map φ f ≠ 0)`, `Monic.roots_map_of_card_eq_natDegree`, `roots_map_of_injective_of_card_eq_natDegree`, `mem_roots_map : p ≠ 0 → (x ∈ (map f p).roots ↔ eval₂ f x p = 0)` (Field R) |
| `Polynomial.roots_multiset_prod_X_sub_C`, `roots_prod_X_sub_C`, `roots_X_sub_C`, `roots_mul`, `roots_C_mul` | `(map (X - C ·) s).prod.roots = s`; `p * q ≠ 0 → (p*q).roots = p.roots + q.roots`; `a ≠ 0 → (C a * p).roots = p.roots` | Roots | yes | |

## D. Kronecker

`open scoped Kronecker`; `A ⊗ₖ B` is `kroneckerMap (· * ·) A B` (that is how `#check` prints it).
Module: `Mathlib.LinearAlgebra.Matrix.Kronecker`.

| Name | Signature | Verified | Note |
|---|---|---|---|
| `Matrix.mul_kronecker_mul` | `[Fintype m] [Fintype m'] [CommSemiring α] (A : Matrix l m α) (B : Matrix m n α) (A' : Matrix l' m' α) (B' : Matrix m' n' α) : (A * B) ⊗ₖ (A' * B') = (A ⊗ₖ A') * (B ⊗ₖ B')` | yes | |
| `Matrix.kronecker_add` / `Matrix.add_kronecker` | `[Distrib α] A ⊗ₖ (B₁ + B₂) = A ⊗ₖ B₁ + A ⊗ₖ B₂` / `(A₁ + A₂) ⊗ₖ B = ...` | yes | also `zero_kronecker`, `kronecker_zero` |
| `Matrix.smul_kronecker` / `Matrix.kronecker_smul` | `(r : R) : (r • A) ⊗ₖ B = r • (A ⊗ₖ B)` / `A ⊗ₖ (r • B) = r • (A ⊗ₖ B)` | yes | `[IsScalarTower R α α]` / `[SMulCommClass R α α]` |
| `Matrix.one_kronecker_one` | `[MulZeroOneClass α] [DecidableEq m] [DecidableEq n] : (1 : Matrix m m α) ⊗ₖ (1 : Matrix n n α) = 1` | yes | `one_kronecker`, `kronecker_one` give blockDiagonal forms (with reindex for `one_kronecker`) |
| `Matrix.conjTranspose_kronecker` | `[CommMagma R] [StarMul R] (x : Matrix l m R) (y : Matrix n p R) : (x ⊗ₖ y)ᴴ = xᴴ ⊗ₖ yᴴ` | yes | |
| `Matrix.trace_kronecker` | `[Fintype m] [Fintype n] [Semiring α] : (A ⊗ₖ B).trace = A.trace * B.trace` | yes | |
| `Matrix.det_kronecker` | `[CommRing R] : (A ⊗ₖ B).det = A.det ^ Fintype.card n * B.det ^ Fintype.card m` | yes | |
| `Matrix.kronecker_apply` | `(A ⊗ₖ B) (i₁, i₂) (j₁, j₂) = A i₁ j₁ * B i₂ j₂` | yes | |
| `Matrix.PosSemidef.kronecker` | see B | yes | |
| `Matrix.IsHermitian.kronecker` | NOT FOUND | -- | derive from `conjTranspose_kronecker` + `.eq` |
| Kronecker with `Finset.sum` | NOT FOUND | -- | substitute `kroneckerMap_add_left/right` + induction, or `Matrix.kroneckerMapBilinear` (bilinear, so `map_sum` applies) |

## E. Multisets and symmetric polynomials

| Name | Signature | Module | Verified |
|---|---|---|---|
| `Multiset.filter_map` | `(p) [DecidablePred p] (f) (s) : filter p (map f s) = map f (filter (p ∘ f) s)` | Data.Multiset.Filter | yes |
| `Multiset.filter_add_not` | `(p) (s) : filter p s + filter (fun a => ¬p a) s = s` | same | yes |
| `Multiset.filter_eq_self` | `filter p s = s ↔ ∀ a ∈ s, p a` | same | yes |
| `Multiset.card_map` | `(f) (s) : (map f s).card = s.card` | Data.Multiset.* | yes |
| `Multiset.card_add` | `(s t) : (s + t).card = s.card + t.card` | same | yes |
| `Multiset.map_map` | `(g) (f) (s) : map g (map f s) = map (g ∘ f) s` | same | yes |
| `Multiset.map_congr` | `{f g} {s t} : s = t → (∀ x ∈ t, f x = g x) → map f s = map g t` | same | yes |
| `Multiset.prod_map_mul` | `[CommMonoid M] : (map (fun i => f i * g i) m).prod = (map f m).prod * (map g m).prod` | Algebra.BigOperators.Group.Multiset | yes |
| `Multiset.prod_map_neg` | `(s) : (map Neg.neg s).prod = (-1) ^ s.card * s.prod` | same | yes |
| `Multiset.prod_map_pow` | `(map (fun i => f i ^ n) m).prod = (map f m).prod ^ n` | same | yes |
| `Multiset.prod_map_one`, `Multiset.sum_map_mul_left` | `(map (fun _ => 1) m).prod = 1`; `(map (fun i => a * f i) s).sum = a * (map f s).sum` | same | yes |
| `Multiset.esymm` | `Multiset.esymm (s : Multiset R) (n : ℕ) : R` | RingTheory.MvPolynomial.Symmetric.Defs | yes |
| `Multiset.prod_X_add_C_eq_sum_esymm` | `(s : Multiset R) : (map (X + C ·) s).prod = ∑ j ∈ range (s.card + 1), C (s.esymm j) * X ^ (s.card - j)` | RingTheory.Polynomial.Vieta | yes |
| `Multiset.prod_X_sub_X_eq_sum_esymm` | `(map (X - C ·) s).prod = ∑ j ∈ range (s.card+1), (-1)^j * (C (s.esymm j) * X ^ (s.card - j))` | Vieta | yes (note the name: `..._X_sub_X_...`) |
| `Multiset.prod_X_sub_C_coeff` | `k ≤ s.card → (map (X - C ·) s).prod.coeff k = (-1) ^ (s.card - k) * s.esymm (s.card - k)` | Vieta | yes |
| `Finset.esymm_map_val` | `(f : σ → R) (s : Finset σ) (n) : (map f s.val).esymm n = ∑ t ∈ powersetCard n s, t.prod f` | Vieta / Symmetric.Defs | yes |

## F. Integrals

| Name | Signature | Module | Verified | Note |
|---|---|---|---|---|
| `integral_exp_mul_complex` | `{a b : ℝ} {c : ℂ} (hc : c ≠ 0) : ∫ x in a..b, Complex.exp (c * ↑x) = (Complex.exp (c * ↑b) - Complex.exp (c * ↑a)) / c` | Analysis.SpecialFunctions.Integrals.Basic | yes | ROOT namespace |
| `intervalIntegral.integral_finset_sum` | `(∀ i ∈ s, IntervalIntegrable (f i) μ a b) → ∫ x in a..b, ∑ i ∈ s, f i x ∂μ = ∑ i ∈ s, ∫ x in a..b, f i x ∂μ` | Integral.* | yes (deprecated) | works with a deprecation warning; the replacement name is `intervalIntegral.integral_finsetSum` (named in the warning, not separately `#check`ed) |
| `intervalIntegral.integral_const_mul` | `[NormedDivisionRing 𝕜] [NormedAlgebra ℝ 𝕜] (r : 𝕜) (f : ℝ → 𝕜) : ∫ x in a..b, r * f x ∂μ = r * ∫ ...` | yes | works for 𝕜 = ℂ |
| `intervalIntegral.integral_smul`, `integral_add`, `integral_sub` | `integral_add : IntervalIntegrable f μ a b → IntervalIntegrable g μ a b → ∫ f + g = ∫ f + ∫ g` | yes | |
| `Continuous.intervalIntegrable` | `Continuous u → ∀ a b, IntervalIntegrable u μ a b` | yes | `ContinuousOn.intervalIntegrable : ContinuousOn u (uIcc a b) → ...` |
| `intervalIntegral.integral_eq_sub_of_hasDerivAt` | `(∀ x ∈ uIcc a b, HasDerivAt f (f' x) x) → IntervalIntegrable f' volume a b → ∫ f' = f b - f a` | yes | FTC; `integral_hasDerivAt_right` also verified |

## G. Real analysis

| Name | Signature (abridged) | Module | Verified | Note |
|---|---|---|---|---|
| `antitoneOn_of_deriv_nonpos` | `Convex ℝ D → ContinuousOn f D → DifferentiableOn ℝ f (interior D) → (∀ x ∈ interior D, deriv f x ≤ 0) → AntitoneOn f D` | Analysis.Calculus.Deriv.MeanValue | yes | |
| `strictAntiOn_of_deriv_neg` | `Convex ℝ D → ContinuousOn f D → (∀ x ∈ interior D, deriv f x < 0) → StrictAntiOn f D` | same | yes | |
| `image_le_of_deriv_right_le_deriv_boundary` | `ContinuousOn f (Icc a b) → (∀ x ∈ Ico a b, HasDerivWithinAt f (f' x) (Ici x) x) → f a ≤ B a → ContinuousOn B (Icc a b) → (∀ x ∈ Ico a b, HasDerivWithinAt B (B' x) (Ici x) x) → (∀ x ∈ Ico a b, f' x ≤ B' x) → ∀ ⦃x⦄, x ∈ Icc a b → f x ≤ B x` | Analysis.Calculus.MeanValue | yes | `image_norm_le_of_norm_deriv_right_le_deriv_boundary` is the vector-valued version (B differentiable everywhere) |
| `norm_le_gronwallBound_of_norm_deriv_right_le` | `ContinuousOn f (Icc a b) → (∀ x ∈ Ico a b, HasDerivWithinAt f (f' x) (Ici x) x) → ‖f a‖ ≤ δ → (∀ x ∈ Ico a b, ‖f' x‖ ≤ K * ‖f x‖ + ε) → ∀ x ∈ Icc a b, ‖f x‖ ≤ gronwallBound δ K ε (x - a)` | Analysis.ODE.Gronwall | yes | `gronwallBound : ℝ → ℝ → ℝ → ℝ → ℝ` |
| `le_gronwallBound_of_liminf_deriv_right_le` | real-valued, liminf hypothesis on `f'` | same | yes | `dist_le_of_approx_trajectories_ODE` also verified |
| `HasDerivAt.mul` | `[NormedRing 𝔸] [NormedAlgebra 𝕜 𝔸] : HasDerivAt c c' x → HasDerivAt d d' x → HasDerivAt (c * d) (c' * d x + c x * d') x` | Analysis.Calculus.Deriv.Mul | yes | noncommutative OK, so it applies to matrix-valued functions given the local linfty normed algebra; `mul_const`, `const_mul`, `smul`, `const_smul` verified |
| `HasDerivAt.sum` / `HasDerivAt.fun_sum` | `(∀ i ∈ u, HasDerivAt (A i) (A' i) x) → HasDerivAt (∑ i ∈ u, A i) (∑ i ∈ u, A' i) x` (`fun_sum`: `fun y => ∑ i ∈ u, A i y`) | Analysis.Calculus.Deriv.Add | yes | `HasDerivAt.finset_sum` does NOT exist |
| `HasDerivAt.add`, `.neg`, `.congr_deriv`, `.deriv`, `.differentiableAt`, `.continuousAt`, `.hasDerivWithinAt` | standard | | yes | |
| `HasDerivAt.star` | `[TrivialStar 𝕜] [StarModule 𝕜 F] [ContinuousStar F] : HasDerivAt f f' x → HasDerivAt (fun x => star (f x)) (star f') x` | Analysis.Calculus.Deriv.Star | yes | works for `f : ℝ → ℂ` (compiled example); `star = conj` on ℂ (`Complex.star_def : star = ⇑(starRingEnd ℂ)`). `HasDerivAt.conj` does NOT exist (`HasDerivAt.conj_conj` is the 𝕜 → 𝕜 conj∘f∘conj version) |
| `HasDerivAt.comp_ofReal` | `{e : ℂ → ℂ} : HasDerivAt e e' ↑z → HasDerivAt (fun y : ℝ => e ↑y) e' z` | Analysis.Complex.RealDeriv | yes | also `HasDerivAt.ofReal_comp`, `HasDerivAt.real_of_complex`, `HasDerivAt.scomp` |
| `hasDerivAt_pi` | `HasDerivAt φ φ' x ↔ ∀ i, HasDerivAt (fun x => φ x i) (φ' i) x` | Analysis.Calculus.Deriv.Pi | yes | componentwise route for vectors `n → ℂ` |
| `Matrix.mulVecLin`, `Matrix.mulVecLin_apply` | `M.mulVecLin v = M.mulVec v` | Matrix.Basic | yes | |
| `intermediate_value_Icc` | `a ≤ b → ContinuousOn f (Icc a b) → Icc (f a) (f b) ⊆ f '' Icc a b` | Topology.Order.IntermediateValue | yes | `intermediate_value_Icc'` for `Icc (f b) (f a)` |
| `IsPreconnected.intermediate_value` | `IsPreconnected s → a ∈ s → b ∈ s → ContinuousOn f s → Icc (f a) (f b) ⊆ f '' s` | same | yes | |
| `Continuous.matrix_det` | `[CommRing R] [IsTopologicalRing R] {A : X → Matrix n n R} : Continuous A → Continuous fun x => (A x).det` | Topology.Instances.Matrix | yes | also `Continuous.matrix_trace`, `Continuous.matrix_mul`, `Continuous.matrix_mulVec` (all verified) |
| `continuous_list_prod` | `(l : List ι) (h : ∀ i ∈ l, Continuous (f i)) : Continuous fun a => (l.map fun i => f i a).prod` | Topology.Algebra.Monoid | yes | |

## Gaps (missing in this Mathlib; closest substitutes)

- `Matrix.exp_smul` (scalar in the exponent) and `Matrix.exp_mul_conj`: NOT FOUND. Closest: `NormedSpace.exp_nsmul`; for `c • 1` use `NormedSpace.algebraMap_exp_comm` with `Algebra.algebraMap_eq_smul_one`.
- `SemiconjBy.exp`: NOT FOUND under that name; the lemma is `SemiconjBy.exp_right`.
- `NormedSpace.hasDerivAt_exp_smul_const`: wrong namespace; it is `hasDerivAt_exp_smul_const` (root).
- A global norm on `Matrix n n ℂ`: none; use the local-instance idiom at the top.
- `Matrix.IsHermitian.kronecker`, Kronecker of a `Finset.sum`: NOT FOUND. Closest: `conjTranspose_kronecker`, `PosSemidef.kronecker`, `kroneckerMap_add_left/right`, `kroneckerMapBilinear`.
- "Trace of a Hermitian matrix is real" (`IsHermitian.trace_real` or similar): NOT FOUND. Closest: `IsHermitian.trace_eq_sum_eigenvalues`, or `trace_conjTranspose` + `IsHermitian.eq`.
- `Matrix.charpoly_conjTranspose`: NOT FOUND. Closest: `charpoly_transpose` + `charpoly_map` with `starRingEnd ℂ`, or `IsHermitian.charpoly_eq`.
- `Polynomial.roots_map`, `Polynomial.roots_reverse`, `Polynomial.reverse_X_sub_C`, `Polynomial.reverse_prod`: NOT FOUND. Closest: `Splits.roots_map_of_injective`, `eval₂_reverse_eq_zero_iff`, `reverse_mul_of_domain` (product by induction), `reverse_add_C`; for matrices `reverse_charpoly` and `charpolyRev`.
- det(1 + z • A) = ∏ (1 + z λ_i), or `eval z charpolyRev = det (1 - z • A)` as a lemma: NOT FOUND. Closest: `charpolyRev` (definition is that determinant), `det_one_add_smul` (first order only), `Splits.eq_prod_roots_of_monic` + `reverse_mul_of_domain`.
- `Matrix.isRoot_charpoly`, `Matrix.eval_charpoly_eq_det`, `Module.End.hasEigenvalue_iff_isRoot_charpoly`, `Module.End.exists_eigenvalue`: NOT FOUND under these names (`exists_eigenvalue [IsAlgClosed K] [FiniteDimensional K V] [Nontrivial V]` exists in `LinearAlgebra.Eigenspace.Triangularizable`, but not under `Module.End.`; namespace not pinned down). Closest: `Matrix.eval_charpoly`, `mem_spectrum_iff_isRoot_charpoly`, `exists_mulVec_eq_zero_iff` (compiled derivation in table C).
- `Matrix.det_one_add_col_mul_row`, `Matrix.det_one_sub_smul`: NOT FOUND.
- `HasDerivAt.finset_sum` (use `HasDerivAt.sum` / `fun_sum`), `HasDerivAt.conj` (use `HasDerivAt.star`), `HasDerivAt.matrix_mulVec`, `HasDerivAt.mulVec`, `HasDerivAt.matrix_mul`, `HasDerivAt.dotProduct`: NOT FOUND. Closest: `hasDerivAt_pi`, unfolding `mulVec`/`dotProduct` into `Finset.sum` and using `HasDerivAt.sum` / `HasDerivAt.mul`, or `HasDerivAt.mul` on matrices with the local linfty normed algebra.
- `Matrix.posSemidef_iff_eigenvalues_nonneg`, `Matrix.PosSemidef.conjTranspose_mul_self`: NOT FOUND (use `posSemidef_conjTranspose_mul_self`, `PosSemidef.eigenvalues_nonneg`).
- `Mathlib.Data.Complex.Basic` is deprecated; the scratch checks used `Mathlib.Analysis.Complex.Basic`.
