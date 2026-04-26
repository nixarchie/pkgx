declare -A CMD_MAP

nix_profile_dispatch() {
  local sub="$1"
  shift
  case "$sub" in
    install) install "$@" ;;
    remove|rm) remove "$@" ;;
    upgrade) upgrade "$@" ;;
    *) error "Unknown nix profile subcommand: $sub"; exit 1 ;;
  esac
}

nix_registry_dispatch() {
  local sub="$1"
  shift
  case "$sub" in
    pin|update) sync "$@" ;;
    *) error "Unknown nix registry subcommand: $sub"; exit 1 ;;
  esac
}

load_interface() {
  case "$PKGX_INTERFACE" in
    pacman)
      CMD_MAP=(
        [-S]=install
        [-R]=remove
        [-Ss]=search
        [-Sy]=sync
        [-Syu]=upgrade
      )
      ;;
    apt)
      CMD_MAP=(
        [install]=install
        [remove]=remove
        [search]=search
        [update]=sync
        [upgrade]=upgrade
      )
      ;;
    nix)
      CMD_MAP=(
        [profile]=nix_profile_dispatch
        [search]=search
        [registry]=nix_registry_dispatch
        [upgrade]=upgrade
      )
      ;;
    *)
      CMD_MAP=(
        [install]=install
        [add]=install
        [i]=install
        [remove]=remove
        [rm]=remove
        [search]=search
        [sync]=sync
        [upgrade]=upgrade
      )
      ;;
  esac
}

load_interface