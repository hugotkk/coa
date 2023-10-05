#!/bin/bash

NATNET=coa-nat
HOSTNET=coa-host

# Check if the NAT network exists
nat_exists=$(VBoxManage natnetwork list | grep $NATNET)

# If not, create it
if [ -z "$nat_exists" ]; then
  VBoxManage natnetwork add --netname $NATNET --network "203.0.114.0/24" --enable
  echo Network $NATNET has been created
else
  echo Network $NATNET already exists
fi

# Check if the host-only network exists
hostonly_exists=$(VBoxManage list hostonlynets | grep $HOSTNET)

# If not, create and configure it
if [ -z "$hostonly_exists" ]; then
  VBoxManage hostonlynet add --name $HOSTNET --netmask 255.255.255.0 --lowerip 10.0.114.2 --upperip 10.0.114.254 --enable
  echo Network $NATNET has been created
else
  echo Network $NATNET already exists
fi

