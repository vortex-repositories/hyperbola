# Vortex Hyperbola
[![Builds CI](https://github.com/vortex-repositories/hyperbola/actions/workflows/build.yml/badge.svg?branch=main)](https://github.com/vortex-repositories/hyperbola/actions/workflows/build.yml)
![](https://byob.yarr.is/vortex-repositories/hyperbola/build-timestamp)

A Atomic Desktop built from the ground for minimalism and ease of access. Building on top of Hyprland with individual shell components to give a complete experience.

> [!NOTE]
> The atomic desktop image(s) is currently work in progress, and is highly not recommended to run bare-metal at this time!
> You are allowed to test the image(s) despite the unfinished state, but be wary of possible bugs/crashes produced from the image(s).

## About
This immutable distribution is designed to remain on par with majority of the distribution base provided by Universal Blue with their distributions such as Bluefin, Bazzite, and Aurora;
while focusing on the Hyprland ecosystem in a way to simplify and focus on what matters the most for users.
Additionally you are allowed to expand on this image for use of your own custom image to get the best experience of your use-case scenarios, like any other Universal Blue base images.

The core scope of this distribution is to be minimal as possible, while making use of the hyprland ecosystem and expand to be a desktop of its own for many users.
Most of the Hyprland packages come from the COPR repositories to maintain up to date with upstream and include essential packages for the ecosystem.
On top of the core focus of minimalism and simplicity for users, the distribution also focuses on supporting common desktop systems including systems with NVIDIA hardware.

## Nvidia
Currently Hyperbola plans to provide image(s) that includes Nvidia drivers (both open and propietary), however they are not available at this time.
In the future, Hyperbola will be able to provide image(s) with Nvidia drivers with the related changes to support the hardware for Nvidia users.

Hyprland does not directly support Nvidia hardware officially, but has been able to run without problems. For more information about Nvidia + Hyprland, see the following section: https://wiki.hyprland.org/Nvidia/

## Installation
There are 2 methods of which you can use Hyperbola on your system, each come with steps required for perfect experience.
The choice of how you install Hyperbola is up to you and depends on your existing system installation.

### Installing Hyperbola with Anaconda
Hyperbola provides 2 common ways you can install with the Anaconda Installer, in case one does not work then the other can be used instead.

You can download a pre-generated ISO from the [Github CI Artifacts](https://github.com/vortex-repositories/hyperbola/actions/workflows/build.yml) to install Hyperbola, a third party workflow action is used to generate the ISO completely after the image is built.
pre-generated ISOs take 10 or more minutes to generate before being uploaded, and may be cancelled when a new commit patch is implemented.
Pre-generated ISOs use the experimental Anaconda WebUI Installer for ease of use of installation, and may differ from other methods of installation.

Alternatively, you can clone the repository and run the following command to get a local copy of the Anaconda Installer ISO:
```
just build-iso
```
This is directly provided by the Universal Blue Image Templates that Hyperbola is built on top of, and is preferred if the above fails to work.
It is expected that ``just`` is installed on your system for this route to work.

### Rebasing to Hyperbola From A Existing Installation
If you are on a existing immutable system based on the fedora immutable system tree (rpm-ostree included), you are able to directly switch to Hyperbola without the steps above.

> [!NOTE]
> For secure boot systems, it is recommended to rebase into the unsigned image first and then rebase to the signed image.
> ```
> rpm-ostree rebase ostree-unverified-registry:ghcr.io/vortex-repositories/hyperbola:latest
> ```
> Make sure you reboot before rebasing to the signed image after rebasing to the unsigned images.

To rebase from a existing installation to Hyperbola, open a terminal and use rpm-ostree rebase command as the following:
```
rpm-ostree rebase ostree-image-signed:docker://ghcr.io/vortex-repositories/hyperbola:latest
```
After rebasing is complete, you can reboot the system to switch to Hyperbola.

## Bugs & Problems
Any issues that occur such as bugs or crashes that are exclusive to this image can be reported via the issues section of the repository.

If the image was succesfully uploaded to the registry but the latest pre-generated ISO fails at any point either in the build process or when using the Anaconda Installer from the ISO,
refer to the ``build-container-installer`` workflow [repository](https://github.com/JasonN3/build-container-installer) if you are experiencing a similar bug.

For issues specific to Hyprland, consult through https://wiki.hyprland.org/ for further support.
