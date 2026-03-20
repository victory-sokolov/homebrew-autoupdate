# 🍺 brew-autoupdate

Selectively auto-update Homebrew packages using an interactive `fzf` picker.

Instead of blindly upgrading everything, you choose **exactly which packages** get automatically updated — then a lightweight macOS LaunchAgent handles the rest in the background.

---

## Features

- **Interactive selection** — fuzzy-search all installed formulae and casks with `fzf`
- **Live preview** — see `brew info` for any package while selecting
- **Background daemon** — macOS LaunchAgent runs updates on a configurable interval
- **Smart diffing** — only upgrades packages that actually have a new version
- **Persistent config** — selections saved to `~/.config/brew-autoupdate/packages.conf`
- **Logging** — every update action timestamped to `autoupdate.log`

---

## Requirements

- macOS
- [Homebrew](https://brew.sh)
- [fzf](https://github.com/junegunn/fzf) (`brew install fzf`)

---

## Installation

### Via Homebrew tap (recommended)

```bash
brew tap yourusername/brew-autoupdate
brew install brew-autoupdate
```

### Manual / one-liner

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/yourusername/brew-autoupdate/main/install.sh)"
```

### From source

```bash
git clone https://github.com/yourusername/brew-autoupdate.git
cp brew-autoupdate/bin/brew-autoupdate "$(brew --prefix)/bin/"
chmod +x "$(brew --prefix)/bin/brew-autoupdate"
```

---

## Usage

### 1. Select packages

```bash
brew autoupdate select
```

Opens an `fzf` interface showing all installed Homebrew packages.

| Key         | Action              |
|-------------|---------------------|
| `SPACE/TAB` | Toggle selection    |
| `CTRL-A`    | Select all          |
| `CTRL-D`    | Deselect all        |
| `CTRL-T`    | Toggle all          |
| `ENTER`     | Save & exit         |
| `ESC`       | Cancel (no changes) |

### 2. Enable the background daemon

```bash
# Check every hour (default)
brew autoupdate start

# Check every 30 minutes
brew autoupdate start 1800

# Check every 6 hours
brew autoupdate start 21600
```

### 3. Other commands

```bash
brew autoupdate list          # show selected packages + update availability
brew autoupdate status        # daemon status + package overview
brew autoupdate run           # trigger update check right now
brew autoupdate stop          # disable the background daemon
brew autoupdate logs          # tail last 50 log lines
brew autoupdate logs 200      # tail last 200 log lines
brew autoupdate help          # full usage reference
```

---

## Configuration

| Path | Purpose |
|------|---------|
| `~/.config/brew-autoupdate/packages.conf` | Selected packages (one per line) |
| `~/.config/brew-autoupdate/autoupdate.log` | Timestamped update history |
| `~/Library/LaunchAgents/com.brew-autoupdate.daemon.plist` | macOS daemon definition |

You can edit `packages.conf` manually — it's just a plain text file with one package name per line.

---

## How it works

1. `brew autoupdate select` writes your chosen package names to `packages.conf`
2. `brew autoupdate start` installs a LaunchAgent plist that runs `brew autoupdate run` on a timer
3. On each run, the script calls `brew update`, checks `brew outdated`, and upgrades only the intersection of your selected list and actually-outdated packages
4. All activity is appended to `autoupdate.log`

---

## Uninstall

```bash
brew autoupdate stop
brew uninstall brew-autoupdate      # if installed via tap
# or: rm "$(brew --prefix)/bin/brew-autoupdate"
rm -rf ~/.config/brew-autoupdate
rm -f ~/Library/LaunchAgents/com.brew-autoupdate.daemon.plist
```

---

## License

MIT
