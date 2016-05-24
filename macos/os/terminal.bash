#!/bin/bash

# New Tabs always open Home directory
defaults write com.apple.Terminal NewTabWorkingDirectoryBehavior -int 1

# Use UTF-8
defaults write com.apple.terminal StringEncodings -array 4

# Create the halo Theme in a temporary folder
# This is a pure dump of the Terminal -> Themes -> Export
tee /tmp/Halo.terminal > /dev/null <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
  <key>ANSIBlueColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OVU5TUkdCXE5TQ29sb3JTcGFjZVYkY2xhc3NPECYw
  LjIwMzc3ODc1NzIgMC4zMzk2ODc4NjUgMC42Mzg5NTc2NzkzABABgALSEBESE1okY2xh
  c3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3RfEA9OU0tleWVkQXJjaGl2
  ZXLRFxhUcm9vdIABCBEaIy0yNztBSE5bYouNj5SfqLCzvM7R1gAAAAAAAAEBAAAAAAAA
  ABkAAAAAAAAAAAAAAAAAAADY
  </data>
  <key>ANSIBrightBlueColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OVU5TUkdCXE5TQ29sb3JTcGFjZVYkY2xhc3NPECcw
  LjIyNTcwNDI2MjQgMC42NzYzMDQ3MTQzIDAuOTk4MTg4OTcyNQAQAYAC0hAREhNaJGNs
  YXNzbmFtZVgkY2xhc3Nlc1dOU0NvbG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hp
  dmVy0RcYVHJvb3SAAQgRGiMtMjc7QUhOW2KMjpCVoKmxtL3P0tcAAAAAAAABAQAAAAAA
  AAAZAAAAAAAAAAAAAAAAAAAA2Q==
  </data>
  <key>ANSIRedColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OVU5TUkdCXE5TQ29sb3JTcGFjZVYkY2xhc3NPEBIx
  IDAuMDkzNjI2MzQzMTcgMAAQAYAC0hAREhNaJGNsYXNzbmFtZVgkY2xhc3Nlc1dOU0Nv
  bG9yohIUWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RcYVHJvb3SAAQgRGiMtMjc7
  QUhOW2J3eXuAi5Scn6i6vcIAAAAAAAABAQAAAAAAAAAZAAAAAAAAAAAAAAAAAAAAxA==
  </data>
  <key>BackgroundBlur</key>
  <real>0.0</real>
  <key>BackgroundColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OV05TV2hpdGVcTlNDb2xvclNwYWNlViRjbGFzc00w
  IDAuODUwMDAwMDIAEAOAAtIQERITWiRjbGFzc25hbWVYJGNsYXNzZXNXTlNDb2xvcqIS
  FFhOU09iamVjdF8QD05TS2V5ZWRBcmNoaXZlctEXGFRyb290gAEIERojLTI3O0FIUF1k
  cnR2e4aPl5qjtbi9AAAAAAAAAQEAAAAAAAAAGQAAAAAAAAAAAAAAAAAAAL8=
  </data>
  <key>CursorColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OV05TV2hpdGVcTlNDb2xvclNwYWNlViRjbGFzc0sw
  LjMwMjQxOTM2ABADgALSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRY
  TlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSFBdZHBy
  dHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAAC9
  </data>
  <key>EscapeNonASCIICharacters</key>
  <false/>
  <key>Font</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGGBlYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKQHCBESVSRudWxs1AkKCwwNDg8QVk5TU2l6ZVhOU2ZGbGFnc1ZOU05hbWVWJGNs
  YXNzI0AiAAAAAAAAEBCAAoADVk1vbmFjb9ITFBUWWiRjbGFzc25hbWVYJGNsYXNzZXNW
  TlNGb250ohUXWE5TT2JqZWN0XxAPTlNLZXllZEFyY2hpdmVy0RobVHJvb3SAAQgRGiMt
  Mjc8QktSW2JpcnR2eH+Ej5ifoqu9wMUAAAAAAAABAQAAAAAAAAAcAAAAAAAAAAAAAAAA
  AAAAxw==
  </data>
  <key>FontAntialias</key>
  <true/>
  <key>FontWidthSpacing</key>
  <real>0.99596774193548387</real>
  <key>ProfileCurrentVersion</key>
  <real>2.04</real>
  <key>SelectionColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OV05TV2hpdGVcTlNDb2xvclNwYWNlViRjbGFzc0sw
  LjI1NDAzMjI1ABADgALSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRY
  TlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSFBdZHBy
  dHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAAC9
  </data>
  <key>ShowWindowSettingsNameInTitle</key>
  <false/>
  <key>TextBoldColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OV05TV2hpdGVcTlNDb2xvclNwYWNlViRjbGFzc0Ix
  ABADgALSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRYTlNPYmplY3Rf
  EA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSFBdZGdpa3B7hIyPmKqt
  sgAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAAC0
  </data>
  <key>TextColor</key>
  <data>
  YnBsaXN0MDDUAQIDBAUGFRZYJHZlcnNpb25YJG9iamVjdHNZJGFyY2hpdmVyVCR0b3AS
  AAGGoKMHCA9VJG51bGzTCQoLDA0OV05TV2hpdGVcTlNDb2xvclNwYWNlViRjbGFzc0sw
  Ljk0NzU4MDY0ABADgALSEBESE1okY2xhc3NuYW1lWCRjbGFzc2VzV05TQ29sb3KiEhRY
  TlNPYmplY3RfEA9OU0tleWVkQXJjaGl2ZXLRFxhUcm9vdIABCBEaIy0yNztBSFBdZHBy
  dHmEjZWYobO2uwAAAAAAAAEBAAAAAAAAABkAAAAAAAAAAAAAAAAAAAC9
  </data>
  <key>UseBoldFonts</key>
  <true/>
  <key>UseBrightBold</key>
  <true/>
  <key>name</key>
  <string>Halo</string>
  <key>shellExitAction</key>
  <integer>2</integer>
  <key>type</key>
  <string>Window Settings</string>
</dict>
</plist>
EOF

# Add the halo Theme to Terminal
/usr/libexec/PlistBuddy -c "Add :Window\ Settings:Halo dict" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Merge /tmp/Halo.terminal :Window\ Settings:Halo" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1

# Set the halo Theme as default
defaults write com.apple.Terminal "Default Window Settings" Halo
defaults write com.apple.Terminal "Startup Window Settings" Halo

# Remove totally useless Themes
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Grass" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Homebrew" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Man\ Page" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Novel" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Ocean" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Red\ Sands" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Silver\ Aerogel" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1
/usr/libexec/PlistBuddy -c "Delete :Window\ Settings:Solid\ Colors" $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null 2>&1

# No audio bells, just visual
/usr/libexec/PlistBuddy \
  -c "Delete :Window\ Settings:Halo:Bell" \
  -c "Delete :Window\ Settings:Halo:VisualBell" \
  -c "Delete :Window\ Settings:Halo:VisualBellOnlyWhenMuted" \
  -c "Add :Window\ Settings:Halo:Bell bool false" \
  -c "Add :Window\ Settings:Halo:VisualBell bool true" \
  -c "Add :Window\ Settings:Halo:VisualBellOnlyWhenMuted bool false" \
  $HOME/Library/Preferences/com.apple.terminal.plist > /dev/null 2>&1

# Terminal itself overwrites everything on quit
# So we need to read the settings once to synchronize with the cache
defaults read $HOME/Library/Preferences/com.apple.Terminal.plist > /dev/null

