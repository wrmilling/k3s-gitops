#!/bin/bash

if [[ -z "$DOMAIN" ]]; then
  echo ".env does not appear to be sourced, sourcing now"
  . ../.env
fi

kseal() {
    name=$(basename -s .txt "$@")
    if [[ -z "$NS" ]]; then
      NS=default
    fi
    envsubst < "$@" > values.yaml | kubectl -n "$NS" create secret generic "$name" --from-file=values.yaml --dry-run -o json | kubeseal --format=yaml --cert=../pub-cert.pem && rm values.yaml
}

###################
# helm chart values
###################

NS=kube-system kseal values-to-encrypt/traefik-values.txt > ../../secrets/traefik-values.yaml
