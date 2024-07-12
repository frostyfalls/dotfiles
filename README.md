# dotfiles

This repository includes the setup data and configurations for my Linux machines, both desktop and server.

My primary shell is Bash, and on the desktop I primarily use XMonad with XMobar. Most things are self-explanatory.

## Installation

Do note if you'd like to use the xmobar and xmonad configs, you need to have Cabal installed. I use GHCup, and have added `~/.cabal/bin` to my `$PATH`.

Symlink all files using:

```
$ stow -Rt ~ .
```

`cd` into both the xmobar and xmonad directories, and run:

```
$ cabal install
```

## TODO

* Organize scripts for xmobar, such as the pipe for volume.
* Combine cabal projects for both xmobar and xmonad, so it's easier to install.
