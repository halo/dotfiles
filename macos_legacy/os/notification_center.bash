#!/bin/bash

# Notification Center -> Begone
launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist &> /dev/null
