declare -A CMD_MAP

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