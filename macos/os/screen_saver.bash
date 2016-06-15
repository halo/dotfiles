#!/bin/bash

defaults -currentHost write com.apple.screensaver moduleDict -dict \
  moduleName Flurry \
  path "/System/Library/Screen Savers/Flurry.saver" \
  type -int 0 \

defaults -currentHost write com.apple.screensaver idleTime -int 0
