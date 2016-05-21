#!/bin/bash

# System Preferences -> Mission Control -> Automatically rearrange Spaces based on use -> No
defaults write com.apple.dock mru-spaces -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Group windows by application in Mission Control
defaults write com.apple.dock expose-group-by-app -bool true

# System Preferences -> Mission Control -> Shortcuts -> Mission Control -> None
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 32 "{enabled = 0;}"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 34 "{enabled = 0;}"

# System Preferences -> Mission Control -> Shortcuts -> Application Windows -> None
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 33 "{enabled = 0;}"
defaults write com.apple.symbolichotkeys.plist AppleSymbolicHotKeys -dict-add 35 "{enabled = 0;}"

