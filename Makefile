SHELL := /bin/sh
.ONESHELL:

# ---- user paths ----
PREFIX   = $(HOME)/.local
BINDIR   = $(PREFIX)/bin
LIBDIR   = $(PREFIX)/lib/pkgx
CFGDIR   = $(HOME)/.config/pkgx

PKGX_BIN = pkgx

all:
	@echo "pkgx: nothing to build"

install:
	@echo "[*] Installing pkgx (user)..."

	mkdir -p $(BINDIR) $(LIBDIR) $(CFGDIR)

	# copy files
	cp -r lib commands $(LIBDIR)
	cp pkgx $(LIBDIR)/$(PKGX_BIN)
	chmod +x $(LIBDIR)/$(PKGX_BIN)

	# copy config.sh if missing
	if [ -f lib/eg-config.sh ]; then \
		[ -f $(CFGDIR)/config.sh ] || cp lib/eg-config.sh $(CFGDIR)/config.sh; \
	fi

	# symlink binary
	ln -sf $(LIBDIR)/$(PKGX_BIN) $(BINDIR)/$(PKGX_BIN)

	@echo "[+] Installed to $(LIBDIR)"
	@echo "[+] Linked to $(BINDIR)/$(PKGX_BIN)"

uninstall:
	@echo "[*] Uninstalling pkgx (user)..."
	rm -f $(BINDIR)/$(PKGX_BIN)
	rm -rf $(LIBDIR)
	rm -f $(CFGDIR)/config.sh
	@echo "[+] Removed pkgx"

check:
	sh -n pkgx
	find lib commands -type f -name '*.sh' -exec sh -n {} \;

.PHONY: all install uninstall check