#!/bin/bash
# Hook: Install and remove packages for Subu5

set -e

echo "Configuring packages..."

# Copy package lists to config directory
if [ -f "../config/packages.list" ]; then
    echo "Copying packages.list..."
    cp ../config/packages.list config/
fi

if [ -f "../config/remove.list" ]; then
    echo "Copying remove.list..."
    cp ../config/remove.list config/
fi

# Install packages from config/packages.list
if [ -f "config/packages.list" ]; then
    echo "Installing packages from packages.list..."
    PACKAGES=$(grep -v "^#" config/packages.list | grep -v "^$" | tr '\n' ' ')
    if [ -n "$PACKAGES" ]; then
        echo "Packages to install: $PACKAGES"
        # This will be executed in the chroot environment during build
        # apt-get install -y $PACKAGES
    fi
fi

# Remove packages from config/remove.list
if [ -f "config/remove.list" ]; then
    echo "Removing packages from remove.list..."
    REMOVE_PACKAGES=$(grep -v "^#" config/remove.list | grep -v "^$" | tr '\n' ' ')
    if [ -n "$REMOVE_PACKAGES" ]; then
        echo "Packages to remove: $REMOVE_PACKAGES"
        # This will be executed in the chroot environment during build
        # apt-get remove -y $REMOVE_PACKAGES
    fi
fi

echo "Package configuration done."
