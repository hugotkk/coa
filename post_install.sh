#!/bin/bash

sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo apt install -y git openvswitch-switch
cd /opt/stack
git clone https://opendev.org/openstack/devstack
cd devstack
git checkout stable/2023.1
cat <<EOF | tee local.conf
[[local|localrc]]
LOGFILE=/opt/stack/logs/stack.sh.log

ADMIN_PASSWORD=openstack
DATABASE_PASSWORD=openstack
RABBIT_PASSWORD=openstack
SERVICE_PASSWORD=openstack
HOST_IP=10.0.114.11

# Enable Security Group
Q_USE_SECGROUP=True

# Disable Subnet Pool
USE_SUBNETPOOL=False

# Use for create bridge and add network device to the bridge
PUBLIC_BRIDGE=br-ex
PUBLIC_INTERFACE=enp0s9

# Use for setp OVN bridge mapping
PHYSICAL_NETWORK=providernet
OVS_PHYSICAL_BRIDGE=br-ex

IP_VERSION=4

# Use for setup public network (like web gui)
Q_USE_PROVIDERNET_FOR_PUBLIC=True
PUBLIC_NETWORK_NAME=provider
PUBLIC_PHYSICAL_NETWORK=providernet
PUBLIC_NETWORK_GATEWAY=203.0.114.1
FLOATING_RANGE=203.0.114.0/24
EOF

chmod 755 /opt/stack/devstack
chown stack:stack -R /opt/stack/devstack
