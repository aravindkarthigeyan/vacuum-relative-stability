/-
Copyright (c) 2026 Aravind Karthigeyan. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
import Core
import Lean

/-!
# Axiom and `sorry` audit for the whole library

Run from the `lean/` directory after `lake build`:

    lake env lean scripts/AxiomAudit.lean

For every declaration whose defining module belongs to one of the library roots in
`projectRoots`, this computes the axioms the declaration depends on, exactly as
`#print axioms` does. Modules under `Audit/` (the comparator restatements, which may
contain a deliberate `sorry`) are excluded.

The audit fails, with a Lean error and exit code 1, if

* any audited declaration depends on an axiom other than `propext`, `Classical.choice`
  and `Quot.sound` (an unfinished proof shows up as `sorryAx`; `native_decide`
  introduces an auxiliary axiom of its own), or
* any project module declares an axiom of its own, or
* a library root listed in `projectRoots` contributes no declarations.

A machine-readable report is written to `.lake/axiom-audit.json`; the README statistics
are generated from it by `scripts/update_readme.py` at the repository root.
-/

open Lean Elab Command

namespace AxiomAudit

/-- Library roots whose declarations are audited. `scripts/update_readme.py` checks
that every Lean source file outside `Audit/` and `scripts/` belongs to one of them. -/
def projectRoots : List Name := [`Core]

/-- Lean's three standard axioms. -/
def allowedAxioms : List Name := [``propext, ``Classical.choice, ``Quot.sound]

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

run_cmd do
  let env ← getEnv
  let header := env.header
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
  for (n, m, c) in audited do
    let axs ← liftCoreM (collectAxioms n)
    for a in axs do
      usage := usage.insert a (usage.getD a 0 + 1)
    let bad := axs.filter (fun a => !allowedAxioms.contains a)
    if c matches .axiomInfo _ then
      logError m!"{n} (module {m}) is an axiom declared in the project"
      violations := violations.push <| Json.mkObj
        [("declaration", n.toString), ("module", m.toString), ("reason", "project axiom")]
    else if !bad.isEmpty then
      logError m!"{n} (module {m}) depends on non-standard axioms {bad.toList}"
      violations := violations.push <| Json.mkObj
        [("declaration", n.toString), ("module", m.toString),
         ("axioms", strArray (bad.map toString))]
    unless n.isInternalDetail do
      match c with
      | .thmInfo _ =>
        theorems := theorems.push <| Json.mkObj
          [("name", n.toString), ("module", m.toString),
           ("axioms", strArray (axs.map toString |>.qsort (· < ·)))]
      | .defnInfo _ | .opaqueInfo _ | .inductInfo _ =>
        definitions := definitions.push n.toString
      | _ => pure ()
  -- Sanity guard: a library this size that reports no axioms at all would mean the
  -- proof bodies were not visible to `collectAxioms`, not that the proofs are clean.
  if usage.isEmpty then
    logError "no audited declaration depends on any axiom; proof bodies may not be loaded"
    violations := violations.push <| Json.mkObj [("reason", "no axioms collected")]
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
     ("violations", Json.arr violations),
     ("passed", toJson violations.isEmpty)]
  IO.FS.createDirAll ".lake"
  IO.FS.writeFile ".lake/axiom-audit.json" (report.pretty ++ "\n")
  if violations.isEmpty then
    logInfo m!"axiom audit passed: {audited.size} declarations in {modules.size} modules, \
      {theorems.size} theorems; axioms used: {usage.toList.map (·.1)}"

end AxiomAudit
