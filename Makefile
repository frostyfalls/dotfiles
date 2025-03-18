PKG_DIR     = pkg
PROFILE_DIR = profile

TARGET  ?= $(HOME)
PROFILE ?= $(shell hostname)

ifeq (,$(wildcard $(PROFILE_DIR)/$(PROFILE)))
$(error no profile found for $(PROFILE))
endif

STOW_FLAGS = -verbose -dir=$(PKG_DIR) -target=$(TARGET)
PKG_LIST   = $(subst $(newline), ,$(shell cat $(PROFILE_DIR)/$(PROFILE)))

all: install

install:
	@xstow $(STOW_FLAGS) -restow $(PKG_LIST)

uninstall:
	@xstow $(STOW_FLAGS) -delete $(PKG_LIST)

.PHONY: all install uninstall
