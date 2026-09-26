#!/usr/bin/env bash
# Installs the h1n054ur terminal: animated welcome banner, fastfetch panel, starship prompt.
# Usage: ./install.sh [handle]      (handle defaults to your username; used for the banner)
# Tested on Ubuntu 24.04 (WSL2 and bare). Needs sudo for apt.
set -euo pipefail
HERE=$(cd "$(dirname "$0")" && pwd)
HANDLE=${1:-$USER}
FF_VER=2.69.0

say() { printf '\e[1;32m==>\e[0m %s\n' "$*"; }

say "apt packages (figlet, lolcat, cmatrix, pipx, curl, unzip)"
sudo apt-get install -y figlet lolcat cmatrix pipx curl unzip

if ! command -v fastfetch >/dev/null; then
  say "fastfetch $FF_VER"
  tmp=$(mktemp -d)
  curl -sLo "$tmp/fastfetch.deb" "https://github.com/fastfetch-cli/fastfetch/releases/download/$FF_VER/fastfetch-linux-amd64.deb"
  sudo dpkg -i "$tmp/fastfetch.deb"
  rm -rf "$tmp"
fi

say "terminaltexteffects + pyfiglet (pipx, user-local)"
pipx install terminaltexteffects >/dev/null 2>&1 || pipx upgrade terminaltexteffects >/dev/null
pipx install pyfiglet >/dev/null 2>&1 || true

if ! command -v starship >/dev/null && [ ! -x "$HOME/.local/bin/starship" ]; then
  say "starship (user-local)"
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
fi

say "configs"
mkdir -p "$HOME/.local/bin" "$HOME/.config/welcome" "$HOME/.config/fastfetch"
install -m 755 "$HERE/bin/welcome" "$HOME/.local/bin/welcome"
install -m 644 "$HERE/config/fastfetch/welcome.jsonc" "$HOME/.config/fastfetch/welcome.jsonc"
[ -f "$HOME/.config/starship.toml" ] && cp "$HOME/.config/starship.toml" "$HOME/.config/starship.toml.bak"
install -m 644 "$HERE/config/starship.toml" "$HOME/.config/starship.toml"
echo "$HANDLE" > "$HOME/.config/welcome/handle"
"$HOME/.local/bin/pyfiglet" -f ansi_shadow "$HANDLE" | sed -e :a -e '/^\n*$/{$d;N;ba' -e '}' > "$HOME/.config/welcome/banner.txt"

if ! grep -q '>>> h1n054ur-terminal >>>' "$HOME/.bashrc"; then
  say "bashrc hook"
  printf '\n' >> "$HOME/.bashrc"
  cat "$HERE/bashrc.snippet" >> "$HOME/.bashrc"
fi

say "done. open a new terminal, or run: welcome"
say "Windows Terminal users: run windows/install-nerd-font.ps1 in PowerShell for the icons"
