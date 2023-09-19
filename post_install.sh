#!/bin/bash

sudo useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
sudo apt install -y git
sudo su - stack
git clone https://opendev.org/openstack/devstack
cd devstack
git checkout stable/ussuri
cat <<EOF | tee local.conf
[[local|localrc]]
ADMIN_PASSWORD=openstack
DATABASE_PASSWORD=openstack
RABBIT_PASSWORD=openstack
SERVICE_PASSWORD=openstack
HOST_IP=192.168.56.11
EOF
