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


alias msfconsole="msfconsole -q"
alias htb="cd ~/HTB; tmux rename-window 'vpn'; sudo openvpn ikuamike.ovpn &; tmux new-window -c ~/HTB/Boxes"
alias dante="cd ~/HTB/Prolabs/Dante; tmux rename-window 'dante-vpn'; sudo openvpn pro_labs_ikuamike.ovpn &; tmux new-window -c ~/HTB/Prolabs/Dante"
alias open="xdg-open"
alias nssh='ssh -o "StrictHostKeyChecking=no" -o "UserKnownHostsFile=/dev/null"'
