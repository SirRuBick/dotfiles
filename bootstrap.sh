#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "${BASH_SOURCE[0]}")"
DOTFILES_ROOT="$(pwd -P)"

# ── Colors ──────────────────────────────────────────────────────────────────
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

# ── Logging ─────────────────────────────────────────────────────────────────
title()   { echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"; echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"; }
error()   { echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1" >&2; exit 1; }
warning() { echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"; }
info()    { echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"; }
success() { echo -e "${COLOR_GREEN}$1${COLOR_NONE}"; }

# ── Globals ─────────────────────────────────────────────────────────────────
OS=""
DRY_RUN=false
FORCE=false
TOOLS_ONLY=false
DEPLOY_ONLY=false
NO_BACKUP=false
VERBOSE=false
SPECIFIC_TOOLS=()
SKIP_TOOLS=()
DOTTER_PROFILE=""
WSL=false
IS_WSL=false
WSL_DISTRO_NAME=""

# ── OS Detection ────────────────────────────────────────────────────────────
detect_os() {
    local uname_out
    uname_out="$(uname -s)"

    case "$uname_out" in
        Linux*)
            if [ -f /etc/arch-release ]; then
                OS="arch"
            elif [ -f /etc/debian_version ]; then
                OS="ubuntu"
            elif [ -f /etc/centos-release ] || [ -f /etc/redhat-release ]; then
                OS="centos"
            else
                OS="linux"
            fi
            ;;
        Darwin*)
            OS="macos"
            ;;
        MINGW*|MSYS*|CYGWIN*)
            OS="windows"
            ;;
        *)
            error "Unsupported OS: $uname_out"
            ;;
    esac
}

detect_wsl() {
    if [[ -f /proc/sys/fs/binfmt_misc/WSLInterop ]] || \
       [[ "$(uname -r)" =~ microsoft ]] || \
       [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
        IS_WSL=true
    else
        IS_WSL=false
    fi
    if [[ -n "${WSL_DISTRO_NAME:-}" ]]; then
        # Optionally store the distro name
        :
    fi
}

dotter_profile_for_os() {
    case "$OS" in
        arch)   echo "arch" ;;
        ubuntu) echo "ubuntu" ;;
        centos) echo "centos" ;;
        macos)  echo "macos" ;;
        windows) echo "windows" ;;
        linux)  echo "linux" ;;
    esac
}

