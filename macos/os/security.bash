#!/bin/bash

# System Preferences -> Security -> General -> Require password after -> 3 seconds
defaults write com.apple.screensaver askForPassword -bool true
defaults write com.apple.screensaver askForPasswordDelay -int 3

# System Preferences -> Security -> General -> Allow apps from App Store and Gatekeeper-enabled apps
sudo spctl --master-enable

# Do not warn about executing applications downloaded from the Internet
# Unfortunately this effectively disables Gatekeeper, which we just activated above :(
defaults write com.apple.LaunchServices LSQuarantine -bool false

# System Preferences -> Security -> Firewall -> Turn on
defaults write com.apple.alf globalstate -int 1

# System Preferences -> Security -> Firewall -> Advanced -> Allow signed software to receive incoming connections
defaults write com.apple.alf allowsignedenabled -bool true

# System Preferences -> Security -> Firewall -> Advanced -> Disable stealth mode
defaults write com.apple.alf stealthenabled -bool false

# Don't keep the FileVault password around in the firmware while sleeping
sudo pmset -a destroyfvkeyonstandby 1
