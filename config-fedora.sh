#!/bin/bash

set -x

green=$'\e[0;32m'
red=$'\e[0;31m'
reset=$'\e[0m'

# ON TESTE SI ON EST ROOT
if [[ $(id -u) -ne "0" ]]
then
	echo -e "${red}LANCER LE SCRIPT D'INSTALLATION AVEC LES DROITS root (su - root ou sudo)${reset}"
	exit 1;
fi

echo "${green}MISE À JOUR SYSTÈME${reset}"

echo "${green}INSTALLATION DE L'ENVIRONNEMENT DE BUREAU gnome ET OUTILS DE BASE${reset}"
dnf install -y \
    @base-x \
    @c-development \
    @core \
    @d-development \
    @development-tools \
    @guest-desktop-agents \
    @hardware-support \
    @multimedia \
    @networkmanager-submodules \
    @standard \
    adobe-source-code-pro-fonts \
    avahi \
    baobab \
    dconf \
    desktop-backgrounds-gnome \
    evince \
    evince-djvu \
    f42-backgrounds-gnome \
    fedora-chromium-config-gnome \
    firefox \
    fprintd-pam \
    fros-gnome \
    gdm \
    glib-networking \
    gnome-abrt \
    gnome-autoar \
    gnome-backgrounds \
    gnome-backgrounds-extras \
    gnome-battery-bench \
    gnome-bluetooth \
    gnome-bluetooth-libs \
    gnome-browser-connector \
    gnome-calculator \
    gnome-calendar \
    gnome-characters \
    gnome-classic-session \
    gnome-classic-session-xsession \
    gnome-clocks \
    gnome-color-manager \
    gnome-connections \
    gnome-control-center \
    gnome-desktop3 \
    gnome-desktop4 \
    gnome-disk-utility \
    gnome-epub-thumbnailer \
    gnome-extensions-app \
    gnome-firmware \
    gnome-font-viewer \
    gnome-icon-theme \
    gnome-initial-setup \
    gnome-keyring \
    gnome-keyring-pam \
    gnome-logs \
    gnome-menus \
    gnome-monitor-config \
    gnome-nettool \
    gnome-online-accounts \
    gnome-power-manager \
    gnome-remote-desktop \
    gnome-screenshot \
    gnome-session \
    gnome-session-wayland-session \
    gnome-session-xsession \
    gnome-settings-daemon \
    gnome-shell \
    gnome-shell-extension-appindicator \
    gnome-shell-extension-apps-menu \
    gnome-shell-extension-background-logo \
    gnome-shell-extension-blur-my-shell \
    gnome-shell-extension-caffeine \
    gnome-shell-extension-common \
    gnome-shell-extension-just-perfection \
    gnome-software \
    gnome-software-fedora-langpacks \
    gnome-system-log \
    gnome-system-monitor \
    gnome-terminal \
    gnome-terminal-nautilus \
    gnome-text-editor \
    gnome-themes-extra \
    gnome-tweaks \
    gnome-usage \
    gnome-user-docs \
    gnome-user-share \
    gvfs-afc \
    gvfs-afp \
    gvfs-archive \
    gvfs-fuse \
    gvfs-goa \
    gvfs-gphoto2 \
    gvfs-mtp \
    gvfs-smb \
    librsvg2 \
    libsane-hpaio \
    localsearch \
    loupe \
    mesa-dri-drivers \
    mesa-libEGL \
    ModemManager \
    nautilus \
    NetworkManager-adsl \
    NetworkManager-openconnect-gnome \
    NetworkManager-openvpn-gnome \
    NetworkManager-ppp \
    NetworkManager-pptp-gnome \
    NetworkManager-ssh-gnome \
    NetworkManager-vpnc-gnome \
    NetworkManager-wwan \
    PackageKit-command-not-found \
    PackageKit-gtk3-module \
    polkit \
    ptyxis \
    rygel \
    sane-backends-drivers-scanners \
    snapshot \
    sushi \
    systemd-oomd-defaults \
    tinysparql \
    vlc \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk \
    xdg-user-dirs-gtk
    
echo "${green}SUPPRESSION DES PAQUETS NON NÉCESSAIRES${reset}"
dnf remove -y gnome-boxes gnome-tour yelp

echo "${green}DÉFINITION DE LA CIBLE PAR DÉFAUT SUR graphical.target (shell graphique)${reset}"
systemctl set-default graphical.target

echo "${green}REDÉMARRAGE DE LA MACHINE${reset}"
reboot