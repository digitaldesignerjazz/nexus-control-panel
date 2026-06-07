.PHONY: help install install-user install-completions uninstall

help:
	@echo "Nexus Control Panel - Available make targets:"
	@echo ""
	@echo "  make install-user       Install nexus-ctl to ~/.local/bin (recommended)"
	@echo "  make install            Install system-wide (requires sudo)"
	@echo "  make install-completions  Install bash + zsh shell completions"
	@echo "  make uninstall          Remove binary and completions"
	@echo "  make help               Show this help"
	@echo ""
	@echo "Recommended: make install-user install-completions"

install:
	@./install.sh

install-user:
	@./install.sh --user

install-completions:
	@./install.sh --user --completions

uninstall:
	@./install.sh --uninstall
