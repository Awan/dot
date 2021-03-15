typeset -U path
path=(~/.cargo/bin ~/.perl5/bin ~/.gem/ruby/2.7.0/bin ~/.local/bin ~/.local/lib ~/.pyenv/bin /usr/sbin /usr/bin/vendor_perl /sbin /usr/X11R6/bin /usr/games $path[@])

BROWSER=$(which chrome)

# Set Terminal

#if [ -z "$TERMINAL" ]; then
#    if (( $+commands[urxvt] )); then
#        if pgrep urxvtd >/dev/null 2>&1; then
#            TERMINAL="urxvtc"
#        else
#            TERMINAL="urxvt"
#        fi
#    else
#        TERMINAL="xterm"
#    fi
#fi

TERMCMD=$TERMINAL

if [ -d ~/git/mysite ]; then
  export SITE="$HOME/git/mysite"
  export post="$SITE/content/posts"
fi

if [ -d ~/.local/bin ]; then
  export mpath="$HOME/.local/bin/"
fi

if [ -d ~/.perl5 ]; then
  export PERL5LIB="~/.perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
  export PERL_LOCAL_LIB_ROOT="~/.perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
  export PERL_MB_OPT="--install_base \"~/.perl5\""
  export PERL_MM_OPT="INSTALL_BASE=~/.perl5"
fi

# Set editor

set_editor() {
  export EDITOR="$@"
  export GIT_EDITOR="$@"
  export VISUAL="$@"
  alias v="$@"
}

# Get editor

get_editor()
{
    if (( $+commands[vim] )); then
        set_editor $(which vim)
    elif
        (( $+commands[vi] )); then
        set_editor $(which vi)
    fi
}

get_editor

XDG_DATA_HOME=$HOME/.local/share
XDG_CONFIG_HOME=$HOME/.config
XDG_CACHE_HOME=$HOME/.cache
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

unset SSH_AUTH_SOCK
if [ "${gnupg_SSH_AUTH_SOCK_by:-0}" -ne $$ ]; then
  export SSH_AUTH_SOCK="$(gpgconf --list-dirs agent-ssh-socket)"
fi
export GPG_TTY=$(tty)
gpg-connect-agent updatestartuptty /bye >/dev/null
#export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
#if [[ -n "$SSH_CONNECTION" ]] ;then
#    export PINENTRY_USER_DATA="USE_CURSES=1"
#fi
export PYENV_ROOT="$HOME/.pyenv"
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Dswing.crossplatformlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel ${_JAVA_OPTIONS}"
export GIT_DISCOVERY_ACROSS_FILESYSTEM=true
