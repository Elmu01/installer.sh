#!/bin/bash

read -r -d '' BANNER << EOF


  ___                             ___  
 (o o)                           (o o) 
(  V  ) Elmu's installer script (  V  )
--m-m-----------------------------m-m--


EOF

clear

echo -e "$BANNER"

#update system
sudo pacman -Syu --noconfirm 

#installs the programs from pacman
sudo pacman -S git zsh os-prober btop bitwarden discord steam grub-customizer solaar lutris plank gnome-boxes signal-desktop noto-fonts-emoji ksysguard flatpak starship --noconfirm --needed

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

#installs the programs from yay
yay -S spotify brave-bin authy nvtop-git qdirstat appimagelauncher heroic-games-launcher cava piavpn-bin plex-desktop latte-dock-git --noconfirm --needed

#installs the program from flatpak
flatpak install -y flathub io.github.Foldex.AdwSteamGtk flathub net.davidotek.pupgui2  

#starship preset
echo 'eval "$(starship init zsh)"' > ~/.zshrc
starship preset pastel-powerline > ~/.config/starship.toml

#change shell from bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
