#!/usr/bin/env bash

PRIVATEKEY="sealed-secrets.key"
PUBLICKEY="sealed-secrets.crt"
NAMESPACE="kube-system"
SECRETNAME="sealed-secrets-cert"

if [ ! -f "${PRIVATEKEY}" ]; then 
  echo "Private key not found, generating one"
  openssl req -x509 -nodes -newkey rsa:4096 -keyout "$PRIVATEKEY" -out "$PUBLICKEY" -subj "/CN=sealed-secret/O=sealed-secret"
fi

echo "Uploading secret to the cluster"
kubectl -n "$NAMESPACE" create secret tls "$SECRETNAME" --cert="$PUBLICKEY" --key="$PRIVATEKEY"
kubectl -n "$NAMESPACE" label secret "$SECRETNAME" sealedsecrets.bitnami.com/sealed-secrets-key=active
