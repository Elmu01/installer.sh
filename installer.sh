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
sudo pacman -S yay zsh btop bitwarden discord steam grub-customizer solaar lutris plank bleachbit gnome-boxes signal-desktop noto-fonts-emoji ksysguard flatpak starship --noconfirm --needed

#installs the programs from yay
yay -S spotify brave-bin noisetorch-bin authy nvtop-git qdirstat appimagelauncher heroic-games-launcher cava piavpn-bin --noconfirm --needed

#installs the program from flatpak
flatpak install -y flathub io.github.Foldex.AdwSteamGtk

#starship preset
echo 'eval "$(starship init zsh)"' > ~/.zshrc
starship preset pastel-powerline > ~/.config/starship.toml

#change shell from bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
