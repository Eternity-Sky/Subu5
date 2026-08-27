#!/bin/bash

set -e

PROJECT="subu5"
SUITE="noble"
ARCH="amd64"

echo "================================"
echo "        Building Subu5"
echo "================================"

echo "Project: $PROJECT"
echo "Suite:   $SUITE"
echo "Arch:    $ARCH"

mkdir -p output
mkdir -p build

echo "[1/5] Preparing..."

# Set up livecd-rootfs configuration
mkdir -p build/config
cd build

# Configure livecd-rootfs for Ubuntu Desktop base
cat > config/autoconfig << 'EOF'
LB_DISTRIBUTION="noble"
LB_PARENT_DISTRIBUTION="noble"
LB_DEBIAN_INSTALLER="none"
LB_BOOTLOADER="grub"
LB_INITRAMFS="live-boot"
LB_INITSYSTEM="systemd"
LB_APPLICATIONS=""
LB_TASKS="standard"
LB_PACKAGES=""
EOF

echo "[2/5] Applying Subu5 configuration..."

# Create overlay directory
mkdir -p config/overlay

# Copy filesystem overlay
if [ -d "../filesystem" ]; then
    echo "Copying filesystem overlay..."
    rsync -a ../filesystem/ config/overlay/
fi

# Execute hooks
if [ -d "../hooks" ]; then
    echo "Running hooks..."
    for hook in ../hooks/*.sh; do
        if [ -f "$hook" ]; then
            echo "Running $(basename $hook)..."
            bash "$hook"
        fi
    done
fi

echo "[3/5] Building filesystem..."

# Build with livecd-rootfs
# This is a placeholder - actual livecd-rootfs commands will be added
# based on the specific Ubuntu image building approach chosen
echo "Building rootfs with livecd-rootfs..."
# sudo lb config --config config
# sudo lb build

echo "[4/5] Creating ISO..."

# ISO generation placeholder
# echo "Creating ISO image..."
# xorriso -as mkisofs -r -J -joliet-long -l \
#   -b boot/grub/i386-pc/eltorito.img \
#   -no-emul-boot -boot-load-size 4 -boot-info-table \
#   -eltorito-alt-boot -e boot/grub/efi.img \
#   -no-emul-boot -isohybrid-gpt-basdat \
#   -isohybrid-apm-hfsplus \
#   -o ../output/${PROJECT}-${SUITE}-${ARCH}.iso \
#   iso/

echo "[5/5] Done."

cd ..
ls -lh output/
