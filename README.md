# My Dotfiles
My dotfiles to personalize my system.<br>
Building up my development workflow bit by bit.<br>
I am using [LinuxHomebrew](https://docs.brew.sh/Homebrew-on-Linux) to manage packages.<br>

Use Dotter for Management

## TODO
- git config setup again
- vscode setup
- look into fzf/ripgrep on windows, integration with pwsh
- powershell on linux
- is terminal multiplexer necessary even on linux? if yes, what about windows? terminal by default?
- align shortcuts for neovim, vscode, jetbrains


## Common tools across platform
- jetbrains: pycharm, datagrip, rider
    TODO:
    - shortcuts: Rider Build
    - quick popups
    - Refactor code shortcuts
    - preview function
    - Plugin: heap allocation viewer
- vscode
- neovim
- powershell
- starship (shell)
- [lazygit](https://github.com/jesseduffield/lazygit)<br>
- [zoxide](https://github.com/ajeetdsouza/zoxide)<br>
- [fzf](https://github.com/junegunn/fzf)<br>
- [ripgrep](https://github.com/BurntSushi/ripgrep)<br>

## Installation
### Arch Linux (One-liner)
```bash
sudo pacman -Syu --noconfirm git && git clone https://github.com/shanr/dotfiles.git ~/dotfiles && cd ~/dotfiles && ./bootstrap.sh
```

### Manual Installation
1. install curl git
2. install linuxhomebrew -> insatll build-essential
3. brew install gcc neovim tmux joshuto lazygit fzf ripgrep glow nodejs
4. tmp: git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
### Terminal<br>
- tmux<br>
- zellij<br>
### File Manager<br>
- [Joshuto](https://github.com/kamiyaa/joshuto)<br>
### Other tools<br>
- [eza](https://github.com/eza-community/eza)<br>
- [bat](https://github.com/sharkdp/bat)<br>
- [cmatrix](https://github.com/abishekvashok/cmatrix) 

## Windows
Font: [Maple Mono](https://github.com/subframe7536/maple-font)

### yasb
- requires cava
### glazewm
### Powershell
command: winget install microsoft.powershell
plugins:
- Terminal-Icons: Install-Module Terminal-Icons
- Z folder jumper: Install-Module ZLocation -Scope CurrentUser
### StarShip
winget install starship
### powertoys

### TODO 
- everything (run with powertoys run)
- quicker


