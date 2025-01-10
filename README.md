# Vortex Hyperbola
[![Builds CI](https://github.com/vortex-repositories/hyperbola/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/vortex-repositories/hyperbola/actions/workflows/build.yml)
![](https://byob.yarr.is/vortex-repositories/hyperbola/build-timestamp)

A Atomic Desktop built from the ground for minimalism and ease of access. Building on top of Hyprland with individual shell components to give a complete experience.

> [!NOTE]
> The atomic desktop image(s) is currently work in progress, and is highly not recommended to run bare-metal at this time!
> If you wish to test the image(s) despite the unfinished state, consider rebasing in a VM with the following command:
> ```
> rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vortex-repositories/hyperbola:latest
> ```

## About
This immutable distribution is designed to remain on par with majority of the distribution base provided by Universal Blue with their distributions such as Bluefin, Bazzite, and Aurora;
while focusing on the hyprland ecosystem in a way to simplify and focus on what matters the most for users.
Additionally you are allowed to expand on this image for use of your own custom image to get the best experience of your use-case scenarios, like any other Universal Blue base images.

The core scope of this distribution is to be minimal as possible, while making use of the hyprland ecosystem and expand to be a desktop of its own for many users.
Most of the hyprland packages come from the COPR repositories to maintain up to date with upstream and include essential packages for the ecosystem.
On top of the core focus of minimalism and simplicity for users, the distribution also focuses on supporting common desktop systems including systems with NVIDIA hardware.

## Bugs & Problems
Any issues that occur such as bugs or crashes that are exclusive to this image can be reported via the issues section of the repository.
For issues specific to Hyprland, consult through the [upstream's wiki](https://wiki.hyprland.org/) for further support.
