#!/bin/bash -feux

umask 022

export DEBIAN_FRONTEND=noninteractive

# update packages
aptitude update
aptitude safe-upgrade -q -y

# vbox guest additions
ver_virtualbox="$(cat .vbox_version)"
pth_guestadditions="$HOME/VBoxGuestAdditions_$ver_virtualbox.iso"
mount -o loop "$pth_guestadditions" /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt

# remove cached network configurations
rm -f /etc/udev/rules.d/70-persistent-net.rules
mkdir -p /etc/udev/rules.d/70-persistent-net.rules
rm /lib/udev/rules.d/75-persistent-net-generator.rules
rm -rf /dev/.udev/ /var/lib/dhcp3/*

# wake up eth0
perl -pe 'm{exit 0} && print "dhclient eth0\n"' -i /etc/rc.local
