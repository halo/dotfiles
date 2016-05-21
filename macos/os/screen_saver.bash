#!/bin/bash

# Finding the newest relevant preference file
filename="$(ls -t ~/Library/Preferences/ByHost/com.apple.screensaver.*.plist | head -1)"

# System Settings -> Screen Saver -> Flurry
defaults write $filename moduleDict -dict moduleName Flurry path /System/Library/Screen\ Savers/Flurry.saver type 0

# System Settings -> Screen Saver -> Start after -> Never
defaults write $filename idleTime -int 0

