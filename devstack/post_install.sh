#!/bin/bash

BRANCH=stable/2023.1
REPO=https://opendev.org/openstack/devstack
WORKDIR=/opt/stack/devstack
PLUGIN=ovn


useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack
apt install -y git
mkdir /opt/stack/devstack
git clone --branch $BRANCH $REPO $WORKDIR
mv /home/vagrant/local-*.conf $WORKDIR
if [[ "$(hostname)" =~ "compute" ]]; then
    ln -s /opt/stack/devstack/local-$PLUGIN-compute.conf /opt/stack/devstack/local.conf
else
    ln -s /opt/stack/devstack/local-$PLUGIN.conf /opt/stack/devstack/local.conf
fi
chmod 755 /opt/stack
chmod 755 /opt/stack/devstack
chown stack:stack -R /opt/stack/devstack
cd /opt/stack/devstack
sudo -u stack ./stack.sh
