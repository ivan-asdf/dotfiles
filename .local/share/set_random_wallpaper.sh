#!/bin/bash

selectedWallpaper=$(find $HOME/.local/share/wallpapers/ -type f | shuf -n 1)
swww img "$selectedWallpaper" -t wave

