#!/bin/bash -feux

umask 022

export DEBIAN_FRONTEND=noninteractive

# update packages
aptitude update
aptitude safe-upgrade -q -y

# vbox guest additions
ver_virtualbox="$(cat .vbox_version)"
url_guestadditions="http://download.virtualbox.org/virtualbox/$ver_virtualbox/VBoxGuestAdditions_$ver_virtualbox.iso"
pth_guestadditions="$HOME/VBoxGuestAdditions_$ver_virtualbox.iso"
wget -nv -O "$pth_guestadditions" "$url_guestadditions"
mount -o loop "$pth_guestadditions" /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -f "$pth_guestadditions"

# wake up eth0
perl -pe 'm{exit 0} && print "dhclient eth0\n"' -i /etc/rc.local

# remove cached network configurations
rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir -p /etc/udev/rules.d/70-persistent-net.rules
rm /lib/udev/rules.d/75-persistent-net-generator.rules
rm -rf /dev/.udev/ /var/lib/dhcp3/*

# zero out virtual disk for compression
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
