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
sudo pacman -S mesa vulkan-radeon libva-mesa-driver mesa-vdpau lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver lib32-mesa-vdpau git zsh os-prober btop bitwarden discord steam grub-customizer solaar piper libreoffice-still lutris plank gnome-boxes signal-desktop noto-fonts-emoji ksysguard flatpak starship --noconfirm --needed

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

#installs the programs from yay
yay -S spotify brave-bin authy qdirstat appimagelauncher heroic-games-launcher cava piavpn-bin plex-desktop latte-dock-git --noconfirm --needed

#installs the program from flatpak
flatpak install -y flathub io.github.Foldex.AdwSteamGtk flathub net.davidotek.pupgui2 flatpak flathub sh.cider.Cider flatpak flathub net.rpcs3.RPCS3

#starship preset
echo 'eval "$(starship init zsh)"' > ~/.zshrc
starship preset pastel-powerline > ~/.config/starship.toml

#change shell from bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
