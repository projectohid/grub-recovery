#!/bin/bash

set -e

ROOT_PART="/dev/nvme0n1p2"
EFI_PART="/dev/nvme0n1p1"
DISK="/dev/nvme0n1"

echo "Mounting root partition..."
mount $ROOT_PART /mnt

echo "Mounting EFI partition..."
mkdir -p /mnt/boot/efi
mount $EFI_PART /mnt/boot/efi

echo "Entering chroot..."
manjaro-chroot /mnt /bin/bash <<EOF

echo "Reinstalling GRUB..."
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=manjaro --recheck

echo "Regenerating GRUB config..."
update-grub

echo "Checking EFI boot entry..."
if ! efibootmgr | grep -qi manjaro; then
    echo "Creating EFI boot entry..."
    efibootmgr --create --disk $DISK --part 1 --label "Manjaro" --loader '\EFI\manjaro\grubx64.efi'
fi

echo "GRUB repair complete."

EOF

echo "Unmounting..."
umount -R /mnt

echo "Done. You can now reboot."
