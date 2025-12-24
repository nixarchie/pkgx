#!/usr/bin/env bash
set -e

. "$LIB/common.sh"
. "$LIB/backend.sh"

. "$LIB/menu.sh"

pkgx_menu

# # This script is heavily dependent on the Omarchy scripts.
# # Ensure you have the Omarchy repo cloned to ~/.local/bin.
#
# # Colors
# RED='\033[1;31m'
# BLUE='\033[1;34m'
# NC='\033[0m'           # No Color
# CLEAR_LINE='\033[2K\r' # Clear line
#
# # Pretty print helpers
# echo_cmd() { echo -e "\033[1;32m───\033[0m $(pretty_path "$1")"; }
#
# pretty_path() {
#     local path="$1"
#     # Absolute path starting with $HOME → replace with ~
#     if [[ "$path" == "$HOME"* ]]; then
#         echo "~${path#$HOME}"
#     else
#         echo "$path"
#     fi
# }
#
# # Set Omarchy repo
# OMARCHY_REPO="${OMARCHY_REPO:-basecamp/omarchy}"
#
# # Fatal error helper
# die() {
#     printf "${CLEAR_LINE}${RED}%s${NC}\n" "$*" >&2
#     exit 1
# }
#
# # Check dependencies
# dep_ch() {
#     for dep; do
#         command -v "${dep%% *}" >/dev/null || die "Program \"${dep%% *}\" not found. Please install it."
#     done
# }
#
# # Show Omarchy clone menu
# show_omarchy() {
#     options=(
#         "Clone Omarchy git repo"
#         "Exit"
#     )
#
#     while true; do
#         echo
#         echo "? What is your choice?"
#         echo
#
#         for i in "${!options[@]}"; do
#             echo -e "\033[1;32m$((i + 1)).\033[0m ${options[$i]}"
#         done
#
#         read -rp $'\nChoose (eg: 1 or 2): ' choice
#         echo
#
#         case "$choice" in
#             1|c|o|y)
#                 sudo pacman -Syu --noconfirm --needed git
#                 echo -e "\nCloning Omarchy from: https://github.com/${OMARCHY_REPO}.git"
#                 rm -rf ~/.local/share/omarchy/
#                 git clone "https://github.com/${OMARCHY_REPO}.git" ~/.local/share/omarchy >/dev/null
#                 break
#                 ;;
#             2|n|e|q)
#                 echo_cmd "Ok. Goodbye!"
#                 break
#                 ;;
#             *)
#                 echo "Invalid choice. Please select a valid option."
#                 ;;
#         esac
#
#         echo
#     done
# }
#
# # Show main package menu
# show_menu() {
#     options=(
#         "Upgrade (yay -Syu)"
#         "Install (pacman)"
#         "Install (AUR)"
#         "Remove (Any)"
#     )
#
#     while true; do
#         echo
#         echo "? What is your preferred operation?"
#         echo
#
#         for i in "${!options[@]}"; do
#             echo -e "\033[1;32m$((i + 1)).\033[0m ${options[$i]}"
#         done
#
#         read -rp $'\nChoose (eg: 1 or 2): ' choice
#         echo
#
#         case "$choice" in
#             1 | u | y | upgrade | "yay -Syu")
#                 yay -Syu --noconfirm
#                 break
#                 ;;
#             2 | i | p | pacman)
#                 omarchy-pkg-install
#                 break
#                 ;;
#             3 | ii | aur | a)
#                 omarchy-pkg-aur-install
#                 break
#                 ;;
#             4 | R | r | remove)
#                 omarchy-pkg-remove
#                 break
#                 ;;
#             5 | e | q | Q)
#                 echo_cmd "Goodbye!"
#                 break
#                 ;;
#             *)
#                 echo "Invalid choice, try again."
#                 ;;
#         esac
#
#         echo
#     done
# }
#
# # Main execution
# printf "${CLEAR_LINE}${BLUE}Checking dependencies...${NC}\n"
# dep_ch "fzf"
#
# if [[ ! -d ~/.local/share/omarchy ]]; then
#     echo_cmd "Omarchy repo not found"
#     show_omarchy
# else
#     show_menu
# fi
