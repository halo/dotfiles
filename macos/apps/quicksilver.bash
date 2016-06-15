# Don't show anything in the Dock
defaults write com.blacktree.Quicksilver "Hide Dock Icon" -bool true

# Skip first-time setup
defaults write com.blacktree.Quicksilver QSAgreementAccepted -bool true
defaults write com.blacktree.Quicksilver "Setup Assistant Completed" -bool true

# Use CMD+. to activate
defaults write com.blacktree.Quicksilver QSActivationHotKey -dict keyCode 47 modifiers 1048848
