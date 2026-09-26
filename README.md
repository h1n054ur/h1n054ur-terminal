# h1n054ur-terminal

Animated hacker-style welcome screen, system panel and prompt for bash. Built for Ubuntu on WSL2 with Windows Terminal, works on any Ubuntu box.

Every new shell:

1. Your handle rendered in big block letters, animated by [TerminalTextEffects](https://github.com/ChrisBuilds/terminaltexteffects) with a random effect: matrix rain, decrypt, beams, burn, laser etch, VHS tape, synth grid and more. Each resolves into a green to cyan gradient in 2.5 to 4 seconds. Ctrl-C skips it.
2. A boxed `sys.status` panel from [fastfetch](https://github.com/fastfetch-cli/fastfetch): OS, kernel, uptime, packages, shell, CPU, memory and disk bars, load, LAN IP, Tailscale IP, clock.
3. An `[ ACCESS GRANTED ]` footer with a random one-liner.
4. A two-line [Starship](https://starship.rs) prompt with git status, language versions and command duration.

## Install (Linux / WSL)

```bash
git clone https://github.com/h1n054ur/h1n054ur-terminal.git
cd h1n054ur-terminal
./install.sh yourhandle
```

The installer needs sudo once for apt (figlet, lolcat, cmatrix, pipx) and the fastfetch .deb. Everything else is user-local: `tte` and `pyfiglet` via pipx, `starship` in `~/.local/bin`. It appends one block to `~/.bashrc` and never touches anything else.

## Install (Windows Terminal font)

The panel and prompt use Nerd Font icons. In PowerShell on Windows:

```powershell
powershell -ExecutionPolicy Bypass -File .\windows\install-nerd-font.ps1
```

This installs CaskaydiaCove Nerd Font per-user (no admin) and sets it as the default font in Windows Terminal's `settings.json` (a `.bak` copy is kept). Restart Windows Terminal afterwards.

## Commands

| command          | what                                   |
|------------------|----------------------------------------|
| `welcome`        | replay with a random effect            |
| `welcome matrix` | force one effect                       |
| `welcome --list` | list effects                           |
| `matrix`         | cmatrix screensaver, `q` to quit       |
| `WELCOME_OFF=1`  | env var to disable the welcome screen  |

## Files

| path                             | installed to                          |
|----------------------------------|---------------------------------------|
| `bin/welcome`                    | `~/.local/bin/welcome`                |
| `config/fastfetch/welcome.jsonc` | `~/.config/fastfetch/welcome.jsonc`   |
| `config/starship.toml`           | `~/.config/starship.toml`             |
| `config/banner.txt`              | `~/.config/welcome/banner.txt` (regenerated for your handle) |
| `bashrc.snippet`                 | appended to `~/.bashrc`               |

Effects, frame rates, the gradient and the one-liners live at the top of `bin/welcome`. Change the banner font with any [pyfiglet](https://github.com/pwaller/pyfiglet) font, `ansi_shadow` is the default.

## License

MIT
