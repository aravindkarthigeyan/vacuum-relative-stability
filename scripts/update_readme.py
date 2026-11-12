#!/usr/bin/env python3
# Copyright (c) 2026 Aravind Karthigeyan. Released under the Apache License 2.0.
"""Regenerate the generated sections of README.md.

Every number in README.md comes from this script, which reads

* lean/status.json            the state of each Paper A result and the supporting lemmas,
* lean/.lake/axiom-audit.json the report written by `lake env lean scripts/AxiomAudit.lean`,
* the Lean sources            file, line, `sorry` and `axiom` counts, verbatim statements,
* paper-a/*.tex               labels and pinned hashes of the source,
* docs/ERRATA-AND-DEVIATIONS.md entry counts.

It rewrites the text between these marker pairs in README.md:

    <!-- BEGIN badges -->    <!-- END badges -->
    <!-- BEGIN glance -->    <!-- END glance -->
    <!-- BEGIN stats -->     <!-- END stats -->
    <!-- BEGIN table -->     <!-- END table -->
    <!-- BEGIN verbatim -->  <!-- END verbatim -->

and the count table between <!-- BEGIN counts --> / <!-- END counts --> in
docs/ERRATA-AND-DEVIATIONS.md.

Usage, from the repository root, after `lake build` and the axiom audit in lean/:

    python3 -I scripts/update_readme.py           # rewrite the generated sections
    python3 -I scripts/update_readme.py --check   # exit 1 if anything is stale or inconsistent

Only the Python standard library is used.
"""

from __future__ import annotations

import argparse
import hashlib
import json
import re
import sys
import urllib.parse
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
LEAN = ROOT / "lean"
STATUS = LEAN / "status.json"
AUDIT = LEAN / ".lake" / "axiom-audit.json"
README = ROOT / "README.md"
ERRATA = ROOT / "docs" / "ERRATA-AND-DEVIATIONS.md"

STATES = ("NOT_STARTED", "FROZEN_UNPROVED", "PROVED", "AUDITED")
DONE = ("PROVED", "AUDITED")
THEOREM_ENVS = ("theorem", "lemma", "proposition", "corollary")
# Directories under lean/ that are not library sources.
NON_LIBRARY = {"Audit", "scripts", "vendor", "tools"}
ICON_DONE, ICON_PARTIAL, ICON_NONE = "✅", "🔧", "⬜"


class CheckError(Exception):
    pass


# --------------------------------------------------------------------------- inputs


def load_json(path: Path) -> dict:
    try:
        return json.loads(path.read_text(encoding="utf-8"))
    except FileNotFoundError:
        if path == AUDIT:
            raise CheckError(
                f"{path.relative_to(ROOT)} not found: run `lake build` and then "
                "`lake env lean scripts/AxiomAudit.lean` in lean/ first"
            ) from None
        raise


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def strip_lean_comments(text: str) -> str:
    """Remove line comments, (nested) block comments and string literals."""
    out: list[str] = []
    i, n, depth = 0, len(text), 0
    while i < n:
        if depth:
            if text.startswith("/-", i):
                depth, i = depth + 1, i + 2
            elif text.startswith("-/", i):
                depth, i = depth - 1, i + 2
            else:
                out.append("\n" if text[i] == "\n" else " ")
                i += 1
        elif text.startswith("/-", i):
            depth, i = 1, i + 2
        elif text.startswith("--", i):
            j = text.find("\n", i)
            i = n if j < 0 else j
        elif text[i] == '"':
            j = i + 1
            while j < n and text[j] != '"':
                j += 2 if text[j] == "\\" else 1
            out.append('""')
            i = j + 1
        else:
            out.append(text[i])
            i += 1
    return "".join(out)


