#!/bin/bash

sudo apt update
sudo apt install git python3-dev libffi-dev gcc libssl-dev
sudo apt install python3-venv

python3 -m venv env
source env/bin/activate
pip install -U pip
pip install 'ansible>=6,<8'
pip install git+https://opendev.org/openstack/kolla-ansible@master

sudo mkdir -p /etc/kolla
sudo chown $USER:$USER /etc/kolla

cp -r /path/to/venv/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
cp -r env/share/kolla-ansible/etc_examples/kolla/* /etc/kolla
cp env/share/kolla-ansible/ansible/inventory/all-in-one .

kolla-ansible install-deps
kolla-genpwd

kolla-ansible -i ./all-in-one bootstrap-servers
kolla-ansible -i ./all-in-one prechecks
kolla-ansible -i ./all-in-one deploy

