# ---- config ----
PREFIX   = /usr/local
BINDIR   = $(PREFIX)/bin
LIBDIR   = $(PREFIX)/lib/pkgx

PKGX_BIN = pkgx

# ---- default ----
all:
	@printf "\n\033[1;35m─── pkgx: nothing to build ───\033[0m"
	@printf "\n\033[1;35m─── It's just shell scripts, really. ───\033[0m\n"

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

override:
	@ command -v pacman || printf "non Arch system"
	@gum spin --spinner "globe" --title "Okey! Overriding with makepkg..." -- bash -c 'read -n 1 -s' || exit 1
	@makepkg -Ccfsi
	@echo
	@gum spin --spinner "globe" --title "Done! Press any key to close..." -- bash -c 'read -n 1 -s'

# ---- housekeeping ----
.PHONY: all install uninstall check dev override
