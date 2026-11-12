> **Further proof attempts completed.** Sections 13--16 now contain an ultraviolet
> counterexample, an exchange-driven vacuum instability, and a screened lattice
> many-body relative theorem. The PDF has 72 pages. See
> [NEXT_STEPS_REPORT.md](NEXT_STEPS_REPORT.md) for the current status.
> The earlier account below is retained for provenance.

> **Audit completed, 27 October 2026.** The historical handoff below is retained
> for provenance. Several claims were corrected, including charge-sector
> hypotheses, static photon-mass interpretation, and the proposed strict
> absorption estimate (now disproved). Read [AUDIT_REPORT.md](AUDIT_REPORT.md)
> and [AUDIT_AGENT_REPORTS.md](AUDIT_AGENT_REPORTS.md) for the current findings.
> The revised PDF has 54 pages. Sections 9-12 are split across three
> continuation source files included by paper-part-three.tex.

# Handoff to Codex: stability of cutoff QED with pairs and point nuclei

Updated 27 Oct 2026 (Claude, Cowork session). Everything below is in this folder.

## Folder map

| Path | What it is |
|---|---|
| `stability-qed-paper/main.tex` | Master file. Abstract now has a "Continuation" paragraph. Includes `paper`, **`paper-part-three`** (new), references, appendices A–C. |
| `stability-qed-paper/paper.tex`, `paper-part-two.tex` | Sections 1–8. The original memo. Unchanged. |
| `stability-qed-paper/paper-part-three.tex` | **New. Sections 9–12** (about 6 pages of mathematics). |
| `stability-qed-paper/references.tex` | 11 references added: LS2000, BBHS1998, HLSol2007, GHLS2013, FLS2007, DRS2019, Bach1992, GS1994, Herbst1977, LiebLossAnalysis, KS1975. |
| `stability-qed-paper/appendix-*.tex` | Agent reports A–C. Unchanged. |
| `stability-qed-paper/stability-qed-paper.pdf` | Compiled, 45 pages. Three pdflatex passes, no errors, no undefined refs, no overfull boxes. |
| `numerics/` | Python checks behind the numbers in Section 9: χ(0), the lattice-sum check, χ(q) monotonicity, Ewald/Madelung, and C₀. |

Build: run `build.ps1`, or run `pdflatex -interaction=nonstopmode -output-directory=build -jobname=stability-qed-paper main.tex` three times. No BibTeX.

## What was added (Sections 9–12)

1. **Section 9, the broken Ward identity.** The L⁵ vacuum instability is the nonperturbative continuation of a cutoff-induced *tachyonic photon mass*.
   - Prop. 9.2 gives the exact second-order response of the cutoff Dirac sea to a static transverse field. The susceptibility χ_L(q) is defined in (9.1).
   - Closed form: χ(0) = Λ³/(6π²√(Λ²+m²)). Then μ²_ind = 2e²χ(0) = (4α/3π)Λ³/E_Λ, and the instability sets in for L > L* ≈ 113/Λ.
   - Remark 9.4 gives the generality argument: any finite-mode regularization with coupling linear in A has χ(0) > 0.
2. **Theorem 9.6, the counterterm model.** Add the photon-mass counterterm (δμ²/2)∫:A²:. Then H ≥ −A_Λ K − B'_Λ V, and −B'V ≤ E_vac ≤ 0. All photon modes stay coupled. With the Ward-tuned δμ² = μ²_ind, the photon constant is 3d²/χ(0) ≈ Λ³E_Λ/(2π²), independent of α.
3. **Remark 9.8.** The small-box counterexample survives if the Madelung self-image term (ξ = 2.83730) is retained.
4. **Section 10, mean-field vacuum-relative stability.** For all quasi-free states 0 ≤ γ ≤ 1, with arbitrary pair coherence, point nuclei, exact neutrality and no photons:
   - **Theorem 10.4:** E^HF(R,Z) − E^HF_vac ≥ −C α Λ (Z_max + Z_max²) K, uniformly in L, K and positions, for α < 4/π. The HF vacuum is exactly the free sea, with E^HF_vac = 0.
   - The key new tool is **Lemma 10.2**, a periodic Coulomb–Kato inequality ∫ G_L(x−y)|f|² ≤ (π/2)⟨f,|p|f⟩ + (c_*/L)‖f‖². Its proof uses a periodic partition of unity and relativistic IMS.
