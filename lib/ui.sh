#!/bin/bash

export BORDER TITLE SUCCESS WARNING DANGER DIM BOLD NC

BORDER="\033[0;36m"
TITLE="\033[1;36m"

SUCCESS="\033[0;32m"
WARNING="\033[1;33m"
DANGER="\033[0;31m"
DIM="\033[2m"

BOLD="\033[1m"
NC="\033[0m"

draw_box() {
  local title="$1"
  local width=${2:-50}
  local term_width=$(tput cols)
  local margin=$(((term_width - width) / 2))
  local pad=$(printf "%${margin}s" "")

  local line
  line=$(printf "═%.0s" $(seq 1 "$width"))

  local pad_left=$(((width - ${#title}) / 2))
  local pad_right=$(((width - ${#title}) - pad_left))

  printf "%s${BORDER}╔%s╗${NC}\n" "$pad" "$line"
  printf "%s${TITLE}${BOLD}║%${pad_left}s%s%${pad_right}s║${NC}\n" "$pad" "" "$title" ""
  printf "%s${BORDER}╚%s╝${NC}\n" "$pad" "$line"
}

msg_success() { printf "${SUCCESS}[OK]${NC}   %s\n" "$1"; }
msg_error() { printf "${DANGER}[ERROR]${NC}   %s\n" "$1"; }
msg_warning() { printf "${WARNING}[WARNING]${NC}  %s\n" "$1"; }
msg_info() { printf "${DIM}[INFO]${NC}  %s\n" "$1"; }
