#!/bin/bash

index=0
for d in sdc sdd sde; do
    sudo parted /dev/${d} -s -- mklabel gpt mkpart KOLLA_SWIFT_DATA 1 -1
    sudo mkfs.xfs -f -L d${index} /dev/${d}1
    (( index++ ))
done

STORAGE_NODES=(10.0.114.11)
KOLLA_SWIFT_BASE_IMAGE="kolla/centos-source-swift-base:4.0.0"
mkdir -p /etc/kolla/config/swift

sudo docker run \
  --rm \
  -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
  swift-ring-builder \
    /etc/kolla/config/swift/object.builder create 10 3 1

for node in ${STORAGE_NODES[@]}; do
    for i in {0..2}; do
      sudo docker run \
        --rm \
        -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
        swift-ring-builder \
          /etc/kolla/config/swift/object.builder add r1z1-${node}:6000/d${i} 1;
    done
done

sudo docker run \
  --rm \
  -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
  swift-ring-builder \
    /etc/kolla/config/swift/account.builder create 10 3 1

for node in ${STORAGE_NODES[@]}; do
    for i in {0..2}; do
      sudo docker run \
        --rm \
        -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
        swift-ring-builder \
          /etc/kolla/config/swift/account.builder add r1z1-${node}:6001/d${i} 1;
    done
done

sudo docker run \
  --rm \
  -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
  swift-ring-builder \
    /etc/kolla/config/swift/container.builder create 10 3 1

for node in ${STORAGE_NODES[@]}; do
    for i in {0..2}; do
      sudo docker run \
        --rm \
        -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
        swift-ring-builder \
          /etc/kolla/config/swift/container.builder add r1z1-${node}:6002/d${i} 1;
    done
done

for ring in object account container; do
  sudo docker run \
    --rm \
    -v /etc/kolla/config/swift/:/etc/kolla/config/swift/ \
$KOLLA_SWIFT_BASE_IMAGE \
    swift-ring-builder \
      /etc/kolla/config/swift/${ring}.builder rebalance;
done
