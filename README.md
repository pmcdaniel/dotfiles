# Dotfiles

These are my personal dotfiles. Feel free to use them, modify them, and send me back
any cool changes!

These dotfiles are primarily for macOS, with lightweight guards where Linux
support is practical. The default expected checkout path is `$HOME/.dotfiles`.
If you clone somewhere else, update `DOT_FILES` in `zsh/zshrc.symlink` or create
an equivalent `$HOME/.dotfiles` symlink.

## What Is Included

- `zsh/`: Zsh startup files, shell behavior, aliases, and prompt setup.
- `system/`: shared environment, aliases, PATH setup, and optional GRC support.
- `git/`: Git config, global ignore rules, and Git aliases.
- `bin/`: helper commands intended to be available on `PATH`.
- `functions/`: shell functions and Zsh completions loaded by the shell.
- `homebrew/` and `Brewfile`: Homebrew shell helpers and package list.
- `python/` and `go/`: language-specific shell environment setup.
- `macos/`: macOS defaults script.
- `vim/`: minimal Vim configuration.
- `xdg-config/`: XDG Base Directory app configuration, including Neovim,
  Ghostty, and Zed.

Files ending in `.symlink` are linked into `$HOME` without the `.symlink`
suffix. For example, `git/gitconfig.symlink` becomes `~/.gitconfig`.

Directories inside `xdg-config/` are linked into
`${XDG_CONFIG_HOME:-$HOME/.config}`.

## Install

Clone the repository to the expected location:

```sh
git clone https://github.com/pmcdaniel/dotfiles.git "$HOME/.dotfiles"
cd "$HOME/.dotfiles"
```

Run the installer:

```sh
./install.sh
```

During installation, the script will:

- prompt for Git author name, email, and SSH signing key path;
- create `git/gitconfig.local.symlink` from the template;
- link tracked `*.symlink` files into `$HOME`;
- link each top-level `xdg-config/` directory into
  `${XDG_CONFIG_HOME:-$HOME/.config}`;
- write `.install-manifest` so uninstall can remove managed links and restore
  backups.

When a target file or directory already exists, the installer prompts you to
overwrite it, back it up, skip it, or apply that choice to all remaining
conflicts.

Restart your shell after installing, or source the new Zsh config:

```sh
source "$HOME/.zshrc"
```

## Homebrew Packages

The `Brewfile` lists the expected Homebrew formulae and casks. After installing
Homebrew, apply the bundle with:

```sh
brew bundle --file "$HOME/.dotfiles/Brewfile"
```

The `dot` helper updates this repository, reapplies macOS defaults on macOS, and
runs `brew update` and `brew upgrade` when Homebrew is installed:

```sh
dot
```

## Local Overrides

Machine-local environment variables and functions belong in `$HOME/.localrc`.
That file is sourced by `zsh/zshrc.symlink` when present and is intentionally
not tracked by this repository.

## macOS Defaults

The installer does not apply macOS defaults automatically. Run them manually
when needed:

```sh
sh "$HOME/.dotfiles/macos/set-defaults.sh"
```

The `dot` helper also runs this script on macOS during updates.

## Uninstall

From the dotfiles checkout, run:

```sh
./install.sh uninstall
```

If `.install-manifest` exists, uninstall removes symlinks that still point into
this repository and restores backups recorded during install when possible.

If no manifest exists, uninstall discovers and removes managed symlinks that
point into the current checkout. It only removes links it can verify are managed
by this repository.

The uninstall command does not remove the repository checkout itself, Homebrew
packages, app data, or unrelated files in `$HOME` or `$XDG_CONFIG_HOME`.
