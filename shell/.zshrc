# Options
setopt autocd
# Make commenting with '#' work
setopt interactivecomments

# zsh history
HISTFILE=~/.config/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# vi mode
bindkey -v

# alias
source ~/.config/shell/common/interactive

# auto completion
source ~/.config/shell/zsh/plugins/completion.zsh

# prompt
source ~/.config/shell/zsh/plugins/prompt.zsh

# cursor
source ~/.config/shell/zsh/plugins/cursor.zsh

# syntax highlight
# source ~/.config/shell/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# auto suggestions
# source ~/.config/shell/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# zoxide
eval "$(zoxide init zsh)"
