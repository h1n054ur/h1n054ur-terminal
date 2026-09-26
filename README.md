# h1n054ur-terminal

Animated hacker-style welcome screen, system panel and prompt for bash. Built for Ubuntu on WSL2 with Windows Terminal, works on any Ubuntu box.

![h1n054ur terminal: animated banner, sys.status panel, starship prompt](docs/hero.gif)

## Showcase

A random effect plays on every new shell. Six of the ten:

| matrix | decrypt |
|:-:|:-:|
| ![matrix](docs/matrix.gif) | ![decrypt](docs/decrypt.gif) |
| **burn** | **beams** |
| ![burn](docs/burn.gif) | ![beams](docs/beams.gif) |
| **laseretch** | **vhstape** |
| ![laseretch](docs/laseretch.gif) | ![vhstape](docs/vhstape.gif) |

Also in the pool: rain, unstable, synthgrid, slide. Every effect resolves into the same green to cyan gradient and finishes in 2.5 to 4 seconds. Ctrl-C skips it.

The GIFs are rendered with [vhs](https://github.com/charmbracelet/vhs) from the tapes in `docs/tapes`, `docs/render.sh` regenerates them.

## What runs on every new shell

1. Your handle in big block letters, animated by [TerminalTextEffects](https://github.com/ChrisBuilds/terminaltexteffects).
2. A boxed `sys.status` panel from [fastfetch](https://github.com/fastfetch-cli/fastfetch): OS, kernel, uptime, packages, shell, CPU, memory and disk bars, load, LAN IP, Tailscale IP, clock.
3. An `[ ACCESS GRANTED ]` footer with a random one-liner.
4. A two-line [Starship](https://starship.rs) prompt with Nerd Font icons: git branch and status, node, bun, python, go, rust, ruby, docker context, command duration, clock on the right, red chevron on a failed command.

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
