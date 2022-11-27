#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;97m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

IN_DOCKER=$(awk -F/ '$2 == "docker"' /proc/self/cgroup)

#==================#
#   functions      #
#==================#
install () {
if ! command -v $1 &> /dev/null
then
    printf "\n${Red}[-] $1 could not be found ${Color_Off}\n"
    printf "${Yellow}[+] Installing $1... ${Color_Off}\n"
    if [ $(id -u) == 0 ]; then
        apt install $1 -y
    else
        sudo apt install $1 -y
    fi
else
    printf "${Green}[*] $1 already installed...skipping ${Color_Off}\n"
fi
}
configure () {
printf "${Blue}[+] Configuring $1: ${White}Creating $1rc symlink to ~/.$1rc ... ${Color_Off}\n"
ln -sf ~/dotfiles/$1rc ~/.$1rc
}
ZSH_CUSTOM=${HOME}/.oh-my-zsh/custom

printf "\n${BWhite}[*] Setting up your terminal... ${Color_Off}\n"

printf "\n${BGreen}[*] Installing dependencies... ${Color_Off}\n"

install curl
install git
install tmux
install zsh
install vim

printf "${Yellow}[+] Installing dconf-cli... ${Color_Off}\n"
sudo apt install dconf-cli -y &>/dev/null
printf "${Yellow}[+] Installing uuid-runtime... ${Color_Off}\n"
sudo apt install uuid-runtime -y &>/dev/null

if [ -n "$SSH_CONNECTION" ] || [ -n "$IS_DOCKER" ]
then
	echo ""
else
	install xcape
	install xclip
fi


#==================#
# Powerline-fonts  #
#==================#
if ls ~/.local/share/fonts 2>/dev/null | grep Powerline >/dev/null; [ $? -eq 0 ]
then
    printf "${Green}[*] Powerline fonts already installed...skipping ${Color_Off}\n"
else
    if [ -n "$SSH_CONNECTION" ] || [ -n "$IS_DOCKER" ]
    then
        printf "${Cyan}[*] In a docker container or ssh connection...skipping ${Color_Off}\n"
    else
        printf "\n${Yellow}[+] Installing Powerline fonts... ${Color_Off}\n"
        git clone --quiet https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
        chmod +x /tmp/fonts/install.sh
        /tmp/fonts/install.sh
        rm -rf /tmp/fonts
    fi
fi


#==================#
#     vundle       #
#==================#
if [ ! -d ${HOME}/.vim/bundle ]; then
    printf "${Yellow}[+] Installing vundle... ${Color_Off}\n"
    git clone --quiet https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
else
    printf "${Green}[*] Vundle already installed...skipping${Color_Off}\n"
fi

#==================#
#   vim-config     #
#==================#
mkdir -p ${HOME}/.vim/backups
mkdir -p ${HOME}/.vim/swaps
mkdir -p ${HOME}/.vim/undo
configure vim
vim +PluginList +qall --not-a-term &>/dev/null

#==================#
#     ohmyzsh      #
#==================#
if [ ! -d ${HOME}/.oh-my-zsh ]; then
    printf "${Yellow}[+] Installing ohmyzsh... ${Color_Off}\n"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc --unattended
else
    printf "${Green}[*] ohmyzsh already installed...skipping${Color_Off}\n"
fi

#==================#
#   zsh-config     #
#==================#
configure zsh
ln -sf ~/dotfiles/zshenv ~/.zshenv

if [ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
    printf "\n${Yellow}[+] Installing powerlevel10k... ${Color_Off}\n"
    git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
else
    printf "${Green}[*] powerlevel10k already installed...skipping${Color_Off}\n"
fi

if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
    printf "\n${Yellow}[+] Installing zsh-syntax-highlighting... ${Color_Off}\n"
    git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
else
    printf "${Green}[*] zsh-syntax-highlighting already installed...skipping${Color_Off}\n"
fi

#==================#
#       fzf        #
#==================#
if [ ! -d ~/.fzf ]; then
    printf "\n${Yellow}[+] Installing fzf... ${Color_Off}\n"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    sed -i 's/\<curl\>/curl -s/g' ~/.fzf/install
    ~/.fzf/install --no-bash --no-fish --key-bindings --completion --no-update-rc
else
    printf "${Green}[*] fzf already installed...skipping${Color_Off}\n"
fi
#==================#
#     terminal     #
#==================#

if [ -n "$SSH_CONNECTION" ] || [ -n "$IS_DOCKER" ]
then
	echo ""
else
	printf "${Blue}[+] Setting up Dracula terminal theme... ${Color_Off}\n"
	echo 48 | bash -c  "$(curl -sLo- https://git.io/vQgMr)" &>/dev/null
fi
#==================#
#       tmux       #
#==================#

if [ -n "$IN_DOCKER" ] 
then
	echo ""
else
	printf "${Blue}[+] Setting up tmux... ${Color_Off}\n"
	${HOME}/dotfiles/setup-tmux.sh
fi

if [ "$(basename "$SHELL")" != "zsh" ]; then
    chsh -s $(which zsh)
fi

#==================#
#       extras     #
#==================#

# setup ctrl as capslock and disable capslock, use both shift key to toggle capslock
if command -v dconf &> /dev/null
then
	dconf write /org/gnome/desktop/input-sources/xkb-options "['ctrl:nocaps', 'shift:both_capslock']"
fi
