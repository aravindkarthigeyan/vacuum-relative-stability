/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core
import Frozen.PaperA.PositivityAndTransferAnnulus
import Frozen.PaperA.CanonicalFourierBound
import Frozen.PaperA.WilsonTwistedTraceBound
import Frozen.PaperA.CenteredTraceNonneg
import Frozen.PaperA.WilsonMassBound
import Frozen.PaperA.WilsonGaugeCovariance
import Lean

/-!
# Axiom and `sorry` audit for the whole library

Run from the `lean/` directory after `lake build`:

    lake env lean scripts/Audit/AxiomAudit.lean

For every declaration whose defining module belongs to one of the library roots in
`projectRoots`, this computes the axioms the declaration depends on, exactly as
`#print axioms` does. Modules under `Audit/` (the comparator restatements, which may
contain a deliberate `sorry`) are excluded.

The audit fails, with a Lean error and exit code 1, if

* any audited declaration depends on an axiom other than `propext`, `Classical.choice`
  and `Quot.sound` (an unfinished proof shows up as `sorryAx`; `native_decide`
  introduces an auxiliary axiom of its own). The single exception: a theorem that
  `frozen-manifest.json` registers as a `DRAFT_SORRY` anchor may also depend on
  `sorryAx`. Anything that uses such a theorem inherits `sorryAx` and fails;
* the manifest names an anchor that is not an audited declaration;
* any project module declares an axiom of its own,
* the type or value of an audited declaration names the provider export of a manifest
  theorem anchor (its `implementation.export`), unless the declaration is that anchor or
  one of its auxiliary declarations: every other result reaches a provider's theorem only
  through its frozen anchor, never by the provider name (a later provider written inside
  `namespace QEDCore.PaperA.Provider` could otherwise resolve a short name to it), or
* a library root listed in `projectRoots` contributes no declarations.

The frozen statements are imported above; this file is on their quarantine allowlist
(`draft_allowlist.audit_paths` in the manifest). For every manifest anchor it also records
the elaborated signature (a theorem's type; a definition's type and value; an inductive
type and its constructors), whose SHA-256 the manifest pins as `abi_sha256`.

A machine-readable report is written to `.lake/axiom-audit.json`; the README statistics
are generated from it by `scripts/update_readme.py` at the repository root.
-/

open Lean Elab Command

namespace AxiomAudit

/-- Library roots whose declarations are audited. `scripts/update_readme.py` checks
that every Lean source file outside `Audit/` and `scripts/` belongs to one of them. -/
def projectRoots : List Name := [`Core, `Frozen]

/-- Lean's three standard axioms. -/
def allowedAxioms : List Name := [``propext, ``Classical.choice, ``Quot.sound]

/-- The frozen-anchor manifest, relative to `lean/`. -/
def manifestPath : System.FilePath := "frozen-manifest.json"

