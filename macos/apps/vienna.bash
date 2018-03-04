# Disable sparkle autoupdates
defaults write uk.co.opencommunity.vienna2 SUEnableAutomaticChecks -bool false

# Sparkle Anonymity
defaults write uk.co.opencommunity.vienna2 SUSendProfileInfo -bool false

# Updated articles only manually
defaults write uk.co.opencommunity.vienna2 CheckForNewMessagesOnStartup -bool false
defaults write uk.co.opencommunity.vienna2 CheckForUpdatedArticles -bool false

# Don't use built-in webkit for links
defaults write uk.co.opencommunity.vienna2 OpenLinksInVienna -bool false

# Empty trash on quit without warning
defaults write uk.co.opencommunity.vienna2 EmptyTrashNotification -bool true
