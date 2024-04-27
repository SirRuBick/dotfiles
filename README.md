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
- Wezterm<br>
- Tmux<br>
### Editor<br>
- Neovim<br>
### Shell<br>
- Zsh<br>
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

## TODO
- config shells better
- tmux is messing with neovim wsl copy paste
- tmux should try to activate vitual env
- check fzf kubectl setup https://github.com/junegunn/fzf/wiki/examples#kubectl
- more fzf integration
- put python configs like flake8, black and isort
- script to copy python configs to local dir? like ruff or project.toml

### Tools to check
- httpie
- pandoc
- [cheat](https://github.com/cheat/cheat)
- delta vs. colordiff
- tldr
