FROM ghcr.io/ublue-os/base-main:latest

## Other possible base images include:
# FROM ghcr.io/ublue-os/bazzite:stable
# FROM ghcr.io/ublue-os/bluefin-nvidia:stable
#
# ... and so on, here are more base images
# Universal Blue Images: https://github.com/orgs/ublue-os/packages
# Fedora base image: quay.io/fedora/fedora-bootc:41
# CentOS base images: quay.io/centos-bootc/centos-bootc:stream10

### MODIFICATIONS
## make modifications desired in your image and install packages by modifying the build.sh script
## the following RUN directive does all the things required to run "build.sh" as recommended.

#COPY build.sh /tmp/build.sh
COPY build-files/* /tmp/build/
COPY pywal-template/* /etc/skel/.cache/wal/
COPY repos/* /etc/yum.repos.d/
#COPY config/default/* /etc/skel/.config/
COPY config/system/scripts/* /usr/share/hyperbola/scripts/
COPY assets/wallpapers/* /usr/share/hyperbola/wallpapers/
COPY assets/plymouth/* /tmp/hyperbola-custom-plymouth/
COPY config/system/services/* /usr/lib/systemd/system/

COPY config/login/regreet.toml /tmp/regreet.toml
COPY config/login/greetd.toml /tmp/config.toml
COPY config/login/hyprland.conf /tmp/hyprland.conf

RUN mkdir -p /var/lib/alternatives && \
    /tmp/build/init.sh && \
    ostree container commit && \
    bootc container lint
