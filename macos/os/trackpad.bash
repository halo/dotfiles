#!/bin/bash

# System Preferences -> Trackpad -> Secondary click -> Look up and data detectors -> Tap with three fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerTapGesture -int 2

# System Preferences -> Trackpad -> Secondary click -> Two fingers
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -int 1

# System Preferences -> Trackpad -> Tap to click -> Yes
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
