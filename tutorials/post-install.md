## Set keyfile:

### Create keyfile for paswordless login

```
dd bs=512 count=4 if=/dev/urandom of=/crypto_keyfile.bin
```

### Add keyfile to encrypted disk

```
cryptsetup luksAddKey /dev/nvme0n1p3 /crypto_keyfile.bin
```

and add to /etc/mkinitcpio.conf the folowwing:

```
FILES=(/crypto_keyfile.bin)
```

Then run:

```
mkinitcpio -p linux
```

Reboot again, you’ll only need to enter your password once.

```
reboot
```

### Secure keyfile and /boot

```
chmod 000 /crypto_keyfile.bin
chmod -R g-rwx,o-rwx /boot
```

## Instaling DWM

Install required dependencies:

```
pacman -S xorg-server xorg-xinit xorg-fonts-misc libx11 libxinerama 
```

### Install st:

```
git clone https://git.suckless.org/st ~/.st
```

Open directory and build it:

```
cd ~/.st
make clean install
```

### Install dwm:

```
git clone https://git.suckless.org/dwm ~/.dwm
```

Open directory and build it:

```
cd ~/dwm
make clean install
```

Open `~/.dwm/config.h` and change the line that starts with #define SHCMD(cmd)

and change the path for the path you installed st(you can check it with `which st`)

something like this:

```
#define SHCMD(cmd) { .v = (const char*[]){ "/usr/local/bin/st", "-c", cmd, NULL } }
```

and make sure to do `make clean install` again to update your changes


### Install dmenu(really recomended if you installed dwm):

```
git clone https://git.suckless.org/dmenu ~/.dmenu
```

Open directory and build it:

```
cd ~/dmenu
make clean install
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
git clone https://aur.archlinux.org/ly.git ~/ly
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
grub-mkconfig -o /boot/grub/grub.cfg
```

if it worked, next time you see the grub menu

you will have an option `Arch Linux Snapshots`
