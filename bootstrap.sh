#!/usr/bin/env bash
set -e

cd "$(dirname "${BASH_SOURCE}")"

DOTFILES_ROOT=$(pwd -P)
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

echo "DOTFILES_ROOT: $DOTFILES_ROOT"

title() {
	echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
	echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
	echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
	exit 1
}

warning() {
	echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
	echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
	echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

setup_dotter() {
	title "Setup Dotter"
	if ! command -v "dotter" &>/dev/null; then
		info "Dotter not found. Installing to ~/.local/bin..."
		mkdir -p "$HOME/.local/bin"
		curl -L https://github.com/SuperCuber/dotter/releases/latest/download/dotter-x86_64-unknown-linux-gnu -o "$HOME/.local/bin/dotter"
		chmod +x "$HOME/.local/bin/dotter"
		export PATH="$HOME/.local/bin:$PATH"
	fi

	local profile="linux"
	if [[ "$(uname)" == "Linux" ]]; then
		if [ -f /etc/arch-release ]; then
			profile="arch"
		elif [ -f /etc/debian_version ]; then
			profile="ubuntu"
		elif [ -f /etc/centos-release ]; then
			profile="centos"
		else
			profile="linux"
		fi
	elif [[ "$(uname)" == "Darwin" ]]; then
		profile="mac"
	elif [[ "$(uname)" == "MINGW"* || "$(uname)" == "MSYS"* ]]; then
		profile="windows"
	fi

	info "Deploying with dotter profile: $profile"
	dotter deploy -v
}

setup_git() {
	title "Setting up Git"

	# Only prompt if not already configured
	local currentName=$(git config user.name || echo "")
	local currentEmail=$(git config user.email || echo "")

	if [[ -z "$currentName" || -z "$currentEmail" ]]; then
		read -rp "Name [$currentName] " name
		read -rp "Email [$currentEmail] " email
		git config --global user.name "${name:-$currentName}"
		git config --global user.email "${email:-$currentEmail}"
	else
		info "Git already configured: $currentName <$currentEmail>"
	fi
}

install_dependencies() {
	title "Installing Core Dependencies"
	# install zoxide
	if ! command -v "zoxide" &>/dev/null; then
		curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	fi
	# install fzf
	if [ ! -d "$HOME/.fzf" ]; then
		git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
		~/.fzf/install --all
	fi
}

main() {
	install_dependencies
	setup_git
	setup_dotter

	echo -e
	success "Bootstrap complete! Please restart your shell or source your rc files."
}

main "$@"
