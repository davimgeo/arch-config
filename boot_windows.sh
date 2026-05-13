#!/bin/bash

WINDOWS_BOOT_NUMBER=sudo efibootmgr | grep "Windows" | sed -E 's/Boot([0-9A-F]{4}).*/\1/'

echo -n "Do you want to boot into the following input?\n"
read answer

sudo efibootmgr | grep "Windows"

if [[ ! "$answer" =~ ^([yY]|[yY][eE][sS])$ ]]; then
  sudo efibootmgr -n WINDOWS_BOOT_NUMBER

  sudo reboot
else
  echo "Stoping program..."
fi

