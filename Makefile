# With no MODULES value, install every module in install/modules.
ifneq ($(origin MODULES),undefined)
export MODULES
endif
export DOTFILES_TARGET

.PHONY: backup remove_backup install list-modules install-codex
backup remove_backup install:
	bash "$(CURDIR)/install/run" $@

list-modules:
	bash "$(CURDIR)/install/run" list

# Keep the existing command for installing only Codex preferences.
install-codex:
	MODULES=codex bash "$(CURDIR)/install/run" install
