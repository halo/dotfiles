#!/bin/bash

# Window open/close Animations -> Off
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false

# Window resize speed -> Fast
defaults write NSGlobalDomain NSWindowResizeTime -float 0.001

# Sidebar Icon Size -> Medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Save Panel -> Expand by default
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -bool true
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -bool true

# Document saving -> To disk, not iCloud
defaults write NSGlobalDomain NSDocumentSaveNewDocumentsToCloud -bool false

# Allow quitting with CMD+Q
defaults write com.apple.finder QuitMenuItem -bool true

# Hard drives on Desktop -> Show
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true

# Remote servers on Desktop -> Hide
defaults write com.apple.finder ShowMountedServersOnDesktop -bool false

# External drives on Desktop -> Show
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Status Bar -> Show
defaults write com.apple.finder ShowStatusBar -bool true

# File Extensions -> Always show
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# View Type -> Columns
defaults write com.apple.finder FXPreferredViewStyle clmv

# Airdrop -> Enable on Ethernet
defaults write com.apple.NetworkBrowser BrowseAllInterfaces -bool true

# Hide from Desktop -> local Hard disks
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool false

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Allow text selection in Quick Look
defaults write com.apple.finder QLEnableTextSelection -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# Search the current folder by default
defaults write com.apple.finder FXDefaultSearchScope SCcf

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write NSGlobalDomain com.apple.springing.enabled -bool true

# Remove spring loading delay for directories
defaults write NSGlobalDomain com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true

# New Windows open at home folder
defaults write com.apple.finder NewWindowTarget PfHm

# Disable "Get Info" and other animations
defaults write com.apple.finder DisableAllAnimations -bool true

if [[ $USER == "orange" ]] || [[ $USER == "blue" ]]; then
  # User Library Directory -> Show
  chflags nohidden ~/Library
else
  # User Library Directory -> Hide
  chflags hidden ~/Library
fi

# Expand these panes in the "Get Info" for files and folders
defaults write com.apple.finder FXInfoPanesExpanded -dict \
  General -bool true \
  OpenWith -bool false \
  Preview -bool false \
  Privileges -bool false \
  Comments -bool false \
  MetaData -bool false \
  Name -bool false

# Show the sidebar
defaults write com.apple.finder ShowSidebar -bool true

# Hide Tags in the Sidebar
defaults write com.apple.finder ShowRecentTags -bool false

# Ensure that the home folder is in the favorites sidebar
# sfltool dump-storage ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.FavoriteItems.sfl

sfltool dump-storage ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.FavoriteItems.sfl > /tmp/favorites.dump

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file:///\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file:/// > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file://#{ENV["HOME"]}\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file://$HOME > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file://#{ENV["HOME"]}/Desktop\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file://$HOME/Desktop > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file://#{ENV["HOME"]}/Downloads\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file://$HOME/Downloads > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file://#{ENV["HOME"]}/Documents\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file://$HOME/Documents > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file://#{ENV["HOME"]}/Pictures\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file://$HOME/Pictures > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("file:///Applications\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems file:///Applications > /dev/null
fi

if ruby -e 'abort if File.read("/tmp/favorites.dump").include?("nwnode://domain-AirDrop\n")'; then
  sfltool add-item com.apple.LSSharedFileList.FavoriteItems nwnode://domain-AirDrop > /dev/null
fi
