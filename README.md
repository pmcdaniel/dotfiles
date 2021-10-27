# dotfiles

These are my version of dotfiles.  There are many like it, but this one is mine.  They are now based on [Oh My Zsh](https://ohmyz.sh) and therefore a required component of using these dotfiles.

## Prerequisites

You must install Oh My Zsh with the following command:

```sh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## Install

Run:

```sh
git clone https://github.com/pmcdaniel/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

This will ask you for your author name and email address to setup the git config and then symlink the appropriate files in `.dotfiles` to your home directory.  All changes should be done in the `~/.dotfiles` directory

This will also set defaults on macOS based on the `macos/set-defaults.sh` script.

## Optional Things

### Homebrew

I like homebrew and to install it run the following command:

```sh
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Setting Hostname
I did not add this to the scripts, but typically change the hostname of my machines.  Where is a quick set of commands to do it

```sh
COMPUTER_NAME="pmcdaniel"

sudo scutil --set ComputerName "${COMPUTER_NAME}"
sudo scutil --set HostName "${COMPUTER_NAME}"
sudo scutil --set LocalHostName "${COMPUTER_NAME}"
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${COMPUTER_NAME}"
```


