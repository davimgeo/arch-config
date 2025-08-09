#!/bin/zsh

xrandr --setprovideroutputsource NVIDIA-G0 modesetting
#xrandr --output HDMI-1-0 --mode 1920x1080 --rate 179.96
xrandr --auto

picom &
polybar &

# firewall related

firewalld

exec i3

