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
PUBLIC_INTERFACE=enp0s9

FLOATING_RANGE="192.0.114.0/24"

PUBLIC_NETWORK_GATEWAY="192.0.114.1"
PUBLIC_INTERFACE=enp0s9
PUBLIC_PHYSICAL_NETWORK=public

FIXED_RANGE=10.0.0.0/24
NETWORK_GATEWAY=10.0.0.1

Q_USE_SECGROUP=True
Q_USE_PROVIDERNET_FOR_PUBLIC=True
Q_PLUGIN=ml2
Q_AGENT=linuxbridge
Q_ML2_PLUGIN_MECHANISM_DRIVERS=linuxbridge,l2population
Q_ML2_PLUGIN_TYPE_DRIVERS=flat,vlan,vxlan
Q_ML2_TENANT_NETWORK_TYPE=flat,vlan,vxlan

ENABLE_TENANT_TUNNELS=True

LB_PHYSICAL_INTERFACE=enp0s9
LB_INTERFACE_MAPPINGS=public:enp0s9
EOF
cd ../
chown stack:stack -R devstack
