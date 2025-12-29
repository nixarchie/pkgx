# ---- config ----
PREFIX   = /usr/local
BINDIR   = $(PREFIX)/bin
LIBDIR   = $(PREFIX)/lib/pkgx

PKGX_BIN = pkgx

# ---- default ----
all:
	@echo "pkgx: nothing to build"

# ---- install ----
install:
	mkdir -p $(BINDIR) $(LIBDIR)
	install -m755 pkgx $(BINDIR)/$(PKGX_BIN)
	cp -r lib commands pkgx.sh $(LIBDIR)

# ---- uninstall ----
uninstall:
	rm -f $(BINDIR)/$(PKGX_BIN)
	rm -rf $(LIBDIR)

# ---- dev helpers ----
check:
	sh -n pkgx pkgx.sh
	find lib commands -type f -name '*.sh' -exec sh -n {} \;

dev:
	mkdir -p $(BINDIR) $(PREFIX)/lib
	ln -sf $(PWD)/pkgx $(BINDIR)/pkgx
	ln -sf $(PWD) $(PREFIX)/lib/pkgx

# ---- housekeeping ----
.PHONY: all install uninstall check dev
