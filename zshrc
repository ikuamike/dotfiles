# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"

unsetopt nomatch

# Set zsh theme 
ZSH_THEME="powerlevel10k/powerlevel10k"

# Powerlevel configs

zsh_custom_ip(){
 local ip=$(ip -brief -4 a show | grep tun0 | awk {'print $3'} | cut -d / -f 1)
 local color="%F{green}"
 echo -n "%{$color%}$ip"
}

POWERLEVEL9K_CUSTOM_IP="zsh_custom_ip"
POWERLEVEL9K_CUSTOM_IP_BACKGROUND="black"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(custom_ip background_jobs)

# tmux plugin settings
export ZSH_TMUX_AUTOCONNECT="true"
export ZSH_TMUX_AUTOSTART="true"
export ZSH_TMUX_AUTOQUIT="false"

# zsh syntax highlighting
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'


# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  zsh-syntax-highlighting
  docker
)

source $ZSH/oh-my-zsh.sh

# fzf
source "${HOME}/dotfiles/fzf.zsh"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#

alias htb="cd ~/HTB; tmux rename-window 'vpn'; openvpn ikuamike.ovpn &; tmux new-window -c ~/HTB/Boxes"
alias open="xdg-open"
# rshell variables
export RSHELL_PORT="/dev/ttyUSB0"

export GOPATH=$HOME
export GOBIN=$HOME/bin
export PATH=$PATH:/usr/local/go/bin:$GOPATH/bin 

# Subdomain Enum with crt.sh 
crtsh () {
curl -s https://crt.sh/?q=%.$1  | sed 's/<\/\?[^>]\+>//g' | grep -v crt.sh | grep -v 'Identity LIKE' | grep $1
}

jadx-gui () {
nohup jadx-gui-1.1.0.jar $1 &>/dev/null &
}

burp () {
nohup ~/burp_suite/burp.sh &>/dev/null &
}
