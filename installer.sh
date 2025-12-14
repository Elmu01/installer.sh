#!/bin/bash

set -euo pipefail

read -r -d '' BANNER << EOF

▗▄▄▄▖▗▖  ▗▖ ▗▄▄▖▗▄▄▄▖▗▄▖ ▗▖   ▗▖   ▗▄▄▄▖▗▄▄▖     ▗▄▄▄▖ ▗▄▖ ▗▄▄▖      ▗▄▖ ▗▄▄▖  ▗▄▄▖▗▖ ▗▖    ▗▄▄▖  ▗▄▖  ▗▄▄▖▗▄▄▄▖▗▄▄▄      ▗▄▄▖▗▖  ▗▖▗▄▄▖▗▄▄▄▖▗▄▄▄▖▗▖  ▗▖ ▗▄▄▖
  █  ▐▛▚▖▐▌▐▌     █ ▐▌ ▐▌▐▌   ▐▌   ▐▌   ▐▌ ▐▌    ▐▌   ▐▌ ▐▌▐▌ ▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌ ▐▌    ▐▌ ▐▌▐▌ ▐▌▐▌   ▐▌   ▐▌  █    ▐▌    ▝▚▞▘▐▌     █  ▐▌   ▐▛▚▞▜▌▐▌   
  █  ▐▌ ▝▜▌ ▝▀▚▖  █ ▐▛▀▜▌▐▌   ▐▌   ▐▛▀▀▘▐▛▀▚▖    ▐▛▀▀▘▐▌ ▐▌▐▛▀▚▖    ▐▛▀▜▌▐▛▀▚▖▐▌   ▐▛▀▜▌    ▐▛▀▚▖▐▛▀▜▌ ▝▀▚▖▐▛▀▀▘▐▌  █     ▝▀▚▖  ▐▌  ▝▀▚▖  █  ▐▛▀▀▘▐▌  ▐▌ ▝▀▚▖
▗▄█▄▖▐▌  ▐▌▗▄▄▞▘  █ ▐▌ ▐▌▐▙▄▄▖▐▙▄▄▖▐▙▄▄▖▐▌ ▐▌    ▐▌   ▝▚▄▞▘▐▌ ▐▌    ▐▌ ▐▌▐▌ ▐▌▝▚▄▄▖▐▌ ▐▌    ▐▙▄▞▘▐▌ ▐▌▗▄▄▞▘▐▙▄▄▖▐▙▄▄▀    ▗▄▄▞▘  ▐▌ ▗▄▄▞▘  █  ▐▙▄▄▖▐▌  ▐▌▗▄▄▞▘


EOF

clear

echo -e "$BANNER"

#update system
sudo pacman -Syu --noconfirm 

### --- Installer-repo ---
if [ ! -d "$INSTALLER_DIR" ]; then
  echo "Kloonataan installer-repo..."
  git clone https://github.com/Elmu01/installer.sh.git "$INSTALLER_DIR"
fi

# Symboliset linkit
[ ! -L "$HOME/Documents/Wallpapers" ] && ln -s "$INSTALLER_DIR/Wallpapers" "$HOME/Documents/Wallpapers"
mkdir -p "$HOME/.config/MangoHud"
[ ! -L "$HOME/.config/MangoHud/MangoHud.conf" ] && ln -s "$INSTALLER_DIR/MangoHud.conf" "$HOME/.config/MangoHud/MangoHud.conf"
[ ! -L "$HOME/.config/neofetch" ] && ln -s "$INSTALLER_DIR/neofetch" "$HOME/.config/neofetch"

cd "$INSTALLER_DIR"
git remote set-url origin git@github.com:Elmu01/installer.sh.git
cd - >/dev/null

### --- Apufunktio ---
confirm() {
  while true; do
    read -rp "$1 [y/n]: " yn
    case $yn in
      [Yy]*) return 0 ;;
      [Nn]*) return 1 ;;
      *) echo "Anna y tai n." ;;
    esac
  done
}

