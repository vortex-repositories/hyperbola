# Allow build scripts to be referenced without being copied into the final image
FROM scratch AS ctx

#COPY build.sh /tmp/build.sh
COPY build-files/* /build/
#COPY pywal-template/* /etc/skel/.cache/wal/
COPY pywal-template/* /template/pywal/
#COPY repos/* /etc/yum.repos.d/
COPY repos/* /template/repos/
#COPY config/default/* /etc/skel/.config/
#COPY config/system/scripts/* /usr/share/hyperbola/scripts/
COPY config/system/scripts/* /template/scripts/
#COPY assets/wallpapers/* /usr/share/hyperbola/wallpapers/
COPY assets/wallpapers/* /design/wallpapers/
#COPY assets/plymouth/* /tmp/hyperbola-custom-plymouth/
COPY assets/plymouth/* /design/boot/
#COPY config/system/services/* /usr/lib/systemd/system/

#COPY config/login/regreet.toml /tmp/regreet.toml
#COPY config/login/greetd.toml /tmp/config.toml
#COPY config/login/hyprland.conf /tmp/hyprland.conf
COPY config/* /config/

# Base Image
FROM ghcr.io/ublue-os/base-main:latest@sha256:5a10a90547b7301c332d96426d07da5cae12400e9a33bcb191e64f322cdf6c72

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



RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    /ctx/build/init.sh  && \
    ostree container commit

### LINTING
## Verify final image and contents are correct.
RUN bootc container lint