# ── Load and parse tools.toml ───────────────────────────────────────────────
load_tools_config() {
    if [ ! -f "$DOTFILES_ROOT/tools.toml" ]; then
        error "tools.toml not found. Create it with tool definitions."
    fi

    local -n tools_ref=$1
    local -n executables_ref=$2
    local -n packages_ref=$3
    local -n methods_ref=$4

    # Clear arrays
    tools_ref=()
    executables_ref=()
    packages_ref=()
    methods_ref=()

    local awk_script='
    /^\[\[tools\]\]/ {
        if (current_tool != "") {
            print "TOOL|" current_tool "|" current_executable "|" current_package
            for (os in methods) {
                print "METHOD|" current_tool "|" os "|" methods[os]
            }
        }
        current_tool = ""
        current_executable = ""
        current_package = ""
        delete methods
        in_tools = 1
        next
    }
    /^[[:space:]]*name[[:space:]]*=/ && in_tools {
        sub(/^[[:space:]]*name[[:space:]]*=[[:space:]]*/, "")
        gsub(/^[[:space:]]*/, "", $0)
        gsub(/[[:space:]]*$/, "", $0)
        gsub(/^"|"$/, "", $0)
        current_tool = $0
        next
    }
    /^[[:space:]]*executable[[:space:]]*=/ && in_tools {
        sub(/^[[:space:]]*executable[[:space:]]*=[[:space:]]*/, "")
        gsub(/^[[:space:]]*/, "", $0)
        gsub(/[[:space:]]*$/, "", $0)
        gsub(/^"|"$/, "", $0)
        current_executable = $0
        next
    }
    /^[[:space:]]*package[[:space:]]*=/ && in_tools {
        sub(/^[[:space:]]*package[[:space:]]*=[[:space:]]*/, "")
        gsub(/^[[:space:]]*/, "", $0)
        gsub(/[[:space:]]*$/, "", $0)
        gsub(/^"|"$/, "", $0)
        current_package = $0
        next
    }
    /^[[:space:]]*methods[[:space:]]*=/ && in_tools {
        line = $0
        sub(/^[[:space:]]*methods[[:space:]]*=[[:space:]]*/, "", line)
        # Remove surrounding braces
        gsub(/^[[:space:]]*{/, "", line)
        gsub(/[[:space:]]*}$/, "", line)
        split(line, pairs, ",")
        for (i in pairs) {
            split(pairs[i], kv, "=")
            if (length(kv) == 2) {
                # Strip leading/trailing spaces and quotes from key and value
                gsub(/^[[:space:]]*/, "", kv[1])
                gsub(/[[:space:]]*$/, "", kv[1])
                gsub(/^"|"$/, "", kv[1])
                gsub(/^[[:space:]]*/, "", kv[2])
                gsub(/[[:space:]]*$/, "", kv[2])
                gsub(/^"|"$/, "", kv[2])
                methods[kv[1]] = kv[2]
            }
        }
        next
    }
    /^[[:space:]]*skip_in_wsl[[:space:]]*=/ && in_tools {
        line = $0
        sub(/^[[:space:]]*skip_in_wsl[[:space:]]*=[[:space:]]*/, "", line)
        gsub(/^[[:space:]]*/, "", line)
        gsub(/[[:space:]]*$/, "", line)
        if (line == "true") {
            print "SKIP|" current_tool
        }
        next
    }
    /^[[:space:]]*$/ || /^[[:space:]]*#/ {
        # blank line or comment, ignore
        next
    }
    END {
        if (current_tool != "") {
            print "TOOL|" current_tool "|" current_executable "|" current_package
            for (os in methods) {
                print "METHOD|" current_tool "|" os "|" methods[os]
            }
        }
    }
    '

    local output
    output=$(awk "$awk_script" "$DOTFILES_ROOT/tools.toml" 2>/dev/null)

    if [ -z "$output" ]; then
        error "Failed to parse tools.toml or no tools found"
    fi

    while IFS= read -r line; do
        case "$line" in
            TOOL\|*)
                IFS='|' read -r _ tool executable package <<< "$line"
                tools_ref+=("$tool")
                executables_ref+=("$executable")
                packages_ref+=("$package")
                # placeholder for methods array (empty)
                methods_ref+=("")
                ;;
            METHOD\|*)
                IFS='|' read -r _ tool os method <<< "$line"
                # Set variable TOOL_METHOD_<tool>_<os>
                declare "TOOL_METHOD_${tool}_${os}=${method}"
                ;;
            SKIP\|*)
                IFS='|' read -r _ tool <<< "$line"
                # Set variable TOOL_SKIP_<tool>
                declare "TOOL_SKIP_${tool}=true"
                ;;
        esac
    done <<< "$output"

    # If verbose, print parsed methods and skip flags
    if [ "$VERBOSE" = true ]; then
        info "Parsed ${#tools_ref[@]} tools from tools.toml"
        for i in "${!tools_ref[@]}"; do
            local tool="${tools_ref[$i]}"
            echo "  $tool:"
            local os_list="windows arch ubuntu centos macos"
            for os in $os_list; do
                local var_name="TOOL_METHOD_${tool}_${os}"
                if [ -n "${!var_name+x}" ]; then
                    echo "    $os: ${!var_name}"
                fi
            done
            local skip_var="TOOL_SKIP_${tool}"
            if [ "${!skip_var:-}" = true ]; then
                echo "    skip_in_wsl: true"
            fi
        done
    fi
}

# ── Helper: run or dry-run ──────────────────────────────────────────────────
run_cmd() {
    if [ "$DRY_RUN" = true ]; then
        echo -e "${COLOR_GRAY}  [dry-run] $*${COLOR_NONE}"
    else
        if [ "$VERBOSE" = true ]; then
            info "Running: $*"
        fi
        "$@"
    fi
}

tool_installed() {
    local tool_executable="$1"
    case "$tool_executable" in
        pwsh) 
            if [ "$OS" = "windows" ]; then
                powershell -Command "Get-Command pwsh -ErrorAction SilentlyContinue" &>/dev/null
            else
                command -v pwsh &>/dev/null
            fi
            ;;
        powertoys) 
            if [ "$OS" = "windows" ]; then
                [ -d "$LOCALAPPDATA/Microsoft/PowerToys" ] 2>/dev/null
            else
                command -v powertoys &>/dev/null
            fi
            ;;
        *)
            if [ "$OS" = "windows" ]; then
                powershell -Command "Get-Command $tool_executable -ErrorAction SilentlyContinue" &>/dev/null
            else
                command -v "$tool_executable" &>/dev/null
            fi
            ;;
    esac
}

should_skip_tool() {
    local tool="$1"
    local var_name="TOOL_SKIP_${tool}"
    if [ "$IS_WSL" = true ] && [ "${!var_name:-}" = true ]; then
        return 0  # skip
    fi
    return 1  # don't skip
}

ensure_scoop() {
    if [ "$OS" != "windows" ]; then return; fi
    if command -v scoop &>/dev/null; then return; fi
    info "Installing scoop..."
    run_cmd powershell -Command "Set-ExecutionPolicy RemoteSigned -Scope CurrentUser -Force; Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression"
}

