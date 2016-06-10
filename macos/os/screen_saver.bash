#!/bin/bash

# Finding the newest relevant preference file
filename="$(ls -t $HOME/Library/Preferences/ByHost/com.apple.screensaver.*.plist | head -1)"

# System Settings -> Screen Saver -> Flurry
/usr/libexec/PlistBuddy -c "Delete :moduleDict:moduleName" $filename &> /dev/null
/usr/libexec/PlistBuddy -c "Delete :moduleDict:type" $filename &> /dev/null
/usr/libexec/PlistBuddy -c "Delete :moduleDict:path" $filename &> /dev/null
/usr/libexec/PlistBuddy -c "Add :moduleDict:moduleName string Flurry" $filename &> /dev/null
/usr/libexec/PlistBuddy -c "Add :moduleDict:type int 0" $filename &> /dev/null
/usr/libexec/PlistBuddy -c "Add :moduleDict:path string '/System/Library/Screen Savers/Flurry.saver'" $filename &> /dev/null

# System Settings -> Screen Saver -> Start after -> Never
defaults write $filename idleTime -int 0

