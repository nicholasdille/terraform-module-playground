#!/bin/bash
set -o errexit

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

if test -z "${HETZNERDNS_TOKEN}"; then
    echo "ERROR: HETZNERDNS_TOKEN is not set"
    exit 1
fi

hcloud server list --selector=purpose=${NAME} --output=json \
| jq '.[].id' \
| xargs -I{} \
    hcloud server delete {}

hcloud ssh-key list --selector=purpose=${NAME} --output=json \
| jq '.[].id' \
| xargs -I{} \
    hcloud ssh-key delete {}

curl -sSfH "Auth-API-Token: ${HETZNERDNS_TOKEN}" "https://dns.hetzner.com/api/v1/zones" \
| jq --raw-output --arg zone "${ZONE}" '.zones[] | select(.name == $zone) | .id' \
| xargs -I{} \
    curl -sSfH "Auth-API-Token: ${HETZNERDNS_TOKEN}" "https://dns.hetzner.com/api/v1/records?zone_id={}" \
| jq --raw-output '.records[] | select(.name == "minecraft") | .id' \
| xargs -I{} \
    curl -sSfX DELETE -H "Auth-API-Token: ${HETZNERDNS_TOKEN}" "https://dns.hetzner.com/api/v1/records/{}"
