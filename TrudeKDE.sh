#! /bin/bash

#####################################################
# TrudeKDE.sh by @TrudeEH                           #
# This is the official install script for TrudeKDE  #
#    Tested on Kubuntu 20.04.2                      #
#####################################################

# ----] Functions [----
error_check(){
    if [ $? == 0 ]
    then
        echo " done"
    else
        echo " error"
    fi
}

# ----] Prepare system [----
sudo aaaaaaaa &> /dev/null

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

echo -ne "[+] Preparing Installer..."
sudo apt install -y git python3 python3-pip &> /dev/null
error_check

# ----] Konsave [----
echo -ne "[+] Downloading Konsave..."
git clone https://github.com/Prayag2/consave &> /dev/null
error_check

echo -ne "[+] Installing Konsave..."
cd consave
sudo python3 setup.py install &> /dev/null
cd ../ ; sudo rm -rf consave
error_check

echo -ne "[+] Loading trude.knsv..."
konsave -i trude.knsv &> /dev/null
konsave -a 1 &> /dev/null
error_check

# ----] Plymouth Theme [----
echo "[I] Please choose the circle theme"
sleep 2
echo "[+] Installing plymouth theme..."
echo
cd Circle-Plymouth-Theme
sudo mkdir /usr/share/plymouth/themes/circle &> /dev/null
sudo rsync -aq --exclude=install-circle * /usr/share/plymouth/themes/circle/ &> /dev/null
sudo update-alternatives --install /usr/share/plymouth/themes/default.plymouth default.plymouth /usr/share/plymouth/themes/circle/circle.plymouth 100 &> /dev/null
sudo update-alternatives --config default.plymouth  #here, choose the number of the theme you want to use then hit enter
sudo update-initramfs -u &> /dev/null
sudo apt-get install plymouth-x11 &> /dev/null
cd ../
echo
echo -ne "[+]"
error_check

# ----] ZSH [----
echo -ne "[+] Installing ZSH..."
sudo apt install -y zsh zsh-syntax-highlighting fonts-powerline xterm &> /dev/null
error_check

echo -ne "[+] Installing OhMyZSH..."
sudo chsh -s $(which zsh)
xterm -e 'sh -c "$(wget -O- https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" ; sleep 1 ; exit'
rm $HOME/.zshrc &> /dev/null
cp zshrc $HOME/.zshrc 
rm $HOME/.p10k.zsh &> /dev/null
cp p10k.zsh $HOME/.p10k.zsh
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
