#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)
. "$REPO_ROOT"/setup/.env

seal() {
  kubeseal --cert ${REPO_ROOT}/setup/sealed-secrets.crt -o yaml $@
}

if [ ! -f "${REPO_ROOT}/cert-manager/route53-api-key.yaml" ]; then
  kubectl create secret --namespace=cert-manager generic route53-api-key --from-literal=key="${ROUTE53_KEY}" --dry-run=client -o yaml | seal > "${REPO_ROOT}"/cert-manager/route53-api-key.yaml
fi
