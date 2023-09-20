#!/bin/bash

sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo apt install -y git openvswitch-switch
cd /opt/stack
git clone https://opendev.org/openstack/devstack
cd devstack
#git checkout stable/ussuri
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
#PUBLIC_PHYSICAL_NETWORK=public

#Q_USE_SECGROUP=True
#Q_USE_PROVIDERNET_FOR_PUBLIC=True
Q_AGENT=linuxbridge

OVN_GENEVE_OVERHEAD=10000

LB_PHYSICAL_INTERFACE=enp0s9
LB_INTERFACE_MAPPINGS=public:enp0s9
EOF
cd ../
chown stack:stack -R devstack
