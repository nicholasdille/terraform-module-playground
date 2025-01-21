#!/bin/bash

: "${ZONE:=$1}"
if test -z "${ZONE}"; then
  echo "Usage: $0 <zone> <name>"
  exit 1
fi

: "${NAME:=$2}"
if test -z "${NAME}"; then
  echo "Usage: $0 <zone> <name>"
  exit 1
fi

hcloud server list --selector=purpose="${NAME}"
hcloud ssh-key list --selector=purpose="${NAME}"

curl -sSfH "Auth-API-Token: $(pp hetzner-dns-web)" "https://dns.hetzner.com/api/v1/zones" \
| jq --raw-output --arg zone inmylab.de '.zones[] | select(.name == $zone) | .id' \
| xargs -I{} \
    curl -sSfH "Auth-API-Token: $(pp hetzner-dns-web)" "https://dns.hetzner.com/api/v1/records?zone_id={}" \
| jq --arg name playground2 '.records[] | select(.name | endswith($name))'
