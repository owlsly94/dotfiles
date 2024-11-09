# Start Starship
eval "$(starship init zsh)"

# Doom emacs
export PATH="$HOME/.emacs.d/bin:$PATH"

# Flatpak
export PATH=$PATH:/var/lib/flatpak/exports/bin:~/.local/share/flatpak/exports/bin

# Completion
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

ZSH_AUTOSUGGEST_STRATEGY=(history completion)

unsetopt menu_complete
unsetopt flowcontrol

setopt prompt_subst
setopt always_to_end
setopt append_history
setopt auto_menu
setopt complete_in_word
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history
setopt no_list_ambiguous

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=2000
SAVEHIST=2000
bindkey -v
# End of lines configured by zsh-newuser-install

# Aliases
alias l="eza --icons --all"
alias ll="eza --icons  -a --group-directories-first -1 --no-user --long"
alias lss="eza --icons  -a --group-directories-first -1"
alias v="nvim"
alias sv="sudo nvim"
#alias cat="bat"
alias how="tldr"
alias emacs="emacsclient -c -a 'emacs'"
alias cp="cp -i"
alias mv="mv -i"

# Github Lazy
lazyg() {
	git add .
	git commit -m "$1"
	git push
}

# Copy file with a progress bar
cpp() {
    set -e
    strace -q -ewrite cp -- "${1}" "${2}" 2>&1 |
    awk '{
        count += $NF
        if (count % 10 == 0) {
            percent = count / total_size * 100
            printf "%3d%% [", percent
            for (i=0;i<=percent;i++)
                printf "="
            printf ">"
            for (i=percent;i<100;i++)
                printf " "
            printf "]\r"
        }
    }
    END { print "" }' total_size="$(stat -c '%s' "${1}")" count=0
}

## Plugins
# Syntax Highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zoxide
eval "$(zoxide init zsh)"
alias cd="z"
