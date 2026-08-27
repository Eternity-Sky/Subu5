#!/bin/bash
# Hook: Apply Subu5 branding to the filesystem

set -e

echo "Applying Subu5 branding..."

# Copy branding assets to filesystem overlay
if [ -d "../branding" ]; then
    echo "Copying logo and wallpaper..."
    mkdir -p config/overlay/usr/share/icons/hicolor/scalable/apps/
    mkdir -p config/overlay/usr/share/backgrounds/
    cp ../branding/logo.svg config/overlay/usr/share/icons/hicolor/scalable/apps/subu5-logo.svg 2>/dev/null || echo "Logo not found, skipping..."
    cp ../branding/wallpaper.png config/overlay/usr/share/backgrounds/subu5-wallpaper.png 2>/dev/null || echo "Wallpaper not found, skipping..."
fi

# Copy GRUB configuration
if [ -f "../branding/grub/grub.cfg" ]; then
    echo "Copying GRUB configuration..."
    mkdir -p config/overlay/boot/grub
    cp ../branding/grub/grub.cfg config/overlay/boot/grub/
else
    echo "GRUB configuration not found, skipping..."
fi

# Copy system files from filesystem/
if [ -d "../filesystem" ]; then
    echo "Copying system files..."
    mkdir -p config/overlay/etc/
    cp ../filesystem/etc/os-release config/overlay/etc/ 2>/dev/null || true
    cp ../filesystem/etc/subu5-release config/overlay/etc/ 2>/dev/null || true
    cp ../filesystem/etc/hostname config/overlay/etc/ 2>/dev/null || true
    cp ../filesystem/etc/hosts config/overlay/etc/ 2>/dev/null || true
fi

echo "Subu5 branding applied."
