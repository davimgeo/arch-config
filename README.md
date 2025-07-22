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

## Update the system clock

List of all timezones:

```
timedatectl list-timezones
```

Set your timezone:

```
timedatectl set-timezone <your-timezone> 
```

## Wi-fi

Authenticate to the wireless network using iwctl

```
iwctl
```

If your device name is wlan0, connect using the following command

```
station wlan0 connect <SSID>
```

If wlan0 is Powered off, check [TODO]

Make sure to enter in your password

Check connection with:

```
ping archlinux.org
```

exit when complete

```
exit
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

## Write random data (optional)

It's a secure way of erasing your data before instaling the OS

it's also a slow process, so do it only if you want to be sure your

data is deleted.

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

### Btfrs + Dual-Boot

If you want dual-boot, make sure to create a partition
for your other OS. Here's an example of Btfrs setup + Dual-boot:

| partition | first sector | last sector | code |
|-----------|--------------|-------------|------|
| 1         | default      | +512M       | ef00 |
| 2         | default      | default     | 8309 |
| 3         | default      | +256GB      | Code for your OS |

**That's will be my disk setup I'll use for the rest of the tutorial**

If you do not want dual-boot, just doesn't create the this extra +250GB partition

## Encryption

```
cryptsetup luksFormat -v -s 512 -h sha512 /dev/nvme0n1p2
```

Create a strong password for your disk. And **KEEP IT SAFE**

There's no way to recover your data if you lost this password


Create encrypted partition: 

```
cryptsetup open /dev/nvme0n1p2 main
```

## Keyfile(optional)

Create a keyfile to open your partition

```
mkdir -P /etc/keys
```

Create and encrypt the key:

```
dd if=/dev/random of=/etc/keys/root.key bs=512 count=8
```

Change permissions:

```
chmod 000 /etc/keys/*
```

## Format Partitions

Format main into btfrs filesystem:

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
loop0         7:0    0  795.7M  1 loop  /run/archiso/airootfs
sda           8:0    1   28.7G  0 disk  
└─sda1        8:1    1   28.7G  0 part  
nvme0n1     259:0    0  476.9G  0 disk  
├─nvme0n1p1 259:3    0      1G  0 part  
└─nvme0n1p2 259:4    0  475.9G  0 part  
  └─main     254:0   0  475.9G  0 crypt
```

TODO: i need to copy with my real instalation

## Create BTFRS subpartitions

Mount main partition into /mnt:

```
mount /dev/mapper/main /mnt
```

Enter /mnt:

```
cd /mnt
```

Create root subvolume:

```
btfrs subvolume create @
```

Create home subvolume:

```
btfrs subvolume create @home
```

Go back into your root directory:

```
cd
```

Umount /mnt folder:

```
umount /mnt
```

TODO: description for this

```
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@ /dev/mapper/main /mnt
```

TODO: description for this

```
mount -o noatime,ssd,compress=zstd,space_cache=v2,discard=async,subvol=@home /dev/mapper/main /mnt/home
```

## Mount EFI partition

Create the EFI directory:

```
mkdir /mnt/boot/efi
```

Mount the EFI directory:

```
mount /dev/nvme0n1p1 /mnt/boot/efi
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
nvim /mnt/etc/locale.gen 
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
echo "your-hostname" >> /etc/hostname
```

Set a password for the root:

```
passwd
```

## Username

Download zsh shell(optional)

```
pacman -S zsh
```

Add a user:

```
useradd -m -g users -G wheel -s /bin/<your-shell> <your-username>
```

Create a password for your user:

```
passwd <your-username>
```

Run:

```
echo "<your-username> ALL=(ALL) ALL" >> /etc/sudoers.d/<your-username>
```

## Instaling aditional packages

### Essential aditional packages:

```
pacman -S base-devel btrfs-progs grub efibootmgr networkmanager iptables-nft  pipewire pipewire-pulse alsa-utils wireplumber alacritty
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
pacman -S bluez bluez-utils reflector ipset firewalld git
```

### Login Manager

If you want to be simple, just install:

```
pacman -S lightdm lightdm-gtk-greeter
```

I'll choose Ly, but choose one to your liking

```
cd /opt
```
```
git clone https://aur.archlinux.org/ly.git
```
```
cd ly
```
```
makepkg -si
```

Prepare .xinitrc:

```
echo "exec qtile" > /home/<your-username>/.xinitrc 
```
```
chown <your-username>:users /home/<your-username>/.xinitrc
```

### Desktop Manager

If you want to keep it simples, just install gnome:

```
pacman -S gnome
```
However, I'll install dwm

Install X11 server:

```
pacman -S xorg xorg-xinit
```

Install dwm:

```
cd /opt
```
```
git clone https://git.suckless.org/dwm
```
```
cd dwm
```

Install and Build:

```
make
```
```
make install
```

Install dmenu(recomended):

```
cd /opt
```
```
git clone https://git.suckless.org/dmenu
```
```
cd dmenu
```

Install and Build:

```
make
```
```
make install
```

Set .xinitrc:

```
echo "exec dwm" > /home/<your-username>/.xinitrc
```
```
chown <your-username>:users /home/<your-username>/.xinitrc
```

## Update mkinitcpio

```
nvim /etc/mkinitcpio.conf
```

Edit the follow:

```
MODULES=(btrfs)
```

```
HOOKS=(... blocks encrypt filesystems ...)
```

If you created a keyfile[direct to keyfile section]:

```
FILES=(/secure/root_keyfile.bin)
```

Run:

```
mkinitcpio -P linux
```

## Set up GRUB

Run:

```
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB
```

Create grub config file:

```
grub-mkconfig -o /boot/grub/grub.cfg
```

Move your UUID to your grub file:

```
blkid /dev/nvme0n1p2 >> /etc/default/grub
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

If you set up a keyfile:

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet cryptdevice=UUID=<your-UUID>:main cryptkey=rootfs:/etc/keys/root.key root=/dev/mapper/main"
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
systemctl enable reflection.timer
```
```
systemctl enable wireplumber.service
```

If you chose Ly:

```
systemctl enable ly.service
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
