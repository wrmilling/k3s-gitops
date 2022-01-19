#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)
. "$REPO_ROOT"/setup/.env

seal() {
  if [ -f "${REPO_ROOT}/${1}/${2}.sops.yaml" ]; then
    echo "${2}.sops.yaml: Already exists"
  else
    echo "${2}.template: Encrypting with SOPS"
    envsubst < ${REPO_ROOT}/setup/secrets-templates/${2}.template > ${REPO_ROOT}/${1}/${2}.sops.yaml
    sops --encrypt --in-place ${REPO_ROOT}/${1}/${2}.sops.yaml
  fi
}

# cert-manager
seal 'cert-manager/cert-manager' 'route53-api-key'

# flux-system
seal 'flux-system-extra/github-alerts' 'github-api-token'
seal 'flux-system-extra/discord-alerts' 'discord-webhook-url'

# kube-system
seal 'kube-system/openldap' 'openldap-secrets'
seal 'kube-system/registry-creds' 'registry-creds-secret'

# media
# seal 'media/plex' 'plex-secrets'