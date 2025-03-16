PKG_DIR     = pkg
PROFILE_DIR = profile

TARGET  ?= $(HOME)
PROFILE ?= `hostname`

STOW_FLAGS = --verbose --dir=$(PKG_DIR) --target=$(TARGET)
PKG_LIST   = $(subst $(newline), ,$(shell cat $(PROFILE_DIR)/$(PROFILE)))

all: install

install:
	@stow $(STOW_FLAGS) --restow $(PKG_LIST)

uninstall:
	@stow $(STOW_FLAGS) --delete $(PKG_LIST)

.PHONY: all install uninstall
