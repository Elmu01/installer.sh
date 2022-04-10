#!/bin/bash

#update system
sudo pacman -Syu --noconfirm

#update nvidia-drivers
sudo pacman -S nvidia --noconfirm

#Apps from pacman
sudo pacman -S yay zsh bashtop bitwarden discord steam grub-customizer solaar lutris --noconfirm

#apss from yay
yay -S brave-bin tidal-hifi-bin octopi noisetorch-bin authy --noconfirm



#automatic reboot
systemctl reboot
