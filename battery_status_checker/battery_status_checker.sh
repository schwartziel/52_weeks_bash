#!/bin/bash
set +x
upower_installed=false
if command -v upower >/dev/null 2>&1; then
    upower_installed=true
else
    echo "script requires upower. You can install with sudo apt-get / dnf ins / yay -Syu upower"
    exit 1
fi
if [ $upower_installed ]; then
    battery_percentage="$(upower --battery | awk 'NR == 25 {print $2}')"
    battery_capacity="$(upower --battery | awk 'NR == 26 {print $2}')"
    echo "Charge Percentage: $battery_percentage"
    echo "Capacity Left: $battery_capacity"
fi
