#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)
. "$REPO_ROOT"/setup/.env

seal() {
  if [ -f "${REPO_ROOT}/${1}.yaml" ]; then
    echo "${1}.yaml: Already exists"
  else 
    echo "${1}.yaml: Sealing secret"
    envsubst < ${REPO_ROOT}/${1}.template | kubeseal --cert ${REPO_ROOT}/setup/sealed-secrets.crt -o yaml > ${REPO_ROOT}/${1}.yaml
  fi
}

seal "cert-manager/route53-api-key"
seal "flux-system-extra/github-alerts/github-api-token"