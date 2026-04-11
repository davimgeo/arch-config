# install JetBrains Nerd Mono
wget -P ~/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip \
&& cd ~/.local/share/fonts \
&& unzip JetBrainsMono.zip \
&& rm JetBrainsMono.zip \
&& fc-cache -fv

# Add HDMI indo GNOME Login Manager
sudo cp ~/.config/monitors.xml /var/lib/gdm3/.config/

# Firefox add-ons

Adaptative Tab Color
Vimium
Tabliss
