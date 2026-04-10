# Essential programs to install after the instalation

## Important apps

```
sudo pacman -Sy flameshot
```

## Controls mouse dpi and LED

```
sudo pacman -S ratbagd
```

- Ex:
- ratbagctl list
- ratbagctl "your_device" dpi set 1600
- ratbagctl "your_device" led 0 set mode off

[ Note: needs multilib enabled, check tutorial/must-configs.txt ]

```
sudo pacman -Sy steam
```

## Install paru

```
sudo pacman -S --needed base-devel && git clone https://aur.archlinux.org/paru.git && cd paru && makepkg -si
```

## Install Brave from AUR

```
paru -S brave-bin
```

