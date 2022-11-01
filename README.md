# Info
"Go implementation of Ethereum proof of stake"

This container provides an easy and simple way to use prysm without the hassle of library dependencies and compiling the source yourself.
It will also determine your CPU set and run the correct prysm client support your CPU the best.

## Volumes
* /prysm/var - Purpose: Stores beacon chain data

## Run
```shell
docker run --name prysm \
    -v /your/path/var:/prysm/var \
    -v /your/geth/jwtsecret:/prysm/etc/jwtsecret \
    -d 11notes/prysm:[tag]
```

Default run command will checkpoint sync (bootstrap) your node if no beaconchain DB is found and connect to geth on localhost.

# Examples run
```shell
docker run --name prysm \
    -v /your/path/var:/prysm/var \
    -v /your/geth/jwtsecret:/prysm/etc/jwtsecret \
    -d 11notes/prysm:[tag] \
        prysm \
            --accept-terms-of-use \
            --datadir "/prysm/var" \
            --restore-target-dir "/prysm/var" \
            --execution-endpoint http://localhost:8551 \
            --jwt-secret /prysm/etc/jwtsecret \
            --p2p-local-ip 0.0.0.0 \
            --monitoring-host 0.0.0.0 \
            --p2p-host-ip 13.224.103.127 \
            --grpc-gateway-host 0.0.0.0 \
            --grpc-gateway-corsdomain '*' \
            --checkpoint-sync-url=https://mainnet.checkpoint.sigp.io \
            --genesis-beacon-api-url=https://mainnet.checkpoint.sigp.io \
            --suggested-fee-recipient=0xDEAD*************************
```

## Docker -u 1000:1000 (no root initiative)
As part to make containers more secure, this container will not run as root, but as uid:gid 1000:1000. Therefore, you have to make sure that all volumes you mount into the container are owned by the uid/gid.

## Tipps
* Use storage capable of 10k IOPS at 4kQD1 (no cache!) like Samsung 980 Pro
* Use [telegraf](https://github.com/influxdata/telegraf) to export :8080 to [influxdb](https://github.com/influxdata/influxdb)

## Built with
* [prysm](https://github.com/prysmaticlabs/prysm) - Prysm Consensus Client (Proof of Stake)
* [ubuntu](https://hub.docker.com/_/ubuntu) - Ubuntu base image