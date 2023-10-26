#!/bin/bash
  IP_WAN=$(curl -s ip.anon.global)

  if cat /proc/cpuinfo | grep -q 'adx'; then
    echo "CPU supports ADX, using faster binary"
    ln -s /usr/local/bin/prysm-adx /usr/local/bin/prysm
  else
    echo "CPU does not support ADX, using generic binary"
    ln -s /usr/local/bin/prysm-no-adx /usr/local/bin/prysm
  fi

  if [ -z "${1}" ]; then
    set -- "prysm" \
      --accept-terms-of-use \
      --datadir "${APP_ROOT}/var" \
      --restore-target-dir "${APP_ROOT}/var" \
      --execution-endpoint http://localhost:8551 \
      --jwt-secret ${APP_ROOT}/etc/jwtsecret \
      --p2p-local-ip 0.0.0.0 \
      --monitoring-host 0.0.0.0 \
      --p2p-host-ip ${IP_WAN} \
      --grpc-gateway-host 0.0.0.0 \
      --grpc-gateway-corsdomain '*' \
      --checkpoint-sync-url=https://checkpoint.eth.web3.anon.global \
      --genesis-beacon-api-url=https://checkpoint.eth.web3.anon.global
  fi

  exec "$@"