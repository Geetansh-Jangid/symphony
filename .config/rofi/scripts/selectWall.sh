#!/bin/bash

wallDIR="$HOME/Wallpapers/"
SWWW_PARAMS="--transition-fps 60 --transition-type=any --transition-duration=1"

# Get focused monitor (fallback to HDMI-A-1)
focused_monitor=$(hyprctl -j monitors | jq -r '.[] | select(.focused==true).name')
focused_monitor="${focused_monitor:-HDMI-A-1}"

# Get wallpaper files
mapfile -d '' wallpapers < <(find "${wallDIR}" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" \) -print0)

# Build rofi menu with icons
menu() {
  for wallpaper in "${wallpapers[@]}"; do
    name=$(basename "$wallpaper")
    printf "%s\x00icon\x1f%s\n" "$name" "$wallpaper"
  done | sort
}

# Start swww daemon if needed
swww query &>/dev/null || swww-daemon --format xrgb

# Show menu and get selection
choice=$(menu | rofi -i -dmenu -config ~/.config/rofi/custom-rofi/config-wallpaper.rasi)

# Exit if nothing selected
[[ -z "$choice" ]] && exit 0

# Find selected wallpaper and set it
for wallpaper in "${wallpapers[@]}"; do
  if [[ "$(basename "$wallpaper")" == "$choice" ]]; then
    swww img -o "$focused_monitor" "$wallpaper" $SWWW_PARAMS
    break
  fi
done
