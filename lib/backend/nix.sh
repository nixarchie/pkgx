#!/usr/bin/env bash

# nix backend implementation

backend_name="nix"

backend_install() {
  debug "install: $*"

  local pkgs=()
  for pkg in "$@"; do
    pkgs+=("nixpkgs#$pkg")
  done

  run_cmd nix profile install "${pkgs[@]}"
}

backend_remove() {
  debug "remove: $*"

  local pkgs=()
  for pkg in "$@"; do
    pkgs+=("nixpkgs#$pkg")
  done

  run_cmd nix profile remove "${pkgs[@]}"
}

backend_search() {
  debug "search: $*"
  run_cmd nix search nixpkgs "$@"
}

backend_sync() {
  debug "sync db"

  warn "nix sync depends on flakes; may do nothing without flake setup"

  run_cmd nix flake update
}

backend_upgrade() {
  debug "upgrade"

  warn "nix upgrades entire profile (not per-package like pacman/apt)"

  run_cmd nix profile upgrade '.*'
}