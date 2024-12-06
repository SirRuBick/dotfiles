# Common Aliases,
# shared by all posix shell
#
#################################################################
function alias_if_exists() {
  # Does the alias only if the aliased program is installed
    if command -v "$2" > /dev/null; then
      alias "$1"="$2"
    fi
}

#################################################################

# aliases

# Make shorthands for common flags
alias_if_exists "ls" "eza"
alias ls="ls --color=auto"
alias ll='ls -alF'
alias la='ls -A'
alias lc="ls -CF"

# operations
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias cf='cd $(fd -t d | fzf)'

# git commands
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gpo='git push origin'
alias gtd='git tag --delete'
alias gtdr='git tag --delete origin'
alias gr='git branch -r'
alias gplo='git pull origin'
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias gco='git checkout '
alias gl='git log'
alias gr='git remote'
alias grs='git remote show'
alias glo='git log --pretty="oneline"'
alias glol='git log --graph --oneline --decorate'

# Overwrite existing commands for better defaults
alias mv="mv -i"           # -i prompts before overwrite
alias mkdir="mkdir -p"     # -p make parent dirs as needed
alias df="df -h"           # -h prints human readable format

# Alias can be composed
alias la="ls -A"
alias lla="la -l"

# Program aliases
alias_if_exists "python" "python3"
alias_if_exists "pip" "pip3"
alias_if_exists "v" "nvim"
alias_if_exists "lg" "lazygit"
alias_if_exists "ld" "lazydocker"
alias_if_exists "cat" "bat"

# Python supports
alias pve="python3 -m venv .venv;source .venv/bin/activate" # TODO: make a function to check if virtual environment exists
alias psv="source .venv/bin/activate"
# Jupyter
alias pjc="jupyter console"
alias pjo="jupyter nbconvert"
alias pjn="jupyter notebook"
alias pjb="jupyter notebook --no-browser"
alias pjl="jupyter lab"

# docker
# TODO: check these aliases
alias dockls="docker container ls | awk 'NR > 1 {print \$NF}'"                  # display names of running containers
alias dockRr='docker rm $(docker ps -a -q)'                                     # delete every containers / images
alias dockRr='docker rm $(docker ps -a -q) && docker rmi $(docker images -q)'   # delete every containers / images
alias dockstats='docker stats $(docker ps -q)'                                  # stats on images
alias dockimg='docker images'                                                   # list images installed
alias dockprune='docker system prune -a'                                        # prune everything
alias dockceu='docker-compose run --rm -u $(id -u):$(id -g)'                    # run as the host user
alias dockce='docker-compose run --rm'

# OS dependent aliases
case "$(uname -s)" in

   Darwin)
     # echo 'Mac OS'
     ;;

   Linux)
     # echo 'Linux'
     ;;

   CYGWIN*|MINGW32*|MSYS*)
     # echo 'MS Windows'
     ;;

   *)
     # echo 'Other OS'
     ;;
esac
