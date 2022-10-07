#!/bin/bash
if [ -z "$1" ]; then
    set -- "prysm" \
        --accept-terms-of-use \
        --datadir "/prysm/var" \
        --restore-target-dir "/prysm/var" \
        --execution-endpoint http://localhost:8551 \
        --jwt-secret /prysm/etc/jwtsecret \
        --block-batch-limit 256 \
        --slots-per-archive-point 8192 \
        --max-goroutines 65536 \
        --p2p-local-ip 0.0.0.0 \
        --p2p-max-peers 512 \
        --grpc-gateway-host 0.0.0.0 \
        --grpc-gateway-corsdomain '*'
fi

exec "$@"