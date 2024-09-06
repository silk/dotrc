# local MACOS
alias sed=gsed
export PATH=~/.bin:/opt/homebrew/bin:~/go/bin:$PATH

#eval "$(dnspyre --completion-script-zsh)"

bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line

if type brew &>/dev/null
then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi

