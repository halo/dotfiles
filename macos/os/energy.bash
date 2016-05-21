#!/bin/bash

# Automatic termination of inactive apps -> Never terminate them
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Never fall asleep
sudo pmset -a displaysleep 0 sleep 0 disksleep 0 autopoweroffdelay 0 autopoweroff 0

# Never wake up automatically
sudo pmset -a womp 0 ring 0 acwake 0 darkwakes 0 powernap 0

# Wait two hours before going from sleep (RAM) to standby (disk)
sudo pmset -a standby 1 standbydelay 7200

# Restart automatically if the computer freezes -> Yes
sudo systemsetup -setrestartfreeze on