ensure_winget() {
    if [ "$OS" != "windows" ]; then return; fi
    if command -v winget &>/dev/null; then return; fi
    warning "winget not found. Install App Installer from Microsoft Store."
}

ensure_brew() {
    if [ "$OS" != "macos" ]; then return; fi
    if command -v brew &>/dev/null; then return; fi
    info "Installing Homebrew..."
    run_cmd /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

ensure_cargo() {
    if command -v cargo &>/dev/null; then return; fi
    info "Installing Rust/Cargo..."
    run_cmd curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | run_cmd sh -s -- -y
    source "$HOME/.cargo/env"
}

ensure_pipx() {
    if command -v pipx &>/dev/null; then return; fi
    info "Installing pipx..."
    if [ "$OS" = "windows" ]; then
        run_cmd pip install pipx
        run_cmd pipx ensurepath
    else
        run_cmd python3 -m pip install --user pipx
        run_cmd python3 -m pipx ensurepath
    fi
}

ensure_npm() {
    if command -v npm &>/dev/null; then return; fi
    info "Installing Node.js (includes npm)..."
    case "$OS" in
        arch)   run_cmd sudo pacman -S --needed --noconfirm nodejs npm ;;
        ubuntu) run_cmd sudo apt install -y nodejs npm ;;
        centos) run_cmd sudo yum install -y nodejs npm ;;
        macos)  run_cmd brew install node ;;
        windows)
            if command -v scoop &>/dev/null; then
                run_cmd scoop install nodejs
            elif command -v winget &>/dev/null; then
                run_cmd winget install --id OpenJS.NodeJS -e --accept-source-agreements --accept-package-agreements
            else
                error "No package manager available to install Node.js"
            fi
            ;;
        *)      error "Unsupported OS for Node.js installation" ;;
    esac
}

ensure_awk() {
    if command -v awk &>/dev/null; then return; fi
    info "Installing awk..."
    case "$OS" in
        arch) run_cmd sudo pacman -S --needed --noconfirm gawk ;;
        ubuntu) run_cmd sudo apt install -y gawk ;;
        centos) run_cmd sudo yum install -y gawk ;;
        macos) run_cmd brew install gawk ;;
        windows)
            # Try scoop first, then winget
            if command -v scoop &>/dev/null; then
                run_cmd scoop install gawk
            elif command -v winget &>/dev/null; then
                run_cmd winget install --id GnuWin32.Awk -e --accept-source-agreements --accept-package-agreements
            else
                warning "awk not found and no package manager available. Please install Git for Windows (includes awk)."
                exit 1
            fi
            ;;
        *) error "Unsupported OS for awk installation" ;;
    esac
}

# ── Get install method for a tool ───────────────────────────────────────────
get_tool_method() {
    local tool="$1"
    local var_name="TOOL_METHOD_${tool}_${OS}"
    if [ -n "${!var_name+x}" ]; then
        echo "${!var_name}"
    else
        case "$OS" in
            arch)   echo "pacman" ;;
            ubuntu) echo "apt" ;;
            centos) echo "yum" ;;
            macos)  echo "brew" ;;
            windows) echo "scoop" ;;
            *)      echo "unknown" ;;
        esac
    fi
}

# ── Per-tool install functions ──────────────────────────────────────────────

install_git() {
    local method
    method="$(get_tool_method git)"
    case "$method" in
        pacman)     run_cmd sudo pacman -S --needed --noconfirm git ;;
        apt)        run_cmd sudo apt install -y git ;;
        yum)        run_cmd sudo yum install -y git ;;
        xcode_cli)  run_cmd xcode-select --install 2>/dev/null || true ;;
        winget)     run_cmd winget install --id Git.Git -e --accept-source-agreements --accept-package-agreements ;;
        *)          error "Unsupported method '$method' for git on $OS" ;;
    esac
}

install_neovim() {
    local method
    method="$(get_tool_method neovim)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm neovim ;;
        apt)
            run_cmd sudo add-apt-repository -y ppa:neovim-ppa/unstable 2>/dev/null || true
            run_cmd sudo apt update -y
            run_cmd sudo apt install -y neovim
            ;;
        yum)
            run_cmd sudo yum install -y epel-release
            run_cmd sudo yum install -y neovim
            ;;
        brew)   run_cmd brew install neovim ;;
        scoop)  run_cmd scoop install neovim ;;
        build)
            info "Building neovim from source..."
            local nvim_dir
            nvim_dir="$(mktemp -d)"
            run_cmd git clone --depth 1 https://github.com/neovim/neovim.git "$nvim_dir"
            run_cmd make -C "$nvim_dir" CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX="$HOME/.local"
            run_cmd make -C "$nvim_dir" install
            rm -rf "$nvim_dir"
            ;;
        *) error "Unsupported method '$method' for neovim on $OS" ;;
    esac
}

