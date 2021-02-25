# Skiff Extension Sample

[SkiffOS](https://github.com/skiffos/skiffos) compiles a lightweight operating
system for any Linux-compatible computer.

This is an example of how Skiff can be extended with custom configuration
packages. Skiff is added as a submodule, and is instructed to use the parent
repo configs directory:

```sh
export SKIFF_EXTRA_CONFIGS_PATH=$(pwd)/configs
```

Then, any extra configuration packages you add in this repo will be available.

The Makefile in this repository is also configured to redirect to the SkiffOS
makefile, while automatically initializing the submodule and setting the env.

To get started:

```sh
make help
```

Alternatively:

```sh
source setup.env
cd ./skiffos
make # this will print help!
```

As a basic example:

```sh
export SKIFF_WORKSPACE=pi4
export SKIFF_CONFIG=pi/4,mycustom/device
make configure compile

# flash to sd card
make cmd/pi/common/{format,install}
```

The example `mycustom/device` package has examples of Wi-Fi configurations, SSH
keys, and other common customizations.

### Package Layout

A configuration package is laid out into the following directories:

```
├── cflags:         compiler flags in files
├── buildroot:      buildroot configuration fragments
├── buildroot_ext:  buildroot extensions (extra packages)
├── buildroot_patches: extra Buildroot global patches
│   ├── <packagename>: patch files for Buildroot <packagename>
│   └── <packagename>/<version>: patches for package version
├── extensions:     extra commands to add to the build system
│   └── Makefile
├── hooks:          scripts hooking pre/post build steps
│   ├── post.sh
│   └── pre.sh
├── kernel:         kernel configuration fragments
├── kernel_patches: kernel .patch files
├── root_overlay:   root overlay files
├── metadata:       metadata files
│   ├── commands
│   ├── dependencies
│   ├── description
│   └── unlisted
├── resources:     files used by the configuration package
├── scripts:       any scripts used by the extensions
├── uboot:         u-boot configuration fragments
└── uboot_patches: u-boot .patch files
```

All files are optional.

