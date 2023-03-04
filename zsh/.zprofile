#  ▓▓▓▓▓▓▓▓▓▓ 
# ░▓ Author ▓ Abdullah <https://abdullah.today/> 
# ░▓▓▓▓▓▓▓▓▓▓ 
# ░░░░░░░░░░ 

# Start keychain for ssh keys

# eval $(keychain --quiet --eval id_ed25519)

# Start X at login    
    

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/ttyC0 ]]; then
#  exec startx 
  :
elif [[ $(tty) != /dev/ttyC0 ]]; then
  #sudo loadkeys $HOME/.loadkeysrc
  tmux has-session -t $USER || tmux new-session -t $USER && tmux attach-session -t $USER
fi