install_vscode() {
    local method
    method="$(get_tool_method vscode)"
    case "$method" in
        pacman)
            if command -v paru &>/dev/null; then
                run_cmd paru -S --needed --noconfirm visual-studio-code-bin
            elif command -v yay &>/dev/null; then
                run_cmd yay -S --needed --noconfirm visual-studio-code-bin
            else
                warning "AUR helper not found. Install paru or yay first, then: paru -S visual-studio-code-bin"
            fi
            ;;
        apt)
            run_cmd sudo apt install -y wget gpg
            run_cmd wget -qO- https://packages.microsoft.com/keys/microsoft.asc | run_cmd gpg --dearmor > /tmp/packages.microsoft.gpg
            run_cmd sudo install -D -o root -g root -m 644 /tmp/packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
            echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" | run_cmd sudo tee /etc/apt/sources.list.d/vscode.list
            run_cmd sudo apt update -y
            run_cmd sudo apt install -y code
            ;;
        yum)
            run_cmd sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | run_cmd sudo tee /etc/yum.repos.d/vscode.repo
            run_cmd sudo yum install -y code
            ;;
        brew)   run_cmd brew install --cask visual-studio-code ;;
        winget) run_cmd winget install --id Microsoft.VisualStudioCode -e --accept-source-agreements --accept-package-agreements ;;
        *) error "Unsupported method '$method' for vscode on $OS" ;;
    esac
}

install_obsidian() {
    local method
    method="$(get_tool_method obsidian)"
    case "$method" in
        pacman)
            if command -v paru &>/dev/null; then
                run_cmd paru -S --needed --noconfirm obsidian
            elif command -v yay &>/dev/null; then
                run_cmd yay -S --needed --noconfirm obsidian
            else
                warning "AUR helper not found. Install paru or yay first, then: paru -S obsidian"
            fi
            ;;
        curl)
            info "Downloading Obsidian AppImage..."
            local arch_suffix
            arch_suffix="$(uname -m)"
            case "$arch_suffix" in
                x86_64) arch_suffix="amd64" ;;
                aarch64) arch_suffix="arm64" ;;
            esac
            run_cmd curl -fSL "https://github.com/obsidianmd/obsidian-releases/releases/latest/download/Obsidian-${arch_suffix}.AppImage" -o "$HOME/.local/bin/obsidian.AppImage"
            run_cmd chmod +x "$HOME/.local/bin/obsidian.AppImage"
            ;;
        brew)   run_cmd brew install --cask obsidian ;;
        winget) run_cmd winget install --id Obsidian.Obsidian -e --accept-source-agreements --accept-package-agreements ;;
        *) error "Unsupported method '$method' for obsidian on $OS" ;;
    esac
}

install_starship() {
    local method
    method="$(get_tool_method starship)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm starship ;;
        apt)    run_cmd sudo apt install -y starship ;;
        brew)   run_cmd brew install starship ;;
        scoop)  run_cmd scoop install starship ;;
        curl)
            run_cmd curl -sS https://starship.rs/install.sh | run_cmd sh -s -- -y
            ;;
        *) error "Unsupported method '$method' for starship on $OS" ;;
    esac
}

install_zoxide() {
    local method
    method="$(get_tool_method zoxide)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm zoxide ;;
        apt)    run_cmd sudo apt install -y zoxide ;;
        brew)   run_cmd brew install zoxide ;;
        scoop)  run_cmd scoop install zoxide ;;
        curl)
            run_cmd curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | run_cmd sh
            ;;
        *) error "Unsupported method '$method' for zoxide on $OS" ;;
    esac
}

install_lazygit() {
    local method
    method="$(get_tool_method lazygit)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm lazygit ;;
        apt)    run_cmd sudo apt install -y lazygit ;;
        brew)   run_cmd brew install lazygit ;;
        scoop)  run_cmd scoop install lazygit ;;
        curl)
            local arch
            arch="$(uname -m)"
            case "$arch" in
                x86_64) arch="x86_64" ;;
                aarch64) arch="arm64" ;;
            esac
            local latest_version
            latest_version="$(curl -sL https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep '"tag_name"' | head -1 | sed -E 's/.*"v([^"]+)".*/\1/')"
            if [ -z "$latest_version" ]; then
                error "Could not determine latest lazygit version"
            fi
            info "Installing lazygit v${latest_version}..."
            local tmp_dir
            tmp_dir="$(mktemp -d)"
            run_cmd curl -sSL "https://github.com/jesseduffield/lazygit/releases/download/v${latest_version}/lazygit_${latest_version}_Linux_${arch}.tar.gz" -o "$tmp_dir/lazygit.tar.gz"
            run_cmd tar -xzf "$tmp_dir/lazygit.tar.gz" -C "$tmp_dir"
            run_cmd mkdir -p "$HOME/.local/bin"
            run_cmd cp "$tmp_dir/lazygit" "$HOME/.local/bin/lazygit"
            run_cmd chmod +x "$HOME/.local/bin/lazygit"
            rm -rf "$tmp_dir"
            ;;
        *) error "Unsupported method '$method' for lazygit on $OS" ;;
    esac
}

