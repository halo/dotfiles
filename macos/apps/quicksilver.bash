# Don't show anything in the Dock
defaults write com.blacktree.Quicksilver "Hide Dock Icon" -bool true

# Skip first-time setup
defaults write com.blacktree.Quicksilver QSAgreementAccepted -bool true
defaults write com.blacktree.Quicksilver "Setup Assistant Completed" -bool true

# Use CMD+. to activate
defaults write com.blacktree.Quicksilver QSActivationHotKey -dict keyCode -int 47 modifiers -int 1048848

# Nicer layout for the main window
defaults write com.blacktree.Quicksilver QSCommandInterfaceControllers QSBezelInterfaceController
