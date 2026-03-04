#!/bin/bash

set -e

echo "=== Checking UEFI mode ==="
if [ ! -d /sys/firmware/efi ]; then
    echo "ERROR: Not booted in UEFI mode."
    echo "Reboot and choose UEFI USB entry."
    exit 1
fi

echo "=== Unlocking LUKS partition ==="
cryptsetup open /dev/sda2 cryptroot

echo "=== Mounting root ==="
mount /dev/mapper/cryptroot /mnt

echo "=== Mounting EFI ==="
mkdir -p /mnt/boot/efi
mount /dev/sda1 /mnt/boot/efi

echo "=== Binding system directories ==="
mount --bind /dev /mnt/dev
mount --bind /proc /mnt/proc
mount --bind /sys /mnt/sys

echo "=== Entering chroot ==="
chroot /mnt /bin/bash <<EOF

echo "=== Reinstalling GRUB ==="
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro

echo "=== Generating GRUB config ==="
grub-mkconfig -o /boot/grub/grub.cfg

echo "=== Done inside chroot ==="
EOF

echo "=== Cleanup ==="
umount -R /mnt
cryptsetup close cryptroot

echo "=== Repair Complete ==="
echo "You can now reboot."
