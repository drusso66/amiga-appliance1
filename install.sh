#!/bin/bash
set -e

echo "=== Amiga Appliance Installer ==="

USER_HOME=$(eval echo "~$SUDO_USER")

echo "[1/7] Installing packages..."
apt update
apt install -y --no-install-recommends \
xorg openbox lightdm unclutter feh rofi \
pulseaudio git build-essential \
libgtk-3-dev libportaudio2 \
libpng-dev libmpeg2-4-dev \
intel-media-va-driver mesa-utils

echo "[2/7] Enabling autologin..."
cat <<EOF >/etc/lightdm/lightdm.conf
[Seat:*]
autologin-user=$SUDO_USER
autologin-session=openbox
EOF

echo "[3/7] Creating directories..."
mkdir -p $USER_HOME/amiga/{configs,roms,hdf,logos}

echo "[4/7] Installing WinUAE..."
cd /opt
git clone https://github.com/tonioni/WinUAE.git
cd WinUAE
make
make install

echo "[5/7] Copying configs, scripts, logos..."
cp configs/*.uae $USER_HOME/amiga/configs/
cp scripts/boot-amiga.sh $USER_HOME/amiga/
cp logos/*.png $USER_HOME/amiga/logos/

chmod +x $USER_HOME/amiga/boot-amiga.sh
chown -R $SUDO_USER:$SUDO_USER $USER_HOME/amiga

echo "[6/7] Openbox autostart..."
mkdir -p $USER_HOME/.config/openbox
cat <<EOF >$USER_HOME/.config/openbox/autostart
unclutter &
$USER_HOME/amiga/boot-amiga.sh &
EOF

chown -R $SUDO_USER:$SUDO_USER $USER_HOME/.config

echo "[7/7] Done."
echo "-------------------------------------------------"
echo "NOW COPY YOUR KICKSTART ROMS INTO:"
echo "$USER_HOME/amiga/roms"
echo ""
echo "Reboot when ready."
