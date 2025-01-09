#!/bin/bash

set -ouex pipefail

### Install packages

echo "Installing core libraries" && dnf install -y gum tmux

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
echo "Installing Hyprland" && dnf install -y hyprland hyprland-plugins hyprland-contrib hyprpaper hyprsunset xdg-desktop-portal-hyprland hyprlock hypridle hyprpolkitagent hyprsysteminfo
echo "Installing Common Components" && dnf install -y waybar rofi waypaper swww
echo "Installing Display Manager" && dnf install -y greetd gtkgreet

# this would install a package from rpmfusion
# rpm-ostree install vlc

## Immutable systems installed on hardware/vms do not see greeter added, a different method must be used.
# Create the greeter system user for greetd
#useradd -M -N greeter
## Instead try to manually add to /usr/etc/passwd
#grep -E '^greetd:' /usr/etc/passwd | tee -a /etc/passwd
#grep -E '^greetd:' /usr/etc/group | tee -a /etc/group
## this does not work either because build process will error, because it doesn't exist.

# Apply & Replace greetd configuration
mkdir /usr/share/greetd
cp /etc/greetd/config.toml /usr/share/greetd/default-config.toml
rm -rf /etc/greetd/config.toml

cp /tmp/config.toml /etc/greetd/
cp /tmp/hyprland.conf /etc/greetd/

#source dotfile-installation

#### Example for enabling a System Unit File
systemctl enable greetd.service
systemctl enable podman.socket
