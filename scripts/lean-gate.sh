#!/usr/bin/env bash
# Copyright (c) 2026 Aravind Karthigeyan. Released under the Apache License 2.0.
#
# Machine-wide Lean compile gate for this repository (docs/DECISIONS.md, D15).
#
# At most LEAN_GATE_SLOTS (default 2) commands started through this script run at
# once on the machine. Each Lean or Lake command of the formalization campaign is
# run through it, so parallel agents never run more than two compiles together.
# A slot is a directory created atomically with `mkdir` (portable to Git Bash on
# Windows, which has no flock); it records the owner's PID and is reclaimed if
# that process has died.
#
# Usage, from lean/:
#     bash ../scripts/lean-gate.sh lake env lean Core/PaperA/Transfer/Foo.lean
#     bash ../scripts/lean-gate.sh lake build Core.PaperA.Transfer.Foo
set -u
slots=${LEAN_GATE_SLOTS:-2}
here=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
dir=${LEAN_GATE_DIR:-"$here/../lean/.lake/lean-gate"}
mkdir -p "$dir"
waited=""
while :; do
  for i in $(seq 0 $((slots - 1))); do
    slot="$dir/slot$i"
    if mkdir "$slot" 2>/dev/null; then
      echo $$ > "$slot/pid"
      trap 'rm -rf "$slot"' EXIT INT TERM
      [ -n "$waited" ] && echo "[lean-gate] acquired slot $i" >&2
      "$@"
      exit $?
    fi
    pid=$(cat "$slot/pid" 2>/dev/null || true)
    if [ -n "$pid" ] && ! kill -0 "$pid" 2>/dev/null; then
      rm -rf "$slot"
    fi
  done
  if [ -z "$waited" ]; then
    echo "[lean-gate] waiting for one of $slots compile slots" >&2
    waited=1
  fi
  sleep 3
done
