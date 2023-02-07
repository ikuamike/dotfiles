# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${HOME}/.oh-my-zsh"
export IS_DOCKER=$(awk -F/ '$2 == "docker"' /proc/self/cgroup)

unsetopt nomatch
setopt inc_append_history
setopt share_history  

# Set zsh theme 
ZSH_THEME="powerlevel10k/powerlevel10k"

# Powerlevel configs

POWERLEVEL9K_VPN_IP_FOREGROUND="green"
POWERLEVEL9K_VPN_IP_BACKGROUND="black"
POWERLEVEL9K_CONTEXT_TEMPLATE="`[ -n "$IS_DOCKER" ] && echo docker \~\ $(hostname) || echo ssh \~\ $(hostname)`"
typeset -g POWERLEVEL9K_CONTEXT_DEFAULT_CONTENT_EXPANSION=

POWERLEVEL9K_ROOT_INDICATOR_BACKGROUND="red"
POWERLEVEL9K_ROOT_INDICATOR_FOREGROUND="white"
POWERLEVEL9K_ROOT_ICON='%B#'

POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context root_indicator dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vpn_ip virtualenv background_jobs)

if [ "$IS_DOCKER" ] ; then
	POWERLEVEL9K_DISABLE_GITSTATUS=true
fi

# tmux plugin settings
if [ -n "$SSH_CONNECTION" ] || [ -n "$IS_DOCKER" ] ; then
	export ZSH_TMUX_AUTOCONNECT="false"
	export ZSH_TMUX_AUTOSTART="false"
else
	export ZSH_TMUX_AUTOCONNECT="true"
	export ZSH_TMUX_AUTOSTART="true"
fi
export ZSH_TMUX_AUTOQUIT="false"

# zsh syntax highlighting
# Declare the variable
typeset -A ZSH_HIGHLIGHT_STYLES

ZSH_HIGHLIGHT_STYLES[path]='none'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=green'

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

apt_pref="apt"

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
  python
  debian
  encode64
  colored-man-pages
)

source $ZSH/oh-my-zsh.sh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
#
source ~/dotfiles/aliases.zsh

# rshell variables
export RSHELL_PORT="/dev/ttyUSB0"

# PATH variables
export GOPATH=$HOME/go
export GOROOT=/usr/local/go
export GOBIN=$HOME/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin:$GOBIN 
export PATH=$PATH:/opt/jdk-11.0.9+11/bin
export PATH=$PATH:$HOME/.gem/ruby/2.7.0/bin
export PATH=$PATH:$HOME/.ipi/bin

# functions
jadx-gui () {
nohup jadx-gui $1 &>/dev/null &
}

burp () {
nohup ~/burp_suite/burp.sh &>/dev/null &
}
if [ -n "$SSH_CONNECTION" ] || [ -n "$IS_DOCKER" ]
then
	echo ""
else
	if [ -d ~/.axiom ]; then
		source ~/dotfiles/axiom.zsh
	fi
fi

shell() {
    if [[ $1 ]]; then 
        port=$1
    else
        port=9000
    fi
    stty raw -echo;
    (
    echo "export TERM=xterm";
    echo 'python -c "import pty;pty.spawn(\"/bin/bash\")" 2>/dev/null || \
    python3 -c "import pty;pty.spawn(\"/bin/bash\")" 2>/dev/null || \
    script -qc /bin/bash /dev/null 2>/dev/null';
    echo "stty$(stty -a | awk -F ';' '{print $2 $3}' | head -n 1)"; 
    echo reset; cat) | nc -lvnp $port && reset
}


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.zsh.inc' ]; then . '/opt/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.zsh.inc' ]; then . '/opt/google-cloud-sdk/completion.zsh.inc'; fi

PATH="/home/${HOME}/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/${HOME}/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/${HOME}/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/${HOME}/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/${HOME}/perl5"; export PERL_MM_OPT;
