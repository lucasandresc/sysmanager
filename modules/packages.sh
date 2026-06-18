#!/bin/bash

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
        msg_info "Remove Orphans - Coming Soon"
        pause
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

update_system() {
  check_sudo || return 1
  confirm "Do you want to update the system?" || return 0
  local sudo_cmd=""
  if [ "$PACKAGE_MANAGER" == "pacman" ]; then
    sudo_cmd="sudo"
  fi

  case $PACKAGE_MANAGER in
  paru | yay | pacman)
    # No quotes: if sudo_cmd is empty it must dissapear, not stay as an empty argument.
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
