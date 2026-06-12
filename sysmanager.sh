#!/bin/bash
source ./lib/ui.sh
source ./lib/detect.sh
source ./lib/utils.sh

check_distro
check_package_manager
check_init_system

show_main_menu() {
  while true; do
    clear
    draw_box "SYSTEM MANAGER"

    local main_options=("Package Management" "System Info" "Services" "Network" "Processes" "Logs" "File Cleanup" "Quit")

    select option in "${main_options[@]}"; do
      case $option in
      "Package Management")
        clear
        msg_info "Package Management - Coming Soon!"
        pause
        break
        ;;
      "System Info")
        clear
        msg_info "System Info - Coming Soon!"
        pause
        break
        ;;
      "Services")
        clear
        msg_info "Services - Coming Soon!"
        pause
        break
        ;;
      "Network")
        clear
        msg_info "Network - Coming Soon!"
        pause
        break
        ;;
      "Processes")
        clear
        msg_info "Processes - Coming Soon!"
        pause
        break
        ;;
      "Logs")
        clear
        msg_info "System Logs - Coming Soon!"
        pause
        break
        ;;
      "File Cleanup")
        clear
        msg_info "File Cleanup - Coming Soon!"
        pause
        break
        ;;
      "Quit")
        clear
        msg_info "Thanks for using Linux System Manager!"
        exit 0
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

show_main_menu
