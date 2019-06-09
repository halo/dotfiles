#!/bin/bash

# No first-boot bla bla
defaults write com.agilebits.onepassword4 CompletedEssentialSettings -bool true
defaults write com.agilebits.onepassword4 WelcomeWindowShown -bool true

# No phoning home
defaults write com.agilebits.onepassword4 HockeySDKAutomaticallySendCrashReports -bool false
defaults write com.agilebits.onepassword4 HockeySDKCrashReportActivated -bool false
defaults write com.agilebits.onepassword4 UserMetricsSkippedNewsletterSignupKey -bool true

# Show mini app in menu bar
defaults write com.agilebits.onepassword4 ShowStatusItem -bool true

# Keep 1Password mini alive
defaults write com.agilebits.onepassword4 KeepHelperRunning -bool true

# Lock after computer is idle
defaults write com.agilebits.onepassword4 LockOnIdle -bool true

# No need for predefined icons
defaults write com.agilebits.onepassword4 ShowRichIcons -bool false
