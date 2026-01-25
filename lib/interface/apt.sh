pkgx_cmd() {
  case "$1" in
    install)
      shift
      backend_add "$@"
      ;;
    remove|purge)
      shift
      backend_rm "$@"
      ;;
    update)
      backend_sync
      ;;
    upgrade)
      backend_sync
      ;;
    list)
      backend_list
      ;;
    *)
      die "unknown apt-style command: $1"
      ;;
  esac
}
