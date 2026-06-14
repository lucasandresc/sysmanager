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
        msg_info "Update System - Coming Soon"
        pause
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
