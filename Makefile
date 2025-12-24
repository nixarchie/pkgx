# ---- config ----
PREFIX ?= $(HOME)/.local
BINDIR  = $(PREFIX)/bin

PKGX_BIN = pkgx
COMMANDS = commands
LIB      = lib

# ---- default ----
all:
	@echo "pkgx: nothing to build"

# ---- install ----
install:
	sh ./install

# ---- uninstall ----
uninstall:
	rm -f $(BINDIR)/$(PKGX_BIN)
	rm -rf $(BINDIR)/$(COMMANDS)
	rm -rf $(BINDIR)/$(LIB)

# ---- dev helpers ----
check:
	sh -n pkgx
	find lib commands -type f -name '*.sh' -exec sh -n {} \;

dev:
	mkdir -p $(BINDIR)
	ln -sf $(PWD)/pkgx $(BINDIR)/pkgx
	ln -sf $(PWD)/commands $(BINDIR)/commands
	ln -sf $(PWD)/lib $(BINDIR)/lib

# ---- housekeeping ----
.PHONY: all install uninstall check dev
