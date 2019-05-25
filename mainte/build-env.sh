#!/bin/bash
#################################################
#   BUILD VDI ENV - 2019-05-25
#################################################

## PACKAGE UPDATE
apt update && \
apt -y upgrade && \
apt -y install xserver-xorg xinit pulseaudio blackbox

## INSTALL REMMINA
# https://remmina.org/how-to-install-remmina/#raspberry-pi
apt -y install dirmngr && \
apt-key adv --fetch-keys http://www.remmina.org/raspbian/remmina_raspbian.asc && \
echo "deb http://www.remmina.org/raspbian/ stretch main" > /etc/apt/sources.list.d/remmina_raspbian.list && \
apt update && \
apt -y install remmina gnome-keyring

