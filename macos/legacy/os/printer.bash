#!/bin/bash

# Print Panel -> Expand by default
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint -bool true
defaults write NSGlobalDomain PMPrintingExpandedStateForPrint2 -bool true

# Printing -> Quit printer when jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true