install_joshuto() {
    local method
    method="$(get_tool_method joshuto)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm joshuto ;;
        brew)   run_cmd brew install joshuto ;;
        scoop)  run_cmd scoop install joshuto ;;
        cargo)
            ensure_cargo
            run_cmd cargo install joshuto
            ;;
        *) error "Unsupported method '$method' for joshuto on $OS" ;;
    esac
}

install_zellij() {
    local method
    method="$(get_tool_method zellij)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm zellij ;;
        apt)    run_cmd sudo apt install -y zellij ;;
        brew)   run_cmd brew install zellij ;;
        scoop)  run_cmd scoop install zellij ;;
        curl)
            run_cmd curl -L https://github.com/zellij-org/zellij/releases/latest/download/zellij-$(uname -m)-unknown-linux-musl.tar.gz | run_cmd tar -xz -C "$HOME/.local/bin"
            ;;
        *) error "Unsupported method '$method' for zellij on $OS" ;;
    esac
}

install_fastfetch() {
    local method
    method="$(get_tool_method fastfetch)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm fastfetch ;;
        apt)
            run_cmd sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch 2>/dev/null || true
            run_cmd sudo apt update -y
            run_cmd sudo apt install -y fastfetch
            ;;
        brew)   run_cmd brew install fastfetch ;;
        scoop)  run_cmd scoop install fastfetch ;;
        curl)
            local arch
            arch="$(uname -m)"
            case "$arch" in
                x86_64) arch="x86_64" ;;
                aarch64) arch="aarch64" ;;
            esac
            local latest_version
            latest_version="$(curl -sL https://api.github.com/repos/fastfetch-cli/fastfetch/releases/latest | grep '"tag_name"' | head -1 | sed -E 's/.*"([^"]+)".*/\1/')"
            if [ -z "$latest_version" ]; then
                error "Could not determine latest fastfetch version"
            fi
            info "Installing fastfetch ${latest_version}..."
            local tmp_dir
            tmp_dir="$(mktemp -d)"
            run_cmd curl -sSL "https://github.com/fastfetch-cli/fastfetch/releases/download/${latest_version}/fastfetch-linux-${arch}.deb" -o "$tmp_dir/fastfetch.deb"
            run_cmd sudo dpkg -i "$tmp_dir/fastfetch.deb"
            rm -rf "$tmp_dir"
            ;;
        *) error "Unsupported method '$method' for fastfetch on $OS" ;;
    esac
}

install_fzf() {
    local method
    method="$(get_tool_method fzf)"
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm fzf ;;
        apt)    run_cmd sudo apt install -y fzf ;;
        yum)    run_cmd sudo yum install -y fzf ;;
        brew)   run_cmd brew install fzf ;;
        scoop)  run_cmd scoop install fzf ;;
        *) error "Unsupported method '$method' for fzf on $OS" ;;
    esac
}

# ── Generic tool installation ───────────────────────────────────────────────
generic_install_tool() {
    local tool_package="$1"
    local method="$2"
    local tool_executable="$3"
    
    case "$method" in
        pacman) run_cmd sudo pacman -S --needed --noconfirm "$tool_package" ;;
        apt)    run_cmd sudo apt install -y "$tool_package" ;;
        yum)    run_cmd sudo yum install -y "$tool_package" ;;
        brew)   run_cmd brew install "$tool_package" ;;
        scoop)  run_cmd scoop install "$tool_package" ;;
        winget) run_cmd winget install --id "$tool_package" -e --accept-source-agreements --accept-package-agreements ;;
        xcode_cli) run_cmd xcode-select --install 2>/dev/null || true ;;
        curl)
            info "Installing $tool_package via curl..."
            run_cmd curl -sS "https://$tool_package/install.sh" | run_cmd sh
            ;;
        cargo)
            ensure_cargo
            run_cmd cargo install "$tool_package"
            ;;
        pipx)
            ensure_pipx
            run_cmd pipx install "$tool_package"
            ;;
        npm)
            ensure_npm
            run_cmd npm install -g "$tool_package"
            ;;
        build)
            info "Building $tool_package from source..."
            local tmp_dir
            tmp_dir="$(mktemp -d)"
            run_cmd git clone "https://github.com/$tool_package" "$tmp_dir"
            run_cmd make -C "$tmp_dir"
            run_cmd make -C "$tmp_dir" install
            rm -rf "$tmp_dir"
            ;;
        *) error "Unsupported method '$method' for $tool_package on $OS" ;;
    esac
}