def lean_sources() -> tuple[list[Path], list[Path], list[Path]]:
    """Library files, Audit/ files, scripts/ files under lean/."""
    lib, audit, scripts = [], [], []
    for path in sorted(LEAN.rglob("*.lean")):
        rel = path.relative_to(LEAN)
        top = rel.parts[0]
        if top.startswith(".lake") or top in ("vendor", "tools") or rel.name == "lakefile.lean":
            continue
        if top == "Audit":
            audit.append(path)
        elif top == "scripts":
            scripts.append(path)
        else:
            lib.append(path)
    return lib, audit, scripts


def module_name(path: Path) -> str:
    return ".".join(path.relative_to(LEAN).with_suffix("").parts)


def toolchain() -> tuple[str, str, str]:
    lean = (LEAN / "lean-toolchain").read_text(encoding="utf-8").strip().split(":")[-1]
    manifest = json.loads((LEAN / "lake-manifest.json").read_text(encoding="utf-8"))
    pkg = next(p for p in manifest["packages"] if p["name"] == "mathlib")
    return lean, pkg.get("inputRev") or pkg["rev"], pkg["rev"]


# --------------------------------------------------------------------------- checks


def tex_labels(tex_files: list[Path]) -> tuple[set[str], dict[str, str]]:
    """All labels, and labels attached to theorem-like environments (label -> file)."""
    labels: set[str] = set()
    results: dict[str, str] = {}
    env = "|".join(THEOREM_ENVS)
    pattern = re.compile(r"\\begin\{(" + env + r")\}(\[[^\]]*\])?\s*\\label\{([^}]+)\}")
    for path in tex_files:
        text = path.read_text(encoding="utf-8")
        labels.update(re.findall(r"\\label\{([^}]+)\}", text))
        for _, _, label in pattern.findall(text):
            results[label] = path.relative_to(ROOT).as_posix()
    return labels, results


def validate(status: dict, audit: dict) -> dict:
    """Cross-check status.json, the sources and the audit; return derived facts."""
    problems: list[str] = []
    src = status["source"]
    for rel, digest in src["pinned_sha256"].items():
        path = ROOT / rel
        if not path.exists():
            problems.append(f"pinned source {rel} is missing")
        elif sha256(path) != digest:
            problems.append(f"pinned source {rel} changed; re-audit status.json and update its hash")
    tex_files = sorted((ROOT / Path(src["main"]).parent).glob("*.tex"))
    labels, env_labels = tex_labels(tex_files)

    results = status["results"]
    seen: set[str] = set()
    for r in results:
        lab = r["label"]
        if lab in seen:
            problems.append(f"duplicate result {lab}")
        seen.add(lab)
        if r["state"] not in STATES:
            problems.append(f"{lab}: unknown state {r['state']}")
        if env_labels.get(lab) != r["file"]:
            problems.append(f"{lab}: not a theorem-like environment in {r['file']}")
        if r["state"] != "NOT_STARTED" and not r["lean"]:
            problems.append(f"{lab}: state {r['state']} needs a Lean name")
    for lab in sorted(set(env_labels) - seen):
        problems.append(f"{lab} ({env_labels[lab]}) is missing from status.json")
    for item in status.get("open_in_source", []):
        if item["label"] not in labels:
            problems.append(f"open_in_source label {item['label']} not found")

    if not audit.get("passed"):
        problems.append("the axiom audit did not pass")
    allowed = set(audit["allowed_axioms"])
    theorems = {t["name"]: t for t in audit["theorems"]}
    for r in results:
        if r["state"] in DONE:
            t = theorems.get(r["lean"])
            if t is None:
                problems.append(f"{r['label']}: {r['lean']} is not an audited theorem")
            elif not set(t["axioms"]) <= allowed:
                problems.append(f"{r['label']}: {r['lean']} uses {t['axioms']}")
    claimed = {r["lean"] for r in results if r["lean"]}
    for s in status["supporting"]:
        if s["name"] not in theorems:
            problems.append(f"supporting {s['name']} is not an audited theorem")
        if s["supports"] not in seen:
            problems.append(f"supporting {s['name']} cites unknown result {s['supports']}")
        claimed.add(s["name"])
    for name in sorted(set(theorems) - claimed):
        problems.append(f"audited theorem {name} is not listed in status.json")

    lib, audit_files, script_files = lean_sources()
    modules = set(audit["modules"])
    for path in lib:
        if module_name(path) not in modules:
            problems.append(f"{path.relative_to(ROOT).as_posix()} is not covered by the axiom audit")
    sorry_hits, axiom_hits, lines = [], [], 0
    for path in lib + script_files:
        raw = path.read_text(encoding="utf-8")
        code = strip_lean_comments(raw)
        rel = path.relative_to(ROOT).as_posix()
        if path in lib:
            lines += raw.count("\n")
        sorry_hits += [rel for _ in re.findall(r"\b(?:sorry|admit)\b", code)]
        axiom_hits += [rel for _ in re.findall(
            r"^\s*(?:@\[[^\]]*\]\s*)?(?:(?:private|protected|noncomputable|unsafe)\s+)*axiom\s",
            code, re.M)]
    if sorry_hits:
        problems.append(f"`sorry`/`admit` outside Audit/: {sorted(set(sorry_hits))}")
    if axiom_hits:
        problems.append(f"`axiom` declarations outside Audit/: {sorted(set(axiom_hits))}")
    if problems:
        raise CheckError("\n".join("  - " + p for p in problems))

    order = {a: i for i, a in enumerate(audit["allowed_axioms"])}
    used = sorted(audit["axiom_usage"], key=lambda a: (order.get(a, len(order)), a))
    return {
        "lib_files": len(lib),
        "lib_lines": lines,
        "audit_files": len(audit_files),
        "script_files": len(script_files),
        "sorry": len(sorry_hits),
        "axiom_decls": len(axiom_hits),
        "axioms_used": used,
        "audited_theorems": len(theorems),
        "declarations": audit["declarations_audited"],
        "modules": len(modules),
        "lean_version": audit["lean_version"],
        "module_of": {t["name"]: t["module"] for t in audit["theorems"]},
    }


