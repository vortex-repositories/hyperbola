#!/bin/bash
### This holds the script that sets up ML4W dotfiles into Hyperbola.

echo "Installing ML4W Python Dependencies"

pip3 install --prefix=/usr --root-user-action=ignore pywal
pip install --prefix=/usr --root-user-action=ignore pywalfox
pip3 install --prefix=/usr --root-user-action=ignore screeninfo
pywalfox install
pip install --prefix=/usr --root-user-action=ignore hyprshade

#ln -s /usr/bin/pywal /usr/lib/python3.13/site-packages/pywal/pywal
#ln -s /usr/bin/pywalfox /usr/lib/python3.13/site-packages/pywalfox
#ln -s /usr/bin/screeninfo /usr/lib/python3.13/site-packages/screeninfo/screeninfo
#ln -s /usr/bin/hyprshade /usr/lib/python3.13/site-packages/hyprshade

echo "Adding oh-my-posh to local binaries..."
wget https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/posh-linux-amd64 -O /usr/bin/oh-my-posh
chmod +x /usr/bin/oh-my-posh

echo "Preparing to setup ML4W Dotfiles..."
mkdir /tmp/ml4w/
mkdir /tmp/ml4w/repository
wget -q 'https://api.github.com/repos/mylinuxforwork/dotfiles/releases/latest' -O '/tmp/ml4w/release-metadata'

ml4w_metadata=$(cat /tmp/ml4w/release-metadata)
ml4w_version=$(echo "$ml4w_metadata" | jq '.tag_name' | tr -d '"')
wget "https://api.github.com/repos/mylinuxforwork/dotfiles/tarball/$ml4w_version" -O '/tmp/ml4w/repository.tar.gz'
tar -xvf /tmp/ml4w/repository.tar.gz -C /tmp/ml4w/repository --strip-components=1
cd /tmp/ml4w/repository
echo "Setting Up ML4W Dotfiles"

# Copy the dotfiles
cp -r share/dotfiles/.config/* /etc/skel/.config/
cp share/dotfiles/.Xresources /etc/skel/.Xresources
cp share/dotfiles/.bashrc /etc/skel/.bashrc
cp share/dotfiles/.zshrc /etc/skel/.zshrc
cp share/dotfiles/.gtkrc-2.0 /etc/skel/.gtkrc-2.0

# for wal to work, we should make a wallpapers example with the distro wallpapers symlinked
mkdir /etc/skel/Wallpapers/
ln -s /usr/share/hyperbola/wallpapers/main.png /etc/skel/Wallpapers/default.jpg

# Copy the preferred font by the dotfiles
cp -r share/fonts/FiraCode/* /usr/share/fonts

curl -s https://raw.githubusercontent.com/mylinuxforwork/packages-installer/main/setup.sh | bash -s -- -y -p flatpak -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles-calendar/master/com.ml4w.calendar.pkginst com.ml4w.calendar
curl -s https://raw.githubusercontent.com/mylinuxforwork/packages-installer/main/setup.sh | bash -s -- -y -p flatpak -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles-sidebar/master/com.ml4w.sidebar.pkginst com.ml4w.sidebar
curl -s https://raw.githubusercontent.com/mylinuxforwork/packages-installer/main/setup.sh | bash -s -- -y -p flatpak -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles-settings/master/com.ml4w.settings.pkginst com.ml4w.settings
curl -s https://raw.githubusercontent.com/mylinuxforwork/packages-installer/main/setup.sh | bash -s -- -y -p flatpak -s https://raw.githubusercontent.com/mylinuxforwork/dotfiles-welcome/master/com.ml4w.welcome.pkginst com.ml4w.welcome
curl -s https://raw.githubusercontent.com/mylinuxforwork/packages-installer/main/setup.sh | bash -s -- -y -p flatpak -s https://raw.githubusercontent.com/mylinuxforwork/hyprland-settings/master/com.ml4w.hyprlandsettings.pkginst com.ml4w.hyprlandsettings

# Installing the ML4W Apps
#app_name="com.ml4w.welcome"
#cp share/apps/$app_name.desktop /usr/share/applications
#cp share/apps/$app_name.png /usr/share/icons/hicolor/128x128/apps
#cp share/apps/$app_name /usr/bin/$app_name

#app_name="com.ml4w.dotfilessettings"
#cp share/apps/$app_name.desktop /usr/share/applications
#cp share/apps/$app_name.png /usr/share/icons/hicolor/128x128/apps
#cp share/apps/$app_name /usr/bin/$app_name

#app_name="com.ml4w.hyprland.settings"
#cp share/apps/$app_name.desktop /usr/share/applications
#cp share/apps/$app_name.png /usr/share/icons/hicolor/128x128/apps
#cp share/apps/$app_name /usr/bin/$app_name

cd /
