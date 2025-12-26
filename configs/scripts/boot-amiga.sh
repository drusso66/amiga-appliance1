#!/bin/bash

show_logo () {
  feh --fullscreen --hide-pointer --auto-zoom "$1" &
  LOGOPID=$!
  sleep 2
  kill $LOGOPID
}

CHOICE=$(printf "A1200 PAL\nA500 PAL\nCD32 PAL" | \
rofi -dmenu -i -p "Select Amiga")

case "$CHOICE" in
  "A1200 PAL")
    show_logo ~/amiga/logos/A1200.png
    exec winuae -f ~/amiga/configs/A1200_PAL.uae
    ;;
  "A500 PAL")
    show_logo ~/amiga/logos/A500.png
    exec winuae -f ~/amiga/configs/A500_PAL.uae
    ;;
  "CD32 PAL")
    show_logo ~/amiga/logos/CD32.png
    exec winuae -f ~/amiga/configs/CD32_PAL.uae
    ;;
esac
