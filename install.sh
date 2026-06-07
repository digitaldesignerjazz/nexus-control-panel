#!/usr/bin/env bash
#
# Nexus Control Panel - Installer
# https://github.com/digitaldesignerjazz/nexus-control-panel
#
# Installs the nexus-ctl unified command interface into your PATH.
#
# Usage:
#   ./install.sh                # Install to /usr/local/bin (requires sudo or root)
#   ./install.sh --user         # Install to ~/.local/bin (recommended for most users)
#   ./install.sh --prefix /opt  # Custom prefix
#   ./install.sh --uninstall    # Remove previously installed version
#
set -euo pipefail

REPO_URL="https://github.com/digitaldesignerjazz/nexus-control-panel"
SCRIPT_NAME="nexus-ctl"

# Default installation directory
PREFIX="${PREFIX:-/usr/local}"
INSTALL_DIR="$PREFIX/bin"
UNINSTALL=false

print_help() {
  cat <<EOF
Nexus Control Panel Installer

Usage:
  $0 [options]

Options:
  --user              Install to ~/.local/bin (no sudo required)
  --prefix <path>     Install to <path>/bin (e.g. --prefix /opt)
  --uninstall         Remove the installed nexus-ctl binary
  -h, --help          Show this help message

Examples:
  $0 --user
  sudo $0
  $0 --prefix ~/.local
  $0 --uninstall
EOF
}

# Parse arguments
while [[ $# -gt 0 ]]; do
  case "$1" in
    --user)
      INSTALL_DIR="$HOME/.local/bin"
      shift
      ;;
    --prefix)
      if [[ -z "${2:-}" ]]; then
        echo "Error: --prefix requires a path argument" >&2
        exit 1
      fi
      PREFIX="$2"
      INSTALL_DIR="$PREFIX/bin"
      shift 2
      ;;
    --uninstall)
      UNINSTALL=true
      shift
      ;;
    -h|--help)
      print_help
      exit 0
      ;;
    *)
      echo "Unknown option: $1" >&2
      print_help
      exit 1
      ;;
    esac
done

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE="$SCRIPT_DIR/$SCRIPT_NAME"
TARGET="$INSTALL_DIR/$SCRIPT_NAME"

if [[ ! -f "$SOURCE" ]]; then
  echo "Error: $SCRIPT_NAME not found in $SCRIPT_DIR" >&2
  echo "Please run this script from the root of the cloned repository." >&2
  exit 1
fi

if $UNINSTALL; then
  if [[ -f "$TARGET" ]]; then
    rm -f "$TARGET"
    echo "✓ Uninstalled $SCRIPT_NAME from $TARGET"
  else
    echo "! $SCRIPT_NAME was not found at $TARGET"
  fi
  echo "Done."
  exit 0
fi

# Create install directory if it doesn't exist
echo "Installing $SCRIPT_NAME to $TARGET ..."
mkdir -p "$INSTALL_DIR"

# Copy and make executable
cp "$SOURCE" "$TARGET"
chmod +x "$TARGET"

# Verify installation
echo "✓ Successfully installed $SCRIPT_NAME"
echo

if command -v "$SCRIPT_NAME" >/dev/null 2>&1; then
  echo "You can now run: $SCRIPT_NAME --help"
  echo "Version: $($SCRIPT_NAME --version 2>/dev/null || echo 'unknown')"
else
  echo "Note: $INSTALL_DIR is not in your current PATH."
  echo "Add it with:"
  echo "  export PATH=\"$INSTALL_DIR:\\$PATH\""
  echo "Or add it permanently to your shell config (~/.bashrc, ~/.zshrc, etc.)"
fi

echo
cat <<EOF
Next steps:
  $SCRIPT_NAME --help
  $SCRIPT_NAME mesh status
  $SCRIPT_NAME system status

For updates: git pull && ./install.sh --user   (or re-run with your preferred flags)

Report issues: $REPO_URL/issues
EOF
