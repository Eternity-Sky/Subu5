# Subu5 Project - Agent Information

## Build Commands

- **Local build**: `sudo ./scripts/build.sh`
- **Dependencies**: `sudo apt install -y livecd-rootfs xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin grub-efi-amd64-signed shim-signed mtools dosfstools rsync debootstrap`

## Test Commands

- **Test ISO**: `./scripts/test.sh output/Subu5.iso`
- **QEMU requirements**: `sudo apt install -y qemu-system-x86`

## GitHub Actions

- **Build trigger**: Push to `main` branch or manual workflow dispatch
- **Release trigger**: Push tags matching `v*`
- **Runner**: `ubuntu-24.04`

## Project Configuration

- **Base Ubuntu version**: 24.04 LTS (Noble)
- **Target architecture**: amd64
- **Desktop environment**: GNOME
- **Project name**: subu5

## Key Files

- **Build script**: `scripts/build.sh`
- **Package lists**: `config/packages.list`, `config/remove.list`
- **System files**: `filesystem/etc/os-release`, `filesystem/etc/subu5-release`
- **Branding**: `branding/logo.svg`, `branding/wallpaper.png`, `branding/grub/grub.cfg`
- **Hooks**: `hooks/01-branding.sh`, `hooks/02-packages.sh`, `hooks/03-cleanup.sh`

## Development Notes

1. The build script currently contains placeholders for actual livecd-rootfs implementation
2. Hooks are relative path aware (use `../` to reference project root from build directory)
3. Branding assets need to be replaced with actual design files
4. The project uses livecd-rootfs for Ubuntu-based image building
5. Future phases will implement custom packages, repository, and automated testing
