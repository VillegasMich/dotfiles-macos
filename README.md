# dotfiles-macos

Configs, apps and tools for my Mac (Apple Silicon). One script takes a fresh macOS install to a
working setup: tiling windows with yabai + skhd, Ghostty + tmux + Neovim, and the usual apps.

## New Mac setup

### 1. Before you start

- Sign in to the **App Store** (needed for the `mas` apps in the `Brewfile`).
- Make the repo reachable. It is private, so either:
  - **SSH:** `ssh-keygen -t ed25519` and add `~/.ssh/id_ed25519.pub` to GitHub, or
  - **HTTPS:** clone with your GitHub username and a personal access token as the password.

### 2. Clone and run

```sh
git clone git@github.com:VillegasMich/dotfiles-macos.git ~/dotfiles
~/dotfiles/bootstrap.sh
```

The repo must live at `~/dotfiles`: `.zshrc` and `bootstrap.sh` reference that path.

`bootstrap.sh` is safe to re-run. It stops once if the Xcode Command Line Tools need installing;
finish that installer and run it again. In order, it:

1. Installs Homebrew and everything in the [`Brewfile`](Brewfile): CLI tools, apps, fonts and App Store apps
2. Signs yabai with the `yabai-cert` certificate (see [yabai](#yabai))
3. Installs Rust (rustup) and cargo tools, including [`dot`](#how-configs-are-linked)
4. Installs the LTS Node with fnm, plus global npm CLIs (codex, openspec, asyncapi, markdownlint)
5. Installs uv, httpie and pyenv Python 3.10 / 3.11
6. Installs Go tools (lazycommit) and Java 25 via sdkman
7. Installs Claude Code and cursor-agent
8. Creates `envs.sh` from the example and runs `dot sync` to symlink every config
9. Installs oh-my-zsh, keeping the symlinked `.zshrc`, and the tmux plugin manager (TPM)

### 3. Finish by hand

- [ ] Fill in the credentials in `~/dotfiles/envs.sh`
- [ ] Set up yabai and skhd (see [yabai](#yabai))
- [ ] Approve the macFUSE system extension: System Settings → Privacy & Security
- [ ] Grant Accessibility access to yabai, skhd, AltTab and Ice when macOS asks
- [ ] Log in: `gh auth login`, `glab auth login`, `granted` / `aws sso login`, `claude`
- [ ] Install [Orca](https://www.stably.ai) from its website. The `orca` Homebrew cask is a different app.
- [ ] Install tmux plugins: start tmux and press `prefix + I`
- [ ] Open Neovim once so AstroNvim installs its plugins and language servers

### yabai

yabai is installed from `HEAD`, which needs a local code-signing certificate:

1. Keychain Access → Certificate Assistant → Create a Certificate…
   Name `yabai-cert`, Identity Type *Self Signed Root*, Certificate Type *Code Signing*.
2. Re-run `bootstrap.sh` (or `codesign -fs 'yabai-cert' $(brew --prefix yabai)/bin/yabai`).
3. Start the services: `yabai --start-service && skhd --start-service`.

SIP stays enabled. The yabai scripting addition is not loaded (it is commented out in `yabairc`),
so features that need it, such as moving windows between spaces, are limited. To use it, follow
the [yabai wiki](https://github.com/asmvik/yabai/wiki/Disabling-System-Integrity-Protection),
then uncomment the `--load-sa` lines in `yabai/yabairc`.

## What's in here

| Path | Linked to | What it is |
|---|---|---|
| `Brewfile` | n/a | Every Homebrew formula, cask and App Store app to install |
| `bootstrap.sh` | n/a | New-Mac setup script (see above) |
| `.zshrc` | `~/.zshrc` | oh-my-zsh, starship prompt, fnm, direnv, autosuggestions and syntax highlighting |
| `starship.toml` | `~/.config/starship.toml` | Prompt |
| `ghostty/` | `~/.config/ghostty` | Terminal: FiraCode Nerd Font, Carbonfox theme, translucent background |
| `tmux/` | `~/.config/tmux` | tmux, prefix `Ctrl+Space`, vim-aware pane navigation |
| `herdr/config.toml` | `~/.config/herdr/config.toml` | herdr agent multiplexer keys |
| `nvim/` | `~/.config/nvim` | AstroNvim v5 with language packs, Copilot and Avante |
| `zed/settings.json` | `~/.config/zed/settings.json` | Zed editor |
| `config.yml` | `~/Library/Application Support/lazygit/config.yml` | lazygit, using delta for diffs |
| `.gitconfig`, `.gitconfig-personal` | `~/` | Git. The personal identity is applied in `~/dotfiles` and `~/Documents/Personal` |
| `yabai/` | `~/.config/yabai` | Tiling window manager (bsp layout, 8px gaps) |
| `skhd/` | `~/.config/skhd` | Hotkeys that drive yabai |
| `Wallpapers/` | `~/Pictures/Wallpapers` | Wallpapers |
| `envs.sh.example` | n/a | Template for `envs.sh`, which holds secrets and is gitignored |

### How configs are linked

[`dot`](https://github.com/rvillegasm/dot) symlinks each path in `dot.toml` to its target, so
editing `~/.config/...` edits this repo directly.

- `dot sync` creates every symlink in `dot.toml`
- `dot add <path>` moves a file into the repo, symlinks it back and adds it to `dot.toml`
- `dot remove <path>` stops tracking a file and restores the original

## Keybindings

**Windows (skhd + yabai)**

| Keys | Action |
|---|---|
| `alt` + `h/j/k/l` | Focus window left / down / up / right |
| `shift+alt` + `h/j/k/l` | Swap window |
| `shift+cmd` + `h/j/k/l` | Warp window (re-split around neighbour) |
| `shift+alt` + `1–9` | Send window to space and follow it |
| `ctrl+cmd` + `n/p` | Send window to next / previous display |
| `ctrl+alt+z` | Focus previous display |
| `cmd+alt+x` | Focus last space |
| `alt+f` | Toggle zoom fullscreen |
| `alt+e` | Toggle split direction |
| `alt+t` | Toggle floating (centered) |
| `alt+r` | Rotate layout 90° |
| `shift+alt+0` | Balance window sizes |

Ghostty windows are not tiled. A yabai signal resizes each new Ghostty window to fill the screen.

**tmux** (prefix `Ctrl+Space`)

| Keys | Action |
|---|---|
| `Ctrl` + `h/j/k/l` | Move between tmux panes and Neovim splits |
| `Alt` + `h/j/k/l` | Resize pane |
| `Alt` + `H/L` | Previous / next window |
| prefix `"` / `%` | Split, keeping the current directory |
| prefix `x` | Kill pane without confirming |

## Keeping it up to date

- **New brew package or app:** add it to the `Brewfile`. Alternatively, run
  `brew bundle dump --file ~/dotfiles/Brewfile --force` and remove project-specific libraries.
  Check with `brew bundle check --file ~/dotfiles/Brewfile`.
- **App installed by hand:** if it has a cask, add it to the `Brewfile`. On a machine where it is
  already installed, `brew install --cask --adopt <name>` puts it under Homebrew.
- **New config file:** `dot add <path>`, then commit.
- **New global CLI from cargo, npm, uv or go:** add it to the matching list in `bootstrap.sh`.
- **Secrets:** put them in `envs.sh` only. It is gitignored and sourced by `.zshrc`.
