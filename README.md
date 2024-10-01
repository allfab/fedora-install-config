Documentation sur l'installation et la configuration de Fedora 40 avec un environement de bureau Gnome

# INSTALLATION DE FEDORA

[https://www.reddit.com/r/Fedora/comments/lobnfm/guide_fedora_gnome_minimal_install/](https://www.reddit.com/r/Fedora/comments/lobnfm/guide_fedora_gnome_minimal_install/)

# PARTIONNEMENT 

`Btrfs` est le système de fichiers par défaut utilisé par Fedora Workstation. `Btrfs` présente deux avantages clés pour les utilisateurs utilisant la configuration du système de fichiers par défaut :
- La compression transparente signifie que les données stockées sur le disque utilisent moins d'espace
- La réinstallation du système tout en préservant les données des utilisateurs peut être prise en charge, tout en évitant la question des volumes à court d'espace. Ceci est dû au fait que les sous-volumes de `Btrfs` ne se limitent pas à une taille prédéfinie statique.

`Btrfs` fournit également une gamme d'autres fonctionnalités, telles que snapshotting et rétrécissement en ligne, qui peuvent être utiles pour ceux qui veulent les utiliser, et peuvent potentiellement être la base des futures fonctionnalités orientées vers l'utilisateur.

Par défaut, une installation Fedora Workstation présente la disposition de disque suivante :

| Rôle                 | Système de fichier | Point de montage | Taille | Nom   |
|----------------------|--------------------|------------------|--------|-------|
| EFI System Partition | EFI                | /boot/efi        | 1GB    | efi   |
| Boot partition       | Bios Boot          | /boot            | 512MB  | boot  |
| Root Subvolume       | BTRFS              | /                | All    | @     |
| Home Subvolume       | BTRFS              | /home            | 100GB  | @home |

Les deux premières partitions sont communes à toutes les installations de Fedora et sont nécessaires au démarrage du système. Le sous-volume racine (/) contient l'installation du système et le sous-volume /home contient les données et paramètres utilisateur.

Docs :
- [Fedora Workstation Documentation : Configuration du disque](https://docs.fedoraproject.org/fr/workstation-docs/disk-config/#_btrfs)
- [Guide de l'administrateur système Btrfs : dispositions des sous-volumes](https://archive.kernel.org/oldwiki/btrfs.wiki.kernel.org/index.php/SysadminGuide.html#Layout)


# Swap sur ZRAM

Fedora Workstation n'utilise pas de partition d'échange dédiée. Au lieu de cela, il utilise zram : un lecteur émulé qui utilise la RAM pour son stockage. L'échange basé sur la RAM est plus rapide que l'échange basé sur le disque, ce qui évite le ralentissement extrême du système et les perturbations qui peuvent survenir avec une partition d'échange traditionnelle.

Le lecteur zram est compressé pour utiliser efficacement la mémoire disponible et se voit attribuer de la mémoire de manière dynamique, ce qui signifie qu'il n'utilise la RAM système que lorsqu'un échange est nécessaire.

# INSTALLATION DE L'ENVIRONNEMENT GRAPHIQUE

## Découverte des différents environnements de bureau disponible
```bash
sudo  dnf group list --ids | grep desktop
   KDE Plasma Workspaces (kde-desktop-environment)
   Bureau Xfce (xfce-desktop-environment)
   Phosh Desktop (phosh-desktop-environment)
   Bureau LXDE (lxde-desktop-environment)
   Bureau LXQt (lxqt-desktop-environment)
   Bureau Cinnamon (cinnamon-desktop-environment)
   Bureau MATE (mate-desktop-environment)
   Environnement de bureau Sugar (sugar-desktop-environment)
   Bureau Deepin (deepin-desktop-environment)
   Budgie Desktop (budgie-desktop-environment)
   Bureau basique (basic-desktop-environment)
   i3 desktop (i3-desktop-environment)
   Sway Desktop (sway-desktop-environment)
   Budgie (budgie-desktop)
   Budgie Desktop Applications (budgie-desktop-apps)
   Desktop accessibility (desktop-accessibility)
```

## Information sur le groupe de packages :
```bash
sudo dnf group info basic-desktop-environment
```
ou
```bash
sudo dnf group info "Bureau basique"
```

```bash
Dernière vérification de l’expiration des métadonnées effectuée il y a 0:20:08 le mar. 01 oct. 2024 13:24:36.
Groupe d’environnement : Bureau basique
 Description : Système de fenêtrage X avec une sélection de gestionnaires de fenêtres.
 Groupes obligatoires :
   Basic Desktop
   Common NetworkManager Submodules
   Core
   Dial-up Networking Support
   Fonts
   Guest Desktop Agents
   Hardware Support
   Multimedia
   Standard
   base-x
 Groupes optionnels :
   Cinnamon
   Firefox Web Browser
   GNOME
   Input Methods
   KDE
   LXDE
   LXQt
   Legacy Fonts
   LibreOffice
   MATE
   Sugar Desktop Environment
   XMonad
   XMonad for MATE
   Xfce
```

## Installation du groupe de packages
```bash
sudo dnf install @basic-desktop-environment
```
ou
```bash
sudo dnf group install basic-desktop-environment
```
ou
```bash
sudo dnf group install "Bureau basique"
```

Comprend les groupes de packages suivants :
```bash
Installation des groupes d’environnement:
 Basic Desktop
Installation des groupes:
 base-x
 Basic Desktop
 Core
 Dial-up Networking Support
 Fonts
 Guest Desktop Agents
 Hardware Support
 Multimedia
 Common NetworkManager Submodules
 Standard
```

Si on veut installer un environnement de bureau Gnome un peu plus épuré :
```bash
sudo dnf install @base-x @gnome
```

Si on veut encore aller plus loin :
```bash
sudo dnf group info gnome
Dernière vérification de l’expiration des métadonnées effectuée il y a 0:04:53 le mar. 01 oct. 2024 13:31:43.
Groupe : GNOME
 Description : GNOME est un environnement de bureau très intuitif et facile à prendre en main.
 Paquets obligatoires :
   dconf
   gdm
   gnome-boxes
   gnome-connections
   gnome-control-center
   gnome-initial-setup
   gnome-session-wayland-session
   gnome-settings-daemon
   gnome-shell
   gnome-software
   gnome-terminal
   gnome-text-editor
   nautilus
   polkit
   yelp
 Paquets par défaut :
   ModemManager
   NetworkManager-adsl
   NetworkManager-openconnect-gnome
   NetworkManager-openvpn-gnome
   NetworkManager-ppp
   NetworkManager-pptp-gnome
   NetworkManager-ssh-gnome
   NetworkManager-vpnc-gnome
   NetworkManager-wwan
   PackageKit-command-not-found
   PackageKit-gtk3-module
   adobe-source-code-pro-fonts
   avahi
   baobab
   evince
   evince-djvu
   fprintd-pam
   glib-networking
   gnome-backgrounds
   gnome-bluetooth
   gnome-browser-connector
   gnome-calculator
   gnome-calendar
   gnome-characters
   gnome-classic-session
   gnome-classic-session-xsession
   gnome-clocks
   gnome-color-manager
   gnome-contacts
   gnome-disk-utility
   gnome-font-viewer
   gnome-logs
   gnome-maps
   gnome-remote-desktop
   gnome-session-xsession
   gnome-system-monitor
   gnome-terminal-nautilus
   gnome-user-docs
   gnome-user-share
   gnome-weather
   gvfs-afc
   gvfs-afp
   gvfs-archive
   gvfs-fuse
   gvfs-goa
   gvfs-gphoto2
   gvfs-mtp
   gvfs-smb
   librsvg2
   libsane-hpaio
   loupe
   mesa-dri-drivers
   mesa-libEGL
   rygel
   sane-backends-drivers-scanners
   simple-scan
   snapshot
   sushi
   systemd-oomd-defaults
   totem
   tracker
   tracker-miners
   xdg-desktop-portal
   xdg-desktop-portal-gnome
   xdg-desktop-portal-gtk
   xdg-user-dirs-gtk
```

```bash
sudo dnf install \
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
```

Désinstallation des applications non souhaitées
```bash
sudo dnf remove gnome-boxes gnome-tour yelp
```

## INSTALLATION DU SUPPORT MATÉRIEL
```bash
sudo dnf group install "Hardware Support"
```
**Pas nécessaire puisque le groupe de packages est déjà inclu dans la groupe de packages de l'environnement de bureau basique (Gnome).**

## APPLICATIONS DE BASE gnome ET AUTRES
```bash
sudo dnf install \
	desktop-backgrounds-gnome \
	f40-backgrounds-gnome \
	fedora-chromium-config-gnome \
	firefox \
	fros-gnome \
	gdm \
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
	gnome-extensions-app \
	gnome-firmware \
	gnome-font-viewer \
	gnome-icon-theme \
	gnome-initial-setup \
	gnome-keyring \
	gnome-keyring-pam \
	gnome-logs \
	gnome-maps \
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
	gnome-weather \
	nautilus
```

## OPTIONS DES RÉPERTOIRES "utilisateur" DANS LE BARRE LATÉRALE DE NAUTILUS
```bash
sudo dnf install xdg-user-dirs xdg-user-dirs-gtk
```

## EXTENSIONS gnome SUPPLÉMENTAIRES
```bash
sudo dnf install -y \
	# gnome-shell-extension-appindicator \
	# gnome-shell-extension-apps-menu \
	gnome-shell-extension-background-logo \
	gnome-shell-extension-blur-my-shell \
	gnome-shell-extension-caffeine \
	gnome-shell-extension-common \
	# gnome-shell-extension-dash-to-dock \
	# gnome-shell-extension-dash-to-panel \
	gnome-shell-extension-just-perfection \
	# gnome-shell-extension-launch-new-instance \
	# gnome-shell-extension-places-menu \
	gnome-shell-extension-pop-shell \
	gnome-shell-extension-pop-shell-shortcut-overrides \
	# gnome-shell-extension-refresh-wifi \
	# gnome-shell-extension-status-icons \
	# gnome-shell-extension-system-monitor \
	# gnome-shell-extension-window-list \
	# gnome-shell-extension-workspace-indicator \
```

## CONFIGURATION DE L'ENVIRONNEMENT GRAPHIQUE PAR DÉFAUT
```bash
sudo systemctl set-default graphical.target
sudo reboot
```

## APPLICATIONS SUPPLÉMENTAIRES
```bash
sudo dnf install -y \
	gedit 
```

## SUPPORT MULTIMÉDIA
```bash
sudo dnf install -y vlc
```

## SUPPORT POUR UN ENVIRONNEMENT DE COMPILATION
```bash
sudo  dnf group list --ids | grep development
Outils de développement et bibliothèques pour C (c-development)
   Outils de développement et bibliothèques pour D (d-development)
   Outils de développement (development-tools)
   KDE Frameworks 6 Software Development (kf6-software-development)
   Outils de développement RPM (rpm-development-tools)
```

```bash
sudo dnf group info development-tools
sudo dnf group info c-development
sudo dnf group info d-development
```

```bash
sudo dnf install -y @development-tools @c-development @d-development
```

## MISE À JOUR DES FIRMWARES ET UEFI DEPUIS LINUX
> [fwupd : Mettre à jour les firmwares et UEFI depuis Linux](https://www.linuxtricks.fr/wiki/fwupd-mettre-a-jour-les-firmwares-et-uefi-depuis-linux)

```bash
sudo dnf install -y fwupd
```

# CUSTOMIZATION GNOME
```bash
echo "Configuration générale de GNOME"
echo " - Boutons de fenêtre"
gsettings set org.gnome.desktop.wm.preferences button-layout ":minimize,maximize,close"
echo " - Suramplification"
gsettings set org.gnome.desktop.sound allow-volume-above-100-percent true
echo " - Détacher les popups des fenêtres"
gsettings set org.gnome.mutter attach-modal-dialogs false
echo " - Affichage du calendrier dans le panneau supérieur"
gsettings set org.gnome.desktop.calendar show-weekdate true
echo " - Modification du format de la date et heure"
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface clock-show-seconds true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-format 24h
#echo " - Localisation du pointeur via CTRL"
#gsettings set org.gnome.desktop.interface locate-pointer true #BUG de FOCUS avec GIMP
echo " - Paramétrage Touch Pad"
gsettings set org.gnome.desktop.peripherals.touchpad disable-while-typing true
gsettings set org.gnome.desktop.peripherals.touchpad click-method "areas"
echo " - Désactivation des sons système"
gsettings set org.gnome.desktop.wm.preferences audible-bell false
echo " - Activation du mode nuit"
gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
echo " - Epuration des fichiers temporaires et de la corbeille de plus de 30 jours"
gsettings set org.gnome.desktop.privacy remove-old-temp-files true
gsettings set org.gnome.desktop.privacy remove-old-trash-files true
gsettings set org.gnome.desktop.privacy old-files-age "30"

echo "Confidentialité de GNOME"
echo " - Désactivation de l'envoi des rapports"
gsettings set org.gnome.desktop.privacy report-technical-problems false
echo " - Désactivation des statistiques des logiciels"
gsettings set org.gnome.desktop.privacy send-software-usage-stats false

echo "Personnalisation de GNOME"
echo " - Application du thème sombre"
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'adw-gtk3-dark'

echo "Configuration Nautilus"
echo " - Désactivation de l ouverture du dossier lorsqu un élément est glissé dedans"
gsettings set org.gnome.nautilus.preferences open-folder-on-dnd-hover false
echo " - Activation du double clic"
gsettings set org.gnome.nautilus.preferences click-policy 'double'
echo " - Modification de l ordre de tri"
gsettings set org.gtk.Settings.FileChooser sort-directories-first true
gsettings set org.gtk.gtk4.Settings.FileChooser sort-directories-first true

echo "Configuration de GNOME Logiciels"
echo " - Désactivation du téléchargement automatique des mises à jour"
gsettings set org.gnome.software download-updates false
echo " - Activation de l'affichage des logiciels propriétaires"
gsettings set org.gnome.software show-only-free-apps false
#echo " - Autorisation de la mise à niveau vers des versions BETA"
#gsettings set org.gnome.software show-upgrade-prerelease false

echo "Configuration de GNOME Text Editor"
gsettings set org.gnome.TextEditor highlight-current-line false
gsettings set org.gnome.TextEditor restore-session false
gsettings set org.gnome.TextEditor show-line-numbers true

# echo "Configuration de GNOME Web"
# gsettings set org.gnome.Epiphany ask-for-default false
# gsettings set org.gnome.Epiphany homepage-url 'about:blank'
# gsettings set org.gnome.Epiphany start-in-incognito-mode true


# echo "Personnalisation de Dash-to-dock"
# echo " - Activation de l'extension"
# gnome-shell-extension-tool -e dash-to-dock@micxgx.gmail.com
# echo " - Placement en bas, fixé et masquage intelligent"
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-position "BOTTOM"
# gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed false
# gsettings set org.gnome.shell.extensions.dash-to-dock autohide-in-fullscreen true 
# echo " - Correction du bug de la double lettre"
# gsettings set org.gnome.shell.extensions.dash-to-dock disable-overview-on-startup true

# echo "Activation de Appindicator"
# gnome-shell-extension-tool -e appindicatorsupport@rgcjonas.gmail.com

echo "Personnalisation terminée."

# gsettings --schemadir ~/.local/share/gnome-shell/extensions/dash-to-dock@micxgx.gmail.com/schemas/ set org.gnome.shell.extensions.dash-to-dock show-trash false
```

## ZSH
### INSTALLATION DE ZSH

```bash
sudo dnf install -y zsh
```
Définir zsh par défaut :
```bash
chsh -s $(which zsh)
```
### INSTALLATION DE OHMYZSH
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
### Plugin Zsh indispensable
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
# edit .zshrc to include plugins plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

### Installation du thème Powerlevel 10k
```bash
wget https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/FiraMono/Regular/FiraMonoNerdFont-Regular.otf
mkdir -p /home/allfab/.local/share/fonts
cp -f FiraMonoNerdFont-Regular.otf /home/allfab/.local/share/fonts
sudo mkdir -p /root/.local/share/fonts
sudo cp -f FiraMonoNerdFont-Regular.otf /root/.local/share/fonts
```

```bash
sudo dnf install -t fontawesome-fonts-all
git clone https://github.com/romkatv/powerlevel10k.git $ZSH_CUSTOM/themes/powerlevel10k
p10k configure
# edit .zshrc
ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_MODE="nerdfont-complete"
```