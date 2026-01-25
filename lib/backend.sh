#!/usr/bin/env bash
set -euo pipefail

. "$LIB/common.sh"   # for die and show_done

# ---- show_done with gum ----
show_done() {
    if [ "$GUM" = true ]; then
        echo
        gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'
    fi
}

# ---- detect backend ----
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

# ---- backend install ----
backend_add() {
    backend="${backend:-$(detect_backend)}"

    case "$backend" in
        pacman)
            args=(-S --needed "$@")
            [ "$DIRECT" = true ] && args+=("--noconfirm")
            sudo pacman "${args[@]}"
            ;;
        nix)
            # nix profile install supports multiple packages
            for pkg in "$@"; do
                nix profile install "nixpkgs#$pkg"
            done
            ;;
        freebsd)
            args=(-y "$@")
            [ "$DIRECT" = false ] || args+=("-y")  # always safe
            sudo pkg install "${args[@]}"
            ;;
        apt)
            args=("install" "-y" "$@")
            [ "$DIRECT" = false ] && args=("install" "$@")  # ask user if direct=false
            sudo apt "${args[@]}"
            ;;
        *)
            die "unknown backend: $backend"
            ;;
    esac

    show_done
}

# ---- backend remove ----
backend_rm() {
    # Use existing backend from config or detect
    backend="${backend:-$(detect_backend)}"

    case "$backend" in
        pacman)
            args=(-Rns "$@")
            [ "$DIRECT" = true ] && args+=("--noconfirm")
            sudo pacman "${args[@]}"
            ;;
        nix)
            # nix profile remove can remove multiple packages
            for pkg in "$@"; do
                nix profile remove "$pkg"
            done
            ;;
        freebsd)
            args=("$@")
            [ "$DIRECT" = true ] && args+=("-y")  # auto-confirm if DIRECT
            sudo pkg delete "${args[@]}"
            ;;
        apt)
            args=("remove" "$@")
            [ "$DIRECT" = true ] && args+=("-y")  # auto-confirm if DIRECT
            sudo apt "${args[@]}"
            ;;
        *)
            die "unknown backend: $backend"
            ;;
    esac

    # optional feedback
    show_done
}


# ---- backend sync ----
backend_sync() {
    backend="${backend:-$(detect_backend)}"

    case "$backend" in
        pacman)
            args=(-Syu)
            [ "$DIRECT" = true ] && args+=("--noconfirm")
            sudo pacman "${args[@]}"

            # AUR helpers
            if have yay; then
                args=(-Syu)
                [ "$DIRECT" = true ] && args+=("--noconfirm")
                yay "${args[@]}"
            elif have paru; then
                args=(-Sua)
                [ "$DIRECT" = true ] && args+=("--noconfirm")
                paru "${args[@]}"
            fi
            ;;
        nix)
            nix-channel --update
            nix flake update
            ;;
        freebsd)
            args=("update" "upgrade")
            [ "$DIRECT" = true ] && args+=("-y")
            sudo pkg "${args[@]}"
            ;;
        apt)
            args=("update" "&&" "apt" "upgrade")
            [ "$DIRECT" = true ] && args+=("-y")
            sudo apt "${args[@]}"
            ;;
        *)
            die "unknown backend: $backend"
            ;;
    esac

    show_done
}
