#!/bin/bash

# System Preferences -> Sound -> Don't play feedback when volume is changed
defaults write NSGlobalDomain com.apple.sound.beep.feedback -int 0

# System Preferences -> Sound -> Disable UI audio
defaults write NSGlobalDomain com.apple.sound.uiaudio.enabled -int 0

# Disable the sound effects on boot
sudo nvram SystemAudioVolume=%00
