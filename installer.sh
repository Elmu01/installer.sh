#!/bin/bash

read -r -d '' BANNER << EOF

.-------------------------.
| Elmu's installer script |
'-------------------------'


EOF

clear

echo -e "$BANNER"

#update system
sudo pacman -Syu --noconfirm 

cd $HOME/Documents
git clone https://github.com/Elmu01/installer.sh.git installer
ln -s $HOME/Documents/installer/Wallpapers $HOME/Documents/Wallpapers
mkdir -p $HOME/.config/MangoHud
ln -s $HOME/Documents/installer/MangoHud.conf $HOME/.config/MangoHud/MangoHud.conf
ln -s $HOME/Documents/installer/neofetch $HOME/.config/neofetch
cd installer
git remote set-url origin git@github.com:Elmu01/installer.sh.git
cd ../..

#installs the programs from pacman
sudo pacman -S mesa vulkan-radeon libva-mesa-driver mesa-vdpau lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver lib32-mesa-vdpau git zsh os-prober btop bitwarden discord steam grub-customizer solaar piper libreoffice-still lutris plank gnome-boxes signal-desktop noto-fonts-emoji ksysguard code flatpak starship --noconfirm --needed

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -rf yay

#installs the programs from yay
yay -S webapp-manager vesktop neofetch micro spotify qdirstat appimagelauncher heroic-games-launcher plex-desktop onedriver mangohud lib32-mangohud ttf-firacode-nerd --noconfirm --needed

#Virt-manager
yay -S virt-manager dnsmasq iptables-nft qemu-desktop swtpm --noconfirm
sudo systemctl enable libvirtd.socket

#installs the program from flatpak
flatpak install -y flathub io.github.Foldex.AdwSteamGtk flathub net.davidotek.pupgui2 flatpak flathub net.rpcs3.RPCS3 flatpak flathub io.missioncenter.MissionCenter

#Lutris WineDependencies
sudo pacman -S wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls \
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
