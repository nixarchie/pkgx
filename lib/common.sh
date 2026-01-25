#!/usr/bin/env bash

# fail loud, fail early
set -eu

PKGX_NAME="pkgx"
PKGX_SUDO="${PKGX_SUDO:-sudo}"

die() {
  echo "$PKGX_NAME: $*" >&2
  exit 1
}

log() {
  echo "==> $*"
}

warn() {
  echo "!! $*" >&2
}

require_root() {
  if [ "$(id -u)" -ne 0 ]; then
    die "this command must be run as root"
  fi
}

have() {
  command -v "$1" >/dev/null 2>&1
}

pkgx_print_config() {
  printf "\n\033[1;35m─── pkgx config ───\033[0m\n"

  printf "  %-14s %s\n" "backend:"        "$backend"
  printf "  %-14s %s\n" "interface:"      "$PKGX_INTERFACE"
  printf "  %-14s %s\n" "direct:"         "$DIRECT"
  printf "  %-14s %s\n" "gum:"            "$GUM"
  printf "  %-14s %s\n" "config dir:"     "$CONFIG_DIR"
  printf "  %-14s %s\n" "log dir:"        "$LOG_DIR"

  printf "\033[1;35m──────────────────\033[0m\n\n"
}

pkgx_debug_config() {
  [ "${PKGX_DEV:-false}" = "true" ] || return 0

  printf "\n\033[1;36m[debug] pkgx config dump\033[0m\n"
  printf "  backend=%s\n"        "$backend"
  printf "  interface=%s\n"      "$PKGX_INTERFACE"
  printf "  DIRECT=%s\n"         "$DIRECT"
  printf "  GUM=%s\n"            "$GUM"
  printf "  CONFIG_DIR=%s\n"     "$CONFIG_DIR"
  printf "  LOG_DIR=%s\n"        "$LOG_DIR"
  printf "\n"
}
