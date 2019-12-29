#!/bin/bash

# Disable Bonjour multicast advertisements
# See https://www.trustwave.com/Resources/SpiderLabs-Blog/mDNS---Telling-the-world-about-you-%28and-your-device%29/
sudo defaults write /Library/Preferences/com.apple.mDNSResponder.plist NoMulticastAdvertisements -bool YES
