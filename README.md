# OpenStack Hands-on with Vagrant

This repository delivers a Vagrant setup tailored for individuals eager to dive into OpenStack hands-on. 

A Controller and Compute on VirtualBox will be setup.

## Specifications:

- **Devstack Version**: 2023.1
- **Network**: OVN
- **Provisioning Tool**: Vagrant
- **Virtualization Tool**: VirtualBox

## Pre-requisites
- VirtualBox
- Vagrant

## Getting Started

**Clone this repository**:
```
git clone git@github.com:hugotkk/coa.git
```

**Network Configuration**:

Configure the necessary networks by executing the following script:

```bash
./network.sh
```

**Launching Virtual Machines**:

Start the Controller VM:

```bash
vagrant up coa-controller
```

Start the Compute VM:

```bash
vagrant up coa-compute
```

**Accessing VMs**:

Once your VMs are up and running, you can SSH into them using the following commands:

Connect to the Controller VM:

```bash
vagrant ssh coa-controller
```

Connect to the Compute VM:

```bash
vagrant ssh coa-compute
```

**Accessing OpenStack Dashboard**:

Open your web browser and navigate to the Horizon dashboard using the following URL:
- [http://10.0.114.11](http://10.0.114.11)

Login with the following credentials:
- Username: admin
- Password: openstack
