#!/bin/sh

#-----MANUAL STEPS-------
#1. pacman -Syu
#2. reboot
#------------------------

#install wifi adapter drivers (if required)
pacman -S zd1211-firmware --noconfirm

#install wpa_supplicant (if not installed)
pacman -S wpa_supplicant --noconfirm

#copy wifi config files
cp wifi.service /etc/systemd/system/
cp home_network.conf /etc/wpa_supplicant/
cp wlan0.network /etc/systemd/network/

#start wifi service
systemctl daemon-reload
systemctl enable wifi.service
systemctl start wifi.service

# install ssmtp
pacman -S ssmtp
cp ssmtp.conf /etc/ssmtp/


# install notime
mkdir /etc/notime
cp notime.sh /etc/notime/
cp notime_demonizer.sh /usr/bin/
cp notime.service /etc/systemd/system/

touch /etc/notime/host_internet_addr.conf

chmod u+x /etc/notime/notime.sh
chmod u+x /usr/bin/notime_demonizer.sh

#start notime service
systemctl daemon-reload
systemctl enable notime.service
systemctl start notime.service
