#!/usr/bin/env bash
set -euo pipefail
cctk="/opt/dell/dcc/cctk"

case "${1:-}" in
dock)
  powerprofilesctl set performance
  sudo $cctk --ThermalManagement=UltraPerformance
  sudo $cctk --PrimaryBattChargeCfg=Custom:50-60
  powerprofilesctl get
  ;;
max)
  powerprofilesctl set performance
  sudo $cctk --ThermalManagement=UltraPerformance
  sudo $cctk --PrimaryBattChargeCfg=Standard
  powerprofilesctl get
  ;;
min)
  powerprofilesctl set power-saver
  sudo $cctk --ThermalManagement=Cool
  sudo $cctk --PrimaryBattChargeCfg=Express
  powerprofilesctl get
  ;;
*)
  echo "Usage: $(basename "$0") {dock|max|min}" >&2
  exit 1
  ;;
esac
