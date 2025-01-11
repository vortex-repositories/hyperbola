#!/bin/bash

set -ouex pipefail

### Install packages
echo "Installing core libraries" && dnf install -y gum tmux jq cargo gtk4-devel

## Need to move .cargo to /tmp/ to prevent errors.
mkdir /tmp/.cargo
export CARGO_HOME="/tmp/.cargo"

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
echo "Installing Hyprland" && dnf install -y hyprland hyprland-plugins hyprland-contrib hyprpaper hyprsunset xdg-desktop-portal-hyprland hyprlock hypridle hyprpolkitagent hyprsysteminfo
echo "Installing Common Components" && dnf install -y waybar rofi waypaper swww
echo "Installing Display Manager Backend" && dnf install -y greetd
echo "Installing Misc Packages" && dnf install -y bibata-cursor-theme ghostty adw-gtk3-theme
#echo "Installing Display Manager" && dnf install -y gtkgreet

## Regreet copr is inactive and there is no native RPM for Regreet, it will be manually build & installed instead.
echo "Preparing to build Display Manager..."
mkdir /tmp/regreet/
mkdir /tmp/regreet/repository
wget -q 'https://api.github.com/repos/rharish101/ReGreet/releases/latest' -O '/tmp/regreet/release-metadata'

regreet_metadata=$(cat /tmp/regreet/release-metadata)
regreet_version=$(echo "$regreet_metadata" | jq '.name' | tr -d '"')
regreet_tarball=$(echo "$regreet_metadata" | jq '.tarball_url')
wget "https://api.github.com/repos/rharish101/ReGreet/tarball/$regreet_version" -O '/tmp/regreet/repository.tar.gz'
tar -xvf /tmp/regreet/repository.tar.gz -C /tmp/regreet/repository --strip-components=1
cd /tmp/regreet/repository
echo "Building Display Manager"
cargo build -F gtk4_8 --release
echo "Installing Display Manager"
cp target/release/regreet /usr/bin
cd /

if command -v sway 2>&1 >/dev/null; then
    echo "Sway was accidentally installed, and since we cannot exclude gtkgreet, we delete sway related packages"
    rm -rf /usr/share/wayland-sessions/sway.desktop
    rm -rf /usr/bin/sway
    rm -rf /usr/bin/foot
    rm -rf /usr/bin/sway*
    rm -rf /usr/bin/foot*
fi

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
systemctl enable greetd-workaround.service
