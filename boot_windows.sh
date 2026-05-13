#!/bin/bash

WINDOWS_BOOT_NUMBER=$(sudo efibootmgr | grep "Windows" | sed -E 's/Boot([0-9A-F]{4}).*/\1/')

echo -e "Do you want to boot into the following input? (Y/N)\n"
sudo efibootmgr | grep "Windows"

read -r answer

if [[ "$answer" =~ ^([yY]|[yY][eE][sS])$ ]]; then
  sudo efibootmgr -n "$WINDOWS_BOOT_NUMBER"
  sudo reboot
else
  echo "Stopping program..."
fi

