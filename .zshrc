# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

bindkey -e
bindkey $terminfo[kLFT5] backward-word
bindkey $terminfo[kRIT5] forward-word
#bindkey $terminfo[kDC5] kill-word
#bindkey '^_' backward-kill-word

if [[ -x /usr/bin/dircolors ]]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

[[ ! -f ~/.aliases ]] || source ~/.aliases

# autcomplete
zstyle ':completion:*' menu select
zstyle ':completion:*' completer _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 1

# history
HISTFILE=$HOME/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt extended_history
setopt inc_append_history
setopt hist_ignore_space
setopt hist_verify
#setopt share_history

# pager
export PAGER=less
export LESS="-FiXRMSx4"
export EDITOR=vim

# colorful man pages
export LESS_TERMCAP_mb=$'\e[0m\e[31m'
export LESS_TERMCAP_md=$'\e[0m\e[32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[43m\e[1;30m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0m\e[36m'

source ~/.zsh/rg.zsh
[[ ! -f /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme ]] || source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.zsh_local ]] || source ~/.zsh_local

case "$OSTYPE" in
    darwin*)
        [[ ! -f ~/.zsh/macos.zsh ]] || source ~/.zsh/macos.zsh
        [[ ! -f ~/.zsh/iterm2_shell_integration.zsh ]] || source ~/.zsh/iterm2_shell_integration.zsh
    ;;
esac

autoload -Uz compinit
compinit

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
