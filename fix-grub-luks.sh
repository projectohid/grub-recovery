#!/bin/bash

set -e

# ===== CONFIGURATION =====
LUKS_PART="/dev/sda2"
EFI_PART="/dev/sda1"
MAPPER_NAME="cryptroot"
MOUNT_POINT="/mnt"
BOOTLOADER_ID="manjaro"

echo "===== GRUB Repair Script (LUKS + UEFI) ====="
echo

# Check if running as root
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root: sudo ./fix-grub-luks.sh"
   exit 1
fi

echo "[1/6] Unlocking LUKS partition..."
cryptsetup luksOpen "$LUKS_PART" "$MAPPER_NAME"

echo "[2/6] Mounting root filesystem..."
mount /dev/mapper/$MAPPER_NAME "$MOUNT_POINT"

echo "[3/6] Mounting EFI partition..."
mkdir -p "$MOUNT_POINT/boot/efi"
mount "$EFI_PART" "$MOUNT_POINT/boot/efi"

echo "[4/6] Entering Manjaro chroot..."
manjaro-chroot "$MOUNT_POINT" /bin/bash <<EOF

echo "[5/6] Reinstalling GRUB..."
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=$BOOTLOADER_ID

echo "[6/6] Updating GRUB configuration..."
update-grub

echo
echo "GRUB reinstall complete."

EOF

echo
echo "Unmounting partitions..."
umount -R "$MOUNT_POINT" || true
cryptsetup close "$MAPPER_NAME" || true

echo
echo "===== DONE ====="
echo "Now reboot and remove the USB."
