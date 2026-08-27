#!/bin/bash

set -Eeuo pipefail

PROJECT="ubuntu"
SUBPROJECT="live"
SUITE="noble"
ARCH="amd64"

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
BUILD_DIR="${ROOT_DIR}/build"
OUTPUT_DIR="${ROOT_DIR}/output"

LIVECD_ROOTFS="/usr/share/livecd-rootfs/live-build/auto"

echo "=============================================="
echo "              Building Subu5"
echo "=============================================="
echo "Base:       Ubuntu ${SUITE}"
echo "Project:    ${PROJECT}"
echo "Subproject: ${SUBPROJECT}"
echo "Architecture: ${ARCH}"
echo "=============================================="

mkdir -p "${OUTPUT_DIR}"

cd "${BUILD_DIR}" 2>/dev/null || {
    mkdir -p "${BUILD_DIR}"
    cd "${BUILD_DIR}"
}

echo
echo "[1/6] Checking build environment..."

if [ ! -x "${LIVECD_ROOTFS}/config" ]; then
    echo "ERROR: livecd-rootfs config script not found:"
    echo "  ${LIVECD_ROOTFS}/config"
    exit 1
fi

if [ ! -x "${LIVECD_ROOTFS}/build" ]; then
    echo "ERROR: livecd-rootfs build script not found:"
    echo "  ${LIVECD_ROOTFS}/build"
    exit 1
fi

echo "livecd-rootfs found."

echo
echo "[2/6] Preparing livecd-rootfs..."

rm -rf auto config .build
mkdir -p auto

ln -sf "${LIVECD_ROOTFS}/clean" auto/clean
ln -sf "${LIVECD_ROOTFS}/config" auto/config
ln -sf "${LIVECD_ROOTFS}/build" auto/build

echo "Creating livecd-rootfs configuration..."

sudo env \
    ARCH="${ARCH}" \
    PROJECT="${PROJECT}" \
    SUBPROJECT="${SUBPROJECT}" \
    SUITE="${SUITE}" \
    "${LIVECD_ROOTFS}/config"

echo
echo "[3/6] Applying Subu5 filesystem..."

# live-build uses config/includes.chroot as the filesystem overlay.
mkdir -p config/includes.chroot

if [ -d "${ROOT_DIR}/filesystem" ]; then
    echo "Copying filesystem/..."
    rsync -a \
        "${ROOT_DIR}/filesystem/" \
        config/includes.chroot/
fi

echo
echo "[4/6] Adding Subu5 packages..."

mkdir -p config/package-lists

if [ -f "${ROOT_DIR}/config/packages.list" ]; then
    cp "${ROOT_DIR}/config/packages.list" \
        config/package-lists/subu5.list.chroot

    echo "Added Subu5 package list."
fi

echo
echo "[5/6] Building Subu5 ISO..."
echo

sudo env \
    ARCH="${ARCH}" \
    PROJECT="${PROJECT}" \
    SUBPROJECT="${SUBPROJECT}" \
    SUITE="${SUITE}" \
    "${LIVECD_ROOTFS}/build"

echo
echo "[6/6] Collecting ISO..."

ISO_FILE=""

for candidate in \
    livecd.ubuntu.iso \
    livecd.ubuntu.iso.zsync \
    livecd.ubuntu.iso.*; do

    if [ -f "${candidate}" ]; then
        ISO_FILE="${candidate}"
        break
    fi
done

if [ -z "${ISO_FILE}" ]; then
    echo
    echo "ERROR: ISO was not generated."
    echo
    echo "Build directory contents:"
    find . -maxdepth 3 -type f -print | sort
    exit 1
fi

echo "Found ISO:"
echo "  ${ISO_FILE}"

if [[ "${ISO_FILE}" == *.zsync ]]; then
    ISO_FILE="${ISO_FILE%.zsync}"
fi

if [ ! -f "${ISO_FILE}" ]; then
    echo "ERROR: Final ISO does not exist."
    exit 1
fi

TARGET="${OUTPUT_DIR}/Subu5-${SUITE}-${ARCH}.iso"

echo
echo "Copying:"
echo "  ${ISO_FILE}"
echo "to:"
echo "  ${TARGET}"

cp -f "${ISO_FILE}" "${TARGET}"

echo
echo "=============================================="
echo "             Subu5 build complete"
echo "=============================================="

ls -lh "${TARGET}"

echo
echo "SHA256:"
sha256sum "${TARGET}"
