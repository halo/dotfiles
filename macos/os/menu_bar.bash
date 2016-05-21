#!/bin/bash

# Battery -> Show Percentage -> Yes
defaults write com.apple.menuextra.battery ShowPercent -string "YES"

# Clock -> Format
defaults write com.apple.menuextra.clock DateFormat "EEE d. MMM  HH:mm"

# Choose which Icons to show
defaults write com.apple.systemuiserver menuExtras -array "/System/Library/CoreServices/Menu Extras/VPN.menu" "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" "/System/Library/CoreServices/Menu Extras/AirPort.menu" "/System/Library/CoreServices/Menu Extras/Battery.menu" "/System/Library/CoreServices/Menu Extras/Clock.menu"

# VPN -> Show connected time
defaults write com.apple.networkConnect VPNShowTime -int 1

# VPN -> Show when connecting
defaults write com.apple.networkConnect VPNShowStatus -int 1
