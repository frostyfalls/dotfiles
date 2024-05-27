# dotfiles

This is my collection of configuration and setup data for all of my Linux machines. The distributions I primarily use are Artix Linux and Debian.

![desktop](https://files.catbox.moe/pq3gyr.png)

![bstack layout](https://files.catbox.moe/dpya3x.png)

You'll probably want to take a look at my [dwm](https://gitlab.com/frostalicious/dwm), [dwmblocks](https://gitlab.com/frostalicious/dwmblocks), [dmenu](https://gitlab.com/frostalicious/dmenu), and [st](https://gitlab.com/frostalicious/st) repositories as well.

I have multiple desktops configured, such as [dwm](https://dwm.suckless.org/), [Openbox](http://openbox.org/wiki/Main_Page), [awesome](https://awesomewm.org/), [xmonad](https://xmonad.org/), and [Qtile](https://qtile.org/). Some are more complete than others, but I consider **dwm** to be the most fleshed out.

## Installation

```sh
$ cd ~
$ git clone https://gitlab.com/frostalicious/dotfiles
$ cd dotfiles
$ stow --verbose --target=${HOME} --restow PACKAGES
```

At the very least, no matter the environment, I would install `bin`, `git`, `shell`, and either `bash` or `zsh`.

## Other Repositories

There are some other dotfiles repositories I cross-referenced when putting my system together, here is a list below:

* [DistroTube](https://gitlab.com/dwt1/dotfiles)
* [Luke Smith](https://github.com/LukeSmithxyz/voidrice)
* [Un1q32](https://github.com/Un1q32/dotfiles)
* [David Zuber](https://github.com/storax/dotfiles)
* [Gl00ria](https://github.com/Gl00ria/dotfiles)
