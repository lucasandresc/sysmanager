#!/bin/bash

view_services() {
  while true; do
    clear
    draw_box "SYSTEM SERVICES"

    local main_options=("Running Services" "Failed Services" "Enabled Services" "Back")

    select option in "${main_options[@]}"; do
      case $option in
      "Running Services")
        clear
        systemctl list-units --type=service --state=running
        pause
        break
        ;;
      "Failed Services")
        clear
        local failed
        failed=$(systemctl --failed --no-legend)
        if [[ -z "$failed" ]]; then
          msg_success "No failed services. System is healthy."
        else
          systemctl list-units --type=service --state=failed
        fi
        pause
        break
        ;;
      "Enabled Services")
        clear
        systemctl list-unit-files --type=service --state=enabled
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

modify_services() {
  while true; do
    clear
    draw_box "MANAGE SERVICES"
    local services
    mapfile -t services < <(systemctl list-units --type=service --state=running --no-legend --plain | awk '{print $1}')
    services+=("Back")

    select service in "${services[@]}"; do
      case $service in
      "Back")
        clear
        return
        ;;
      *)
        msg_info "Elegiste: $service"
        break
        ;;
      esac
    done
  done
}

show_system_services() {
  while true; do
    clear
    draw_box "SYSTEM SERVICES"
    local system_menu
    system_menu=("View Services" "Manage Services" "Back")
    select option in "${system_menu[@]}"; do
      case $option in
      "View Services")
        clear
        view_services
        break
        ;;
      "Manage Services")
        clear
        modify_services
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
