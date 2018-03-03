#!/bin/bash

# System Preferences -> Dock -> Double-click a window's title bar to -> zoom
defaults write NSGlobalDomain AppleActionOnDoubleClick Maximize
defaults write NSGlobalDomain AppleMiniaturizeOnDoubleClick -bool false

# System Preferences -> General -> Appearance -> Green
defaults write NSGlobalDomain AppleAquaColorVariant -int 1

# System Preferences -> General -> Use dark menu bar and Dock
defaults write NSGlobalDomain AppleInterfaceStyle Dark

# System Preferences -> General -> Highlight Color -> Green
defaults write NSGlobalDomain AppleHighlightColor "0.752941 0.964706 0.678431"

# System Preferences -> General -> Click in the scroll bar to -> Jump to the spot that's clicked
defaults write NSGlobalDomain AppleScrollerPagingBehavior -int 1

# System Preferences -> General -> Show scroll bars -> Based on mouse or trackpad
defaults write NSGlobalDomain AppleShowScrollBars Automatic

# System Preferences -> General -> No not reinstate window states (bad for terminal, quicktime, etc.)
defaults write NSGlobalDomain NSQuitAlwaysKeepsWindows -bool false

# Hot Corners -> Top right -> Desktop
defaults write com.apple.dock wvous-tr-corner -int 4
defaults write com.apple.dock wvous-tr-modifier -int 0

# Hot Corners -> Bottom left -> Screen saver
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# Hot Corners -> Bottom Right → Mission Control
defaults write com.apple.dock wvous-br-corner -int 2
defaults write com.apple.dock wvous-br-modifier -int 0

# Do not pop-animate the blue ring around a focused text-field
defaults write NSGlobalDomain NSUseAnimatedFocusRing -bool false

# Set desktop background picture to dark gray
osascript <<END
set defaultImagePath to "/System/Library/CoreServices/DefaultDesktop.jpg"
set wantedImagePath to "/Library/Desktop Pictures/Solid Colors/Solid Gray Pro Dark.png"

tell application "System Events"
    repeat with currentDesktop in desktops
      set imagePath to (picture of currentDesktop)
      if imagePath is defaultImagePath then
        set picture of currentDesktop to wantedImagePath
      end if
    end repeat
end tell
END
