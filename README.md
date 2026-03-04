 sudo ./repair.sh                                                               ✔ 
=== Checking UEFI mode ===
=== Unlocking LUKS partition ===
Enter passphrase for /dev/sda2: 
=== Mounting root ===
=== Mounting EFI ===
=== Binding system directories ===
=== Entering chroot ===
=== Reinstalling GRUB ===
Installing for x86_64-efi platform.
EFI variables are not supported on this system.
EFI variables are not supported on this system.
grub-install: error: efibootmgr failed to register the boot entry: No such file or directory.
=== Generating GRUB config ===
Generating grub configuration file ...
Found theme: /usr/share/grub/themes/manjaro/theme.txt
Found linux image: /boot/vmlinuz-6.12-x86_64
Found initrd image: /boot/intel-ucode.img /boot/amd-ucode.img /boot/initramfs-6.12-x86_64.img
Found linux image: /boot/vmlinuz-5.10-x86_64
Found initrd image: /boot/intel-ucode.img /boot/amd-ucode.img /boot/initramfs-5.10-x86_64.img
Warning: os-prober will be executed to detect other bootable partitions.
Its output will be used to detect bootable binaries on them and create new boot entries.
Adding boot menu entry for UEFI Firmware Settings ...
Root filesystem isn't btrfs
If you think an error has occurred, please file a bug report at "https://github.com/Antynea/grub-btrfs"
Found memtest86+ image: /boot/memtest86+/memtest.bin
Found memtest86+ EFI image: /boot/memtest86+/memtest.efi
done
=== Done inside chroot ===
=== Cleanup ===
=== Repair Complete ===
You can now reboot.
    ~/Downloads                                                                         ✔  15s  

