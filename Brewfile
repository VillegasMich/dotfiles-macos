# Install everything with: brew bundle --file ~/dotfiles/Brewfile
# Refresh after installing something new: brew bundle dump --file ~/dotfiles/Brewfile --force
# (then trim project-specific libraries back out)

tap "asmvik/formulae"
tap "cavaldos/tap"
tap "common-fate/granted"
tap "gromgit/fuse"
tap "villegasmich/tap"

# --- Shell ---
brew "starship"
brew "zoxide"
brew "fzf"
brew "eza"
brew "bat"
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"
brew "direnv"

# --- Terminal / editor ---
brew "neovim"
brew "tmux"
brew "sesh"
brew "herdr"
brew "lazygit"
brew "ripgrep"

# --- Git ---
brew "gh"
brew "glab"
brew "git-delta"
brew "git-lfs"

# --- CLI utilities ---
brew "jq"
brew "xh"
brew "wget"
brew "htop"
brew "watch"
brew "gnu-sed"
brew "ffmpeg"
brew "media-info"
brew "marp-cli"
brew "gromgit/fuse/sshfs-mac"

# --- Languages / build ---
brew "fnm"
brew "pyenv"
# Python build deps for pyenv (3.10/3.11 need OpenSSL 3, not 4)
brew "openssl@3"
brew "readline"
brew "xz"
brew "tcl-tk"
brew "go"
brew "libpq" # psql client (keg-only)

# --- Containers / cloud ---
brew "colima"
brew "docker"
brew "docker-completion"
brew "docker-compose"
brew "docker-credential-helper-ecr"
brew "kubernetes-cli"
brew "awscli"
brew "common-fate/granted/granted"

# --- AI CLIs ---
brew "opencode"

# --- Window management (yabai needs codesigning, see bootstrap.sh) ---
brew "asmvik/formulae/yabai", args: ["HEAD"]
brew "asmvik/formulae/skhd"

# --- App Store ---
brew "mas"

# --- Fonts ---
cask "font-fira-code-nerd-font"
cask "font-geist-mono"
cask "font-geist-mono-nerd-font"
cask "font-jetbrains-mono"
cask "font-jetbrains-mono-nerd-font"

# --- Menu bar / system ---
cask "alt-tab"
cask "betterdisplay"
cask "stats"
cask "cavaldos/tap/ice"
cask "vorssaint"
cask "macfuse"
cask "villegasmich/tap/football-menubar"

# --- Apps ---
cask "ghostty"
cask "zed"
cask "sublime-text"
cask "claude"
cask "postman"
cask "google-chrome"
# cask "thebrowsercompany-dia"
cask "obsidian"
cask "zoom"
# cask "vlc"
cask "spotify"

mas "Bitwarden", id: 1352778147
mas "Slack", id: 803453959
mas "Tailscale", id: 1475387142
mas "WhatsApp", id: 310633997
mas "Usage for Claude", id: 6755173244
mas "Xcode", id: 497799835
