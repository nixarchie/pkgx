# Pkgx Makefile

SHELL    := /usr/bin/env bash
PREFIX   ?= $(HOME)/.local
DESTDIR  ?=
BINDIR   ?= $(PREFIX)/bin
LIBDIR   ?= $(PREFIX)/lib/pkgx
CONFDIR  ?= $(HOME)/.config/pkgx

# Executables and scripts
INSTALL  := install
INSTALL_DIR  := $(INSTALL) -m 755 -d
INSTALL_BIN  := $(INSTALL) -m 755
INSTALL_DATA := $(INSTALL) -m 644

.PHONY: all install uninstall check test help

all: help

help:
	@echo "Pkgx Management"
	@echo ""
	@echo "Targets:"
	@echo "  install    Install pkgx to $(PREFIX)"
	@echo "  uninstall  Remove pkgx from $(PREFIX)"
	@echo "  check      Run syntax checks on scripts"
	@echo "  test       Run functional test suite"
	@echo "  help       Show this help"

install:
	@echo "[*] Installing pkgx to $(DESTDIR)$(PREFIX)..."

	$(INSTALL_DIR) $(DESTDIR)$(BINDIR)
	$(INSTALL_DIR) $(DESTDIR)$(LIBDIR)
	$(INSTALL_DIR) $(DESTDIR)$(LIBDIR)/lib
	$(INSTALL_DIR) $(DESTDIR)$(LIBDIR)/lib/backend
	$(INSTALL_DIR) $(DESTDIR)$(LIBDIR)/commands
	$(INSTALL_DIR) $(DESTDIR)$(CONFDIR)

	# Install libraries and commands
	$(INSTALL_DATA) lib/*.sh $(DESTDIR)$(LIBDIR)/lib/
	$(INSTALL_DATA) lib/backend/*.sh $(DESTDIR)$(LIBDIR)/lib/backend/
	$(INSTALL_DATA) commands/*.sh $(DESTDIR)$(LIBDIR)/commands/

	# Install main executable
	$(INSTALL_BIN) pkgx $(DESTDIR)$(LIBDIR)/pkgx

	# Copy default config if it doesn't exist
	if [ -f lib/eg-config.sh ] && [ ! -f $(DESTDIR)$(CONFDIR)/config.sh ]; then \
		$(INSTALL_DATA) lib/eg-config.sh $(DESTDIR)$(CONFDIR)/config.sh; \
	fi

	# Create symlink
	ln -sf $(LIBDIR)/pkgx $(DESTDIR)$(BINDIR)/pkgx

	@echo "[+] Installation complete"

uninstall:
	@echo "[*] Uninstalling pkgx..."
	rm -f $(DESTDIR)$(BINDIR)/pkgx
	rm -rf $(DESTDIR)$(LIBDIR)
	@echo "[!] Configuration in $(DESTDIR)$(CONFDIR) was left untouched"
	@echo "[+] Uninstallation complete"

check:
	@echo "[*] Running syntax checks..."
	@sh -n pkgx
	@find lib commands -type f -name '*.sh' -exec sh -n {} \;
	@echo "[+] Syntax checks passed"

test:
	@echo "[*] Running tests..."
	@./test.sh

.DEFAULT_GOAL := help