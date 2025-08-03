# How to setup HDMI on NVIDIA-Optimus

In NVIDIA-Optimus, GPU usually handles the HDMI output
so we need to install nvidia drivers, and also configure 
xrandr so we can tell Arch to use NVIDIA port for HDMI

## Install nvidia drivers

```
sudo pacman -S nvidia nvidia-utils nvidia-settings
```

Update mkinitcpio and grub


```
sudo mkinitcpio -P linux
grub-mkconfig -o /boot/grub/grub.cfg
```

and `sudo reboot` (necessary)

### Checking if its working

Check the available providers in xrandr

```
xrandr --listproviders
```

if it says "NVIDIA-G0", its working.

## Output to HDMI

Add to .xinitrc:

```
xrandr --setprovideroutputsource NVIDIA-G0 modesetting
xrandr --auto
```

### Laptop lid configuration (ignore when close)

```
sudo nvim /etc/systemd/logind.conf
```

And change the following:

```
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore
```
