#!/bin/bash

set -ouex pipefail

### Install required COPR Repositories
dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable varlad/yazi

### Install third-party repositories
dnf5 -y install --nogpgcheck --repofrompath 'terra,https://repos.fyralabs.com/terra$releasever' terra-release
dnf5 -y install --nogpgcheck --repofrompath 'charm,https://repo.charm.sh/yum/' charm

### Install packages
echo "Installing core libraries" && dnf install -y gum tmux jq cargo gtk4-devel python3-pip

## Some patches to make the build-files operate normally.
mkdir -p /etc/skel/.config
mkdir /tmp/.cargo
export CARGO_HOME="/tmp/.cargo"

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
echo "Installing Hyprland" && dnf install -y hyprland hyprland-plugins hyprland-contrib hyprpaper hyprsunset xdg-desktop-portal-hyprland hyprlock hypridle hyprpolkitagent hyprsysteminfo
echo "Installing Common Components" && dnf install -y astral aylurs-gtk-shell rofi waypaper swww cliphist nwg-look qt6ct nwg-dock-hyprland xdg-desktop-portal-gtk wlogout waybar nautilus
echo "Installing Display Manager Backend" && dnf install -y greetd
echo "Installing Fonts" && dnf install -y fira-code-fonts
echo "Installing Misc Packages" && dnf install -y bibata-cursor-theme ghostty adw-gtk3-theme yazi neovim eza fastfetch figlet sox

## Regreet copr is inactive and there is no native RPM for Regreet, it will be manually build & installed instead.
source /build/regreet.sh

## ML4W provides a installation script but is not conventional in build process, extraction will be done instead.
source /build/ml4w-dotfiles.sh

# this would install a package from rpmfusion
# rpm-ostree install vlc

## Immutable systems installed on hardware/vms do not see greeter added, a different method must be used.

echo "Finishing Up"

# Apply & Replace greetd configuration
mkdir /usr/share/greetd
cp /etc/greetd/config.toml /usr/share/greetd/default-config.toml
rm -rf /etc/greetd/config.toml

## This pulls from the login configuration.
cp /template/config/greetd.toml /etc/greetd/greetd.toml
cp /template/config/hyprland-login.conf /etc/greetd/hyprland.conf
cp /template/config/regreet.toml /etc/greetd/regreet.toml

# Apply global scripts
mkdir -p /usr/share/hyperbola/
mkdir -p /usr/share/hyperbola/scripts/
mkdir -p /usr/share/hyperbola/wallpapers/
cp -r /template/scripts/* /usr/share/hyperbola/scripts/
chmod +x /usr/share/hyperbola/scripts/*.sh

### UNAVAILABLE FOR NOW - Plymouth is not properly loaded in with the current plymouth setup.
# Setting up plymouth theme
#rm -rf /usr/share/plymouth/themes/bgrt/bgrt.plymouth
#cp -r /tmp/hyperbola-custom-plymouth/* /usr/share/plymouth/themes/bgrt/
#rpm-ostree initramfs --enable

#### Example for enabling a System Unit File
systemctl enable greetd.service
systemctl enable podman.socket

#### Post-build service patches
cp -r /template/config/services/* /usr/lib/systemd/system/
systemctl enable greetd-workaround.service

#### Post-build COPR Repos
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable varlad/yazi

#### Post-build design
cp -r /design/wallpapers/* /usr/share/hyperbola/wallpapers/

#### Post-build cleanup
rm -rf /build/
rm -rf /template/
rm -rf /design/
