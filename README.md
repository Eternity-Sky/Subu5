# Subu5

Subu5 is a custom Linux distribution based on Ubuntu, designed with its own branding, software packages, and user experience.

## Overview

Subu5 aims to provide a polished desktop experience built on the solid foundation of Ubuntu 24.04 LTS (Noble), with custom branding, default applications, and system configuration.

### Features

- **Base**: Ubuntu 24.04 LTS (Noble)
- **Desktop Environment**: GNOME
- **Architecture**: amd64
- **Custom Branding**: Subu5 logo, wallpaper, and theme
- **Default Software**: Curated selection of desktop applications
- **Custom Configuration**: Optimized settings and system files
- **Automated Builds**: GitHub Actions CI/CD pipeline

## Project Structure

```
Subu5/
├── .github/
│   └── workflows/
│       ├── build.yml      # Main build workflow
│       └── release.yml    # Release workflow
├── config/
│   ├── packages.list      # Packages to install
│   ├── remove.list        # Packages to remove
│   └── settings/          # System configuration
├── filesystem/
│   ├── etc/
│   │   ├── os-release     # System identification
│   │   ├── subu5-release  # Subu5 version info
│   │   ├── hostname       # Default hostname
│   │   └── hosts          # Host file configuration
│   └── usr/
│       └── share/
│           ├── backgrounds/  # Default wallpapers
│           ├── icons/       # Custom icons
│           └── themes/      # Custom themes
├── hooks/
│   ├── 01-branding.sh      # Apply branding
│   ├── 02-packages.sh      # Package management
│   └── 03-cleanup.sh       # Cleanup and optimization
├── branding/
│   ├── logo.svg            # Subu5 logo
│   ├── wallpaper.png       # Subu5 wallpaper
│   └── grub/
│       └── grub.cfg        # GRUB boot menu
├── scripts/
│   ├── build.sh            # Main build script
│   └── test.sh             # Testing script
├── README.md
└── LICENSE
```

## Building Subu5

### Prerequisites

- Ubuntu 24.04 or compatible system
- Build dependencies:
  - livecd-rootfs
  - xorriso
  - squashfs-tools
  - grub-pc-bin
  - grub-efi-amd64-bin
  - grub-efi-amd64-signed
  - shim-signed
  - mtools
  - dosfstools
  - rsync
  - debootstrap

### Local Build

```bash
# Install dependencies
sudo apt update
sudo apt install -y livecd-rootfs xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed shim-signed mtools dosfstools rsync debootstrap

# Run build script
chmod +x scripts/build.sh
sudo ./scripts/build.sh
```

The resulting ISO will be in the `output/` directory.

### GitHub Actions Build

1. Push your changes to the `main` branch
2. GitHub Actions will automatically trigger the build
3. Download the ISO from the Actions artifacts

### Release Build

```bash
# Tag and push for release
git tag v1.0.0
git push origin v1.0.0
```

This will trigger the release workflow and create a GitHub Release with the ISO.

## Roadmap

### v0.1 (Current)
- [x] Project structure
- [x] GitHub Actions workflow
- [x] Basic build script
- [x] Configuration files
- [x] Branding structure

### v0.2
- [ ] Complete branding (logo, wallpaper, GRUB)
- [ ] Theme customization
- [ ] Default hostname configuration

### v0.3
- [ ] Subu5 Welcome application
- [ ] Subu5 Settings
- [ ] Default packages configuration
- [ ] Remove unnecessary Ubuntu packages

### v0.4
- [ ] Subu5 APT repository
- [ ] Custom packages (subu5-desktop, subu5-theme, subu5-welcome)
- [ ] Package signing

### v0.5
- [ ] Automated installation testing
- [ ] QEMU boot testing
- [ ] ISO checksums
- [ ] SBOM generation

### v1.0
- [ ] Complete branding identity
- [ ] Custom software repository
- [ ] Custom packages
- [ ] Optimized default configuration
- [ ] Custom installer experience
- [ ] Full CI/CD pipeline
- [ ] Automated testing
- [ ] Automatic releases

## Configuration

### System Identification

Edit `filesystem/etc/os-release` to change system identification:

```ini
NAME="Subu5"
PRETTY_NAME="Subu5 1.0.0"
ID=subu5
ID_LIKE=ubuntu
VERSION_ID="1.0"
```

### Package Management

- Add packages to `config/packages.list` to include them in the build
- Add packages to `config/remove.list` to remove them from the Ubuntu base

### Branding

- Replace `branding/logo.svg` with your logo
- Replace `branding/wallpaper.png` with your wallpaper
- Customize `branding/grub/grub.cfg` for the boot menu

## Contributing

Contributions are welcome! Please feel free to submit issues and pull requests.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Based on Ubuntu Linux
- Built with livecd-rootfs
- Powered by GitHub Actions
