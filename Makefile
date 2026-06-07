.PHONY: help install install-user uninstall

help:
	@echo "Nexus Control Panel - Available make targets:"
	@echo ""
	@echo "  make install-user    Install nexus-ctl to ~/.local/bin (recommended, no sudo)"
	@echo "  make install         Install system-wide to /usr/local/bin (requires sudo)"
	@echo "  make uninstall       Remove the installed nexus-ctl binary"
	@echo "  make help            Show this help message"
	@echo ""
	@echo "After installation, use: nexus-ctl --help"

install:
	@./install.sh

install-user:
	@./install.sh --user

uninstall:
	@./install.sh --uninstall
