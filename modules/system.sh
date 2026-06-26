#!/bin/bash

show_ram() {
  local mem_total mem_available usage_ram
  mem_total=$(grep "^MemTotal:" /proc/meminfo | awk -v factor=1024 '{print $2 * factor}')
  mem_available=$(grep "^MemAvailable:" /proc/meminfo | awk -v factor=1024 '{print $2 * factor}')
  usage_ram=$(($mem_total - $mem_available))

  printf "%-12s %s\n" "Total:" "$(bytes_formatter "$mem_total")"
  printf "%-12s %s\n" "Used:" "$(bytes_formatter "$usage_ram")"
  printf "%-12s %s\n" "Available:" "$(bytes_formatter "$mem_available")"
}

show_disk() {
  printf "%-12s %-8s %-8s %-8s %s\n" "Mount" "Size" "Used" "Avail" "Use%"
  df -h | grep "^/dev/" | awk '{printf "%-12s %-8s %-8s %-8s %s\n", $6, $2, $3, $4, $5}'
}

show_cpu() {
  local model cores threads
  model=$(grep -m1 "^model name" /proc/cpuinfo | cut -d: -f2 | xargs)
  cores=$(grep -m1 "^cpu cores" /proc/cpuinfo | cut -d: -f2 | xargs)
  threads=$(nproc)
  printf "%-12s %s\n" "Model:" "$model"
  printf "%-12s %s\n" "Cores:" "$cores"
  printf "%-12s %s\n" "Threads:" "$threads"
}

show_temp() {
  if ! command -v sensors &>/dev/null; then
    msg_error "lm_sensors is not installed."
    msg_info "Please install lm_sensors to run this section."
    return 1
  fi

  local temp
  temp=$(sensors | grep "^Tctl:" | awk '{print $2}')

  if [[ -z "$temp" ]]; then
    msg_warning "CPU temperature not available on this system."
    return 1
  else
    printf "%-12s %s\n" "CPU Temp:" "$temp"
    return 0
  fi

}
