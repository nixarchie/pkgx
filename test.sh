#!/usr/bin/env bash

set -e

export PKGX_ROOT="$(cd "$(dirname "$0")" && pwd)"

source "$PKGX_ROOT/lib/util.sh"
source "$PKGX_ROOT/lib/flags.sh"
source "$PKGX_ROOT/lib/backend.sh"

enable_debug

fail() {
  error "Test failed: $*"
  exit 1
}

pass() {
  info "✔ $*"
}

debug "starting tests"

info "== install test =="
out=$(./pkgx install bash --dry-run)
debug "install output: $out"
echo "$out" | grep -q "\[DRY RUN\]" || fail "install dry-run missing"
pass "install dry-run"

info "== search test =="
./pkgx search bash > /dev/null || fail "search failed"
pass "search"

info "== remove test =="
out=$(./pkgx remove bash --dry-run)
debug "remove output: $out"
echo "$out" | grep -q "\[DRY RUN\]" || fail "remove dry-run missing"
pass "remove dry-run"

info "All tests passed"