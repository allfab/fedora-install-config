#!/bin/bash

green=$'\e[0;32m'
red=$'\e[0;31m'
reset=$'\e[0m'

# ON TESTE SI ON EST ROOT
if [[ $(id -u) -ne "0" ]]
then
	echo -e "${red}Lancer le script avec les droits root (su - root ou sudo)${reset}"
	exit 1;
fi

echo "${green}INSTALLATION DE L'ENVIRONNEMENT DE BUREAU gnome${reset}"
dnf install \
    @base-x \
    @core \
    @guest-desktop-agents \
    @hardware-support \
    @multimedia \
    @networkmanager-submodules \
    @standard \
    adobe-source-code-pro-fonts \
    avahi \
    baobab \
    dconf \
    evince \
    evince-djvu \
    fprintd-pam \
    gdm \
    glib-networking \
    gnome-backgrounds \
    gnome-bluetooth \
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
    gnome-disk-utility \
    gnome-font-viewer \
    gnome-initial-setup \
    gnome-logs \
    gnome-maps \
    gnome-remote-desktop \
    gnome-session-wayland-session \
    gnome-session-xsession \
    gnome-settings-daemon \
    gnome-shell \
    gnome-software \
    gnome-system-monitor \
    gnome-terminal \
    gnome-terminal-nautilus \
    gnome-text-editor \
    gnome-user-docs \
    gnome-user-share \
    gnome-weather \
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
    rygel \
    sane-backends-drivers-scanners \
    simple-scan \
    snapshot \
    sushi \
    systemd-oomd-defaults \
    tracker \
    tracker-miners \
    vlc \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk \
    xdg-user-dirs-gtk

echo "${green}INSTALLATION DE L'ENVIRONNEMENT DE BUREAU gnome${reset}"
systemctl set-default graphical.target

echo "${green}REDÉMARRAGE DE LA MACHINE${reset}"
reboot