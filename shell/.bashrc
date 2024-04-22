# this file gets run in two cases:
# 1. non-login interactive shell
# 2. remote shell (over ssh or similar)

# #2 happens when you run "ssh user@host bash" explicitly.
# in this case, /etc/bash.bashrc has not been previous executed (unlike #1).
# however, we assume that #2 is a recovery mode, so we don't want to do much.
# (also, my google-fu didn't find a way to distinguish them)

. ~/.config/shell/bash/env
. ~/.config/shell/bash/interactive
. ~/.config/shell/bash/functions

if [[ -n $PS1 ]]; then
    : # These are executed only for interactive shells
    echo "interactive"
else
    : # Only for NON-interactive shells
    echo "non interactive"
fi

if shopt -q login_shell ; then
    : # These are executed only when it is a login shell
    echo "login"
else
    : # Only when it is NOT a login shell
    echo "nonlogin"
fi
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
