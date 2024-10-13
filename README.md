# Dots (⚠️ under construction)

Preamble:

This is mostly a note to self to remember most things I need to do to have a
usable system/dev environment should I need to machine hop.

## Essentials

> [!WARNING]
> This guide assumes you **know** how to install packages for your particular operating system.

Install:

- [x] `git`
- [x] `stow`
- [x] `neovim`
- [x] `tmux`
- [x] `zsh`
- [x] `The build tools group for the linux distro you find yourself on`

  **Arch**:

  ```
  sudo pacman -S --needed base-devel
  ```

  **Ubuntu**:

  ```
    sudo apt install build-essential
  ```

## Initial setup

Clone this repo into your home directory

```bash
git clone https://github.com/ezra-ramatong/dots.git ~/.dots
```

## Neovim

You need these packages for Neovim:

- [x] `ripgrep`
- [x] `fzf`
- [x] `npm`
