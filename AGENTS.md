# Agent Instructions

This repository contains personal dotfiles for an interactive shell and
application configuration. It is primarily used on macOS, but changes should
keep reasonable guards for future Linux support.

The expected default checkout location is `$HOME/.dotfiles`. `zsh/zshrc.symlink`
sets `DOT_FILES=$HOME/.dotfiles`, and users who clone elsewhere are expected to
update that variable or provide an equivalent symlink.

## Repository Layout

- Topic directories group related configuration, for example `git/`, `python/`,
  `go/`, `vim/`, `zsh/`, `homebrew/`, `macos/`, and `system/`.
- Files ending in `.zsh` are shell snippets that are sourced into the shell.
- Files ending in `.symlink` are linked into `$HOME` without the `.symlink`
  suffix, for example `git/gitconfig.symlink` becomes `~/.gitconfig`.
- `bin/` contains executable scripts intended to be available on `$PATH`.
- `functions/` contains shell functions that are sourced into the shell.
- `xdg-config/` contains XDG Base Directory configuration. Its child
  directories are linked into `${XDG_CONFIG_HOME:-$HOME/.config}`.
- `system/system_path.zsh` owns repository PATH setup, including
  `$DOT_FILES/bin`.

## Change Guidelines

- Follow the existing topic-based organization when adding configuration.
- Keep shell code portable where practical: prefer POSIX `sh` for standalone
  scripts in `bin/`, and use Zsh features only in `.zsh` shell snippets.
- Shell function files in `functions/` are sourced by Zsh. Keep them compatible
  with how they are sourced, quote path-like arguments, and return nonzero on
  usage or validation errors.
- Guard machine-specific or OS-specific behavior with checks such as command
  existence, file existence, or platform detection.
- Do not assume Linux paths or tools are present on macOS, and do not assume
  macOS-only tools exist when adding code intended to be portable.
- Preserve existing formatting from `.editorconfig`: UTF-8, LF line endings,
  two-space indentation, final newlines, and 80-column shell scripts where
  practical.
- Avoid adding secrets, tokens, host-specific private paths, or generated cache
  files.
- Do not commit temporary review artifacts such as `BUG_REPORT.md` unless the
  user explicitly asks for them to be tracked.

## Validation

- For shell changes, run syntax checks where applicable, such as
  `zsh -n path/to/file.zsh` or `sh -n path/to/script`.
- For sourced shell functions, run the syntax check matching the intended shell
  and add a small smoke test when behavior changes.
- For executable scripts in `bin/`, preserve or add an appropriate shebang and
  executable bit.
