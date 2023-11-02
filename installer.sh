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

#Lutris WineDependencies
sudo pacman -S --noconfirm --needed wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error \
lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo \
sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama \
ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 \
lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

#starship preset
echo 'eval "$(starship init zsh)"' > ~/.zshrc
starship preset pastel-powerline > ~/.config/starship.toml

#change shell from bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
