#!/bin/bash

# Wake up time 7:00
defaults write org.herf.Flux wakeTime -int 420

# Sunset color
defaults write org.herf.Flux lateColorTemp -int 3000

# Bedtime color
defaults write org.herf.Flux nightColorTemp -int 4300

# Geolocation
defaults write org.herf.Flux location "64.963051,-19.020835"
defaults write org.herf.Flux locationTextField Iceland
defaults write org.herf.Flux locationType L
