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
alias server="ssh stefan@192.168.1.21"

# Github Lazy
lazyg() {
	git add .
	git commit -m "$1"
	git push
}

# Get local IP
myip() {
  ip addr show | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | cut -d/ -f1
}

# Check public IP
pubip() {
  curl -s ifconfig.me
}

# Show memory usage
mem() {
  free -h
}

# Show CPU info
cpuinfo() {
  lscpu | grep -E 'Model name|Socket|Thread|Core'
}

# Disk usage sorted by size
dus() {
  du -sh * | sort -hr
}

# Reload the shell
reload() {
  source ~/.zshrc && echo "✅ Reloaded .zshrc"
}

# Serve current directory on HTTP (great for testing)
serve() {
  python3 -m http.server "${1:-8000}"
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

# Extract any archive with one command
extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2) tar xjf "$1" ;;
      *.tar.gz)  tar xzf "$1" ;;
      *.bz2)     bunzip2 "$1" ;;
      *.rar)     unrar x "$1" ;;
      *.gz)      gunzip "$1" ;;
      *.tar)     tar xf "$1" ;;
      *.tbz2)    tar xjf "$1" ;;
      *.tgz)     tar xzf "$1" ;;
      *.zip)     unzip "$1" ;;
      *.Z)       uncompress "$1" ;;
      *.7z)      7z x "$1" ;;
      *)         echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Find and grep functions
f() { find . -name "$1"; }

grepf() { grep -rnw . -e "$1"; }

# Weather
weather() {
  curl wttr.in/"${1:-Belgrade}"
}

# CPU functions
cpuinfo() {
  lscpu | grep -E 'Model name|CPU\(s\)|MHz|Architecture'
}

stress-test() {
  stress --cpu "$(nproc)" --timeout "${1:-30}"
}

# Show directory sizes, sorted
duh() {
  du -sh ./* 2>/dev/null | sort -hr
}

# Create a compressed archive easily
archive() {
  tar -czvf "${1}.tar.gz" "${1}"
}

# Show public IP and hostname info
myhost() {
  echo "IP: $(curl -s ifconfig.me)"
  echo "Host: $(hostnamectl)"
  echo "Uptime: $(uptime -p)"
}

# Syntax Highlighting
source ~/.config/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Autosuggestions
source ~/.config/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Zoxide
eval "$(zoxide init zsh)"
alias cd="z"
