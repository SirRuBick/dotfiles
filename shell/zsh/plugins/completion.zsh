autoload -Uz compinit
compinit
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' matcher-list 'm:{[:lower:]}={[:upper:]}' 'r:|[._-]=** r:|=**' '+r:|[._-]=** r:|=** l:|=*'
zstyle ':completion:*' original true
# The following lines were added by compinstall
zstyle :compinstall filename '/home/alexshan/.config/zsh/.zshrc'
