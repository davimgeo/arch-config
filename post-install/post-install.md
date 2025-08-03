## Set up wi-fi again

```
nmcli device wifi list
```

Then:

```
nmcli device wifi connect "<WIFI-NAME>" password "<PASSWORD>"
```

## Set up ssh again(optional)

```
sudo pacman -S openssh
```

```
sudo systemctl start sshd
sudo systemctl enable sshd
```

Check your ipv6 in `ip addr` then connect in other computer
with `ssh <your-username>@<your-ipv6>`

## Set keyfile:

### Create keyfile in uncrypted partition (not recomended) 

```
sudo dd bs=512 count=4 if=/dev/urandom of=/crypto_keyfile.bin
```

#### Add keyfile to encrypted disk

```
sudo cryptsetup luksAddKey /dev/nvme0n1p3 /crypto_keyfile.bin
```

edit mkinitcpio.conf:

```
sudo nvim /etc/mkinitcpio.conf
```

and add the following:

```
FILES=(/crypto_keyfile.bin)
```

Then run:

```
sudo mkinitcpio -p linux
```

Reboot again, you’ll only need to enter your password once.

```
sudo reboot
```

### Secure keyfile and /boot

```
sudo chmod 000 /crypto_keyfile.bin
sudo chmod -R g-rwx,o-rwx /boot
```

### Create keyfile in uncrypted pen-drive USB

Create a script that search for all usb devices and
try to find and unlock your LUKS partition

First create the folder

```
mkdir -p /mnt/usbkey
```

Do:

```
sudo nvim /bin/luks-unlock
```

and copy:

```
#!/bin/sh
set -e

KEYFILE_NAME="crypto_keyfile.bin" # change for your keyfile name
MNTPOINT="/mnt/usbkey"

log_msg() {
    echo "[luks-unlock] $1" > /dev/kmsg
}

log_msg "===== Starting luks-unlock script ====="

mkdir -p "$MNTPOINT"
sleep 2  # Allow time for USB devices to be ready

for dev in /dev/disk/by-id/usb-* /dev/sd*; do
    realdev=$(readlink -f "$dev" 2>/dev/null || echo "$dev")
    [ -b "$realdev" ] || continue

    log_msg "Checking device: $realdev"

    for part in "${realdev}"*; do
        [ -b "$part" ] || continue
        log_msg "Attempting to mount: $part"

        if mount "$part" "$MNTPOINT" 2>/dev/null; then
            log_msg "Mounted $part at $MNTPOINT"

            if [ -f "$MNTPOINT/$KEYFILE_NAME" ]; then
                log_msg "Keyfile found! Outputting contents..."
                cat "$MNTPOINT/$KEYFILE_NAME"
                umount "$MNTPOINT"
                log_msg "Unmounted $part — success"
                exit 0
            else
                log_msg "Keyfile not found on $part"
            fi

            umount "$MNTPOINT"
            log_msg "Unmounted $part"
        else
            log_msg "Failed to mount $part"
        fi
    done
done

log_msg "No keyfile found on any USB device. Falling back to password prompt"
exit 1

```

and make it executable:

```
sudo chmod +x /bin/luks-unlock
```

### Create custom hook for mkinitcpio

#### Create hook

```
sudo nvim `/etc/initcpio/hooks/luks-unlock
```

and copy

```
#!/usr/bin/bash

run_hook() {
        /bin/luks-unlock > /crypto_keyfile.bin
}
```

and make it executable:

```
sudo chmod +x /etc/initcpio/hooks/luks-unlock
```

#### Create hook install

```
nvim etc/initcpio/install/luks-unlock
```

and copy:

```
#!/usr/bin/bash

build() {
        add_binary "/bin/luks-unlock"
        add_file "/bin/luks-unlock" "/bin/luks-unlock"
        add_runscript
}

help () {
        cat <<HELPOF
        Custom unlock script for LUKS
HELPOF

}
```

and make it executable:

```
sudo chmod +x /etc/initcpio/install/luks-unlock
```

#### Modify mkinitcpio.conf

Modify `sudo nvim /etc/mkinitcpio.conf` with the folowing:

```
MODULES=(btrfs ext4 nls_cp437 nls_utf8 usb_storage hid hid_generic usbhid xhci_hcd xhci_pci)
BINARIES=(/bin/mount /bin/umount /usr/bin/blkid /usr/bin/cat /usr/bin/readlink)
FILES=(/bin/luks-unlock)
HOOKS=(base udev autodetect microcode modconf kms keyboard keymap consolefont block luks-unlock encrypt filesystems fsck)
```

Do `sudo mkinitcpio -P linux` to save settings

#### Change grub 

Modify `sudo nvim /etc/default/grub` with the following
uncomment this:

```
GRUB_ENABLE_CRYPTODISK=y
```

Do `sudo grub-mkconfig -o /boot/grub/grub.cfg` to save the settings
`sudo reboot` to test it

## Instaling DWM

Install required dependencies:

```
sudo pacman -S xorg-server xorg-xinit xorg-fonts-misc xorg-xsetroot libx11 libxft libxinerama 
```

### Install dwm repository:

```
git clone https://git.suckless.org/dwm ~/.config/dwm
```

Open directory and build it:

```
cd ~/.config/dwm
sudo make clean install
```

### Change default terminal to alacritty:

```
static const char *termcmd[]  = { "alacritty", NULL };
```

and make sure to do `make clean install` again to update your changes

### Install dmenu(really recomended if you installed dwm):

```
git clone https://git.suckless.org/dmenu ~/.config/dmenu
```

Open directory and build it:

```
cd ~/.config/dmenu
sudo make clean install
```

Set .xinitrc:

```
echo "exec dwm" >> /home/<your-user>/.xinitrc
```

Make it run automatically when start:

```
echo "startx" >> /home/<your-user>/.zprofile
```

## Instaling Ly 

```
git clone https://aur.archlinux.org/ly.git ~/.config/ly
```

Open directory and build it:

```
cd ly
makepkg -si
```

### Prepare .xinitrc:

```
sudo systemctl enable ly.service
```

And `reboot`.

## Install paru

```
sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru-bin.git && cd paru-bin && makepkg -si
```

Remove the folder

```
rm -fr paru-bin
```

## Install auto-cpufreq

```
paru -S auto-cpufreq
```

And eable it:

```
sudo systemctl enable --now auto-cpufreq.service
```

## Install timeshift (really important)

```
sudo pacman -S timeshift
```

edit this grub-btrfsd file:

```
sudo EDITOR=/usr/bin/nvim systemctl edit --full grub-btrfsd
```

and change the following:

```
ExecStart=/usr/bin/grub/btrfsd --syslog -t
```

check snapshots, and schedule periodicy in `sudo timeshift-gtk`
> settings > schedule

update grub-mkconfig:

```
sudo grub-mkconfig -o /boot/grub/grub.cfg
```

if it worked, next time you see the grub menu

you will have an option `Arch Linux Snapshots`
