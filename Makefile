# ---- Shell ----
SHELL := /bin/sh
.ONESHELL:

# ---- config ----
PREFIX       = /usr/local
BINDIR       = $(PREFIX)/bin
LIBDIR       = $(PREFIX)/lib/pkgx

# ---- user config ----
USER_PREFIX  = $(HOME)/.local
USER_BINDIR  = $(USER_PREFIX)/bin
USER_LIBDIR  = $(USER_PREFIX)/lib/pkgx
USER_CFGDIR  = $(HOME)/.config/pkgx

PKGX_BIN     = pkgx

# ---- default ----
all:
	@printf "\n\033[1;35m─── pkgx: nothing to build ───\033[0m"
	@printf "\n\033[1;35m─── It's just shell scripts, really. ───\033[0m\n"

# ---- install (system-wide) ----
install:
	mkdir -p $(BINDIR) $(LIBDIR) /etc/pkgx
	install -m755 pkgx $(BINDIR)/$(PKGX_BIN)
	cp -r lib commands pkgx.sh $(LIBDIR)
	# copy default config if missing
	[ -f /etc/pkgx/config.yaml ] || cp $(LIBDIR)/config.yaml /etc/pkgx/config.yaml
	# copy to user config if missing
	mkdir -p $(USER_CFGDIR)
	[ -f $(USER_CFGDIR)/config.yaml ] || cp /etc/pkgx/config.yaml $(USER_CFGDIR)/config.yaml
	@printf "\033[1;32m─── pkgx: system-wide install done ───\033[0m\n"

# ---- uninstall (system-wide) ----
uninstall:
	rm -f $(BINDIR)/$(PKGX_BIN)
	rm -rf $(LIBDIR)
	rm -f /etc/pkgx/config.yaml
	@printf "\033[1;32m─── pkgx: system-wide uninstall done ───\033[0m\n"

remove: uninstall

# ---- user install (symlink, no root) ----
install-user:
	@printf "\033[1;32m─── pkgx: installing for user ───\033[0m\n"
	mkdir -p $(USER_BINDIR) $(USER_PREFIX)/lib $(USER_CFGDIR)
	ln -sf $(PWD)/pkgx $(USER_BINDIR)/pkgx
	ln -sf $(PWD) $(USER_PREFIX)/lib/pkgx
	# copy config if missing
	[ -f $(USER_CFGDIR)/config.yaml ] || cp $(PWD)/lib/config.yaml $(USER_CFGDIR)/config.yaml
	@printf "\033[1;32m─── pkgx: user install done, linked to ~/.local ───\033[0m\n"

# ---- user uninstall ----
uninstall-user:
	rm -f $(USER_BINDIR)/pkgx
	rm -rf $(USER_PREFIX)/lib/pkgx
	rm -f $(USER_CFGDIR)/config.yaml
	@printf "\033[1;32m─── pkgx: user uninstall done ───\033[0m\n"

# ---- dev helpers ----
check:
	sh -n pkgx pkgx.sh
	find lib commands -type f -name '*.sh' -exec sh -n {} \;

dev:
	mkdir -p $(BINDIR) $(PREFIX)/lib
	ln -sf $(PWD)/pkgx $(BINDIR)/pkgx
	ln -sf $(PWD) $(PREFIX)/lib/pkgx

override:
	@if ! command -v pacman >/dev/null 2>&1; then \
		printf "pkgx: override is Arch-only\n" >&2; \
		exit 1; \
	fi
	@if ! command -v makepkg >/dev/null 2>&1; then \
		printf "pkgx: makepkg not found\n" >&2; \
		exit 1; \
	fi
	@if ! command -v gum >/dev/null 2>&1; then \
		printf "pkgx: gum not found\n" >&2; \
		exit 1; \
	fi
	@gum spin --spinner "globe" --title "Okay! Overriding with makepkg..." -- \
		bash -c 'read -n 1 -s'
	@makepkg -Ccfsi
	@echo
	@gum spin --spinner "globe" --title "Done! Press any key to close..." -- \
		bash -c 'read -n 1 -s'

# ---- housekeeping ----
.PHONY: all install uninstall install-user uninstall-user check dev override remove
