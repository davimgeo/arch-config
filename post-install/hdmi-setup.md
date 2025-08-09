Try changing the framebuffer in grub config, do

```
cat /proc/fb
```

to check the actives framebuffers, ex:

```
0 inteldrmfb
1 nouveau
```

then add the following to `sudo nvim /etc/default/grub` 

```
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet ... fbcon=map:1"
```

map:1 if you want the second framebuffer, and map:0 if you want the first.

map:1 works for me.

Laptop lid configuration (ignore when close)

```
sudo nvim /etc/systemd/logind.conf
```

And change the following:

```
HandleLidSwitch=ignore
HandleLidSwitchDocked=ignore
```

and `reboot`

Source: https://unix.stackexchange.com/questions/193470/how-do-i-change-which-monitor-the-tty-shows-up-on
