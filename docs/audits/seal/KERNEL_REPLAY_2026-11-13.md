# Kernel replay of every project module (2026-11-13)

`lake env leanchecker <Module>` from `lean/`, one process per module, through
`scripts/lean-gate.sh`, on commit 422b189 (Lean v4.35.0 toolchain `leanchecker`, default
mode: replays the module's own declarations through the kernel and trusts compiled imports).

An earlier single-process run over all 30 modules stopped with `failed to read file
…/Lean/Meta/Tactic/Grind/ForallProp.olean.private` (a toolchain file that exists and is
intact) while the session was ending; leanchecker prefixed it with "found a problem in
Frozen.PaperA.PositivityAndTransferAnnulus". Rerunning that module alone exited 0, and the
per-module run below shows no failure, so it was an I/O interruption, not a kernel rejection.

| Module | Exit code |
|---|---|
| `Core.CanonicalComparison` | 0 |
| `Core.Coefficients` | 0 |
| `Core.Eigenvectors` | 0 |
| `Core.PaperA.Defs.CenteredTrace` | 0 |
| `Core.PaperA.Defs.DiracOperator` | 0 |
| `Core.PaperA.Defs.Step` | 0 |
| `Core.PaperA.Defs.StepFreeTime` | 0 |
| `Core.PaperA.Defs.StepGenerator` | 0 |
| `Core.PaperA.Defs.TransferMatrix` | 0 |
| `Core.PaperA.Fourier.Bound` | 0 |
| `Core.PaperA.Fourier.DetProd` | 0 |
| `Core.PaperA.Fourier.Factorization` | 0 |
| `Core.PaperA.Fourier.FourierCoeff` | 0 |
| `Core.PaperA.Fourier.TwistKick` | 0 |
| `Core.PaperA.Provider.CanonicalFourierBound` | 0 |
| `Core.PaperA.Provider.PositivityAndTransferAnnulus` | 0 |
| `Core.PaperA.Transfer.Annulus` | 0 |
| `Core.PaperA.Transfer.BetaForm` | 0 |
| `Core.PaperA.Transfer.DetExp` | 0 |
| `Core.PaperA.Transfer.DiracAlgebra` | 0 |
| `Core.PaperA.Transfer.DiracLift` | 0 |
| `Core.PaperA.Transfer.ExpForm` | 0 |
| `Core.PaperA.Transfer.History` | 0 |
| `Core.PaperA.Transfer.Homotopy` | 0 |
| `Core.PaperA.Transfer.RootCount` | 0 |
| `Core.PaperA.Transfer.SpectralPairing` | 0 |
| `Core.PositiveMeasure` | 0 |
| `Core.PseudoUnitary` | 0 |
| `Frozen.PaperA.CanonicalFourierBound` | 0 |
| `Frozen.PaperA.PositivityAndTransferAnnulus` | 0 |

Result: 30 modules, 0 failures. The Lemma 3.2 seal audit 2 independently replayed the 27
modules of that closure, one per command, with exit 0.
