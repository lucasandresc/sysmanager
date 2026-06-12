#!/bin/bash

check_distro() {
  source /etc/os-release
  export DISTRO=$(grep "^NAME=" /etc/os-release | cut -d= -f2 | tr -d '''')
}

check_package_manager() {
  packages_manager=("paru" "yay" "pacman" "apt" "dnf" "zypper" "xbps-install" "apk" "emerge" "nix")
  for manager in "${packages_manager[@]}"; do
    if command -v "$manager" &>/dev/null; then
      export PACKAGE_MANAGER="$manager"
      break
    fi
  done
}

check_init_system() {
  local SYSTEM
  SYSTEM=$(ps -p 1 -o comm=)

  case $SYSTEM in

  systemd | openrc | init)
    export INIT_SYSTEM="$SYSTEM"
    ;;
  *)
    export INIT_SYSTEM="unknown"
    ;;

  esac

}
