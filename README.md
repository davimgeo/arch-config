# Arch Linux Installation Guide

Keywords: full disk encryption, luks, btfs, dual-boot, single-disk

## Download

Make sure to download the iso from an official link

```
https://archlinux.org/download/
```

## Font (optional)

Usually the terminal font is too small, select this font to solve this 

```
setfont -d
```

or select and choose other font of your choice:

```
localectl list-keymaps
```

## Wi-fi

Authenticate to the wireless network using iwctl

```
iwctl
```

Check if your device name is wlan:

```
device list
```

Check wifi list:

```
station wlan0 get-networks 
```

Connect to a wifi:

```
station wlan0 connect <your-wifi>
```

If wlan0 is Powered off, check [TODO]

Make sure to enter in your password

exit when complete

```
exit
```

Check connection with:

```
ping archlinux.org
```

## SSH (optional)

If you want to enable sshd to control your instalation via other PC

```
systemctl enable sshd
```

Then set a password for your ISO environment

```
passwd
```

## Update the system clock

List of all timezones:

```
timedatectl list-timezones
```

Set your timezone:

```
timedatectl set-timezone <your-timezone> 
```

## Write random data (optional)

It's a secure way of erasing your data before instaling the OS

it's also a slow process, so do it only if you want to be sure your data is deleted.

List your block devices. Usually they are such as /dev/sda, /dev/nvme0n1 or /dev/mmcblk0

```
$ lsblk
```

Write random data into your drive. 

**WARNING** By typing the following command the process will imediately
start running

```
dd if=/dev/urandom of=/dev/<your block device> status=progress bs=4096
```

This may take a while, but it is worth it if you value your privacy.

## Partitioning Data

Get the names of the blocks

```
$ lsblk
```

For both partition setups, you'll want to setup a table on your primary drive.

```
$ gdisk /dev/nvme0n1
```

Inside of gdisk, you can print the table using the `p` command.

To create a new partition use the `n` command. 

To delete all partitions use the `o` command. 

### btrfs + Dual-Boot

If you want dual-boot, make sure to create a partition
for your other OS. Here's an example of btrfs setup + Dual-boot:

| partition | first sector | last sector | code |
|-----------|--------------|-------------|------|
| 1         | default      | +512M       | ef00 |
| 2         | default      | +256GB      | 0700 |
| 3         | default      | default     | 8300 |

**That's will be my disk setup I'll use for the rest of the tutorial**

If you do not want dual-boot, just doesn't create the this extra +250GB partition

Type `w` to write the changes.

## Encryption

```
cryptsetup luksFormat -v -s 512 -h sha512 /dev/nvme0n1p3
```

Create a strong password for your disk. And **KEEP IT SAFE**

There's no way to recover your data if you lost this password


Create encrypted partition: 

```
cryptsetup open /dev/nvme0n1p3 main
```

## Format Partitions

Format main into btrfs filesystem:

```
mkfs.btrfs /dev/mapper/main
```

Format EFI partition into FAT32:

```
mkfs.fat -F32 /dev/nvme0n1p1
```

Check if it's created correctly with

```
$ lsblk
```

It should be something like:

```
NAME        MAJ:MIN RM   SIZE RO TYPE  MOUNTPOINTS
loop0         7:0    0 942.7M  1 loop  /run/archiso/airootfs
sda           8:0    1    15G  0 disk
├─sda1        8:1    1   1.1G  0 part
└─sda2        8:2    1   179M  0 part
nvme0n1     259:0    0 238.5G  0 disk
├─nvme0n1p1 259:1    0   512M  0 part
├─nvme0n1p2 259:2    0   256G  0 part
└─nvme0n1p3 259:3    0   110G  0 part
  └─main    253:0    0   110G  0 crypt
```

## Create btrfs subpartitions

Mount main partition into /mnt:

```
mount /dev/mapper/main /mnt
```

Enter /mnt:

```
cd /mnt
```

### Create subvolumes:

```
btrfs subvolume create @
btrfs subvolume create @home
btrfs subvolume create @snapshots
```

Umount /mnt folder:

```
umount /mnt
```

TODO: description for this

### Mount options

```
o=defaults,x-mount.mkdir
o_btrfs=$o,compress=zstd,ssd,noatime,nodiratime,space_cache
```

### Remount the partitions:

