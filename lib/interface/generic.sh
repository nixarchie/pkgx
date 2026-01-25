pkgx_cmd() {
  cmd="$1"
  shift || true

  # ---- normalize aliases ----
  case "$cmd" in
  add | install) action=add ;;
  rm | remove) action=rm ;;
  sync | update | up) action=sync ;;
  list | show | ls) action=list ;;
  aur | yay | add-aur) action=aur ;;
  menu) action=menu ;;
  config) action=config ;;
  *)
    die "unknown command: $cmd"
    ;;
  esac

  case "$action" in
  add)
    exec sh "$CMD/add.sh" "$@"
    ;;

  rm)
    exec sh "$CMD/rm.sh" "$@"
    ;;

  sync)
    exec sh "$CMD/sync.sh"
    ;;

  list)
    exec sh "$CMD/list.sh"
    ;;

  aur)
    # pacman-only feature
    [ "$backend" = pacman ] || die "AUR is only available with pacman"

    have pacman || die "pacman not found"
    have yay || die "yay is required for AUR installs"

    exec sh "$CMD/aur-install.sh" "$@"
    ;;

  menu)
    exec sh "$CMD/menu.sh"
    ;;

  config)
    sub="${1:-}"
    shift || true

    case "$sub" in
    get)
      pkgx_config_get "$@"
      ;;
    *)
      die "unknown config subcommand: $sub"
      ;;
    esac
    ;;
  esac

  [ $# -eq 0 ] && exec sh "$CMD/help.sh"
}
