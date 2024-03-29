#!/usr/bin/env zsh

if [[ $commands[pkg_add] ]]; then
    alias pkgadd='doas pkg_add'
    alias pkgdel='doas pkg_delete'
fi
if [[ $commands[notmuch] ]]; then
  alias vimail="vim -c NotMuch"
fi

if [[ $commands[bat] ]]; then
  alias cat='PAGER=less bat -p'
fi

if [[ $commands[pydf] ]]; then
  alias df='pydf'
fi

if [[ $commands[pacman] ]]; then
  alias pacman='sudo pacman'
fi

if [[ $commands[colorls] ]]; then
  #alias ls='colorls --almost-all --git-status --group-directories-first'
  alias ls='colorls -G'
# else
#   alias ls='ls --color=auto'
fi

if [[ $commands[todo.sh] ]]; then
  alias todo='todo.sh'
fi

if [[ $commands[cmus] ]]; then
  alias cms='cmus-remote'
fi

if [[ $commands[systemctl] ]]; then
 alias scdr='systemctl --user daemon-reload'
 alias scst='systemctl --user status'
 alias scrs='systemctl --user restart'
 alias scsr='systemctl --user start'
 alias scens='systemctl --user enable --now'
 alias scds='systemctl --user disable'
 alias scdsn='systemctl --user disable --now'
 alias sscdr='sudo systemctl daemon-reload'
 alias sscst='sudo systemctl status'
 alias sscrs='sudo systemctl restart'
 alias sscsr='sudo systemctl start'
 alias sscens='sudo systemctl enable --now'
 alias sscds='sudo systemctl disable'
 alias sscdsn='sudo systemctl disable --now'
fi

if [[ $commands[gpg2] ]]; then
    alias gpg=gpg2
else
    #do nothing
fi
