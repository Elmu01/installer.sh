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


#installs gpu drivers
#PS3="Select your graphics: "

#toinstall=()

#select graphics in nvidia amd intel virtualbox; do
#  case $graphics in
#    nvidia)
#      toinstall+=(nvidia nvidia-lts nvidia-settings lib32-nvidia-utils)
#    break 
#      ;;
#    amd)
#      toinstall+=(mesa lib32-mesa xf86-video-amdgpu vulkan-radeon lib32-vulkan-radeon libva-mesa-driver)
#    break 
#      ;;
#    intel)
#      toinstall+=(mesa lib32-mesa xf86-video-intel vulkan-intel lib32-vulkan-intel intel-media-driver)
#    break 
#      ;;
#    virtualbox)
#      toinstall+=(virtualbox-guest-utils)
#    break 
#      ;;
#    *)
#      echo Invalid option $REPLY
#      ;;
#  esac
#done
#
#sudo pacman -S "${toinstall[@]}" --noconfirm --needed


#installs the programs from pacman
sudo pacman -S yay zsh btop bitwarden discord steam grub-customizer solaar lutris ksysguard flatpak starship --noconfirm --needed

#installs the programs from yay
yay -S spotify brave-bin noisetorch-bin authy nvtop-git plank plex-desktop qdirstat bleachbit-git appimagelauncher-git gnome-boxes-git signal-desktop heroic-games-launcher cava piavpn-bin noto-fonts-emoji --noconfirm --needed

#installs the program from flatpak
flatpak install flathub io.github.Foldex.AdwSteamGtk

#starship preset
echo 'eval "$(starship init zsh)"' > .zshrc
starship preset pastel-powerline > .config/starship.toml

#change shell from bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
