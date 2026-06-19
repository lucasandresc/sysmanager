#!/bin/bash

get_sudo_cmd() {
  if [ "$PACKAGE_MANAGER" == "pacman" ]; then
    echo "sudo"
  fi
}

update_system() {
  check_sudo || return 1
  confirm "Do you want to update the system?" || return 0
  local sudo_cmd
  sudo_cmd=$(get_sudo_cmd)

  case $PACKAGE_MANAGER in
  paru | yay | pacman)
    # No quotes: if sudo_cmd is empty it must disappear, not stay as an empty argument.
    if $sudo_cmd "$PACKAGE_MANAGER" -Syu; then
      msg_success "Update process completed."
    else
      msg_error "Update failed."
    fi
    pause
    ;;
  *)
    msg_error "Manager not supported or detected yet."
    ;;
  esac
}

remove_orphans() {
  check_sudo || return 1
  confirm "Do you want to remove orphans packages?" || return 0

  local sudo_cmd
  sudo_cmd=$(get_sudo_cmd)

  case $PACKAGE_MANAGER in
  paru | yay | pacman)
    local orphans
    orphans=$("$PACKAGE_MANAGER" -Qdtq)
    if [[ -z "$orphans" ]]; then
      msg_info "No orphan packages found."
      pause
      return 0
    fi

    if $sudo_cmd "$PACKAGE_MANAGER" -Rns $orphans; then
      msg_success "Orphans packages process completed."
    else
      msg_error "Process failed."
    fi
    pause
    ;;
  *)
    msg_error "Manager not supported or detected yet."
    ;;
  esac
}

show_package_management() {
  while true; do
    clear
    draw_box "PACKAGE MANAGEMENT"

    local main_options=("Update System" "Remove Orphans" "Check Updates" "Back")

    select option in "${main_options[@]}"; do
      case $option in
      "Update System")
        clear
        update_system
        break
        ;;
      "Remove Orphans")
        clear
        remove_orphans
        break
        ;;
      "Check Updates")
        clear
        msg_info "Check Updates - Coming Soon"
        pause
        break
        ;;
      "Back")
        clear
        return
        ;;
      *)
        msg_error "Invalid option. Please try again."
        pause
        break
        ;;
      esac
    done
  done
}