# --------------------------------------------------------------------------- rendering


def badge(label: str, message: str, color: str) -> str:
    def enc(s: str) -> str:
        return urllib.parse.quote(s.replace("-", "--").replace("_", "__"), safe="")

    return f"![{label}: {message}](https://img.shields.io/badge/{enc(label)}-{enc(message)}-{color})"


def cell(text: str) -> str:
    """Make text safe inside a GitHub Markdown table cell."""
    return text.replace("|", "\\|")


def module_path(module: str) -> str:
    return "lean/" + module.replace(".", "/") + ".lean"


def short(name: str) -> str:
    return name.split(".", 1)[1] if name.startswith("QEDCore.") else name


def per_result(status: dict) -> list[tuple[dict, list[dict], str]]:
    out = []
    for r in status["results"]:
        sup = [s for s in status["supporting"] if s["supports"] == r["label"]]
        if r["state"] in DONE:
            icon = ICON_DONE
        elif r["state"] == "FROZEN_UNPROVED" or sup:
            icon = ICON_PARTIAL
        else:
            icon = ICON_NONE
        out.append((r, sup, icon))
    return out


def counts(status: dict) -> dict:
    rows = per_result(status)
    c = {s: sum(r["state"] == s for r, _, _ in rows) for s in STATES}
    c["total"] = len(rows)
    c["done"] = c["PROVED"] + c["AUDITED"]
    c["partial"] = sum(icon == ICON_PARTIAL for _, _, icon in rows)
    c["none"] = sum(icon == ICON_NONE for _, _, icon in rows)
    c["supporting"] = len(status["supporting"])
    return c


def errata_counts() -> tuple[int, int]:
    text = ERRATA.read_text(encoding="utf-8")
    errata = deviations = 0
    section = None
    for line in text.splitlines():
        if line.startswith("### "):
            section = line[4:].strip().lower()
        elif line.startswith("## "):
            section = None
        elif re.match(r"^\d+\. \*\*", line):
            if section == "errata":
                errata += 1
            elif section == "deviations":
                deviations += 1
    return errata, deviations


