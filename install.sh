#!/usr/bin/env bash
# Quick install script for brew-autoupdate
set -euo pipefail

REPO="https://raw.githubusercontent.com/yourusername/brew-autoupdate/main"
INSTALL_DIR="$(brew --prefix)/bin"

echo "🍺 Installing brew-autoupdate…"

# Check for fzf
if ! command -v fzf &>/dev/null; then
  echo "→ Installing fzf (required dependency)…"
  brew install fzf
fi

# Download the script
curl -fsSL "${REPO}/bin/brew-autoupdate" -o "${INSTALL_DIR}/brew-autoupdate"
chmod +x "${INSTALL_DIR}/brew-autoupdate"

echo "✓ Installed to ${INSTALL_DIR}/brew-autoupdate"
echo ""
echo "Get started:"
echo "  brew autoupdate select    # pick packages to auto-update"
echo "  brew autoupdate start     # enable hourly background daemon"
