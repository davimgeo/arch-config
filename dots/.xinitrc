#!/bin/zsh

xrandr --output HDMI-1-0 --mode 1920x1080 --rate 179.96 --primary --output eDP-1 --off

feh --bg-scale ~/wallpapers/zero-two-high-res.jpg

picom &

exec dwm

