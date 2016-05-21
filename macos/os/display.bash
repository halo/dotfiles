#!/bin/bash

# Show HiDPI display modes to enable low-resolution but high quality on regular screens
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true

# Dim the scren when on battery
sudo pmset -a halfdim 0
sudo pmset -b halfdim 1
