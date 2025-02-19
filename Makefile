TARGET ?= $(HOME)
PACKAGES = */

.PHONY: all install uninstall

all:
	@echo "usage: make [install|uninstall]"

install:
	@stow --verbose --target=$(HOME) --restow $(PACKAGES)

uninstall:
	@stow --verbose --target=$(HOME) --delete $(PACKAGES)