install_glazewm() {
    local method
    method="$(get_tool_method glazewm)"
    case "$method" in
        scoop)  run_cmd scoop install glazewm ;;
        winget) run_cmd winget install --id GlazeWM.GlazeWM -e --accept-source-agreements --accept-package-agreements ;;
        *)      error "glazewm is only available on Windows" ;;
    esac
}

install_yasb() {
    local method
    method="$(get_tool_method yasb)"
    case "$method" in
        pipx)
            ensure_pipx
            run_cmd pipx install yasb
            ;;
        *) error "Unsupported method '$method' for yasb on $OS" ;;
    esac
}

install_powershell() {
    local method
    method="$(get_tool_method powershell)"
    case "$method" in
        winget) run_cmd winget install --id Microsoft.PowerShell -e --accept-source-agreements --accept-package-agreements ;;
        scoop)  run_cmd scoop install pwsh ;;
        *)      error "powershell is only available on Windows" ;;
    esac
}

install_powertoys() {
    local method
    method="$(get_tool_method powertoys)"
    case "$method" in
        winget) run_cmd winget install --id Microsoft.PowerToys -e --accept-source-agreements --accept-package-agreements ;;
        scoop)  run_cmd scoop install powertoys ;;
        *)      error "powertoys is only available on Windows" ;;
    esac
}

# ── Tool install dispatcher ─────────────────────────────────────────────────
install_tool() {
    local tool_name="$1"
    local -n tools_ref=$2
    local -n executables_ref=$3
    local -n packages_ref=$4
    local -n methods_ref=$5
    
    # Find the tool index in the arrays
    local tool_index=-1
    for i in "${!tools_ref[@]}"; do
        if [ "${tools_ref[$i]}" = "$tool_name" ]; then
            tool_index=$i
            break
        fi
    done
    
    if [ $tool_index -eq -1 ]; then
        warning "Tool '$tool_name' not found in configuration. Skipping."
        return
    fi
    
    local tool_executable="${executables_ref[$tool_index]}"
    local tool_package="${packages_ref[$tool_index]}"
    local tool_methods="${methods_ref[$tool_index]}"
    
    # Check if tool should be skipped in WSL
    if should_skip_tool "$tool_name"; then
        if [ "$FORCE" = true ] || [ "$WSL" = true ]; then
            info "Skipping $tool_name (not applicable in WSL, but overridden by --force/--wsl)"
        else
            info "Skipping $tool_name (not applicable in WSL; use --wsl or --force to install)"
            return
        fi
    fi
    # Check if tool is already installed
    if [ "$FORCE" = false ] && tool_installed "$tool_executable"; then
        info "$tool_name ($tool_executable) is already installed. Use --force to reinstall."
        return
    fi
    
    # Get installation method from parsed TOML or default
    local method
    method="$(get_tool_method "$tool_name")"
    
    info "Installing $tool_name ($tool_executable) with method: $method"
    
    # Call the appropriate install function
    local install_func="install_${tool_name}"
    if type -t "$install_func" &>/dev/null; then
        "$install_func" "$tool_package" "$method"
    else
        warning "No install function for tool '$tool_name'. Using generic installation."
        generic_install_tool "$tool_package" "$method" "$tool_executable"
    fi
    
    if [ "$DRY_RUN" = false ]; then
        if tool_installed "$tool_executable"; then
            success "  $tool_name installed successfully"
        else
            warning "  $tool_name may not be on PATH yet (will be available after shell restart)"
        fi
    fi
}

# ── Compute final tool list ─────────────────────────────────────────────────
get_tool_list() {
    local tools_ref=("$@")
    local os_tools_var="TOOLS_$(echo "$OS" | tr '[:lower:]' '[:upper:]')"
    local os_tools="${!os_tools_var:-}"

    local all_tools="${tools_ref[*]} $os_tools"

    local result=()
    for tool in $all_tools; do
        local skip=false

        for st in "${SKIP_TOOLS[@]}"; do
            if [ "$st" = "$tool" ]; then
                skip=true
                break
            fi
        done

        if [ "$skip" = false ]; then
            result+=("$tool")
        fi
    done

    echo "${result[*]}"
}

# ── Install dotter ──────────────────────────────────────────────────────────
install_dotter() {
    if command -v dotter &>/dev/null; then
        info "dotter is already installed"
        return
    fi

    info "Installing dotter..."
    local dotter_bin="$HOME/.local/bin/dotter"
    mkdir -p "$(dirname "$dotter_bin")"

    local suffix
    case "$OS" in
        arch|ubuntu|centos|linux)
            suffix="dotter-x86_64-unknown-linux-gnu"
            if [ "$(uname -m)" = "aarch64" ]; then
                suffix="dotter-aarch64-unknown-linux-gnu"
            fi
            ;;
        macos)
            suffix="dotter-x86_64-apple-darwin"
            if [ "$(uname -m)" = "arm64" ]; then
                suffix="dotter-aarch64-apple-darwin"
            fi
            ;;
        windows)
            suffix="dotter-x86_64-pc-windows-msvc.exe"
            dotter_bin="$HOME/.local/bin/dotter.exe"
            ;;
    esac

    run_cmd curl -L "https://github.com/SuperCuber/dotter/releases/latest/download/${suffix}" -o "$dotter_bin"
    run_cmd chmod +x "$dotter_bin"

    export PATH="$HOME/.local/bin:$PATH"
    success "dotter installed to $dotter_bin"
}

