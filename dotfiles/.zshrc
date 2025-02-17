# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Load completions
autoload -Uz compinit && compinit

# Add in zsh plugins
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions


# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward
bindkey '^[w' kill-region

# History
HISTSIZE=500000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza $realpath'

# Handy change dir shortcuts
alias ..='cd ..'
alias ...='cd ../..'
alias .3='cd ../../..'
alias .4='cd ../../../..'
alias .5='cd ../../../../..'

# Core Utils Aliases
alias l='eza -lh  --icons=auto'
alias ls='eza -1   --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias mkdir='mkdir -p'
# aliao ssh='kitten ssh'
alias tree='tree -a -I .git'
alias cat='bat'
alias c='clear' # clear terminal
alias e='exit'
alias mkdir='mkdir -p'
alias vim='nvim'
alias v='nvim'
alias grep='rg --color=auto'
alias ssn='sudo shutdown now'
alias srn='sudo reboot now'

# Git Aliases
alias gac='git add . && git commit -m'
alias gs='git status'
alias gpush='git push origin'
alias lg='lazygit'

# Nixos Aliases
alias rebuild='sudo nixos-rebuild switch --flake ~/rudra/.#default'
alias recats='sudo nix flake lock --update-input nixCats && sudo nixos-rebuild switch --flake ~/rudra/.#default'

# Downloads Aliases
alias yd='yt-dlp -f "bestvideo+bestaudio" --embed-chapters --external-downloader aria2c --concurrent-fragments 8 --throttled-rate 100K'
alias td='yt-dlp --external-downloader aria2c -o "%(title)s."'
alias download='aria2c --split=16 --max-connection-per-server=16 --timeout=600 --max-download-limit=10M --file-allocation=none'

# VPN Aliases
alias vu='sudo tailscale up --exit-node=raspberrypi --accept-routes'
alias vd='sudo tailscale down'
warp ()
{
    sudo systemctl "$1" warp-svc
}

# Other Aliases
alias apps-space='expac -H M "%011m\t%-20n\t%10d" $(comm -23 <(pacman -Qqe | sort) <(pacman -Qqg base base-devel | sort)) | sort -n'
alias files-space='sudo ncdu --exclude /.snapshots /'
alias ld='lazydocker'
alias docker-clean='docker container prune -f && docker image prune -f && docker network prune -f && docker volume prune -f'
alias crdown='mpv --yt-dlp-raw-options=cookies-from-browser=brave'
alias cr='cargo run'
alias battery='upower -i /org/freedesktop/UPower/devices/battery_BAT1'
alias y='yazi'
lsfind ()
{
    ll "$1" | grep "$2"
}

# X11 Clipboard Aliases `xsel`
# alias pbcopy='xsel --input --clipboard'
# alias pbpaste='xsel --output --clipboard'

# Wayland Clipboard Aliases `wl-clipboard`
alias pbcopy='wl-copy'
alias pbpaste='wl-paste'


# Shell Intergrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd)"


# Export Paths

# pnpm
export PNPM_HOME="/home/vasu/.local/share/pnpm"
case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Cargo Bin
export PATH="$HOME/.cargo/bin:$PATH"

# Local Bin
export PATH="$HOME/.local/bin:$PATH"

# Android Studio Paths
# export JAVA_HOME="/opt/android-studio/jbr"
# export ANDROID_HOME="$HOME/Android/Sdk"
# export NDK_HOME="$ANDROID_HOME/ndk/$(ls -1 $ANDROID_HOME/ndk)"

# Turso
export PATH="$PATH:/home/vasu/.turso"

source "$HOME/.sdkman/bin/sdkman-init.sh"
