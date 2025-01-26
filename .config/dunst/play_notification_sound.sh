#!/usr/bin/env bash
set -e
case $DUNST_URGENCY in
"LOW")
    mpv ~/.local/share/sounds/notifications/Taptap.ogg
    ;;
"NORMAL")
    mpv ~/.local/share/sounds/notifications/Taptap.ogg
    ;;
"CRITICAL")
    mpv ~/.local/share/sounds/notifications/Alarmed.ogg
    ;;
esac
