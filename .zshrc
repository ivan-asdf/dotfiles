eval "$(atuin init zsh --disable-up-arrow)"
eval "$(starship init zsh)"

export EDITOR=nvim

alias -- cp=xcp
alias -- grep='grep --color=always'
alias -- la='ls -a'
alias -- lla='ls -al'
alias -- ls='eza --icons --group-directories-first'
