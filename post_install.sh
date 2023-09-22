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
EOF

chmod 755 /opt/stack/devstack
chown stack:stack -R /opt/stack/devstack