def render_badges(status: dict, facts: dict) -> str:
    c = counts(status)
    lean, mathlib, _ = toolchain()
    color = "brightgreen" if c["done"] == c["total"] else ("yellow" if c["done"] else "lightgrey")
    std = facts["axioms_used"] and set(facts["axioms_used"]) <= {"propext", "Classical.choice", "Quot.sound"}
    return " ".join([
        badge("Paper A results proved in Lean", f"{c['done']}/{c['total']}", color),
        badge("supporting lemmas checked", str(c["supporting"]), "blue"),
        badge("sorry", str(facts["sorry"]), "brightgreen" if facts["sorry"] == 0 else "red"),
        badge("axioms", "standard only" if std else "non-standard", "brightgreen" if std else "red"),
        badge("Lean", lean, "blue"),
        badge("Mathlib", mathlib, "blue"),
        badge("papers", "drafts, not specialist-reviewed", "orange"),
    ])


def render_glance(status: dict, facts: dict) -> str:
    c = counts(status)
    lean, mathlib, _ = toolchain()
    e, d = errata_counts()
    axioms = ", ".join(f"`{a}`" for a in facts["axioms_used"])
    lines = [
        f"- {ICON_NONE} **The stability theorem is not formalized.** "
        f"{c['done']} of the {c['total']} numbered results of Paper A are proved in Lean, "
        f"and {c['FROZEN_UNPROVED']} have a frozen Lean statement.",
        f"- {ICON_DONE} **What is checked.** {facts['audited_theorems']} conditional supporting lemmas "
        f"for steps of {c['partial']} of those results compile on Lean {lean} with Mathlib {mathlib}, "
        f"with no `sorry`; every declaration in the library depends only on {axioms}.",
    ]
    for r, sup, icon in per_result(status):
        head = f"**{r['kind']} {r['number']}, {r['title']}** (`{r['label']}`)"
        if icon == ICON_DONE:
            lines.append(f"- {icon} {head}: {r['state'].lower()} as `{r['lean']}`.")
        elif sup:
            lines.append(
                f"- {icon} {head}: not formalized as stated. Checked: {r['lean_coverage']} "
                f"({len(sup)} lemmas). Not in Lean: {r['outside_lean']}"
            )
        elif r["state"] == "FROZEN_UNPROVED":
            lines.append(f"- {icon} {head}: statement frozen as `{r['lean']}`, proof not started.")
        else:
            lines.append(f"- {icon} {head}: not formalized.")
    lines.append(
        f"- 📄 **Errata and deviations:** {e} errata, {d} deviations "
        "→ [docs/ERRATA-AND-DEVIATIONS.md](docs/ERRATA-AND-DEVIATIONS.md)"
    )
    lines.append("")
    lines.append(
        f"{ICON_DONE} proved in Lean · {ICON_PARTIAL} not formalized as stated, but conditional "
        f"lemmas for some proof steps are checked (or the statement is frozen) · {ICON_NONE} nothing in Lean"
    )
    return "\n".join(lines)


def progress_bar(c: dict, width: int = 20) -> str:
    total = c["total"] or 1
    done = round(width * c["done"] / total)
    partial = round(width * (c["done"] + c["partial"]) / total) - done
    return "█" * done + "▒" * partial + "░" * (width - done - partial)


