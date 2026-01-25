#!/usr/bin/env bash
set -eu

# ---- determine library path ----
LIB="$(cd "$(dirname "$0")/.." && pwd)"

# ---- load helpers ----
. "$LIB/common.sh"   # show_done, die
. "$LIB/backend.sh"   # backend_* functions
. "$LIB/config.sh"    # backend, DIRECT, GUM

# ---- detect backend if not already set ----
backend="${backend:-$(detect_backend)}"

# ---- perform sync ----
backend_sync
