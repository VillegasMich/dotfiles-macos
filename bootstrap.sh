#!/bin/bash

# New Mac setup: Homebrew packages and apps, language toolchains, CLI tools
# installed outside brew, then dotfile symlinks. Safe to re-run.
#
# Usage: git clone git@github.com:VillegasMich/dotfiles-macos.git ~/dotfiles && ~/dotfiles/bootstrap.sh

set -e # Exit on error

DOTFILES="$HOME/dotfiles"

echo "🛠  Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  xcode-select --install
  echo "⏳ Finish the Command Line Tools installer, then re-run this script."
  exit 1
fi

echo "🍺 Homebrew..."
if ! command -v brew &>/dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
eval "$(/opt/homebrew/bin/brew shellenv)"

echo "📦 Brewfile (sign in to the App Store first for the mas apps)..."
brew update
brew bundle --file "$DOTFILES/Brewfile" || echo "⚠️  Some Brewfile entries failed, check the output above"

# yabai is installed from HEAD and must be signed with a local certificate
if security find-certificate -c "yabai-cert" &>/dev/null; then
  codesign -fs 'yabai-cert' "$(brew --prefix yabai)/bin/yabai"
else
  echo "⚠️  No 'yabai-cert' certificate found, create it in Keychain Access and re-run to sign yabai"
fi

# Orca (stablyai) has no cask (the 'orca' cask is a different app), install the latest
# release DMG. The app updates itself afterwards.
echo "🐳 Orca..."
if [ ! -d "/Applications/Orca.app" ]; then
  orca_tmp="$(mktemp -d)"
  curl -fsSL -o "$orca_tmp/orca.dmg" "https://github.com/stablyai/orca/releases/latest/download/orca-macos-arm64.dmg"
  hdiutil attach -nobrowse -readonly -quiet -mountpoint "$orca_tmp/mnt" "$orca_tmp/orca.dmg"
  cp -R "$orca_tmp/mnt/Orca.app" /Applications/
  hdiutil detach -quiet "$orca_tmp/mnt"
  rm -rf "$orca_tmp"
fi

echo "🦀 Rust..."
if ! command -v rustup &>/dev/null; then
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --no-modify-path
fi
source "$HOME/.cargo/env"
cargo_crates=(
  "dot_rust" # provides `dot`, used below
  "skillfile"
  "cargo-machete"
)
for crate in "${cargo_crates[@]}"; do
  cargo install --locked "$crate"
done

echo "🟢 Node (fnm)..."
eval "$(fnm env --shell bash)"
fnm install --lts
fnm default lts-latest
fnm use lts-latest
npm_globals=(
  "@openai/codex"
  "@fission-ai/openspec"
  "@asyncapi/cli"
  "markdownlint-cli"
)
npm install -g "${npm_globals[@]}"

echo "🐍 Python (uv + pyenv)..."
if ! command -v uv &>/dev/null; then
  curl -LsSf https://astral.sh/uv/install.sh | sh
fi
export PATH="$HOME/.local/bin:$PATH"
uv tool install httpie
for version in 3.10 3.11; do
  pyenv install --skip-existing "$version"
done

echo "🐹 Go tools..."
go install github.com/m7medvision/lazycommit@latest

echo "☕ Java (sdkman)..."
if [ ! -d "$HOME/.sdkman" ]; then
  curl -s "https://get.sdkman.io?rcupdate=false" | bash
fi
set +e # sdkman-init is not compatible with set -e
source "$HOME/.sdkman/bin/sdkman-init.sh"
sdk install java 25-tem
set -e

echo "🤖 AI coding CLIs..."
command -v claude &>/dev/null || curl -fsSL https://claude.ai/install.sh | bash
command -v cursor-agent &>/dev/null || curl -fsS https://cursor.com/install | bash

echo "🔗 Dotfiles..."
if [ ! -f "$DOTFILES/envs.sh" ]; then
  cp "$DOTFILES/envs.sh.example" "$DOTFILES/envs.sh"
  echo "⚠️  Created envs.sh from the example, fill in the credentials"
fi
mkdir -p "$HOME/Library/Application Support/lazygit" "$HOME/.config/zed" "$HOME/.config/herdr" "$HOME/Pictures"
(cd "$DOTFILES" && dot sync)

# After dot sync so the installer keeps the symlinked .zshrc
echo "🐚 oh-my-zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no KEEP_ZSHRC=yes sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "🪟 tmux plugin manager..."
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
  git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
fi

echo ""
echo "✨ Bootstrap complete!"
echo ""
echo "📝 Manual steps:"
echo "  • Approve the macFUSE system extension in System Settings > Privacy & Security"
echo "  • Optional: yabai scripting addition (requires partially disabling SIP, see README)"
echo "  • Install tmux plugins: start tmux and press prefix + I"
echo "  • Start services: yabai --start-service && skhd --start-service"
echo "  • Fill in ~/dotfiles/envs.sh"
echo "  • Log in: gh auth login, glab auth login, granted / aws sso"
