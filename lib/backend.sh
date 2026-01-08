#!/usr/bin/env bash

. "$LIB/common.sh"

show_done() {
    echo
    gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
}

detect_backend() {
  if have pacman; then
    echo pacman
  elif have nix; then
    echo nix
  elif have pkg; then
    echo freebsd
  elif have apt; then
    echo apt
  else
    die "no supported package backend found"
  fi
}


backend_add() {
  backend="$(detect_backend)"

  case "$backend" in
    pacman)
      sudo pacman -S --needed "$@"
      ;;
    nix)
      nix profile install "nixpkgs#$1"
      ;;
    freebsd)
      sudo pkg install -y "$@"
      ;;
    apt)
      sudo apt install -y "$@"
      ;;
  esac
}

backend_rm() {
  backend="$(detect_backend)"

  case "$backend" in
    pacman)
      sudo pacman -Rns "$@"
      ;;
    nix)
      nix profile remove "$@"
      ;;
    freebsd)
      sudo pkg delete -y "$@"
      ;;
    apt)
      sudo apt remove -y "$@"
      ;;
  esac
}

backend_sync() {
  backend="$(detect_backend)"

  case "$backend" in
    pacman)
      sudo pacman -Syu
      if have yay; then
        yay -Syu
      elif have paru; then
        paru -Sua
      fi
      ;;
    nix)
      nix-channel --update
      nix flake update
      ;;
    freebsd)
      sudo pkg update && sudo pkg upgrade
      ;;
    apt)
      sudo apt update && sudo apt upgrade -y
      ;;
  esac
}