# ── Backup existing dotfiles ────────────────────────────────────────────────
backup_dotfiles() {
    if [ "$NO_BACKUP" = true ]; then
        info "Skipping backup (--no-backup)"
        return
    fi

    title "Backing up existing dotfiles"
    local backup_dir="$HOME/dotfiles-backup-$(date +%Y%m%d-%H%M%S)"
    local backup_items=()

    local items
    case "$OS" in
        windows)
            items=(
                "$HOME/.gitconfig"
                "$HOME/.ideavimrc"
                "$HOME/AppData/Local/nvim/init.lua"
                "$HOME/AppData/Roaming/Code/User/settings.json"
                "$HOME/AppData/Roaming/Code/User/keybindings.json"
                "$HOME/.obsidian.vimrc"
            )
            ;;
        macos)
            items=(
                "$HOME/.gitconfig"
                "$HOME/.ideavimrc"
                "$HOME/.config/nvim/init.lua"
                "$HOME/Library/Application Support/Code/User/settings.json"
                "$HOME/.obsidian.vimrc"
            )
            ;;
        *)
            items=(
                "$HOME/.gitconfig"
                "$HOME/.ideavimrc"
                "$HOME/.config/nvim/init.lua"
                "$HOME/.config/Code/User/settings.json"
                "$HOME/.obsidian.vimrc"
            )
            ;;
    esac

    for item in "${items[@]}"; do
        if [ -e "$item" ]; then
            backup_items+=("$item")
            info "Backing up: $item"
        fi
    done

    if [ ${#backup_items[@]} -eq 0 ]; then
        info "No existing dotfiles found to backup"
    else
        mkdir -p "$backup_dir"
        for item in "${backup_items[@]}"; do
            if [ -d "$item" ]; then
                cp -r "$item" "$backup_dir/$(basename "$item")"
            else
                cp "$item" "$backup_dir/"
            fi
        done
        success "Backup completed: $backup_dir"
    fi
}

# ── Dotter deploy ───────────────────────────────────────────────────────────
dotter_deploy() {
    title "Deploying dotfiles with dotter"

    install_dotter

    if [ -n "$DOTTER_PROFILE" ]; then
        info "Using specified profile: $DOTTER_PROFILE"
    else
        DOTTER_PROFILE="$(dotter_profile_for_os)"
        info "Auto-detected dotter profile: $DOTTER_PROFILE"
    fi

    run_cmd dotter deploy -v
    success "Dotter deploy complete"
}

# ── Git setup ───────────────────────────────────────────────────────────────
setup_git() {
    title "Setting up Git"

    local current_name current_email
    current_name="$(git config --global user.name 2>/dev/null || echo "")"
    current_email="$(git config --global user.email 2>/dev/null || echo "")"

    if [ -z "$current_name" ] || [ -z "$current_email" ]; then
        if [ "$DRY_RUN" = true ]; then
            info "[dry-run] Would prompt for git user.name and user.email"
            return
        fi
        read -rp "Git user.name [${current_name}]: " name
        read -rp "Git user.email [${current_email}]: " email
        git config --global user.name "${name:-$current_name}"
        git config --global user.email "${email:-$current_email}"
    else
        info "Git already configured: $current_name <$current_email>"
    fi
}

# ── Validate ────────────────────────────────────────────────────────────────
validate() {
    title "Validating installation"
    local tools
    tools="$(get_tool_list)"
    local failed=false

    for tool in $tools; do
        if tool_installed "$tool"; then
            success "  $tool: found"
        else
            warning "  $tool: not found (may need shell restart)"
            failed=true
        fi
    done

    if command -v dotter &>/dev/null; then
        success "  dotter: found"
    else
        warning "  dotter: not found"
        failed=true
    fi

    if [ "$failed" = true ]; then
        warning "Some tools not found. Restart your shell and check again."
    else
        success "All tools validated!"
    fi
}

# ── Usage ───────────────────────────────────────────────────────────────────
usage() {
    cat <<'EOF'
Usage: bootstrap.sh [OPTIONS]

Dotfiles bootstrap script - installs tools and deploys config files via dotter.

Options:
  --tools-only         Install tools only, skip dotter deploy
  --deploy-only        Run dotter deploy only, skip tool installation
  --tool <name>        Install specific tool(s) only (can be repeated)
  --skip-tool <name>   Skip specific tool(s) (can be repeated)
  --os <os>            Override OS detection (arch|ubuntu|centos|macos|windows)
  --profile <profile>  Override dotter profile (default: auto-detected)
   --dry-run            Show what would be installed without executing
   --force              Reinstall tools even if already present
   --no-backup          Skip dotfile backup before deploy
   --wsl                Install tools in WSL environment (skip GUI tools)
   --verbose, -v        Verbose output
   --help, -h           Show this help message

Examples:
  bootstrap.sh                        # Full: install tools + deploy configs
  bootstrap.sh --tools-only           # Install tools only
  bootstrap.sh --deploy-only          # Deploy configs only
  bootstrap.sh --tool starship --tool zoxide  # Install specific tools
  bootstrap.sh --skip-tool vscode     # Install everything except vscode
  bootstrap.sh --os arch --dry-run    # Preview arch installations
  bootstrap.sh --force                # Reinstall all tools

Available tools (global):
  git neovim vscode obsidian starship zoxide lazygit joshuto zellij fastfetch fzf

OS-specific tools:
  windows: glazewm yasb powershell powertoys

   Edit tools.toml to customize tool definitions.
EOF
}

# ── Parse arguments ─────────────────────────────────────────────────────────
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --tools-only)   TOOLS_ONLY=true; shift ;;
            --deploy-only)  DEPLOY_ONLY=true; shift ;;
            --tool)
                if [ -z "${2:-}" ]; then error "--tool requires an argument"; fi
                SPECIFIC_TOOLS+=("$2"); shift 2 ;;
            --skip-tool)
                if [ -z "${2:-}" ]; then error "--skip-tool requires an argument"; fi
                SKIP_TOOLS+=("$2"); shift 2 ;;
            --os)
                if [ -z "${2:-}" ]; then error "--os requires an argument"; fi
                OS="$2"; shift 2 ;;
            --profile)
                if [ -z "${2:-}" ]; then error "--profile requires an argument"; fi
                DOTTER_PROFILE="$2"; shift 2 ;;
            --dry-run)      DRY_RUN=true; shift ;;
            --force)        FORCE=true; shift ;;
            --no-backup)    NO_BACKUP=true; shift ;;
            --verbose|-v)   VERBOSE=true; shift ;;
            --wsl)          WSL=true; shift ;;
            --help|-h)      usage; exit 0 ;;
            *)              error "Unknown option: $1. Use --help for usage." ;;
        esac
    done

    if [ "$TOOLS_ONLY" = true ] && [ "$DEPLOY_ONLY" = true ]; then
        error "Cannot use both --tools-only and --deploy-only"
    fi
}

