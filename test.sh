#!/usr/bin/env bash

# test.sh - Enhanced test suite for pkgx

set -e

# Setup environment for testing
export PKGX_ROOT="$(cd "$(dirname "$0")" && pwd)"
export PKGX_LOG_LEVEL=2 # Enable debug logging for tests

# Source utilities for colors and logging in the test script itself
source "$PKGX_ROOT/lib/util.sh"

# Test state
PASSED=0
FAILED=0
TOTAL=0

# Helper functions
pass() {
    echo -e "${PKGX_CLR_GREEN}  ✔ PASS:${PKGX_CLR_RESET} $*"
    PASSED=$((PASSED + 1))
}

fail() {
    echo -e "${PKGX_CLR_RED}  ✖ FAIL:${PKGX_CLR_RESET} $*"
    FAILED=$((FAILED + 1))
    # We don't exit immediately so we can see all failures
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    local msg="$3"
    TOTAL=$((TOTAL + 1))
    if echo "$haystack" | grep -qF -- "$needle"; then
        pass "$msg"
    else
        fail "$msg (expected '$needle' in '$haystack')"
    fi
}

test_header() {
    echo -e "\n${PKGX_CLR_BLUE}=== Testing: $* ===${PKGX_CLR_RESET}"
}

# --- Tests ---

test_basic_commands() {
    test_header "Basic Commands (Dry Run)"

    # Test Install
    out=$(PKGX_BACKEND=pacman ./pkgx install bash --dry-run 2>&1)
    assert_contains "$out" "sudo pacman -S --needed bash" "install command formatting (pacman)"

    # Nix Install (standard)
    out=$(PKGX_BACKEND=nix ./pkgx install hello --dry-run 2>&1)
    assert_contains "$out" "nix profile install nixpkgs#hello" "install command formatting (nix)"

    # Nix Install (full URI)
    out=$(PKGX_BACKEND=nix ./pkgx install github:nixos/nixpkgs#hello --dry-run 2>&1)
    assert_contains "$out" "nix profile install github:nixos/nixpkgs#hello" "install command formatting (nix full URI)"

    # Test Remove
    out=$(PKGX_BACKEND=pacman ./pkgx remove bash --dry-run 2>&1)
    assert_contains "$out" "sudo pacman -Rs bash" "remove command formatting (pacman)"

    # Test Sync
    out=$(PKGX_BACKEND=pacman ./pkgx sync --dry-run 2>&1)
    assert_contains "$out" "sudo pacman -Sy" "sync command formatting (pacman)"

    # Nix Sync
    out=$(PKGX_BACKEND=nix ./pkgx sync --dry-run 2>&1)
    assert_contains "$out" "nix registry pin nixpkgs" "sync command formatting (nix)"

    # Test Upgrade
    out=$(PKGX_BACKEND=pacman ./pkgx upgrade --dry-run 2>&1)
    assert_contains "$out" "sudo pacman -Syu" "upgrade command formatting (pacman)"
}

test_flags() {
    test_header "Flags and Options"

    # Test Assume Yes
    out=$(PKGX_BACKEND=pacman ./pkgx install bash -y --dry-run 2>&1)
    assert_contains "$out" "--noconfirm" "assume-yes flag (-y)"

    out=$(PKGX_BACKEND=pacman ./pkgx install bash --yes --dry-run 2>&1)
    assert_contains "$out" "--noconfirm" "assume-yes flag (--yes)"
}

test_interfaces() {
    test_header "Interface Mapping"

    # Test pacman interface mapping on pacman backend
    out=$(PKGX_INTERFACE=pacman PKGX_BACKEND=pacman ./pkgx -S bash --dry-run 2>&1)
    assert_contains "$out" "pacman -S" "pacman interface mapping (-S)"

    out=$(PKGX_INTERFACE=pacman PKGX_BACKEND=pacman ./pkgx -R bash --dry-run 2>&1)
    assert_contains "$out" "pacman -Rs" "pacman interface mapping (-R)"

    # Test apt interface mapping on apt backend
    out=$(PKGX_INTERFACE=apt PKGX_BACKEND=apt ./pkgx update --dry-run 2>&1)
    assert_contains "$out" "apt update" "apt interface mapping (update -> sync)"

    # Test nix interface mapping on nix backend
    out=$(PKGX_INTERFACE=nix PKGX_BACKEND=nix ./pkgx profile install hello --dry-run 2>&1)
    assert_contains "$out" "nix profile install nixpkgs#hello" "nix interface mapping (profile install)"

    out=$(PKGX_INTERFACE=nix PKGX_BACKEND=nix ./pkgx registry pin --dry-run 2>&1)
    assert_contains "$out" "nix registry pin nixpkgs" "nix interface mapping (registry pin)"
}

test_backend_detection() {
    test_header "Backend Detection"

    # Use a command that exists but is dry-run to check backend loading
    out=$(PKGX_BACKEND=nix ./pkgx search bash --dry-run 2>&1)
    assert_contains "$out" "loaded backend: nix" "backend override"
}

# --- Execution ---

test_basic_commands
test_flags
test_interfaces
test_backend_detection

# --- Summary ---

echo -e "\n${PKGX_CLR_BLUE}=== Test Summary ===${PKGX_CLR_RESET}"
echo -e "Total:  $TOTAL"
echo -e "Passed: ${PKGX_CLR_GREEN}$PASSED${PKGX_CLR_RESET}"
if [ $FAILED -gt 0 ]; then
    echo -e "Failed: ${PKGX_CLR_RED}$FAILED${PKGX_CLR_RESET}"
    exit 1
else
    echo -e "Failed: 0"
    echo -e "\n${PKGX_CLR_GREEN}All tests passed!${PKGX_CLR_RESET}"
fi
