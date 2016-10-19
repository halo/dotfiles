#!/bin/bash

# Don't mess with my Tabs
defaults write com.macromates.TextMate.preview disableTabReordering -bool true

# Don't jump around in File Browser
defaults write com.macromates.TextMate.preview autoRevealFile -bool false

# Always wrap around search
defaults write com.macromates.TextMate.preview findWrapAround -bool true

# Tabs all the way through
defaults write com.macromates.TextMate.preview tabsAboveDocument -bool false

# Allow rather narrow tabs
defaults write com.macromates.TextMate.preview tabItemMinWidth -int 50

# Truncate the filename in the tabs
defaults write com.macromates.TextMate.preview tabItemLineBreakStyle -int 2

# Show file browser to the right
defaults write com.macromates.TextMate.preview fileBrowserPlacement right

# Always show the tab bar
defaults write com.macromates.TextMate.preview disableTabBarCollapsing -bool true

# Set Environment variables
defaults write com.macromates.TextMate.preview environmentVariables -array

defaults write com.macromates.TextMate.preview environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_RUBY</string>
    <key>value</key><string>$(which ruby)</string>
  </dict>"

defaults write com.macromates.TextMate.preview environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>RBENV_VERSION</string>
    <key>value</key><string>2.2.4</string>
  </dict>"

defaults write com.macromates.TextMate.preview environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_NODE</string>
    <key>value</key><string>$(which node)</string>
  </dict>"
