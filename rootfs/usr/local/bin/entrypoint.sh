#!/bin/bash

WAN_IP=$(curl -s ifconfig.me)

BIRed='\033[1;91m'
BIGreen='\033[1;92m'
NC='\033[0m'

if cat /proc/cpuinfo | grep -q 'adx'; then
    echo "${BIGreen}CPU supports ADX, using faster binary${NC}"
    ln -s /usr/local/bin/prysm-adx /usr/local/bin/prysm
else
    echo "${BIRed}CPU does not support ADX, using generic binary${NC}"
    ln -s /usr/local/bin/prysm-no-adx /usr/local/bin/prysm
fi

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
        --checkpoint-sync-url=https://checkpoint.eth.web3.eleven.cloud \
        --genesis-beacon-api-url=https://checkpoint.eth.web3.eleven.cloud
fi

exec "$@"