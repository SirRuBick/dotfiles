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

pro_info() {
	printf "\r  [ ${COLOR_BLUE}..${COLOR_NONE} ] $1\n"
}

pro_success() {
	printf "\r  [ ${COLOR_GREEN}OK${COLOR_NONE} ] $1\n"
}

pro_fail() {
	printf "\r  [${COLOR_RED}FAIL${COLOR_NONE} $1\n"
	echo ''
	exit
}

backup() {
	BACKUP_DIR=$HOME/dotfiles-backup

	echo "Creating backup directory at $BACKUP_DIR"
	mkdir -p "$BACKUP_DIR"

	for file in $(get_linkables); do
		filename=".$(basename "$file" '.symlink')"
		target="$HOME/$filename"
		if [ -f "$target" ]; then
			echo "backing up $filename"
			cp "$target" "$BACKUP_DIR"
		else
			warning "$filename does not exist at this location or is a symlink"
		fi
	done

	for filename in "$HOME/.config/nvim" "$HOME/.vim" "$HOME/.vimrc"; do
		if [ ! -L "$filename" ]; then
			echo "backing up $filename"
			cp -rf "$filename" "$BACKUP_DIR"
		else
			warning "$filename does not exist at this location or is a symlink"
		fi
	done
}

link_file() {
	local src=$1 dst=$2

	local overwrite= backup= skip=
	local action=

	if [ -f "$dst" -o -d "$dst" -o -L "$dst" ]; then
		info "File already exists: $dst ($(basename "$src"))"

		# do not link file if already linked
		local currentdst="$(readlink $dst)"
		if [ "$currentdst" == "$src" ]; then
			info "already linked to $src"
			return
		fi

		mv "$dst" "${dst}.backup"
		success "moved $dst to ${dst}.backup"
	fi

	ln -s "$1" "$2"
	success "linked $1 to $2"
}

setup_tmux() {
	title "Setup Tmux"
	if ! command -v "tmux" &>/dev/null; then
		warning "Tmux is not installed"
	fi
	link_file "$DOTFILES_ROOT/tmux" "$HOME/.config/tmux"
}

setup_zellij() {
	title "Setup Zellij"
	if ! command -v "zellij" &>/dev/null; then
		warning "Zellij is not installed"
	fi
	link_file "$DOTFILES_ROOT/zellij" "$HOME/.config/zellij"
}

setup_lazygit() {
	title "Setup Lazygit"
	if ! command -v "lazygit" &>/dev/null; then
		warning "Lazygit is not installed"
	fi
	link_file "$DOTFILES_ROOT/lazygit" "$HOME/.config/lazygit"
}

setup_joshuto() {
	title "Setup Joshuto"
	if ! command -v "lazygit" &>/dev/null; then
		warning "Joshuto is not installed"
	fi
	link_file "$DOTFILES_ROOT/joshuto" "$HOME/.config/joshuto"
}

setup_neovim() {
	title "Setup Neovim"
	if ! command -v "nvim" &>/dev/null; then
		warning "Neovim is not installed"
	fi
	link_file "$DOTFILES_ROOT/nvim" "$HOME/.config/nvim"
}

setup_shell() {
	title "Setup Shell"
	link_file "$DOTFILES_ROOT/bin" "$HOME/.local/bin"

	link_file "$DOTFILES_ROOT/shell" "$HOME/.config/shell"
	link_file "$DOTFILES_ROOT/shell/.bashrc" "$HOME/.bashrc"
	link_file "$DOTFILES_ROOT/shell/.bash_profile" "$HOME/.bash_profile"
	link_file "$DOTFILES_ROOT/shell/.bash_logout" "$HOME/.bash_logout"

	if ! command -v "zsh" &>/dev/null; then
		warning "Zsh is not installed"
		install_zsh
	fi
	link_file "$DOTFILES_ROOT/shell/.zshrc" "$HOME/.zshrc"
	link_file "$DOTFILES_ROOT/shell/.zshenv" "$HOME/.zshenv"
}

setup_git() {
	title "Setting up Git"

	defaultName=$(git config user.name)
	defaultEmail=$(git config user.email)
	defaultGithub=$(git config github.user)

	read -rp "Name [$defaultName] " name
	read -rp "Email [$defaultEmail] " email
	read -rp "Github username [$defaultGithub] " github

	git config -f ~/.gitconfig-local user.name "${name:-$defaultName}"
	git config -f ~/.gitconfig-local user.email "${email:-$defaultEmail}"
	git config -f ~/.gitconfig-local github.user "${github:-$defaultGithub}"

	if [[ "$(uname)" == "Darwin" ]]; then
		git config --global credential.helper "osxkeychain"
	else
		read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N] " save
		if [[ $save =~ ^([Yy])$ ]]; then
			git config --global credential.helper "store"
		else
			git config --global credential.helper "cache --timeout 3600"
		fi
	fi
}

install_dependencies() {
	# install zoxide
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	# install fzf
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	~/.fzf/install
}

install_zsh() {
	# Test to see if zshell is installed.  If it is:
	if [ -f /bin/zsh -o -f /usr/bin/zsh ]; then
		# Set the default shell to zsh if it isn't currently set to zsh
		if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
			info "setting default shell to zsh"
			chsh -s $(which zsh)
		fi
	else
		# install zsh
		sudo apt-get install zsh
		fail "zsh not installed"
	fi
}

main() {
	case "$1" in
	backup)
		backup
		;;
	git)
		setup_git
		;;
	shell)
		setup_shell
		;;
	tmux)
		setup_tmux
		;;
	zellij)
		setup_zellij
		;;
	lazygit)
		setup_lazygit
		;;
	joshuto)
		setup_joshuto
		;;
	*)
		backup
		setup_shell
		setup_git
		setup_tmux
    setup_zellij
		setup_lazygit
		setup_joshuto
		;;
	esac

	echo -e
	success "Done."
}

main "$@"