def render_stats(status: dict, facts: dict) -> str:
    c = counts(status)
    lean, mathlib, rev = toolchain()
    pct = round(100 * c["done"] / c["total"]) if c["total"] else 0
    rows = [
        ("Paper A numbered results", c["total"]),
        ("… proved in Lean (`PROVED` or `AUDITED`)", f"{c['done']} ({c['AUDITED']} audited)"),
        ("… frozen statement, unproved (`FROZEN_UNPROVED`)", c["FROZEN_UNPROVED"]),
        ("… `NOT_STARTED`, with checked supporting lemmas", c["partial"] - c["FROZEN_UNPROVED"]),
        ("… `NOT_STARTED`, nothing in Lean", c["none"]),
        ("Supporting lemmas listed in `lean/status.json`", c["supporting"]),
        ("Theorems in the axiom audit", facts["audited_theorems"]),
        ("Declarations audited (including auxiliary ones)", facts["declarations"]),
        ("Library modules / files / lines", f"{facts['modules']} / {facts['lib_files']} / {facts['lib_lines']}"),
        ("Comparator files in `lean/Audit/`", facts["audit_files"]),
        ("`sorry` or `admit` outside `lean/Audit/`", facts["sorry"]),
        ("`axiom` declarations in the project", facts["axiom_decls"]),
        ("Axioms used", ", ".join(f"`{a}`" for a in facts["axioms_used"])),
        ("Toolchain", f"Lean {lean}, Mathlib {mathlib} (`{rev[:12]}`)"),
    ]
    table = ["| | |", "|---|---|"] + [f"| {k} | {v} |" for k, v in rows]
    bar = (
        "```text\n"
        f"Paper A results  {progress_bar(c)}  {c['done']}/{c['total']} proved ({pct}%), "
        f"{c['partial']} with checked supporting lemmas\n"
        "```"
    )
    legend = "`█` proved · `▒` supporting lemmas checked or statement frozen · `░` nothing in Lean"
    return "\n".join([bar, legend, "", *table])


def render_table(status: dict, facts: dict) -> str:
    lines = [
        "| # | Paper A result | Label | State | Lean statement | Checked supporting lemmas |",
        "|---|---|---|---|---|---|",
    ]
    for r, sup, icon in per_result(status):
        lean = f"`{r['lean']}`" if r["lean"] else "—"
        names = ", ".join(f"`{short(s['name'])}`" for s in sup) if sup else "—"
        lines.append(
            f"| {r['number']} | {icon} {r['kind']}: {r['title']} | [`{r['label']}`]({r['file']}) "
            f"| `{r['state']}` | {lean} | {names} |"
        )
    lines += [
        "",
        "Each supporting lemma is a conditional statement about a single proof step. "
        "Its hypotheses include facts that Paper A proves analytically and Lean does not:",
        "",
        "| Lean declaration (`QEDCore.`) | File | Paper A result | Step checked |",
        "|---|---|---|---|",
    ]
    for s in status["supporting"]:
        path = module_path(facts["module_of"][s["name"]])
        lines.append(
            f"| `{short(s['name'])}` | [{path}]({path}) | `{s['supports']}` | {cell(s['step'])} |"
        )
    return "\n".join(lines)


def statement(path: Path, name: str) -> str:
    """The verbatim statement of `name` in `path`: docstring through the `:=` ending the signature."""
    text = path.read_text(encoding="utf-8")
    m = re.search(
        r"(/--(?:(?!-/).)*?-/[ \t]*\n)?^(?:theorem|lemma)[ \t]+" + re.escape(name) + r"\b",
        text, re.S | re.M,
    )
    if not m:
        raise CheckError(f"cannot find theorem {name} in {path.relative_to(ROOT)}")
    start = m.start()
    i, depth = m.end(), 0
    pairs = {"(": ")", "[": "]", "{": "}", "⟨": "⟩"}
    closing = set(pairs.values())
    while i < len(text):
        ch = text[i]
        if text.startswith("--", i):
            i = text.index("\n", i)
            continue
        if text.startswith("/-", i):
            i = text.index("-/", i) + 2
            continue
        if ch in pairs:
            depth += 1
        elif ch in closing:
            depth -= 1
        elif depth == 0 and text.startswith(":=", i):
            block = text[start : i + 2]
            rest = text[i + 2 :]
            if block not in text or not re.match(r"[ \t]*(by\b|\n)", rest):
                raise CheckError(f"statement of {name} is not followed by its proof")
            return block
        i += 1
    raise CheckError(f"no `:=` after theorem {name}")