### --- pakettilistat ---
PACMAN_PACKAGES=(
  mesa vulkan-radeon libva-mesa-driver mesa-vdpau
  lib32-mesa lib32-vulkan-radeon lib32-libva-mesa-driver lib32-mesa-vdpau
  git zsh os-prober btop bitwarden discord steam grub-customizer
  solaar piper libreoffice-still lutris noto-fonts-emoji
  ksysguard code flatpak starship
)

AUR_PACKAGES=(
  webapp-manager vesktop fastfetch micro spotify
  appimagelauncher heroic-games-launcher onedriver
  mangohud lib32-mangohud ttf-firacode-nerd
)

VIRT_PACKAGES=(
  virt-manager dnsmasq iptables-nft qemu-desktop swtpm
)

### --- yay päätös ---
USE_YAY=false
confirm "Asennetaanko yay (AUR-tuki)?" && USE_YAY=true

### --- yay asennus ---
if $USE_YAY && ! command -v yay &>/dev/null; then
  sudo pacman -S --needed --noconfirm base-devel git
  [ ! -d /tmp/yay ] && git clone https://aur.archlinux.org/yay.git /tmp/yay
  (cd /tmp/yay && makepkg -si --noconfirm)
  rm -rf /tmp/yay
fi

### --- Pacman-paketit ---
echo "Asennetaan Pacman-paketit..."
for pkg in "${PACMAN_PACKAGES[@]}"; do
  sudo pacman -S --needed "$pkg" --noconfirm || echo "Pakettia $pkg ei voitu asentaa, ohitetaan."
done

### --- AUR tai fallback ---
if $USE_YAY; then
  yay -S --needed "${AUR_PACKAGES[@]}" --noconfirm
else
  echo "Yay ei käytössä, yritetään pacmania."
  for pkg in "${AUR_PACKAGES[@]}"; do
    if pacman -Si "$pkg" &>/dev/null; then
      sudo pacman -S --needed "$pkg" --noconfirm
    else
      echo "Pakettia $pkg ei löytynyt pacmanista, ohitetaan."
    fi
  done
fi

### --- Virt-manager ---
echo "Asennetaan virt-manager paketit..."
for pkg in "${VIRT_PACKAGES[@]}"; do
  if $USE_YAY; then
    yay -S --needed "$pkg" --noconfirm || echo "Pakettia $pkg ei voitu asentaa, ohitetaan."
  else
    sudo pacman -S --needed "$pkg" --noconfirm || echo "Pakettia $pkg ei voitu asentaa, ohitetaan."
  fi
done
sudo systemctl enable libvirtd.socket

### --- Flatpak ---
FLATPAK_APPS=(
  io.github.Foldex.AdwSteamGtk
  net.davidotek.pupgui2
  net.rpcs3.RPCS3
  io.missioncenter.MissionCenter
  com.github.wwmm.easyeffects
)
echo "Asennetaan Flatpak-applikaatiot..."
mkdir -p ~/.local/share/flatpak
for app in "${FLATPAK_APPS[@]}"; do
  flatpak install -y flathub "$app" || echo "Flatpak $app ei onnistunut, ohitetaan."
done

### --- Lutris WineDependencies ---
WINE_DEPS=(
  wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls
  mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error
  lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo
  sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libxinerama libgcrypt lib32-libgcrypt
  ncurses lib32-ncurses ocl-icd lib32-ocl-icd libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3
  gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader
)

echo "Asennetaan Wine-riippuvuudet..."
for dep in "${WINE_DEPS[@]}"; do
  sudo pacman -S --needed "$dep" --noconfirm || echo "Pakettia $dep ei voitu asentaa, ohitetaan."
done

### --- Starship ---
echo "Konfiguroidaan Starship..."
mkdir -p ~/.config
grep -qxF 'eval "$(starship init zsh)"' ~/.zshrc || echo 'eval "$(starship init zsh)"' >> ~/.zshrc
starship preset pastel-powerline > ~/.config/starship.toml

### --- Vaihdetaan shell ---
echo "Vaihdetaan shell zsh:ksi..."
chsh -s /bin/zsh || echo "Shellin vaihto epäonnistui. Tarkista oikeudet."

### --- Lopuksi ---
confirm "Kaikki asennukset tehty. Käynnistetäänkö uudelleen?" && sudo systemctl reboot
