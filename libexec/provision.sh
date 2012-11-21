#!/bin/bash -feux

#/ NAME
#/     provision.sh -- vagrant shell provisioner for zendesk definition
#/
#/ SYNOPSIS
#/     
#/     ./provision.sh
#/

umask 022

# figure out the project root under which bin, lib live
shome="/vagrant"
cd $shome

# entry point
function main {
  export DEBIAN_FRONTEND=noninteractive

  # update packages
  aptitude update
  aptitude safe-upgrade -q -y

  # aptitude cleanup
  aptitude clean
}

# pass arguments to entry point
main "$@"
