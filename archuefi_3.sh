#!/bin/bash
mkdir ~/downloads
cd ~/downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
sudo pacman -S wget --noconfirm
sudo pacman -S --noconfirm --needed wget curl git 
git clone https://aur.archlinux.org/yay.git
cd yay
# makepkg -si
makepkg -si --skipinteg
cd ..
rm -rf yay

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка базовых программ и пакетов'
sudo pacman -S reflector firefox firefox-i18n-ru f2fs-tools dosfstools ntfs-3g file-roller p7zip unrar gvfs

echo 'Установить рекомендумые программы?'
read -p "1 - Да, 0 - Нет: " prog_set
if [[ $prog_set == 1 ]]; then
  #Можно заменить на pacman -Qqm > ~/.pacmanlist.txt
  sudo pacman -S gparted mc flameshot neofetch telegram-desktop --noconfirm
  yay -Syy
  yay -S xflux sublime-text-dev hunspell-ru pamac-aur-git megasync-nopdfium xorg-xkill ttf-symbola ttf-clear-sans --noconfirm
elif [[ $prog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi

echo "Ставим i3 с моими настройками?"
read -p "1 - Да, 2 - Нет: " vm_setting
if [[ $vm_setting == 1 ]]; then
    pacman -S i3-wm dmenu pcmanfm ttf-font-awesome feh gvfs udiskie xorg-xbacklight ristretto tumbler compton jq --noconfirm
    yay -S polybar ttf-weather-icons ttf-clear-sans
    wget https://github.com/ordanax/arch/raw/master/attach/config_i3wm.tar.gz
    sudo rm -rf ~/.config/i3/*
    sudo rm -rf ~/.config/polybar/*
    sudo tar -xzf config_i3wm.tar.gz -C ~/
elif [[ $vm_setting == 2 ]]; then
  echo 'Пропускаем.'
fi

echo 'Установить conky?'
read -p "1 - Да, 0 - Нет: " conky_set
if [[ $conky_set == 1 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget git.io/conky.tar.gz
  tar -xzf conky.tar.gz -C ~/
elif [[ $conky_set == 0 ]]; then
  echo 'Установка conky пропущена.'
fi

# Очистка
rm -rf ~/downloads/

echo 'Установка завершена!'
