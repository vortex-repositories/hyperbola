#!/bin/bash

set -ouex pipefail

### Install required COPR Repositories
dnf5 -y copr enable solopasha/hyprland
dnf5 -y copr enable varlad/yazi

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
echo "Installing Misc Packages" && dnf install -y bibata-cursor-theme ghostty adw-gtk3-theme zsh yazi neovim

## Regreet copr is inactive and there is no native RPM for Regreet, it will be manually build & installed instead.
source /tmp/build/regreet.sh

## ML4W provides a installation script but is not conventional in build process, extraction will be done instead.
source /tmp/build/ml4w-dotfiles.sh

# this would install a package from rpmfusion
# rpm-ostree install vlc

## Immutable systems installed on hardware/vms do not see greeter added, a different method must be used.
# Create the greeter system user for greetd
#useradd -M -N greeter
## Instead try to manually add to /usr/etc/passwd
#grep -E '^greetd:' /usr/etc/passwd | tee -a /etc/passwd
#grep -E '^greetd:' /usr/etc/group | tee -a /etc/group
## this does not work either because build process will error as in the process, it doesn't exist.
### In both podman and VM/Bare Metal, greetd is not found in /etc/shadow, Try to add it manually..
#echo 'greetd:!:::::::' >> /etc/shadow
## it gets added to /usr/etc/shadow, we do not know a easier way to move this to base /etc/shadow everytime.

echo "Finishing Up"

# Apply & Replace greetd configuration
mkdir /usr/share/greetd
cp /etc/greetd/config.toml /usr/share/greetd/default-config.toml
rm -rf /etc/greetd/config.toml

cp /tmp/config.toml /etc/greetd/
cp /tmp/hyprland.conf /etc/greetd/
cp /tmp/regreet.toml /etc/greetd/

#source dotfile-installation
chmod +x /usr/share/hyperbola/scripts/*.sh

#### Example for enabling a System Unit File
systemctl enable greetd.service
systemctl enable podman.socket

#### Post-build service patches
systemctl enable greetd-workaround.service

#### Post-build COPR Repos
dnf5 -y copr disable solopasha/hyprland
dnf5 -y copr disable varlad/yazi
