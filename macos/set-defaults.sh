#!/bin/sh
# Sets reasonable macOS defaults.
#
# Or, in other words, set shit how I like in macOS.
#
# The original idea (and a couple settings) were grabbed from:
#  https://github.com/mathiasbynens/dotfiles/blob/master/.macos
#
# Run ./set-defaults.sh and you'll be good to go.

###############################################################################
# Finder
###############################################################################

# "Use AirDrop over every interface"
defaults write com.apple.NetworkBrowser BrowseAllInterfaces 1

# "Always open everything in Finder's list view"
defaults write com.apple.finder FXPreferredViewStyle Nlsv

# "Keep folders on top when sorting by name"
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# "When performing a search, search the current folder by default"
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# "Set the Finder prefs for showing a few different volumes on the Desktop"
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true

# "Set Home as the default location for new Finder windows"
defaults write com.apple.finder NewWindowTarget -string "PfHm"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/"

# "Show filename extensions"
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# "Show status bar in Finder windows"
defaults write com.apple.finder ShowStatusBar -bool true

# "Show path bar in Finder windows"
defaults write com.apple.finder ShowPathbar -bool true

# "Avoid creating .DS_Store files on network or USB volumes"
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# "Automatically open a new Finder window when a volume is mounted"
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# "Show the ~/Library folder"
chflags nohidden ~/Library

###############################################################################
# General
###############################################################################

# "Always show scrollbars"
defaults write NSGlobalDomain AppleShowScrollBars -string "Always"

# "Save screenshots to the desktop"
defaults write com.apple.screencapture location -string "${HOME}/Desktop"

# "Save screenshots in PNG format"
defaults write com.apple.screencapture type -string "png"

# "Disable shadow in screenshots"
defaults write com.apple.screencapture disable-shadow -bool true

# "Require password immediately after sleep or screen saver beings"
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

###############################################################################
# Keyboard
###############################################################################

# "Disable press-and-hold for keys in favor of key repeat"
defaults write -g ApplePressAndHoldEnabled -bool false

# "Set a really fast key repeat"
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10

# "Enable full keyboard access for all controls"
defaults write NSGlobalDomain AppleKeyboardUIMode -int 3

###############################################################################
# Track Pad
###############################################################################

# "Enable tap to click for this user and for the login screen"
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write NSGlobalDomain com.apple.mouse.tapBehavior -int 1
defaults write NSGlobalDomain com.apple.mouse.tapBehavior -int 1

###############################################################################
# Dock, Hot Corners, Spaces
###############################################################################

# "Do not automatically rearrange Spaces based on most recent use"
defaults write com.apple.dock mru-spaces -bool false

# "Do not switch Spaces when opening application windows"
defaults write NSGlobalDomain AppleSpacesSwitchOnActivate -bool false

# "Automatically hide and show the dock"
defaults write com.apple.dock autohide -bool true

# "Remove the auto-hiding dock delay"
defaults write com.apple.dock autohide-delay -float 0

# "bottom-left hot corner -> disable"
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

# "top-left hot corner -> disable"
defaults write com.apple.dock wvous-tl-corner -int 0
defaults write com.apple.dock wvous-tl-modifier -int 0

# "bottom-right hot corner -> put display to sleep"
defaults write com.apple.dock wvous-br-corner -int 10
defaults write com.apple.dock wvous-br-modifier -int 0

# "top-right hot corner -> disable"
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0

# "Hide recent apps from Dock"
defaults write com.apple.dock show-recents -bool false

# "Place the Dock on the left side of the screen"
defaults write com.apple.dock orientation left

###############################################################################
# Safari
###############################################################################

# "Hide Safari's bookmark bar"
defaults write com.apple.Safari ShowFavoritesBar -bool false

# "Set up Safari for development"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
