#!/bin/bash

# Don't send Spotlight searches to Apple or Microsoft
# El Capitan default looks like this as of May 2016:
#
#  '{"enabled" = 1; "name" = "APPLICATIONS";}' \
#  '{"enabled" = 1; "name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
#  '{"enabled" = 1; "name" = "MENU_CONVERSION";}' \
#  '{"enabled" = 1; "name" = "MENU_EXPRESSION";}' \
#  '{"enabled" = 1; "name" = "MENU_DEFINITION";}' \
#  '{"enabled" = 1; "name" = "SYSTEM_PREFS";}' \
#  '{"enabled" = 1; "name" = "DOCUMENTS";}' \
#  '{"enabled" = 1; "name" = "DIRECTORIES";}' \
#  '{"enabled" = 1; "name" = "PRESENTATIONS";}' \
#  '{"enabled" = 1; "name" = "SPREADSHEETS";}' \
#  '{"enabled" = 1; "name" = "PDF";}' \
#  '{"enabled" = 1; "name" = "MESSAGES";}' \
#  '{"enabled" = 1; "name" = "CONTACT";}' \
#  '{"enabled" = 1; "name" = "EVENT_TODO";}' \
#  '{"enabled" = 1; "name" = "IMAGES";}' \
#  '{"enabled" = 1; "name" = "BOOKMARKS";}' \
#  '{"enabled" = 1; "name" = "MUSIC";}' \
#  '{"enabled" = 1; "name" = "MOVIES";}' \
#  '{"enabled" = 1; "name" = "FONTS";}' \
#  '{"enabled" = 1; "name" = "MENU_OTHER";}' \
#  '{"enabled" = 1; "name" = "MENU_WEBSEARCH";}'
#
defaults write com.apple.spotlight orderedItems -array \
  '{"enabled" = 0; "name" = "APPLICATIONS";}' \
  '{"enabled" = 0; "name" = "MENU_CONVERSION";}' \
  '{"enabled" = 0; "name" = "MENU_EXPRESSION";}' \
  '{"enabled" = 0; "name" = "MENU_DEFINITION";}' \
  '{"enabled" = 0; "name" = "SYSTEM_PREFS";}' \
  '{"enabled" = 0; "name" = "DOCUMENTS";}' \
  '{"enabled" = 0; "name" = "DIRECTORIES";}' \
  '{"enabled" = 0; "name" = "PRESENTATIONS";}' \
  '{"enabled" = 0; "name" = "SPREADSHEETS";}' \
  '{"enabled" = 0; "name" = "PDF";}' \
  '{"enabled" = 0; "name" = "MESSAGES";}' \
  '{"enabled" = 0; "name" = "CONTACT";}' \
  '{"enabled" = 0; "name" = "EVENT_TODO";}' \
  '{"enabled" = 0; "name" = "IMAGES";}' \
  '{"enabled" = 0; "name" = "BOOKMARKS";}' \
  '{"enabled" = 0; "name" = "MUSIC";}' \
  '{"enabled" = 0; "name" = "MOVIES";}' \
  '{"enabled" = 0; "name" = "FONTS";}' \
  '{"enabled" = 0; "name" = "MENU_OTHER";}' \
  '{"enabled" = 1; "name" = "SOURCE";}' \
  '{"enabled" = 0; "name" = "MENU_WEBSEARCH";}' \
  '{"enabled" = 0; "name" = "MENU_SPOTLIGHT_SUGGESTIONS";}'
