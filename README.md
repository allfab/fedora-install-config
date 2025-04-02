# INSTALLATION DE FEDORA 42

Documentation sur l'installation et la configuration de Fedora 42 avec un environement de bureau Gnome à partir d'une installation de [**Fedora Server 42**](https://fedoraproject.org/fr/server/download) : [Fedora-Server-netinst-x86_64-42_Beta-1.4.iso](https://download.fedoraproject.org/pub/fedora/linux/releases/test/42_Beta/Server/x86_64/iso/Fedora-Server-netinst-x86_64-42_Beta-1.4.iso)

## Téléchargement

Télécharger l'ISO Minimal sur [le site de Fedora](https://fedoraproject.org/fr/server/download) :

- [`Fedora-Server-netinst-x86_64-42_Beta-1.4.iso`](https://download.fedoraproject.org/pub/fedora/linux/releases/test/42_Beta/Server/x86_64/iso/Fedora-Server-netinst-x86_64-42_Beta-1.4.iso)

Pour confectionner le support d'installation, on utilisera un système Linux
existant. 

Insérer et identifier la clé USB :

```
# lsblk
```

Écrire le fichier ISO sur la clé USB :

```
# dd status=progress if=Fedora-Server-netinst-x86_64-42_Beta-1.4.iso of=/dev/sdX
```

> Attention à ne pas vous tromper de fichier de périphérique `/dev/sdX`!


## Réinitialiser le disque

Démarrer sur la clé en choisissant l'option `Rescue a Fedora System` via `Troubleshooting` :

![Troubleshooting](./assets/images/boot-01.png)
![Rescue a Fedora System](./assets/images/boot-02.png)

Opter pour l'option `3) Skip to shell` et confirmer.
![3) Skip to shell](./assets/images/boot-03.png)

Passer du clavier QWERTY à un clavier AZERTY :
```
# loadkeys fr-latin1
```

Pour réinitialiser le disque, lancez `gdisk` et utilisez successivement les
options `x` et `z`.


## Partitionnement

Identifiez le disque à partitionner :

```
# lsblk
```

Exemple avec BIOS/MBR (`fdisk`) :

```
  Device     Boot    Start       End   Sectors  Size Id Type
  /dev/sda1  *        2048   2099199   2097152    1G 83 Linux
  /dev/sda2        2099200  10487807   8388608    4G 82 Linux swap
  /dev/sda3       10487808 117231407 106743600 50.9G 83 Linux
```

Exemple avec BIOS/GPT (`gdisk`) :

```
  Device        Start       End   Sectors  Size Type
  /dev/sda1      2048      4095      2048    1M BIOS boot
  /dev/sda2      4096   2101247   2097152    1G Linux filesystem
  /dev/sda3   2101248  10489855   8388608    4G Linux swap
  /dev/sda4  10489856 117229567 106739712 50.9G Linux filesystem
```

Exemple avec UEFI/GPT (`gdisk`) :

```
  Device        Start       End   Sectors  Size Type
  /dev/sda1      2048    206847    204800  100M EFI System
  /dev/sda2    206848   2303999   2097152    1G Linux filesystem
  /dev/sda3   2304000  10692607   8388608    4G Linux swap
  /dev/sda4  10692608 117229567 106536960 50.8G Linux filesystem
```

```
Number  Start (sector)    End (sector)  Size       Code  Name
   1            2048         1230847   600.0 MiB   EF00  EFI System Partition
   2         1230848         3327999   1024.0 MiB  EA00  
   3         3328000      1953523711   929.9 GiB   8304
```

| Type de partition     | Point de montage | Code `gdisk`  |
|-----------------------|------------------|---------------|
| Linux filesystem      | Tout             | `8300`        |
| EFI system partition  | Tout             | `ef00`        |
| BIOS boot partition   | Aucun            | `ef02`        |
| XBOOTLDR partition    | Tout             | `ea00`        |
| Linux x86-64 root (/) | /                | `8304`        |
| Linux swap            | [SWAP]           | `8200`        |
| Linux /home           | /home            | `8302`        |
| Linux /srv            | /srv             | `8306`        |
| Linux /var            | /var             | `8310`        |
| Linux /var/tmp        | /var/tmp         | `8311`        |
| Linux LVM             | Tout             | `8e00`        |
| Linux RAID            | Tout             | `fd00`        |
| Linux LUKS            | Tout             | `8309`        |
| Linux dm-crypt        | Tout             | `8308`        |

---

> Idéalement, créez une partition `swap` égale à la quantité de RAM disponible
> sur votre machine. Utilisez la commande `free -m` pour en savoir plus.

> **Swap sur ZRAM** :
> Fedora n'utilise pas de partition d'échange dédiée. Au lieu de cela, il utilise zram : un lecteur émulé qui utilise la RAM pour son stockage. L'échange basé sur la RAM est plus rapide que l'échange basé sur le disque, ce qui évite le ralentissement extrême du système et les perturbations qui peuvent survenir avec une partition d'échange traditionnelle.
> 
> Le lecteur zram est compressé pour utiliser efficacement la mémoire disponible et se voit attribuer de la mémoire de manière dynamique, ce qui signifie qu'il n'utilise la RAM système que lorsqu'un échange est nécessaire.

## Installation

- Démarrez sur le support d'installation.

- Sélectionnez la langue et le clavier.

- Optez pour le partitionnement manuel et formatez les partitions que vous
  venez de faire. Pour les étiquettes (*labels*) vous pouvez choisir `EFI`,
  `boot`, `swap` et `root`.

- Activez le réseau et vérifiez si vous obtenez bien une adresse IP. 

- Choisissez un nom d'hôte en remplacement de `localhost.localdomain`.

- Configurez le fuseau horaire.

- Désactivez Kdump (mécanisme de capture de plantage du noyau).

- Dans la sélection des paquets, optez pour **Installation minimale**.

- Définissez le mot de passe `root`.

- Créez un utilisateur normal, par exemple `allfab`.

- Cochez la case **Faire de cet utilisateur un administrateur**. L’utilisateur
  sera ajouté au groupe `wheel` et pourra se servir de la commande `sudo`.

- Lancez l'installation.


## Mise à jour

Au terme de l'installation, connectez-vous en tant que `root` et effectuez la
mise à jour initiale :

```
# dnf update -y
```

Redémarrez :

```
# reboot
```

## Installation de l'environnement graphique

Découverte des différents environnements de bureau disponible :
```bash
dnf group list --hidden | grep -i desktop
Mise à jour et chargement des dépôts :
Dépôts chargés.
basic-desktop                Basic Desktop                                      no
budgie-desktop               Budgie                                             no
budgie-desktop-apps          Budgie Desktop Applications                        no
cinnamon-desktop             Cinnamon                                           no
cosmic-desktop               COSMIC Desktop                                     no
cosmic-desktop-apps          COSMIC Desktop Supplementary Applications          no
critical-path-deepin-desktop Critical Path (Deepin desktop)                     no
deepin-desktop               Deepin Desktop Environment                         no
deepin-desktop-apps          Deepin Desktop Applications                        no
deepin-desktop-media         Media packages for Deepin Desktop                  no
deepin-desktop-office        Deepin Desktop Office                              no
desktop-accessibility        Desktop accessibility                              no
enlightenment-desktop        Enlightenment                                      no
gnome-desktop                GNOME                                              no
gnome-games                  Extra games for the GNOME Desktop                  no
guest-desktop-agents         Guest Desktop Agents                               no
kde-desktop                  KDE                                                no
lxde-apps                    Applications for the LXDE Desktop                  no
lxde-desktop                 LXDE                                               no
lxqt-apps                    Applications for the LXQt Desktop                  no
lxqt-desktop                 LXQt                                               no
mate-desktop                 MATE                                               no
miraclewm-desktop            Miracle Window Manager Desktop                     no
phosh-desktop                A phone/tablet UX environment                      no
sugar-desktop                Sugar Desktop Environment                          no
xfce-apps                    Applications for the Xfce Desktop                  no
xfce-desktop                 Xfce                                               no
```

### Information sur le groupe de packages :
```bash
dnf group info gnome-desktop
```
ou
```bash
dnf group info "GNOME"
```

### Installation de GNOME

Installer les groupes :
```bash
sudo dnf install @base-x @gnome-desktop
```

Ou en choississant ces paquets :
```bash
sudo dnf install \
    @base-x \
    @core \
    @guest-desktop-agents \
    @hardware-support \
    @multimedia \
    @networkmanager-submodules \
    @standard \
    dconf \
    gdm \
    gnome-boxes \
    gnome-connections \
    gnome-control-center \
    gnome-initial-setup \
    gnome-session-wayland-session \
    gnome-settings-daemon \
    gnome-shell \
    gnome-software \
    gnome-text-editor \
    nautilus \
    polkit \
    ptyxis \
    yelp \
    ModemManager \
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
    adobe-source-code-pro-fonts \
    avahi \
    baobab \
    evince \
    evince-djvu \
    fprintd-pam \
    glib-networking \
    gnome-backgrounds \
    gnome-bluetooth \
    gnome-browser-connector \
    gnome-calculator \
    gnome-calendar \
    gnome-characters \
    gnome-classic-session \
    gnome-clocks \
    gnome-color-managerv
    gnome-contacts \
    gnome-disk-utility \
    gnome-epub-thumbnailer \
    gnome-font-viewer \
    gnome-logs \
    gnome-maps \
    gnome-remote-desktop \
    gnome-system-monitor \
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
    localsearch \
    loupe \
    mesa-dri-drivers \
    mesa-libEGL \
    rygel \
    sane-backends-drivers-scanners \
    simple-scan \
    snapshot \
    sushi \
    systemd-oomd-defaults \
    tinysparql \
    totem \
    xdg-desktop-portal \
    xdg-desktop-portal-gnome \
    xdg-desktop-portal-gtk \
    xdg-user-dirs-gtk
```

## Configuration de base

Installez Git :

```
# dnf install -y git
```

Récupérez les fichiers de cet atelier pratique dans `/home/allfab` :

```
# cd /home/allfab
# git clone https://github.com/allfab/fedora-install-config.git
# cd fedora-install-config
```

## Personnaliser le shell Bash

Installer le fichier `.bashrc` pour `root` .

```
# cp -vf bash/bashrc-root /root/.bashrc
```

Installer le fichier `.bashrc` pour l'utilisateur initial (`allfab` dans
l'exemple) :

```
# cp -vf bash/bashrc-user /home/allfab/.bashrc
# chown allfab:allfab /home/allfab/.bashrc
```

Installer le fichier `.bashrc` pour les futurs utilisateurs :

```
# cp -vf bash/bashrc-user /etc/skel/.bashrc
```

## Personnaliser l'éditeur Vim

Installer le fichier `.vimrc` pour `root` .

```
# cp -vf vim/vimrc /root/.vimrc
```

Installer le fichier `.vimrc` pour l'utilisateur initial (`allfab` dans
l'exemple) :

```
# cp -vf vim/vimrc /home/allfab/.vimrc
# chown allfab:allfab /home/allfab/.vimrc
```

Installer le fichier `.vimrc` pour les futurs utilisateurs :

```
# cp -vf vim/vimrc /etc/skel/.vimrc
```

## Configurer le dépôt de paquets EPEL

Le dépôt de paquets tiers EPEL (*Extra Packages for Enterprise Linux*) fournit
un grand nombre de paquets logiciels qui ne sont pas officiellement inclus dans
RHEL et ses clones.

Activer le dépôt EPEL :

```
# dnf install -y epel-release
```

Ce dépôt nécessite l'activation du dépôt CRB (*Code Ready Builder*) :

```
# /usr/bin/crb enable
```

Afficher la liste des dépôts configurés :

```
# dnf repolist
```


## Configurer le dépôt de paquets ELRepo

Le dépôt de paquets tiers ELRepo (*Enterprise Linux Repository*) fournit
surtout des kernels plus récents et toute une série de pilotes (ou *drivers*)
pour RHEL et ses clones.

Activer le dépôt ELRepo :

```
# dnf install -y elrepo-release
```

Afficher la liste des dépôts configurés :

```
# dnf repolist
```

## Configurer les dépôts de paquets RPMFusion

Les quatre dépôts RPMFusion fournissent des paquets potentiellement
problématiques en termes de licence (multimédia, paquets propriétaires, etc.)

Activer le dépôt RPMFusion Free : 

```
# dnf install --nogpgcheck \
  https://mirrors.rpmfusion.org/free/el/rpmfusion-free-release-9.noarch.rpm
```

Activer le dépôt RPMFusion Nonfree : 

```
# dnf install --nogpgcheck \
  https://mirrors.rpmfusion.org/nonfree/el/rpmfusion-nonfree-release-9.noarch.rpm
```

Activer le dépôt RPMFusion Free Tainted :

```
# dnf install -y rpmfusion-free-release-tainted
```

Activer le dépôt RPMFusion Nonfree Tainted:

```
# dnf install -y rpmfusion-nonfree-release-tainted
```

Afficher la liste des dépôts configurés :

```
# dnf repolist
```

## Configurer le dépôt de paquets Google Chrome

Éditer un fichier `/etc/yum.repos.d/google-chrome.repo` comme ceci :

```
[chrome]
name=Chrome
baseurl=http://dl.google.com/linux/chrome/rpm/stable/x86_64
enabled=1
priority=10
gpgcheck=1
gpgkey=https://dl.google.com/linux/linux_signing_key.pub
```

Si tout se passe bien, une recherche sur `chrome` doit afficher quelque chose
comme ceci :

```
# dnf search chrome
...
google-chrome-beta.x86_64 : Google Chrome (beta)
google-chrome-canary.x86_64 : Google Chrome (canary)
google-chrome-stable.x86_64 : Google Chrome
google-chrome-unstable.x86_64 : Google Chrome (unstable)
```


## Installer GNOME

Dans un premier temps, installer le paquet `ffmpeg` en provenance de RPMFusion.
Ce paquet est une dépendance de KDE sous le capot, et de cette manière on est
sûr de gérer correctement tous les formats audio et vidéo.

``` 
# dnf install -y ffmpeg 
``` 

Partant de là, on peut installer le groupe de paquets pour KDE :

``` 
# dnf group install "KDE (K Desktop Environment)"
``` 

Démarrer en mode graphique par défaut :

```
# systemctl set-default graphical.target
```

## Franciser le système

Il se peut que le système n'utilise pas la bonne locale :

```
# localectl status
System Locale: LANG=C.UTF-8
    VC Keymap: ch-fr
   X11 Layout: ch
  X11 Variant: fr
```

Dans ce cas, on peut définir la langue française par défaut pour le système :

```
# localectl set-locale LANG=fr_FR.UTF-8
```

Vérifier si tout s'est bien passé :

```
# localectl status
System Locale: LANG=fr_FR.UTF-8
    VC Keymap: ch-fr
   X11 Layout: ch
  X11 Variant: fr
```

## Configuration initiale de GNOME

Dans les Paramètres de KDE, ouvrir la section **Gestion de l'énergie** et
désactiver tout ce qui ressemble à de la mise en veille.

Faire une recherche sur `background` et `wallpaper` pour trouver une collection
de fonds d'écran :

```
# dnf search background
# dnf search wallpaper
```

## Applications Internet

- Mozilla Firefox : `firefox`

- Google Chrome : `google-chrome-stable`

- Mozilla Thunderbird : `thunderbird`

- Filezilla : `filezilla`

- Client BitTorrent : `transmission`

- Client IRC : `hexchat`

- Client VNC : `krdc`


## Applications Bureautique

- LibreOffice :

  * `libreoffice`

  * `libreoffice-langpack-fr`

  * `libreoffice-help-fr`


## Applications Graphisme

- Digikam : `digikam`

- GIMP : `gimp`

- Inkscape : `inkscape`

- Scribus : `scribus`

- Simple Scan : `simple-scan`


## Applications Multimedia

- Audacious : 

  * `audacious`

  * `audacious-plugins-freeworld`

- Audacity : `audacity`

- VLC : `vlc`

- MPlayer : `mplayer`

- DVDCSS : `libdvdcss`

- Openshot : `openshot`

- Kdenlive : `kdenlive`


## Applications Utilitaires

- Ark : `ark`

- KeePassXC : `keepassxc`


## AnyDesk

Éditer un fichier `/etc/yum.repos.d/anydesk.repo` :

```
[anydesk]
name=AnyDesk
enabled=1
baseurl=http://rpm.anydesk.com/rhel/$basearch/
gpgcheck=1
gpgkey=https://keys.anydesk.com/repos/RPM-GPG-KEY
```

Installer AnyDesk :

```
# dnf install -y anydesk
```
