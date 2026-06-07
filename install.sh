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
#   ./install.sh --completions  # Also install shell completions
#   ./install.sh --uninstall    # Remove previously installed version
#
set -euo pipefail

REPO_URL="https://github.com/digitaldesignerjazz/nexus-control-panel"
SCRIPT_NAME="nexus-ctl"

# Default installation directory
PREFIX="${PREFIX:-/usr/local}"
INSTALL_DIR="$PREFIX/bin"
UNINSTALL=false
INSTALL_COMPLETIONS=false

print_help() {
  cat <<EOF
Nexus Control Panel Installer

Usage:
  $0 [options]

Options:
  --user              Install to ~/.local/bin (no sudo required)
  --prefix <path>     Install to <path>/bin
  --completions       Also install bash and zsh completions
  --uninstall         Remove the installed binary and completions
  -h, --help          Show this help message

Examples:
  $0 --user --completions
  sudo $0 --completions
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
    --completions)
      INSTALL_COMPLETIONS=true
      shift
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
  fi

  # Try to remove completions
  for compdir in "$HOME/.local/share/bash-completion/completions" \
                 "$HOME/.zfunc" \
                 "/etc/bash_completion.d"; do
    if [[ -f "$compdir/$SCRIPT_NAME" || -f "$compdir/_$SCRIPT_NAME" ]]; then
      rm -f "$compdir/$SCRIPT_NAME" "$compdir/_$SCRIPT_NAME" 2>/dev/null || true
      echo "✓ Removed completions from $compdir"
    fi
  done
  echo "Done."
  exit 0
fi

# Create install directory if it doesn't exist
echo "Installing $SCRIPT_NAME to $TARGET ..."
mkdir -p "$INSTALL_DIR"

# Copy and make executable
cp "$SOURCE" "$TARGET"
chmod +x "$TARGET"

echo "✓ Successfully installed $SCRIPT_NAME"

echo

if command -v "$SCRIPT_NAME" >/dev/null 2>&1; then
  echo "You can now run: $SCRIPT_NAME --help"
else
  echo "Note: $INSTALL_DIR is not in your current PATH."
  echo "Add it permanently to your shell config (~/.bashrc, ~/.zshrc, etc.)"
fi

# Install completions if requested
if $INSTALL_COMPLETIONS=true; then
  echo
  echo "Installing shell completions..."

  # Bash
  BASH_COMP_DIR="$HOME/.local/share/bash-completion/completions"
  mkdir -p "$BASH_COMP_DIR"
  if [[ -f "$SCRIPT_DIR/completions/nexus-ctl.bash" ]]; then
    cp "$SCRIPT_DIR/completions/nexus-ctl.bash" "$BASH_COMP_DIR/$SCRIPT_NAME"
    echo "✓ Bash completion installed to $BASH_COMP_DIR/$SCRIPT_NAME"
  fi

  # Zsh
  ZSH_COMP_DIR="$HOME/.zfunc"
  mkdir -p "$ZSH_COMP_DIR"
  if [[ -f "$SCRIPT_DIR/completions/_nexus-ctl" ]]; then
    cp "$SCRIPT_DIR/completions/_nexus-ctl" "$ZSH_COMP_DIR/_$SCRIPT_NAME"
    echo "✓ Zsh completion installed to $ZSH_COMP_DIR/_$SCRIPT_NAME"
    echo "   Add the following to your ~/.zshrc if not already present:"
    echo "   fpath+=($ZSH_COMP_DIR)"
    echo "   autoload -Uz compinit && compinit"
  fi
fi

echo
cat <<EOF
Next steps:
  $SCRIPT_NAME --help
  $SCRIPT_NAME mesh status

For updates: git pull && ./install.sh --user --completions

Report issues: $REPO_URL/issues
EOF
