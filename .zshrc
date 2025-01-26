eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"

bindkey -e  # Explicitly use emacs keymap
# bindkey '^P' up-line-or-search    # Ctrl+P: history backward
# bindkey '^N' down-line-or-search  # Ctrl+N: history forward

export EDITOR=nvim

alias -- cp=xcp
alias -- grep='grep --color=always'
alias -- la='ls -a'
alias -- ll='ls -l'
alias -- lla='ls -al'
alias -- ls='eza --icons --group-directories-first'

