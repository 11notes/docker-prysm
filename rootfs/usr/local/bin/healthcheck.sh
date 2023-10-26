#!/bin/bash
  CURL_RESULT=$(curl -s http://localhost:8080/healthz) || exit 12
  while read STATUS; do
  if ! echo "${STATUS}" | grep -q ': OK$'; then
      exit 13
  fi
  done < <(echo "${CURL_RESULT}")
  exit 0