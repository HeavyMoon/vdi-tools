#!/bin/bash
#################################################
#   VDI SETUP USER
#################################################
## USER CHECK
if [ $UID -en 0 ]; then
    echo "Run as root. Exit..."
    exit 1
fi

## SETUP MAINTENANCE USER
MPW=mainte
usermod -l mainte -m -p "$MPW" pi
groupmod -n mainte pi
rm -r /home/pi

## SETUP VDI USER
UPW=vdi
useradd -m -p "$UPW" vdi

ln -fs /lib/systemd/system/getty@.service /etc/systemd/system/getty.target.wants/getty@tty1.service
cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf << EOF
[Service]
ExecStart=
ExecStart=-/sbin/agetty --autologin vdi --noclear %I \$TERM
EOF

mkdir -p /home/vdi/.config/remmina/
cat > /home/vdi/.config/remmina/remmina.pref << EOF
[remmina_pref]
disable_tray_icon=true
fullscreen_toolbar_visibility=2
EOF
chown -R  vdi:vdi /home/vdi/.config/

## PAM FOR POQWEOFF
cat > /etc/pam.d/poweroff << EOF
#PAM-1.0
auth       sufficient   pam_rootok.so
auth       sufficient   pam_listfile.so onerr=fail item=user sense=allow file=/etc/security/poweroff
auth       required     pam_console.so
account    required     pam_permit.so
EOF
echo vdi >> /etc/security/poweroff
