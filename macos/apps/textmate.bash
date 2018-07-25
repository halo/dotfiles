# Don't mess with my Tabs
defaults write com.macromates.TextMate disableTabReordering -bool true

# Don't jump around in File Browser
defaults write com.macromates.TextMate autoRevealFile -bool false

# Always wrap around search
defaults write com.macromates.TextMate findWrapAround -bool true

# Tabs all the way through
defaults write com.macromates.TextMate tabsAboveDocument -bool false

# Allow rather narrow tabs
defaults write com.macromates.TextMate tabItemMinWidth -int 50

# Truncate the filename in the tabs
defaults write com.macromates.TextMate tabItemLineBreakStyle -int 2

# Show file browser to the right
defaults write com.macromates.TextMate fileBrowserPlacement right

# Always show the tab bar
defaults write com.macromates.TextMate disableTabBarCollapsing -bool true

# Set Environment variables
defaults write com.macromates.TextMate environmentVariables -array

defaults write com.macromates.TextMate environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_RUBY</string>
    <key>value</key><string>$(which ruby)</string>
  </dict>"

defaults write com.macromates.TextMate environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_RUBOCOP</string>
    <key>value</key><string>$(which rubocop)</string>
  </dict>"

defaults write com.macromates.TextMate environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>RBENV_VERSION</string>
    <key>value</key><string>2.4.1</string>
  </dict>"

defaults write com.macromates.TextMate environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_NODE</string>
    <key>value</key><string>$(which node)</string>
  </dict>"

defaults write com.macromates.TextMate environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_SASS_LINT</string>
    <key>value</key><string>$(which sass-lint)</string>
  </dict>"

defaults write com.macromates.TextMate environmentVariables -array-add \
  "<dict>
    <key>enabled</key><true/>
    <key>name</key><string>TM_PASSENGER_CONFIG</string>
    <key>value</key><string>$(which passenger-config)</string>
  </dict>"
