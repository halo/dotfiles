#!/bin/bash

# Default Black Terminal Style
defaults write com.apple.Terminal "Default Window Settings" -string Pro

# Startup Black Terminal Style
defaults write com.apple.Terminal "Startup Window Settings" -string Pro

# New Tabs always open Home directory
defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -int 1

# Use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# No audio bells, just visual
/usr/libexec/PlistBuddy                                     \
    -c "Delete :WindowSettings:Basic:Bell"                  \
    -c "Add    :WindowSettings:Basic:Bell       bool false" \
    -c "Delete :WindowSettings:Basic:VisualBell"            \
    -c "Add    :WindowSettings:Basic:VisualBell bool true"  \
    ~/Library/Preferences/com.apple.terminal.plist
