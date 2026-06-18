#!/bin/bash

confirm() {
  local message="$1"
  read -rp "$message (y/n): " answer
  if [[ "${answer,,}" == "y" ]]; then
    return 0
  else
    return 1
  fi
}

pause() {
  read -srn 1 -p "Press any key to continue..."
  printf "\n"
}

check_sudo() {
  if ! command -v sudo &>/dev/null; then
    return 1
  fi
}

bytes_formatter() {
  local bytes="$1"

  if [[ "$bytes" -lt 1024 ]]; then
    printf "%d B\n" "$bytes"
  elif [[ "$bytes" -lt 1048576 ]]; then
    awk "BEGIN { printf \"%.2f KB\n\", $bytes / 1024 }"
  elif [[ "$bytes" -lt 1073741824 ]]; then
    awk "BEGIN { printf \"%.2f MB\n\", $bytes / 1048576 }"
  else
    awk "BEGIN { printf \"%.2f GB\n\", $bytes / 1073741824 }"
  fi
}
