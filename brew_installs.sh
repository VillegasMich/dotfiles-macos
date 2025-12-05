#!/bin/bash

# Homebrew Installation Script
# This script installs development tools and utilities

set -e # Exit on error

echo "🍺 Starting Homebrew installation..."

# Check if Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "❌ Homebrew is not installed. Please install it first:"
  echo '/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"'
  exit 1
fi

# Update Homebrew
echo "📦 Updating Homebrew..."
brew update

# Add taps
echo "🔧 Adding taps..."
brew tap koekeishiya/formulae

# List of formulae to install
formulae=(
  "ninja"
  "cmake"
  "colima"
  "docker"
  "fnm"
  "ffmpeg"
  "jq"
  "borders"
  "starship"
  "zoxide"
  "sesh"
  "tmux"
  "fzf"
  "zsh-syntax-highlighting"
  "zsh-autosuggestions"
  "eza"
  "lazygit"
  "ripgrep"
  "neovim"
)

# Install regular formulae
echo "📥 Installing formulae..."
for formula in "${formulae[@]}"; do
  if brew list "$formula" &>/dev/null; then
    echo "✅ $formula is already installed"
  else
    echo "⬇️  Installing $formula..."
    brew install "$formula"
  fi
done

# Install yabai with --HEAD flag
echo "⬇️  Installing yabai (HEAD version)..."
if brew list yabai &>/dev/null; then
  echo "✅ yabai is already installed"
else
  brew install koekeishiya/formulae/yabai --HEAD
  codesign -fs 'yabai-cert' $(brew --prefix yabai)/bin/yabai
fi

# Install skhd
echo "⬇️  Installing skhd..."
if brew list skhd &>/dev/null; then
  echo "✅ skhd is already installed"
else
  brew install koekeishiya/formulae/skhd
fi

echo ""
echo "✨ Installation complete!"
echo ""
echo "📝 Post-installation notes:"
echo "  • Run 'fnm env' to set up Node.js version manager"
echo "  • Configure yabai and skhd (may require disabling SIP)"
echo "  • Run 'fzf --install' for shell integration"
echo "  • Add to ~/.zshrc:"
echo "      source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
echo "      source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
echo "      eval \"\$(starship init zsh)\""
echo "      eval \"\$(zoxide init zsh)\""
echo ""
echo "Other things to install manuelly:"
echo "  • Cargo"
echo "  • Tailscale"
echo "  • Cursor"
echo "  • Slack"
echo "  • Whatsapp"
echo "  • vlc"
echo "  • Obsidian"
echo "  • Google Chrome"
echo "  • Zoom"
echo ""
echo "Finally run 'dot sync' to sync all dotfiles"
