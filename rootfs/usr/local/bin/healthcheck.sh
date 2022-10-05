#!/bin/ash
curl --max-time 5 -s http://localhost:3500/eth/v1/node/syncing || exit 1