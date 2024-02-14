#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)

need() {
    which "$1" &>/dev/null || die "Binary '$1' is missing but required"
}

message() {
  echo -e "\n######################################################################"
  echo "# $1"
  echo "######################################################################"
}

installFlux() {
  . "$REPO_ROOT"/setup/.env

  message "installing fluxv2"

  flux check --pre > /dev/null
  FLUX_PRE=$?
  if [ $FLUX_PRE != 0 ]; then
    echo -e "flux prereqs not met:\n"
    flux check --pre
    exit 1
  fi

  if [ -z "$GITHUB_TOKEN" ]; then
    echo "GITHUB_TOKEN is not set! Check $REPO_ROOT/setup/.env"
    exit 1
  fi

  flux bootstrap github \
    --owner=wrmilling \
    --repository=k3s-gitops \
    --branch main \
    --personal

  FLUX_INSTALLED=$?
  if [ $FLUX_INSTALLED != 0 ]; then
    echo -e "flux did not install correctly, aborting!"
    exit 1
  fi
}

need "kubectl"
need "helm"
need "flux"
need "openssl"

"${REPO_ROOT}"/setup/bootstrap-secrets.sh
"${REPO_ROOT}"/setup/bootstrap-crds.sh

installFlux

message "all done!"
kubectl get nodes -o=wide
