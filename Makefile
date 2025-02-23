PKGDIR = pkg
TARGET ?= $(HOME)
PKG = $(notdir $(patsubst %/,%,$(wildcard $(PKGDIR)/*/)))
STOWFLAGS = --verbose --dir=$(PKGDIR) --target=$(TARGET)

all:
	@echo "usage: make install|uninstall"

install:
	@stow $(STOWFLAGS) --restow $(PKG)

uninstall:
	@stow $(STOWFLAGS) --delete $(PKG)

.PHONY: all install uninstall