# ── Main ────────────────────────────────────────────────────────────────────
main() {
    parse_args "$@"

    if [ -z "$OS" ]; then
        detect_os
    fi
    info "Detected OS: $OS"

    # Detect WSL
    detect_wsl
    if [ "$WSL" = true ]; then
        IS_WSL=true
    fi
    if [ "$IS_WSL" = true ]; then
        info "WSL detected"
        if [ "$WSL" = false ] && [ "$FORCE" = false ]; then
            error "WSL detected. Use --wsl to install tools in WSL, or --force to ignore."
        fi
    fi

    # Ensure package managers are available
    case "$OS" in
        windows)
            ensure_scoop
            ensure_winget
            ;;
        macos)
            ensure_brew
            ;;
        # Linux package managers are usually pre-installed
    esac
    ensure_awk

# Load tools configuration from TOML
    local tools=()
    local executables=()
    local packages=()
    local methods=()
    load_tools_config tools executables packages methods
    
    if [ "$VERBOSE" = true ]; then
        info "Loaded ${#tools[@]} tools from tools.toml"
        for i in "${!tools[@]}"; do
            echo "  ${tools[$i]} (executable: ${executables[$i]}, package: ${packages[$i]})"
        done
    fi
    
    if [ "$DRY_RUN" = true ]; then
        warning "DRY RUN - no changes will be made"
    fi

    if [ "$DEPLOY_ONLY" = false ]; then
        title "Installing Tools"

        if [ ${#SPECIFIC_TOOLS[@]} -gt 0 ]; then
            info "Installing specific tools: ${SPECIFIC_TOOLS[*]}"
            for tool_name in "${SPECIFIC_TOOLS[@]}"; do
                install_tool "$tool_name" tools executables packages methods
            done
        else
            local tool_list
            tool_list="$(get_tool_list "${tools[@]}")"
            info "Tools to install: $tool_list"
            for tool_name in $tool_list; do
                install_tool "$tool_name" tools executables packages methods
            done
        fi
    fi

    if [ "$TOOLS_ONLY" = false ]; then
        setup_git
        backup_dotfiles
        dotter_deploy
    fi

    validate

    echo ""
    success "Bootstrap complete! Restart your shell or source your rc files."
}

main "$@"
