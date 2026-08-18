#!/usr/bin/env bash
# ARC_DIR=../arc scripts/build.sh regenerates src/fuller_react_dom_server.erl
set -euo pipefail
cd "$(dirname "$0")/.."
ARC_DIR="${ARC_DIR:-../arc}"
[ -d "$ARC_DIR/aot" ] || { echo "ARC_DIR=$ARC_DIR has no aot/ dir" >&2; exit 1; }

bun install --frozen-lockfile
bun run bundle
(cd "$ARC_DIR/aot" && gleam build)
escript scripts/emit_erlang.escript "$ARC_DIR" js/out/fuller_react_dom_server.cjs fuller_react_dom_server src/fuller_react_dom_server.erl
