for f in  ~/.zsh/*(DN); do source $f; done

precmd() {
 psvar[1]=$(mailsnow)
}

PS1="%{$fg[magenta]%} ✿ %n@%m %{$reset_color%}%{$fg[magenta]%}in %~ ✿ %{$reset_color%}${git_branch} %1v %F{%5v}%6v%f%F{green}%7v%f%(?.%{$fg[blue]%}.%{$fg[red]%})%(!.#.❤) %{$reset_color%}"
