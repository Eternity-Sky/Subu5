#!/bin/bash
# Hook: Cleanup and optimization

set -e

echo "Performing cleanup..."

# Clean apt cache
echo "Cleaning apt cache..."
# apt-get clean
# apt-get autoremove -y

# Remove temporary files
echo "Removing temporary files..."
# rm -rf /tmp/*
# rm -rf /var/tmp/*

# Clean logs
echo "Cleaning logs..."
# rm -rf /var/log/*.log
# rm -rf /var/log/apt/*

# Update databases
echo "Updating databases..."
# updatedb
# mandb

echo "Cleanup completed."
