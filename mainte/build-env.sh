#!/bin/bash
#################################################
#   VDI BUILD ENV
#################################################
## PROXY
# PROXY=http://hostname:port/
# cat > /etc/apt/apt.conf.d/99proxy << EOF
# Acquire::http::Proxy  "$PROXY";
# Acquire::https::Proxy "$PROXY";
# EOF
# APTKEYPX="--keyserver-option http-proxy=$PROXY"

## PACKAGE UPDATE
apt update && \
apt -y upgrade && \
apt -y install xserver-xorg xinit pulseaudio blackbox

## INSTALL REMMINA
# https://remmina.org/how-to-install-remmina/#raspberry-pi
apt -y install dirmngr && \
apt-key adv $APTKEYPX --fetch-keys http://www.remmina.org/raspbian/remmina_raspbian.asc && \
echo "deb http://www.remmina.org/raspbian/ stretch main" > /etc/apt/sources.list.d/remmina_raspbian.list && \
apt update && \
apt -y install remmina gnome-keyring

## auto start
cat >> /etc/profile << EOF

if [ \$UID -eq 0 ]; then
    exit
fi
/opt/vdi-tools/menu.sh

EOF

## SET HOSTNAME
hostnamectl set-hostname vdi

## SET ROOT PASSWORD
echo "SET ROOT PASSWORD"
passwd root

## REBOOT
reboot