def scope_variables(path: Path, name: str) -> list[str]:
    """`variable` lines still in scope at the declaration of `name`."""
    stack: list[list[str]] = [[]]
    for line in path.read_text(encoding="utf-8").splitlines():
        if re.match(r"^(?:theorem|lemma)\s+" + re.escape(name) + r"\b", line):
            return [v for frame in stack for v in frame]
        if re.match(r"^(?:noncomputable\s+)?section\b|^namespace\b", line):
            stack.append([])
        elif re.match(r"^end\b", line) and len(stack) > 1:
            stack.pop()
        elif line.startswith("variable "):
            stack[-1].append(line)
    raise CheckError(f"cannot find theorem {name} in {path.relative_to(ROOT)}")


def render_verbatim(status: dict, facts: dict) -> str:
    parts = []
    for s in [s for s in status["supporting"] if s["headline"]]:
        rel = module_path(facts["module_of"][s["name"]])
        result = next(r for r in status["results"] if r["label"] == s["supports"])
        block = statement(ROOT / rel, short(s["name"]))
        variables = scope_variables(ROOT / rel, short(s["name"]))
        context = (
            " It uses the section variables " + ", ".join(f"`{v}`" for v in variables) + "."
            if variables else ""
        )
        parts.append(
            f"`{s['name']}`, a supporting lemma for {result['kind']} {result['number']} "
            f"(`{result['label']}`), verbatim from [{rel}]({rel}) (namespace `QEDCore`; "
            f"its proof follows the `:=`).{context}\n\n```lean\n" + block + "\n```"
        )
    return "\n\n".join(parts)


def render_errata_counts() -> str:
    e, d = errata_counts()
    return "\n".join(["| Source | Errata | Deviations |", "|---|---|---|", f"| Paper A | {e} | {d} |"])


def splice(text: str, key: str, body: str, path: Path) -> str:
    begin, end = f"<!-- BEGIN {key} -->", f"<!-- END {key} -->"
    if text.count(begin) != 1 or text.count(end) != 1:
        raise CheckError(f"{path.name} must contain exactly one {begin} ... {end} pair")
    head, rest = text.split(begin)
    _, tail = rest.split(end)
    return f"{head}{begin}\n{body}\n{end}{tail}"


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__.split("\n\n")[0])
    parser.add_argument("--check", action="store_true", help="fail instead of rewriting if stale")
    args = parser.parse_args()
    try:
        status = load_json(STATUS)
        audit = load_json(AUDIT)
        facts = validate(status, audit)
        for r, sup, _ in per_result(status):
            if sup and not r.get("lean_coverage"):
                raise CheckError(f"{r['label']} has supporting lemmas but no lean_coverage text")
        readme = README.read_text(encoding="utf-8")
        new = readme
        for key, fn in (("badges", render_badges), ("glance", render_glance),
                        ("stats", render_stats), ("table", render_table),
                        ("verbatim", render_verbatim)):
            new = splice(new, key, fn(status, facts), README)
        errata = ERRATA.read_text(encoding="utf-8")
        new_errata = splice(errata, "counts", render_errata_counts(), ERRATA)
    except CheckError as err:
        print(f"update_readme: check failed:\n{err}", file=sys.stderr)
        return 1
    stale = [p.name for p, old, cur in ((README, readme, new), (ERRATA, errata, new_errata)) if old != cur]
    if args.check:
        if stale:
            print(f"update_readme: stale generated sections in {stale}; run scripts/update_readme.py",
                  file=sys.stderr)
            return 1
        print("update_readme: README.md and the errata counts are current")
        return 0
    for path, old, cur in ((README, readme, new), (ERRATA, errata, new_errata)):
        if old != cur:
            path.write_text(cur, encoding="utf-8", newline="\n")
    print(f"update_readme: updated {stale}" if stale else "update_readme: already current")
    return 0


if __name__ == "__main__":
    sys.exit(main())
