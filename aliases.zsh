# Docker aliases
alias dk='docker'
alias dkps="docker ps"
alias dkst="docker stats"
alias dkpsa="docker ps -a"
alias dki="docker images"
alias dkrm="docker rm"
alias dkrmi="docker rmi"
alias dkcpup="docker-compose up -d"
alias dkcpdown="docker-compose down"
alias dkcpstart="docker-compose start"
alias dkcpstop="docker-compose stop"

# Others
alias msfconsole="msfconsole -q"
alias open="xdg-open"
alias nssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
alias bat='batcat'
alias fixvbox="sudo sed -i s/'Exec=VirtualBox %U'/'Exec=VirtualBox -style Fusion %U'/ /usr/share/applications/virtualbox.desktop"
alias vim='nvim'
