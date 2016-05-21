#!/bin/bash

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make the Dock appear and disappear really fast
defaults write com.apple.dock autohide-delay -float 0

# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Rather small Dock icons
defaults write com.apple.dock tilesize -int 27

# Do not magnify the icons on hover
defaults write com.apple.dock magnification -bool false

# Place the Dock at the bottom of the screen
defaults write com.apple.dock orientation bottom

# Scale animation is not as explicit as Genie, but it's faster
defaults write com.apple.dock mineffect scale

# Open files and folders when dragging something onto them
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Don't minimize windows into their icon, place them to the right
defaults write com.apple.dock minimize-to-application -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true
