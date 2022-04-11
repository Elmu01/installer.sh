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

#installs nvidia gpu drivers
sudo pacman -S nvidia --noconfirm --needed

#installs the programs from pacman
sudo pacman -S yay zsh bashtop bitwarden discord steam grub-customizer solaar lutris ksysguard --noconfirm --needed

#installs the programs from yay
yay -S brave-bin tidal-hifi-bin noisetorch-bin authy nvtop-git plank --noconfirm --needed


#change shell from bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
