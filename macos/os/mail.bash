#!/bin/bash

# Disable Reply Animations
defaults write com.apple.mail DisableReplyAnimations -bool true

# Disable Send Animations
defaults write com.apple.mail DisableSendAnimations -bool true

# Disable inline attachments (just show the icons)
defaults write com.apple.mail DisableInlineAttachmentViewing -bool true

# Disable Junk filter
defaults write com.apple.mail JunkMailBehavior -bool false
