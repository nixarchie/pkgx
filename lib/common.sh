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
