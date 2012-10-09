#!/bin/bash -feux

umask 022

# dont prompt
export DEBIAN_FRONTEND="noninteractive"

# update packages
aptitude update
aptitude install -q -y linux-virtual linux-headers-virtual linux-image-virtual linux-headers
aptitude install -q -y ntp
aptitude hold linux-virtual linux-headers-virtual linux-image-virtual linux-headers
aptitude safe-upgrade -q -y
aptitude clean
