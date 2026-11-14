# Kernel replay of the wave 3 modules (2026-11-14)

`lake env leanchecker <Module>` from `lean/`, one process per module, through
`scripts/lean-gate.sh` (Lean v4.35.0 toolchain `leanchecker`, default mode: replays the module's
own declarations through the kernel and trusts compiled imports). Run on the working tree of the
wave 3 landing commit (T3–T6 sealed), after a full `lake build` and a passing axiom audit
(390 declarations, 47 modules, 0 registered drafts). The modules are the three Wilson
definitions frozen on 2026-11-14 (not in the replay of 2026-11-13), the five new helper modules,
the four providers, the four sealed anchors, and the two sealed anchors of Lemmas 3.1 and 3.2
that the T3 and T4 providers consume.

| Module | Exit code |
|---|---|
| `Core.PaperA.Defs.LatticeShift` | 0 |
| `Core.PaperA.Defs.WilsonHopping` | 0 |
| `Core.PaperA.Defs.WilsonMass` | 0 |
| `Core.PaperA.Wilson.Shift` | 0 |
| `Core.PaperA.Wilson.MassBound` | 0 |
| `Core.PaperA.Wilson.GaugeCovariance` | 0 |
| `Core.PaperA.Wilson.TwistSplit` | 0 |
| `Core.PaperA.Transfer.NonnegMass` | 0 |
| `Core.PaperA.Provider.WilsonTwistedTraceBound` | 0 |
| `Core.PaperA.Provider.CenteredTraceNonneg` | 0 |
| `Core.PaperA.Provider.WilsonMassBound` | 0 |
| `Core.PaperA.Provider.WilsonGaugeCovariance` | 0 |
| `Frozen.PaperA.WilsonTwistedTraceBound` | 0 |
| `Frozen.PaperA.CenteredTraceNonneg` | 0 |
| `Frozen.PaperA.WilsonMassBound` | 0 |
| `Frozen.PaperA.WilsonGaugeCovariance` | 0 |
| `Frozen.PaperA.PositivityAndTransferAnnulus` | 0 |
| `Frozen.PaperA.CanonicalFourierBound` | 0 |

Result: 18 modules, 0 failures. The other project modules are unchanged since the replay of
2026-11-13 ([KERNEL_REPLAY_2026-11-13.md](KERNEL_REPLAY_2026-11-13.md)).
