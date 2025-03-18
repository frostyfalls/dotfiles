PKG_DIR     = pkg
PROFILE_DIR = profile

TARGET  ?= $(HOME)
PROFILE ?= $(shell hostname)

PROFILE_FILE = $(PROFILE_DIR)/$(PROFILE)

STOW_FLAGS = -verbose -dir=$(PKG_DIR) -target=$(TARGET)

ifeq (,$(PKG))
ifeq (,$(wildcard $(PROFILE_FILE)))
$(error no profile found for $(PROFILE))
endif
PKG = $(subst $(newline), ,$(shell cat $(PROFILE_FILE)))
endif

all: install

install:
	@xstow $(STOW_FLAGS) -restow $(PKG)

uninstall:
	@xstow $(STOW_FLAGS) -delete $(PKG)

.PHONY: all install uninstall
