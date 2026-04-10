# My Dotfiles

Personal dotfiles repository for cross-platform development environment setup. This repository manages configuration files for various tools across Windows, Linux, and macOS using [Dotter](https://github.com/SuperCuber/dotter) for deployment and a unified bootstrap script for tool installation.

## Features

- **Cross-platform support**: Windows, Arch, CentOS, macOS
- **Unified bootstrap**: Single entrypoint for tool installation and configuration deployment
- **Tool management**: Automatic detection and installation of development tools
- **Dotter-based deployment**: OS-specific configuration via profiles
- **Modular design**: Easy to add/remove tools via `tools.toml`

## Tools Managed

### Global Tools (All Platforms)
- **Version Control**: Git
- **Editors/IDEs**: Neovim, VSCode, Obsidian
- **Shell Enhancements**: Starship, Zoxide, FZF
- **Terminal Tools**: Lazygit, Joshuto, Zellij, Fastfetch
- **Build Tools**: Cargo (for Rust-based tools)
- **AI Coding Agent**: OpenCode

### Windows-Specific Tools
- **Window Manager**: GlazeWM
- **Status Bar**: YASB (Yet Another Status Bar)
- **Shell**: PowerShell
- **Productivity**: PowerToys
- **Audio Visualizer**: Cava

### Linux-Specific Tools
- **Package Managers**: Pacman (Arch), Apt (Ubuntu), Yum (CentOS)
- **Build Tools**: Rust/Cargo for tools not available via package managers
- **Compiler**: GCC

### macOS-Specific Tools
- **Package Manager**: Homebrew
- **GUI Tools**: VSCode, Obsidian via Homebrew Casks
- **Compiler**: GCC (via Xcode Command Line Tools)

### Fonts
- **Maple Mono NF**: Open‑source monospace font with Nerd Font icons.
  - **Windows**: Installed via Scoop (`Maple-Mono-NF`)
  - **macOS**: Installed via Homebrew (`font-maple-mono-nf`)
  - **Linux**: Manual installation required (download from [GitHub releases](https://github.com/subframe7536/maple-font/releases))

## Installation

### Prerequisites

- Git (for cloning the repository)
- Bash (for running the bootstrap script)
- Internet connection (for downloading tools)

### Bootstrap Script Usage

The bootstrap script handles both tool installation and dotfile deployment. Run it from the repository root:

```bash
# Full installation: tools + dotfile deployment
./bootstrap.sh

# Preview what would be installed (dry run)
./bootstrap.sh --dry-run

# Install tools only, skip dotter deployment
./bootstrap.sh --tools-only

# Deploy dotfiles only, skip tool installation
./bootstrap.sh --deploy-only

# Install specific tools only
./bootstrap.sh --tool starship --tool zoxide

# Skip specific tools
./bootstrap.sh --skip-tool vscode

# Force reinstall all tools
./bootstrap.sh --force

# Override OS detection (useful for testing)
./bootstrap.sh --os arch

# Specify dotter profile manually
./bootstrap.sh --profile ubuntu
```

### Manual Installation (Alternative)

If you prefer manual installation:

1. Clone the repository:
```bash
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
```

2. Install tools manually based on your OS:
   - **Windows**: Use Scoop or Winget to install the tools listed above
   - **Arch Linux**: `sudo pacman -S git neovim vscode obsidian starship zoxide lazygit joshuto zellij fastfetch fzf`
   - **Ubuntu**: `sudo apt install git neovim code obsidian starship zoxide lazygit joshuto zellij fastfetch fzf`
   - **macOS**: `brew install git neovim code obsidian starship zoxide lazygit joshuto zellij fastfetch fzf`

3. Deploy configurations:
```bash
dotter deploy
```

## Dotter Configuration

Dotter manages the deployment of configuration files across different operating systems. The configuration is structured as follows:

```
.dotter/
├── global.toml      # Global configurations (applied to all OSes)
├── linux.toml       # Linux-specific configurations
├── arch.toml        # Arch Linux-specific configurations
├── ubuntu.toml      # Ubuntu-specific configurations
├── centos.toml      # CentOS-specific configurations
├── macos.toml       # macOS-specific configurations
├── windows.toml     # Windows-specific configurations
└── local.toml       # Local overrides (gitignored)
```

### How Dotter Works

1. **Global Configuration**: Base configurations that apply to all platforms
2. **OS-Specific Profiles**: Additional configurations for specific operating systems
3. **Local Overrides**: User-specific configurations (stored in `.dotter/local.toml`)

### Adding New Configurations

To add a new configuration file:

1. Place the file in the appropriate directory (e.g., `shell/bashrc` for bash configuration)
2. Update the corresponding dotter profile to include the file
3. Run `dotter deploy` to apply the changes

### Example: Adding a New Tool Configuration

To add configuration for a new tool (e.g., `ripgrep`):

1. Create the configuration file:
```bash
mkdir -p ripgrep
echo "color_always = true" > ripgrep/config.toml
```

2. Update the dotter profile (e.g., `global.toml`):
```toml
[ripgrep.files]
"ripgrep/config.toml" = "~/.config/ripgrep/config.toml"
```

3. Deploy:
```bash
dotter deploy
```

## Tool Configuration

### tools.toml - Tool Definitions

The `tools.toml` file defines which tools to install, their executables, package names, and per-OS installation methods:

```toml
[[tools]]
name = "neovim"
executable = "nvim"
package = "neovim"
methods = { windows = "scoop", arch = "pacman", ubuntu = "apt", centos = "yum", macos = "brew" }
```

Each tool section includes:
- `name`: Tool identifier used in the bootstrap script
- `executable`: Command name used to detect if the tool is installed
- `package`: Package name used by package managers
- `methods`: Table mapping OS to installation method (optional; defaults to OS-specific defaults)
- `skip_in_wsl`: Boolean (true/false) to skip installing this tool in WSL environments (optional; default false)

### WSL Support

When running under Windows Subsystem for Linux (WSL), the bootstrap script detects WSL and will skip tools marked with `skip_in_wsl = true` (e.g., GUI tools like VS Code). Use the `--wsl` flag to force installation of these tools in WSL, or `--force` to override all skips.

Available methods:
- `pacman`: Arch Linux package manager
- `apt`: Ubuntu/Debian package manager
- `yum`: CentOS/RHEL package manager
- `brew`: macOS Homebrew
- `scoop`: Windows Scoop package manager
- `winget`: Windows Winget package manager
- `curl`: Universal installer (for tools with curl-based installers)
- `cargo`: Rust Cargo (for Rust-based tools)
- `pipx`: Python package manager
- `npm`: Node.js package manager (for JavaScript tools)
- `build`: Build from source

### Adding New Tools

To add a new tool:

1. Add the tool to `GLOBAL_TOOLS` or the appropriate OS-specific list
2. Define the installation method in `tools.sh`
3. Create the install function in `bootstrap.sh` if needed
4. Update the README with the new tool information

## Troubleshooting

### Common Issues

1. **Bootstrap script not found**
   - Ensure you're running from the repository root
   - Check file permissions: `chmod +x bootstrap.sh`

2. **Tool installation fails**
   - Check internet connectivity
   - Verify package manager is installed (pacman/apt/brew/scoop/winget)
   - Run with `--verbose` for detailed output
   - Try `--force` to reinstall

3. **Dotter deployment fails**
   - Ensure dotter is installed: `command -v dotter`
   - Check dotter profile syntax
   - Run `dotter --help` for troubleshooting

4. **Tools not found after installation**
   - Restart your shell or terminal
   - Check if tools are in your PATH
   - Use `--force` to reinstall

### Debugging

Run the bootstrap script with verbose output:
```bash
./bootstrap.sh --verbose
```

Check dotter logs:
```bash
dotter deploy --verbose
```

## Contributing

### Adding New Tools

1. Edit `tools.toml` to add a new tool section
2. Define the installation method
3. Create the install function in `bootstrap.sh` if needed
4. Update the README with the new tool information
5. Test on all supported platforms

### Modifying Configurations

1. Make changes to the appropriate dotter profile
2. Test the changes locally
3. Deploy and verify the changes work as expected

### Testing

Test the bootstrap script on different platforms:
```bash
# Test on Windows
bash ./bootstrap.sh --dry-run

# Test on Linux
./bootstrap.sh --dry-run
```

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Acknowledgments

- [Dotter](https://github.com/SuperCuber/dotter) - Dotfile manager
- [Starship](https://starship.rs/) - Cross-shell prompt
- [Zoxide](https://github.com/ajeetdsouza/zoxide) - Smarter cd command
- [Lazygit](https://github.com/jesseduffield/lazygit) - Simple terminal UI for git
- [Joshuto](https://github.com/kamiyaa/joshuto) - Terminal file manager
- [Zellij](https://github.com/zellij-org/zellij) - Terminal workspace manager
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch) - Fast system info
- [FZF](https://github.com/junegunn/fzf) - Command-line fuzzy finder
- [GlazeWM](https://github.com/GlazeWM/GlazeWM) - Tiling window manager for Windows
- [YASB](https://github.com/ChrisGrieser/yasb) - Yet Another Status Bar for Windows
- [PowerToys](https://github.com/microsoft/PowerToys) - Windows system utilities
