#!/bin/bash

WAN_IP=$(curl -s ifconfig.me)

if [ -z "${1}" ]; then
    set -- "prysm" \
        --accept-terms-of-use \
        --datadir "/prysm/var" \
        --restore-target-dir "/prysm/var" \
        --execution-endpoint http://localhost:8551 \
        --jwt-secret /prysm/etc/jwtsecret \
        --p2p-local-ip 0.0.0.0 \
        --monitoring-host 0.0.0.0 \
        --p2p-host-ip ${WAN_IP} \
        --grpc-gateway-host 0.0.0.0 \
        --grpc-gateway-corsdomain '*' \
        --checkpoint-sync-url=https://mainnet.checkpoint.sigp.io \
        --genesis-beacon-api-url=https://mainnet.checkpoint.sigp.io
fi

exec "$@"