# Skiff Extension Sample

This is an example of how Skiff can be extended with custom configuration
packages. Skiff is added as a submodule, and is instructed to use the parent
repo configs directory:

```sh
export SKIFF_EXTRA_CONFIGS_PATH=$(pwd)/configs
```

Then, any extra Skiff configuration packages you add in this repo will be available.

To get started:

```sh
source setup.env
cd ./skiffos
make # this will print help!
```

As a basic example:

```sh
export SKIFF_CONFIG=virt/docker,coreenv/ubuntu
export SKIFF_WORKSPACE=docker
make configure compile
make cmd/virt/docker/buildimage
make cmd/virt/docker/run
make cmd/virt/docker/exec
# entered root shell
su - core
# entered core user shell
```

## Ubuntu Core

The configuration at `coreenv/ubuntu` provides:

 - Systemd inside container
 - Udev inside container
 - Full desktop environment
 - X11
 - KDE Plasma

A gentoo-based core is also possible and will be added to this repo soon.
