# Dots (⚠️ under construction)

Preamble:

This is mostly a note to self to remember the things I need to do to have a
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
- [x] `npm` (use [nvm](https://github.com/nvm-sh/nvm) )
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

## ZSH

First things first:

- Run `chsh` and change it to zsh, usually `/usr/bin/zsh` and log out of your session
- Log back in and zsh should be your default shell now

Run:

```bash
cd ~/.dots
stow zsh
```

Expected outcome:

Navigate to the home directory and run `ls --color=auto`. The zsh files should
appear somewhat "special" i.e be symlinked.

## Neovim

You need these packages for Neovim (lastest stable version will do):

- [x] [ripgrep](https://github.com/BurntSushi/ripgrep)
- [x] [fd](https://github.com/sharkdp/fd)
- [x] [clipboard provider](https://wiki.archlinux.org/title/Clipboard#Tools) (system dependent)

- Nuke/backup pre-existing neovim config found in ~/.config/nvim
- Find all nvim related files and delete them if needed
- Run `:checkhealth` pre and post stow

Then run:

```bash
cd ~/.dots
stow nvim
```

Expected outcome:

Lazy should run and install all the plugins automagically. Troubleshoot errors
thrown by Lazy accordingly and again, `:checkhealth` is your friend. Reddit and Gippity are
also there to help!
