#!/bin/bash

read -r -d '' BANNER << EOF
 ________ __                       __               __                     __              __ __                                                   __            __     
|        \  \                     |  \             |  \                   |  \            |  \  \                                                 |  \          |  \    
| ▓▓▓▓▓▓▓▓ ▓▓______ ____  __    __| ▓▓ _______      \▓▓_______   _______ _| ▓▓_    ______ | ▓▓ ▓▓ ______   ______        _______  _______  ______  \▓▓ ______  _| ▓▓_   
| ▓▓__   | ▓▓      \    \|  \  |  \\▓ /       \    |  \       \ /       \   ▓▓ \  |      \| ▓▓ ▓▓/      \ /      \      /       \/       \/      \|  \/      \|   ▓▓ \  
| ▓▓  \  | ▓▓ ▓▓▓▓▓▓\▓▓▓▓\ ▓▓  | ▓▓  |  ▓▓▓▓▓▓▓    | ▓▓ ▓▓▓▓▓▓▓\  ▓▓▓▓▓▓▓\▓▓▓▓▓▓   \▓▓▓▓▓▓\ ▓▓ ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\    |  ▓▓▓▓▓▓▓  ▓▓▓▓▓▓▓  ▓▓▓▓▓▓\ ▓▓  ▓▓▓▓▓▓\\▓▓▓▓▓▓  
| ▓▓▓▓▓  | ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓  | ▓▓   \▓▓    \     | ▓▓ ▓▓  | ▓▓\▓▓    \  | ▓▓ __ /      ▓▓ ▓▓ ▓▓ ▓▓    ▓▓ ▓▓   \▓▓     \▓▓    \| ▓▓     | ▓▓   \▓▓ ▓▓ ▓▓  | ▓▓ | ▓▓ __ 
| ▓▓_____| ▓▓ ▓▓ | ▓▓ | ▓▓ ▓▓__/ ▓▓   _\▓▓▓▓▓▓\    | ▓▓ ▓▓  | ▓▓_\▓▓▓▓▓▓\ | ▓▓|  \  ▓▓▓▓▓▓▓ ▓▓ ▓▓ ▓▓▓▓▓▓▓▓ ▓▓           _\▓▓▓▓▓▓\ ▓▓_____| ▓▓     | ▓▓ ▓▓__/ ▓▓ | ▓▓|  \
| ▓▓     \ ▓▓ ▓▓ | ▓▓ | ▓▓\▓▓    ▓▓  |       ▓▓    | ▓▓ ▓▓  | ▓▓       ▓▓  \▓▓  ▓▓\▓▓    ▓▓ ▓▓ ▓▓\▓▓     \ ▓▓          |       ▓▓\▓▓     \ ▓▓     | ▓▓ ▓▓    ▓▓  \▓▓  ▓▓
 \▓▓▓▓▓▓▓▓\▓▓\▓▓  \▓▓  \▓▓ \▓▓▓▓▓▓    \▓▓▓▓▓▓▓      \▓▓\▓▓   \▓▓\▓▓▓▓▓▓▓    \▓▓▓▓  \▓▓▓▓▓▓▓\▓▓\▓▓ \▓▓▓▓▓▓▓\▓▓           \▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓\▓▓      \▓▓ ▓▓▓▓▓▓▓    \▓▓▓▓ 
                                                                                                                                                     | ▓▓               
                                                                                                                                                     | ▓▓               
                                                                                                                                                      \▓▓               

EOF

clear

echo -e "$BANNER"


#update system
sudo pacman -Syu --noconfirm 

#update nvidia-drivers
sudo pacman -S nvidia --noconfirm --needed

#Apps from pacman
sudo pacman -S yay zsh bashtop bitwarden discord steam grub-customizer solaar lutris ksysguard --noconfirm --needed

#apss from yay
yay -S brave-bin tidal-hifi-bin octopi noisetorch-bin authy nvtop-git --noconfirm --needed

#change bash to zsh
chsh -s /bin/zsh

#automatic reboot
systemctl reboot
