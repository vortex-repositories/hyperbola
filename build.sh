#!/bin/bash

set -ouex pipefail

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# Copr Repos containing the necessary packages for this custom image.
copr enable solopasha/hyprland

# this installs a package from fedora repos
dnf install -y tmux
dnf install -y hyprland
dnf install -y hyprland-plugins
dnf install -y hyprland-contrib
dnf install -y hyprpaper
dnf install -y hyprsunset
dnf install -y xdg-desktop-portal-hyprland
dnf install -y hyprlock
dnf install -y hypridle
dnf install -y hyprpolkitagent
dnf install -y hyprsysteminfo
dnf install -y waybar
dnf install -y rofi
dnf install -y waypaper
dnf install -y swww

# this would install a package from rpmfusion
# rpm-ostree install vlc

#### Example for enabling a System Unit File

systemctl enable podman.socket
