#!/usr/bin/env bash

# nix backend implementation

backend_name="nix"

# Check for required nix experimental features
check_nix_features() {
  if ! nix show-config 2>/dev/null | grep -q "experimental-features.*nix-command" || \
     ! nix show-config 2>/dev/null | grep -q "experimental-features.*flakes"; then
    warn "Nix support requires 'nix-command' and 'flakes' experimental features."
    warn "Add 'experimental-features = nix-command flakes' to your nix.conf"
  fi
}

check_nix_features

# Helper to format package names for nix profile
format_nix_pkg() {
  local pkg="$1"
  # If it already looks like a flake URI (contains # or :), leave it
  if [[ "$pkg" == *"#"* ]] || [[ "$pkg" == *":"* ]]; then
    echo "$pkg"
  else
    echo "nixpkgs#$pkg"
  fi
}

backend_install() {
  debug "install: $*"

  local pkgs=()
  for pkg in "$@"; do
    pkgs+=("$(format_nix_pkg "$pkg")")
  done

  # nix profile install is generally non-interactive
  run_cmd nix profile install "${pkgs[@]}"
}

backend_remove() {
  debug "remove: $*"

  # For remove, we need to find the correct attribute path or index
  # but 'nix profile remove' often accepts the flake URI if it matches
  local pkgs=()
  for pkg in "$@"; do
    pkgs+=("$(format_nix_pkg "$pkg")")
  done

  run_cmd nix profile remove "${pkgs[@]}"
}

backend_search() {
  debug "search: $*"
  # nix search nixpkgs <query> --json or similar could be used for better parsing,
  # but for a frontend, standard output is usually what users want.
  run_cmd nix search nixpkgs "$@"
}

backend_sync() {
  debug "sync db (updating nixpkgs registry)"
  
  # Updating the registry is more akin to 'apt update' for nix profile
  run_cmd nix registry pin nixpkgs
}

backend_upgrade() {
  debug "upgrade profile"

  # Upgrades all packages in the current profile to their latest versions
  # according to the registry or their flake URIs
  run_cmd nix profile upgrade '.*'
}