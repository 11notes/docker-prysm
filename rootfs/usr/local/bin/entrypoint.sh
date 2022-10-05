#!/bin/ash
if [ -z "$1" ]; then
    set -- "prysm" \
        --accept-terms-of-use \
        --datadir "/eth/prysm/var" \
        --restore-target-dir "/eth/prysm/var" \
        --execution-endpoint http://${GETH}:8551 \
        --jwt-secret /prysm/etc/jwtsecret \
        --block-batch-limit 256 \
        --p2p-max-peers 512 \
        --slots-per-archive-point 8192 \
        --max-goroutines 65536
fi

exec "$@"