```
mount -o compress=lzo,subvol=@,$o_btrfs /dev/mapper/main /mnt
mount -o compress=lzo,subvol=@home,$o_btrfs /dev/mapper/main /mnt/home
mount -o compress=lzo,subvol=@snapshots,$o_btrfs /dev/mapper/main /mnt/.snapshots
```

## Mount EFI partition

Create the EFI directory:

```
mkdir -p /mnt/boot
```

Mount the EFI directory:

```
mount /dev/nvme0n1p1 /mnt/boot
```

## Linux instalation

Update reflector to your location, increases download speed

```
reflector -c <your-country> -a 12 --sort rate --save /etc/pacman.d/mirrorlist
```

Download essential packages:

```
pacstrap -K /mnt base linux linux-headers linux-firmware sudo
```

## Generate Filesystem Table

```
genfstab -U -p /mnt >> /mnt/etc/fstab
```

You can check if the fstab was generated correctly

```
cat /mnt/etc/fstab
```

## Enter Chroot

Everything now was interacting only with the live ISO 

Now we will interact with your system environment

```
arch-chroot /mnt
```

## Set Time

Change "Region/City" for your respective region/city (cf. Set Timezone)

```
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime
```

Run:

```
hwclock --systohc
```

## Install Text Manager

For the next steps, we will need to edit some files

so download a text editor of your choice, I'll choose neovim

```
pacman -S nvim
```

## Localization

Open:

```
nvim /etc/locale.gen 
```

Uncomment the `en_US.UTF-8 UTF-8` and other UTF-8 locales or your choice

Create locale.conf:

```
locale-gen
```

Set your locale to english:

```
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
```

Change your keymap to your liking (optional)

```
echo "KEYMAP=br-abnt2" >> /etc/vconsole.conf
```

## Set hostname

It will be name of your machine

```
echo "<your-hostname>" >> /etc/hostname
```

Set a password for the root:

```
passwd
```

## Username

Download zsh shell

```
pacman -S zsh
```

Add a user:

```
useradd -m -U -G wheel -s /bin/zsh <your-username>
```

Create a password for your user:

```
passwd <your-username>
```

Run:

```
EDITOR=<your-text-editor> visudo
```

and uncomment the line `%wheel ALL=(ALL:ALL) ALL`

## Instaling aditional packages

### Essential aditional packages:

```
pacman -S base-devel btrfs-progs grub grub-btrfs efibootmgr networkmanager pipewire pipewire-pulse alsa-utils wireplumber alacritty
```

### Microcode(esssential)

If you use intel:

```
pacman -S intel-ucode
```

or AMD:

```
pacman -S amd-ucode
```

### Not-essential, but recommended:

```
pacman -S bluez bluez-utils reflector git xclip fastfetch
```

### Login Manager (optional)

If you want to be simple, just install:

```
pacman -S lightdm lightdm-gtk-greeter
```

You can install a login manager after the installation

### Desktop Manager

If you want to keep it simples, just install gnome:

```
pacman -S gnome
```

You can also install the desktop manager after the installation

## Update mkinitcpio

```
nvim /etc/mkinitcpio.conf
```

Edit the follow:

```
MODULES=(btrfs)
```

Change hooks:

```
HOOKS=(... blocks encrypt filesystems ...)
```

Run:

```
mkinitcpio -P linux
```

## Set up GRUB

Run:

```
grub-install --target=x86_64-efi --efi-directory=/boot/ --bootloader-id=GRUB
```

Create grub config file:

```
grub-mkconfig -o /boot/grub/grub.cfg
```

Move your UUID to your grub file:

```
blkid /dev/nvme0n1p3 >> /etc/default/grub
```
Search it in the botton of the file and use it for the next step

Edit it:

```
nvim /etc/default/grub
```

Edit the follow:

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=<your-UUID>:main root=/dev/mapper/main"
```

Update grub config file:

```
grub-mkconfig -o /boot/grub/grub.cfg
```

## Enable System Utilities

```
systemctl enable NetworkManager
```
```
systemctl enable bluetooth
```
```
systemctl enable reflector.timer
```

Enable audio for your user:

```
systemctl --user enable pipewire pipewire-pulse wireplumber
```

If you chose gnome:

```
systemctl enable gdm
```

## Reboot

Exit chroot and reboot:

```
exit
```
```
umount -R /mnt
```
```
reboot
```

Now enjoy your Arch Linux :)
