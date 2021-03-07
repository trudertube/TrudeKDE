#!/bin/bash

#####################################################
# TrudeKDE.sh by @TrudeEH                           #
# This is the official install script for TrudeKDE  #
#    Tested on Kubuntu 20.04.2                      #
#####################################################

# Functions:
error_check(){
    if [ $? == 0 ]
    then
        echo " done"
    else
        echo " error"
    fi
}


sudo aaaaaaaa &> /dev/null

echo -ne "[+] Preparing Installer..."
sudo apt install -y git &> /dev/null
error_check

# Update base:
echo
echo "[+] Updating the system base..."
echo -ne '[.........................]\r'
sudo apt update -y &> /dev/null
echo -ne '[#####....................]\r'
sudo apt upgrade -y &> /dev/null
echo -ne '[##########...............]\r'
sudo apt dist-upgrade -y &> /dev/null
echo -ne '[################.........]\r'
sudo apt autoremove -y &> /dev/null
echo -ne '[#####################....]\r'
sudo apt autoclean -y &> /dev/null
echo -ne '[#########################]\r'
echo -ne '\n'
echo

# --------------------------------
# Appearance 
echo -ne "[+] Downloading TrudeKDE-files..."
git clone https://github.com/trudertube/TrudeKDE-files.git &> /dev/null
cd TrudeKDE-files
error_check

# Icons
echo -ne "[+] Installing Tela Circle Icon Theme..."
cd tela-icons ; ./install.sh &> /dev/null ; cd ..
error_check

# Cursor
echo -ne "[+] Installing GoogleDot cursors..."
mkdir $HOME/.icons &> /dev/null
cp -r GoogleDot $HOME/.icons
error_check

# Plasma themes
echo -ne "[+] Installing Plasma themes..."
mkdir $HOME/.local/share/plasma &> /dev/null
cp -r look-and-feel $HOME/.local/share/plasma
error_check

# Plymouth theme
echo "[I] Please choose the circle theme"
sleep 2
echo "[+] Installing plymouth theme..."
echo
cd plymouth/Circle-Plymouth-Theme
sudo mkdir /usr/share/plymouth/themes/circle &> /dev/null
sudo rsync -aq --exclude=install-circle * /usr/share/plymouth/themes/circle/ &> /dev/null
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/circle/circle.plymouth 100 &> /dev/null
sudo update-alternatives --config default.plymouth  #here, choose the number of the theme you want to use then hit enter
sudo update-initramfs -u &> /dev/null
sudo apt-get install plymouth-x11 &> /dev/null
cd ../../
echo
echo -ne "[+]"
error_check

# --------------------------------------------------

# ZSH
echo -ne "[+] Installing ZSH..."
sudo apt install -y zsh zsh-syntax-highlighting fonts-powerline xterm &> /dev/null
error_check

echo -ne "[+] Installing OhMyZSH..."
sudo chsh -s $(which zsh)
xterm -e 'sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ; sleep 1 ; exit'
rm $HOME/.zshrc &> /dev/null
cp zshrc ~/.zshrc 
rm $HOME/.p10k.zsh &> /dev/null
cp p10k.zsh ~/.p10k.zsh
error_check

echo -ne "[+] Preparing ZSH Plugins..."
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"
error_check
echo -ne "[+] Installing powerlevel10k..."
git clone https://github.com/romkatv/powerlevel10k $ZSH_CUSTOM/themes/powerlevel10k &> /dev/null
error_check
echo -ne "[+] Installing ZSH-autosuggestions..."
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions &> /dev/null
error_check
echo -ne "[+] Installing ZSH-syntax-highlighting..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting &> /dev/null
error_check

cd .. ; rm -rf TrudeKDE-files
