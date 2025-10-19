#!/usr/bin/env bash
selected=$(ls ~/scripts/ | rofi -dmenu -p "Run: ") && bash ~/scripts/$selected
