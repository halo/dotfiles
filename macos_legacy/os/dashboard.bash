#!/bin/bash

# Disable Dashboard alltogether
defaults write com.apple.dashboard mcx-disabled -bool true

# Don’t show Dashboard as a Space, but as overlay
defaults write com.apple.dock dashboard-in-overlay -bool true

# Activate Dashboard dev mode (allows keeping widgets on the desktop)
defaults write com.apple.dashboard devmode -bool true
