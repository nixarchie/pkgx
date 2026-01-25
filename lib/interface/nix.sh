pkgx_cmd() {
  case "$1" in
    profile)
      shift
      case "$1" in
        install)
          shift
          backend_add "$@"
          ;;
        remove)
          shift
          backend_rm "$@"
          ;;
        list)
          backend_list
          ;;
        *)
          die "unknown nix profile subcommand"
          ;;
      esac
      ;;
    flake)
      backend_sync
      ;;
    *)
      die "unknown nix-style command"
      ;;
  esac
}
