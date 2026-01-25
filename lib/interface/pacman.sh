pkgx_cmd() {
  cmd="${1:-}"

  case "$cmd" in
    -S)
      shift
      [ "$#" -ge 1 ] || die "pkgx -S: missing package name"
      backend_add "$@"
      ;;

    -R|-Rs|-Rns)
      shift
      [ "$#" -ge 1 ] || die "pkgx $cmd: missing package name"
      backend_rm "$@"
      ;;

    -Syu)
      shift || true
      backend_sync
      ;;

    -Q|-Qq|-Qe)
      shift || true
      backend_list
      ;;

    ""|-h|--help)
      exec sh "$LIB/help.sh"
      ;;

    *)
      die "unknown pacman-style option: $cmd"
      ;;
  esac
}
