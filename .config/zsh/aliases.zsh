#!/bin/sh

# Colorize grep output (good for log files)
alias grep='grep --color=auto -I --exclude-dir=".*" --exclude-dir="venv3"'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# confirm before overwriting something
alias cp="cp -i"
alias mv='mv -i'
alias rm='rm -i'

# easier to read disk
alias df='df -h'     # human-readable sizes
alias free='free -m' # show sizes in MB

# get top process eating memory
alias psmem='ps auxf | sort -nr -k 4 | head -5'

# get top process eating cpu ##
alias pscpu='ps auxf | sort -nr -k 3 | head -5'

# gpg encryption
# verify signature for isos
alias gpg-check="gpg2 --keyserver-options auto-key-retrieve --verify"
# receive the key of a developer
alias gpg-retrieve="gpg2 --keyserver-options auto-key-retrieve --receive-keys"

# kubectl
alias k=kubectl

if [[ $TERM == "xterm-kitty" ]]; then
    alias ssh="kitty +kitten ssh"
fi

case "$(uname -s)" in

Darwin)
    # echo 'Mac OS X'
    alias ls='ls -G'
    ;;

Linux)
    alias ls="eza --icons --git"
    alias l='eza -alg --color=always --group-directories-first --git'
    alias ll='eza -aliSgh --color=always --group-directories-first --icons --header --long --git'
    alias lt='eza -@alT --color=always --git'
    alias llt="eza --oneline --tree --icons --git-ignore"
    alias lr='eza -alg --sort=modified --color=always --group-directories-first --git'
    ;;

CYGWIN* | MINGW32* | MSYS* | MINGW*)
    # echo 'MS Windows'
    ;;
*)
    # echo 'Other OS'
    ;;
esac

# disable globbing for pip
alias pip='noglob pip'
alias vim='nvim'
