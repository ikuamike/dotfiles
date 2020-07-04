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
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

echo -e "\n${BWhite}[*] Setting up your terminal... ${Color_Off}"

echo -e "\n${BGreen}[*] Installing dependencies... ${Color_Off}"

if ! command -v curl &> /dev/null
then
	echo -e "\n${Red}[-] curl could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing curl... ${Color_Off}\n"
	apt install curl    
fi

if ! command -v git &> /dev/null
then
	echo -e "\n${Red}[-] git could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing git... ${Color_Off}\n"
	apt install git
fi

if ! command -v tmux &> /dev/null
then
	echo -e "\n${Red}[-] tmux could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing tmux... ${Color_Off}\n"
	apt install tmux    
fi

if ! command -v zsh &> /dev/null
then
	echo -e "\n${Red}[-] zsh could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing zsh... ${Color_Off}\n"
	apt install zsh    
fi


echo -e "\n${BGreen}[+] Configuring zsh... ${Color_Off}\n"
ln -s ~/dotfiles/zshrc ~/.zshrc

echo -e "\n${Green}[+] Installing ohmyzsh... ${Color_Off}\n"
curl -sLo /tmp/install.sh https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
chmod +x /tmp/install.sh
CHSH=yes /tmp/install.sh --unattended --keep-zshrc
rm /tmp/install.sh

echo -e "\n${Green}[+] Installing powerlevel10k... ${Color_Off}"
[ -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k ] && echo -e "${Green}[+] powerlevel10k already installed...skipping${Color_Off}"
git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k

echo -e "\n${Green}[+] Installing zsh-syntax-highlighting... ${Color_Off}\n"
git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo -e "\n${Green}[+] Installing fzf... ${Color_Off}\n"
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
sed -i 's/\<curl\>/curl -s/g' ~/.fzf/install
~/.fzf/install --no-bash --no-fish --key-bindings --completion --no-update-rc

echo -e "\n${Green}[+] Setting up tmux... ${Color_Off}\n"
./setup-tmux.sh