def isAudited (m : Name) : Bool :=
  projectRoots.any (·.isPrefixOf m) && !(`Audit).isPrefixOf m

def kindOf : ConstantInfo → String
  | .thmInfo _ => "theorem"
  | .defnInfo _ => "def"
  | .axiomInfo _ => "axiom"
  | .opaqueInfo _ => "opaque"
  | .inductInfo _ => "inductive"
  | .ctorInfo _ => "constructor"
  | .recInfo _ => "recursor"
  | .quotInfo _ => "quot"

def strArray (xs : Array String) : Json := Json.arr (xs.map Json.str)

/-- All anchor exports of the manifest, and those that are `DRAFT_SORRY` theorems. -/
def readManifest : IO (Array Name × Array Name) := do
  unless ← manifestPath.pathExists do
    return (#[], #[])
  let json ← IO.ofExcept (Json.parse (← IO.FS.readFile manifestPath))
  let anchors ← IO.ofExcept (json.getObjValAs? (Array Json) "anchors")
  let mut all := #[]
  let mut drafts := #[]
  for a in anchors do
    let exportName ← IO.ofExcept (a.getObjValAs? String "export")
    let kind ← IO.ofExcept (a.getObjValAs? String "kind")
    let state ← IO.ofExcept (a.getObjValAs? String "state")
    all := all.push exportName.toName
    if kind == "theorem" && state == "DRAFT_SORRY" then
      drafts := drafts.push exportName.toName
  return (all, drafts)

/-- The pairs (anchor export, provider export) of the manifest's theorem anchors. -/
def readProviders : IO (Array (Name × Name)) := do
  unless ← manifestPath.pathExists do
    return #[]
  let json ← IO.ofExcept (Json.parse (← IO.FS.readFile manifestPath))
  let anchors ← IO.ofExcept (json.getObjValAs? (Array Json) "anchors")
  let mut pairs := #[]
  for a in anchors do
    let kind ← IO.ofExcept (a.getObjValAs? String "kind")
    if kind == "theorem" then
      let exportName ← IO.ofExcept (a.getObjValAs? String "export")
      let impl ← IO.ofExcept (a.getObjValAs? Json "implementation")
      let provider ← IO.ofExcept (impl.getObjValAs? String "export")
      pairs := pairs.push (exportName.toName, provider.toName)
  return pairs

/-- The constants named in a declaration's type and value. -/
def usedConstants (c : ConstantInfo) : Array Name :=
  let fromValue := match c.value? (allowOpaque := true) with
    | some v => v.getUsedConstants
    | none => #[]
  c.type.getUsedConstants ++ fromValue

/-- The elaborated signature of an anchor, whose hash the manifest pins. -/
def abiString (env : Environment) (n : Name) : Option String :=
  match env.find? n with
  | some (.thmInfo t) => some s!"theorem {n} : {t.type}"
  | some (.defnInfo d) => some s!"def {n} : {d.type} := {d.value}"
  | some (.inductInfo i) =>
    let ctors := i.ctors.map fun k =>
      match env.find? k with
      | some c => s!"{k} : {c.type}"
      | none => s!"{k}"
    some s!"inductive {n} : {i.type} | {" | ".intercalate ctors}"
  | _ => none

run_cmd do
  let env ← getEnv
  let header := env.header
  let (anchors, drafts) ← liftIO readManifest
  let providers ← liftIO readProviders
  let mut modules : Array String := #[]
  let mut audited : Array (Name × Name × ConstantInfo) := #[]
  for h : i in [0:header.moduleNames.size] do
    let m := header.moduleNames[i]
    if isAudited m then
      modules := modules.push m.toString
      for c in header.moduleData[i]!.constants do
        audited := audited.push (c.name, m, c)
  for r in projectRoots do
    unless modules.any (fun m => r.isPrefixOf m.toName) do
      logError m!"library root {r} contributes no modules; is it imported above?"
  let mut theorems : Array Json := #[]
  let mut definitions : Array String := #[]
  let mut violations : Array Json := #[]
  let mut usage : Std.HashMap Name Nat := {}
  for a in anchors do
    unless audited.any (·.1 == a) do
      logError m!"manifest anchor {a} is not a declaration of an audited module"
      violations := violations.push <| Json.mkObj
        [("declaration", a.toString), ("reason", "manifest anchor not audited")]
  for (n, m, c) in audited do
    let axs ← liftCoreM (collectAxioms n)
    let isDraft := drafts.contains n
    unless isDraft do
      for a in axs do
        usage := usage.insert a (usage.getD a 0 + 1)
    let allowed := if isDraft then allowedAxioms ++ [``sorryAx] else allowedAxioms
    let bad := axs.filter (fun a => !allowed.contains a)
    if c matches .axiomInfo _ then
      logError m!"{n} (module {m}) is an axiom declared in the project"
      violations := violations.push <| Json.mkObj
        [("declaration", n.toString), ("module", m.toString), ("reason", "project axiom")]
    else if !bad.isEmpty then
      logError m!"{n} (module {m}) depends on non-standard axioms {bad.toList}"
      violations := violations.push <| Json.mkObj
        [("declaration", n.toString), ("module", m.toString),
         ("axioms", strArray (bad.map toString))]
    for (anchor, provider) in providers do
      if (usedConstants c).contains provider &&
          !(anchor.isPrefixOf n || provider.isPrefixOf n) then
        logError (m!"{n} (module {m}) names the provider {provider} " ++
          m!"of the frozen anchor {anchor}; use the anchor instead")
        violations := violations.push <| Json.mkObj
          [("declaration", n.toString), ("module", m.toString),
           ("reason", s!"names provider {provider} outside its anchor {anchor}")]
    unless n.isInternalDetail do
      match c with
      | .thmInfo _ =>
        theorems := theorems.push <| Json.mkObj
          [("name", n.toString), ("module", m.toString),
           ("axioms", strArray (axs.map toString |>.qsort (· < ·))),
           ("draft", toJson isDraft)]
      | .defnInfo _ | .opaqueInfo _ | .inductInfo _ =>
        definitions := definitions.push n.toString
      | _ => pure ()
  -- Sanity guard: a library this size that reports no axioms at all would mean the
  -- proof bodies were not visible to `collectAxioms`, not that the proofs are clean.
  if usage.isEmpty then
    logError "no audited declaration depends on any axiom; proof bodies may not be loaded"
    violations := violations.push <| Json.mkObj [("reason", "no axioms collected")]
  let mut abi : Array (String × Json) := #[]
  for a in anchors do
    match abiString env a with
    | some s => abi := abi.push (a.toString, Json.str s)
    | none =>
      logError m!"cannot compute the elaborated signature of manifest anchor {a}"
      violations := violations.push <| Json.mkObj
        [("declaration", a.toString), ("reason", "no elaborated signature")]
  let sortedTheorems := theorems.qsort fun x y =>
    (x.getObjValAs? String "name").toOption.getD "" < (y.getObjValAs? String "name").toOption.getD ""
  let usageJson := Json.mkObj <| (usage.toList.map fun (a, k) => (a.toString, toJson k)).mergeSort
    (fun x y => x.1 ≤ y.1)
  let report := Json.mkObj
    [("lean_version", Lean.versionString),
     ("roots", strArray (projectRoots.toArray.map toString)),
     ("allowed_axioms", strArray (allowedAxioms.toArray.map toString)),
     ("modules", strArray (modules.qsort (· < ·))),
     ("declarations_audited", toJson audited.size),
     ("theorems", Json.arr sortedTheorems),
     ("definitions", strArray (definitions.qsort (· < ·))),
     ("axiom_usage", usageJson),
     ("draft_exports", strArray (drafts.map toString |>.qsort (· < ·))),
     ("anchor_abi", Json.mkObj (abi.qsort (fun x y => x.1 < y.1)).toList),
     ("violations", Json.arr violations),
     ("passed", toJson violations.isEmpty)]
  IO.FS.createDirAll ".lake"
  IO.FS.writeFile ".lake/axiom-audit.json" (report.pretty ++ "\n")
  if violations.isEmpty then
    logInfo m!"axiom audit passed: {audited.size} declarations in {modules.size} modules, \
      {theorems.size} theorems ({drafts.size} registered DRAFT_SORRY anchors); \
      axioms used outside them: {usage.toList.map (·.1)}"

end AxiomAudit
