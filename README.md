# docker-prysm

Container to run the prysm ethereum consensus client.

## Volumes

/prysm/var

Purpose: Stores beacon chain data

## Run

default settings
```shell
docker run --name prysm \
    -v /your/NVMe/storage:/prysm/var \
    -v /your/geth/jwtsecret:/prysm/etc/jwtsecret \
    -d 11notes/prysm:[tag]
```

Default run command will checkpoint sync (bootstrap) your node if no beaconchain DB is found and connect to geth on localhost.

custom settings
```shell
docker run --name prysm \
    -v /your/NVMe/storage:/prysm/var \
    -d 11notes/prysm:[tag] \
        prysm \
            --accept-terms-of-use \
            --datadir "/prysm/var" \
            --restore-target-dir "/prysm/var" \
            --execution-endpoint http://geth-node:8551 \
            ...
```

## Docker -u 1000:1000 (no root initiative)

As part to make containers more secure, this container will not run as root, but as uid:gid 1000:1000. Make sure your volume is chown 1000:1000.

## Build with

* [prysm](https://github.com/prysmaticlabs/prysm) - Prysm Consensus Client (Proof of Stake)
* [ubuntu](https://hub.docker.com/_/ubuntu) - Ubuntu base image

## Tips

* Don't bind to ports < 1024 (requires root), use NAT/LB/proxy/...
* [Permanent Storge with NFS/CIFS/...](https://github.com/11notes/alpine-docker-netshare) - Module to store permanent container data via NFS/CIFS/...