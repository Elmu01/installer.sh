#!/bin/bash

#update system
sudo pacman -Syu --noconfirm 

#update nvidia-drivers
sudo pacman -S nvidia --noconfirm --needed

#Apps from pacman
sudo pacman -S yay zsh bashtop bitwarden discord steam grub-customizer solaar lutris ksysguard --noconfirm --needed

#apss from yay
yay -S brave-bin tidal-hifi-bin octopi noisetorch-bin authy nvtop-git --noconfirm --needed



#automatic reboot
systemctl reboot
