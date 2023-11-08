# OpenStack Cluster Setup for COA Exam Study

## Introduction
This repository documents my journey in setting up an all-in-one OpenStack cluster to prepare for the Certified OpenStack Administrator (COA) exam. The aim is to provide a comprehensive guide and resources for others who are embarking on the same path.

## Motivation
In the beginning, I used DevStack for setting up a simple OpenStack cluster. However, the available online tutorials were not thorough enough for my needs, particularly when it came to configuring a provider network.

I encountered difficulties with different Neutron network types such as OVN, Linuxbridge, and OVS. 

Additionally, the parameter names in DevStack's setup scripts were misleading and required me to delve deep into the complex bash scripts to understand their functionality. 

This prompted me to document the configurations that worked for me.

## Transition to Kolla-Ansible

Upon discovering that others faced similar challenges on Reddit, I was directed towards using Kolla-Ansible, which is designed to deploy a production-grade OpenStack cluster.

Kolla-Ansible proved to be much easier to use.

Consequently, I moved my DevStack configurations into a subfolder and created a new one for Kolla-Ansible configurations.

## Quickstart with Kolla-Ansible

To get started with a functional OpenStack cluster using Kolla-Ansible, simply follow the quickstart guide:

- [Kolla-Ansible Quickstart](https://docs.openstack.org/kolla-ansible/latest/user/quickstart.html)

## Additional Configurations

In the Kolla-Ansible folder, you will find configurations for enabling various features:

### Swift Object Storage

To enable Swift with storage policies and additional disks for the VMs, follow the guide below and create the necessary ring files:

- [Swift Guide](https://docs.openstack.org/kolla-ansible/latest/reference/storage/swift-guide.html)

### Cinder Block Storage

For Cinder, label your disks accordingly:

- [Cinder Guide](https://docs.openstack.org/kolla-ansible/latest/reference/storage/cinder-guide.html)

### Additional Features

- Volume backup
- LUKS encryption with Barbican in Nova and Cinder (Note: It's tricky because Barbican is not configured on Swift and Cinder by default).

To override the default configurations, place your custom config files into `/etc/kolla/config`. These will be merged with the existing ones, hence the `config` folder in this repository.

### TLS and Troubleshooting

I attempted to enable TLS; however, it caused issues with the volume backup service's connectivity to the database.

This may be due to enabling TLS at pos- setup. Therefore, it is currently disabled. It's advised to start with a fresh installation if you wish to enable TLS.
