#!/bin/bash

# Bedtime color
defaults write org.herf.Flux nightColorTemp -int 4300

# Sunset color
defaults write org.herf.Flux lateColorTemp -int 3000

# Wake up time
defaults write org.herf.Flux wakeTime -int 420
