#!/bin/bash

BRNACH=stable/2023.1
REPO=https://opendev.org/openstack/devstack
WORKDIR=/opt/stack/devstack
PLUGIN=lb

useradd -s /bin/bash -d /opt/stack -m stack
echo "stack ALL=(ALL) NOPASSWD: ALL" | tee /etc/sudoers.d/stack
apt install -y git
git clone --branch $BRANCH $REPO $WORKDIR
cp /home/vagrant/local-*.conf $WORKDIR
ln -s local.conf local-$PLUGIN.cnf
chmod 755 /opt/stack/devstack
chown stack:stack -R /opt/stack/devstack
