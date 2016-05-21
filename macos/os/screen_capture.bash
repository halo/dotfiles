#!/bin/bash

# Saving location -> Desktop
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# Format -> PNG
defaults write com.apple.screencapture type jpg

# Window Shadows -> Disable
defaults write com.apple.screencapture disable-shadow -bool true
