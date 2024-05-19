# dotfiles

This is my collection of configuration and setup data for all of my Linux machines. The distributions I primarily use are Artix Linux and Debian.

## What to Expect

### Environments

- [dwm](https://dwm.suckless.org/)
- [Openbox](http://openbox.org/wiki/Main_Page)
- shells ([Bash](https://www.gnu.org/software/bash/) and [Zsh](https://www.zsh.org/))

## Installation

```
$ cd ~
$ git clone https://gitlab.com/frostalicious/dotfiles .dotfiles
$ cd .dotfiles
$ stow --verbose --target=${HOME} --restow PACKAGES
```

At the very least, no matter the environment, I would install the `bin`, `git`, `shell`, and either `bash` or `zsh`.

## Other Repositories

There are some other dotfiles repositories I cross-referenced when putting my system together, here is a list below:

* [DistroTube](https://gitlab.com/dwt1/dotfiles)
* [Luke Smith](https://github.com/LukeSmithxyz/voidrice)
* [Un1q32](https://github.com/Un1q32/dotfiles)
* [David Zuber](https://github.com/storax/dotfiles)
* [Gl00ria](https://github.com/Gl00ria/dotfiles)
