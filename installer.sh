#!/bin/bash

#update system
sudo pacman -Syu

#update nvidia-drivers
sudo pacman -S nvidia

#Apps from pacman
sudo pacman -S yay zsh octopi bashtop bitwarden discord steam-native-runtime grub-customizer solaar 

#apss from yay
yay -S brave-bin tidal-hifi-bin

