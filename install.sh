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

ZSH_CUSTOM=~/.oh-my-zsh/custom

echo -e "\n${BWhite}[*] Setting up your terminal... ${Color_Off}"

echo -e "\n${BGreen}[*] Installing dependencies... ${Color_Off}"

if ! command -v curl &> /dev/null
then
	echo -e "\n${Red}[-] curl could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing curl... ${Color_Off}\n"
	sudo apt install curl -y    
else
	echo -e "${Green}[+] curl already installed...skipping ${Color_Off}\n"
fi

if ! command -v git &> /dev/null
then
	echo -e "\n${Red}[-] git could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing git... ${Color_Off}\n"
	sudo apt install git -y
else
	echo -e "${Green}[+] git already installed...skipping ${Color_Off}\n"
fi

if ! command -v tmux &> /dev/null
then
	echo -e "\n${Red}[-] tmux could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing tmux... ${Color_Off}\n"
	sudo apt install tmux -y  
else
	echo -e "${Green}[+] tmux already installed...skipping ${Color_Off}\n"
fi

if ! command -v zsh &> /dev/null
then
	echo -e "\n${Red}[-] zsh could not be found ${Color_Off}"
	echo -e "${Yellow}[+] Installing zsh... ${Color_Off}\n"
	sudo apt install zsh -y   
else
	echo -e "${Green}[+] zsh already installed...skipping ${Color_Off}\n"
fi

echo -e "\n${Yellow}[+] Installing Powerline fonts... ${Color_Off}\n"
git clone --quiet https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
cd /tmp/fonts
/tmp/fonts/install.sh
rm -rf /tmp/fonts

echo -e "\n${Yellow}[+] Installing ohmyzsh... ${Color_Off}\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --keep-zshrc

echo -e "\n${Blue}[+] Configuring zsh: ${White}Creating zshrc symlink to ~/.zshrc ... ${Color_Off}\n"
ln -sf ~/dotfiles/zshrc ~/.zshrc

if [ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
	echo -e "\n${Yellow}[+] Installing powerlevel10k... ${Color_Off}"
	git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
else
	echo -e "${Green}[*] Powerlevel10k already installed...skipping${Color_Off}"
fi

if [ ! -d ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting ]; then
	echo -e "\n${Yellow}[+] Installing zsh-syntax-highlighting... ${Color_Off}\n"
	git clone --quiet https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
else
	echo -e "${Green}[*] zsh-syntax-highlighting already installed...skipping${Color_Off}"
fi

if [ ! -d ${ZSH_CUSTOM}/themes/powerlevel10k ]; then
	echo -e "\n${Yellow}[+] Installing powerlevel10k... ${Color_Off}"
	git clone --quiet --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM}/themes/powerlevel10k
else
	echo -e "${Green}[*] Powerlevel10k already installed...skipping${Color_Off}"
fi

if [ ! -d ~/.fzf ]; then
	echo -e "\n${Yellow}[+] Installing fzf... ${Color_Off}\n"
	git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
	sed -i 's/\<curl\>/curl -s/g' ~/.fzf/install
	~/.fzf/install --no-bash --no-fish --key-bindings --completion --no-update-rc
else
	echo -e "${Green}[*] fzf already installed...skipping${Color_Off}"
fi

echo -e "\n${Green}[+] Setting up tmux... ${Color_Off}\n"
~/dotfiles/setup-tmux.sh

chsh -s $(which zsh)

