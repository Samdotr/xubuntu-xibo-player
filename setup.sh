#!/bin/bash

# change to xibo_client directory within home folder
cd ~/xubuntu-xibo-player/

# update the system
sudo apt update
sudo apt full-upgrade -y

# remove unnecessary packages
sudo apt remove -y libreoffice-common libreoffice-style-elementary libreoffice-style-tango libreoffice-style-colibre zfsutils-linux zfs-initramfs zfs-zed thunderbird transmission-common pidgin cups bluez language-pack-bn language-pack-de language-pack-fr language-pack-es printer-driver-brlaser printer-driver-foo2zjs printer-driver-m2300w printer-driver-pnm2ppa printer-driver-ptouch printer-driver-pxljr printer-driver-sag-gdi printer-driver-min12xxw printer-driver-c2esp printer-driver-foo2zjs-common network-manager-pptp pptp-linux xfburn system-config-printer-common system-config-printer-udev simple-scan sgt-launcher sgt-puzzles xfce4-weather-plugin xfce4-mailwatch-plugin mobile-broadband-provider-info xserver-xorg-input-wacom pidgin-otr mate-calc-common cups-bsd cups-client cups-common cups-filters cups-filters-core-drivers cups-ipp-utils gnome-sudoku gimp gimp-data cryptsetup cryptsetup-bin cryptsetup-initramfs cryptsetup-run xfce4-screensaver update-manager-core
sudo rm -r /usr/share/hplip/

# optional, install certificates on client if required
#sudo mkdir /usr/share/ca-certificates/local/
#sudo cp YOUR-CERTIFICATE-CA.crt /usr/share/ca-certificates/local/
#sudo cp YOUR-CERTIFICATE.crt /usr/share/ca-certificates/local/
#sudo cp YOUR-CERTIFICATE.key /usr/share/ca-certificates/local/
#sudo dpkg-reconfigure ca-certificates

# set power management settings eg display sleep
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/inactivity-sleep-mode-on-ac -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-sleep -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/power-button-action -s 4
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/lid-action-on-ac -s 0

# install required apt packages
echo "Installing HTOP"
sudo apt -y install htop
echo "HTOP package now installed"

sudo apt autoremove -y

# vnc server setup
echo "Configuring x11vnc client"
sudo mkdir /etc/x11vnc
sudo x11vnc --storepasswd /etc/x11vnc/vncpwd
sudo bash -c "echo [Unit] >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo Description=Start x11vnc at startup. >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo After=multi-user.target >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo [Service] >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo Type=simple >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo ExecStart=/usr/bin/x11vnc -auth guess -forever -noxdamage -repeat -rfbauth /etc/x11vnc/vncpwd -rfbport 5900 -shared >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo [Install] >> /lib/systemd/system/x11vnc.service"
sudo bash -c "echo WantedBy=multi-user.target >> /lib/systemd/system/x11vnc.service"
sudo systemctl daemon-reload
sudo systemctl enable x11vnc.service
sudo systemctl start x11vnc.service

echo "Installing xibo player snap"
sudo snap install xibo-player
