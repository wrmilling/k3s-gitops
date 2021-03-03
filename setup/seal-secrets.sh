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

# flux-system
seal "flux-system-extra/github-alerts/github-api-token"
seal "flux-system-extra/discord-alerts/discord-webhook-url"

# kube-system
seal 'kube-system/nginx/nginx-basic-auth-winston'
seal 'kube-system/openldap/openldap-secrets'
seal 'kube-system/registry-creds/registry-creds-secret'
seal 'kube-system/authelia/authelia-helm-values'

# cert-manager
seal "cert-manager/cert-manager/route53-api-key"

# monitoring
seal "monitoring/botkube/botkube-helm-values"