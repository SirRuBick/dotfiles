# My Dotfiles
My dotfiles to personalize my system.<br>
Building up my development workflow bit by bit.<br>
I am using [LinuxHomebrew](https://docs.brew.sh/Homebrew-on-Linux) to manage packages.<br>

## Installation
```bash
./bootstrap.sh
```
1. install curl git
2. install linuxhomebrew -> insatll build-essential
3. brew install gcc neovim tmux joshuto lazygit fzf ripgrep glow nodejs
4. tmp: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

## Contents
### Terminal<br>
- wezterm<br>
- tmux<br>
- zellij<br>
### Editor<br>
- neovim<br>
### Shell<br>
- zsh<br>
### File Manager<br>
- [Joshuto](https://github.com/kamiyaa/joshuto)<br>
### Other tools<br>
- [fzf](https://github.com/junegunn/fzf)<br>
- [ripgrep](https://github.com/BurntSushi/ripgrep)<br>
- [zoxide](https://github.com/ajeetdsouza/zoxide)<br>
- [eza](https://github.com/eza-community/eza)<br>
- [lazygit](https://github.com/jesseduffield/lazygit)<br>
- [lazydocker](https://github.com/jesseduffield/lazydocker)<br>
- [thefuck](https://github.com/nvbn/thefuck)<br>
- [bat](https://github.com/sharkdp/bat)<br>
- [cmatrix](https://github.com/abishekvashok/cmatrix) 

## TODO
- tmux copy to clipboard
- config shells better
- tmux should try to activate vitual env
- check fzf kubectl setup https://github.com/junegunn/fzf/wiki/examples#kubectl
- more fzf integration
- script to copy python configs to local dir? like ruff or project.toml
- vscode setup
- more custom scripts in bin/

### Tools to check
- httpie
- pandoc
- [cheat](https://github.com/cheat/cheat)
- delta vs. colordiff
- tldr
- kubectl, k9s and stern
- jq and jpq
- Alfred on Mac
