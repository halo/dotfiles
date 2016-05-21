#!/bin/bash

# Don't mess with my Tabs
defaults write com.macromates.TextMate.preview disableTabReordering -bool true

# Don't jump around in File Browser
defaults write com.macromates.TextMate.preview autoRevealFile -bool false

# Always wrap around search
defaults write com.macromates.TextMate.preview findWrapAround -bool true

# Tabs all the way through
defaults write com.macromates.TextMate.preview tabsAboveDocument -bool false

# Show file browser to the right
defaults write com.macromates.TextMate.preview fileBrowserPlacement right

# Always show the tab bar
defaults write com.macromates.TextMate.preview disableTabBarCollapsing -bool true