5. **Section 10.4, photons at mean field.** Prop. 10.6 proves the relative bound with a *heavy* counterterm δμ² > 24e²d/(mθ_L). That is a massive renormalized photon, so effectively an IR regulator. Remark 10.7 identifies why the Ward-tuned case is open: a marginal q→0 pair-coherence direction, and the size of the diagonal magnetic attraction. It states the exact open inequality.
6. **Section 11, exact reduction.** The many-body vacuum-relative theorem (photon-free) follows from the relative correlation estimate c(R,Z) ≤ c(0) + C_Λ K (Prop. 11.1). This is the central open problem.
7. **Section 12.** Status table and next steps.

## Please verify (highest priority first)

1. **Lemma 10.2 (periodic Coulomb–Kato).**
   - Check the folding argument in Step 3 and the torus quadratic-form formula ⟨f,|p|f⟩_T = (1/2π²)∫_C dx ∫_{R³} dy |f(x)−f(y)|²/|x−y|⁴.
   - Make c_* explicit for a concrete φ.
   - Certify C₀ = max_cell(G₁ − 1/|x|) ≤ 0 rigorously. Ewald numerics give −1.957, attained at the corner. Interval arithmetic would settle it.
2. **Lemma 10.1.** Check the signs and conventions of the HF energy against the Wick formula (eq. trial-wick in Section 5), in particular Ex(Q) with the full zero-mean G_L.
3. **Prop. 9.2(ii).**
   - The pair-state matrix elements and the factor V/2.
   - The parity argument χ_L(−q) = χ_L(q).
   - The claim that the free-sea current vanishes for the symmetric cutoff.
4. **Lemma 9.5.**
   - The Bogoliubov diagonalization on {k,−k} pairs with the real polarization convention.
   - The constant E_γ(δμ) ∈ [−(δμ²/4)Σ1/|k|, 0].
5. **Novelty of Theorem 10.4.** Compare with Bach–Barbaroux–Helffer–Siedentop, Doc. Math. 3 (1998) 353–364, which proves HF stability of the electron–positron field up to Z = 67. Also compare with Hainzl–Lewin–Solovej (CPAM 2007). Check whether a box-uniform, vacuum-relative point-nucleus statement already exists. Adjust Remark 10.5(d) accordingly.
6. **Reference metadata.** Check volumes and pages, especially DRS2019 (journal volume not filled in), GHLS2013, FLS2007, Bach1992 and GS1994. These were filled from memory or search snippets.

## Suggested next research steps

- **A (doable).** Prove a Λ-independent version of Theorem 10.4 under Z_max α ≤ 2/π, using Lieb–Yau and the relativistic Lieb–Thirring bound (eq. LT) for Q₊₊ and −Q₋₋. The open part is controlling the anomalous density ρ_{Q₊₋} through Tr(|D₀|Q₊₋Q₋₊).
- **B (central).** Prove the relative correlation bound (11.2) for a Yukawa-screened Coulomb interaction on a lattice (Kogut–Susskind / Wilson fermions), via gap persistence (De Roeck–Salmhofer 2019). Then treat the Coulomb tail through neutrality and dipole kernels.
- **C.** Prove or refute the Ward-tuned mean-field photon inequality in Remark 10.7. Alternatively, switch to a gauge-covariant lattice regularization, where χᵀ(0) = 0 holds identically.
- **D.** Keep the honest framing. Nothing proves the full many-body primary theorem (S) yet. Sections 9–11 move the frontier to the single estimate (11.2).

