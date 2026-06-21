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
