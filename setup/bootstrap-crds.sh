#!/usr/bin/env bash

REPO_ROOT=$(git rev-parse --show-toplevel)

need() {
    which "$1" &>/dev/null || die "Binary '$1' is missing but required"
}

echo "Applying cert-manager CRD"
kubectl apply -f https://github.com/jetstack/cert-manager/releases/download/v1.7.1/cert-manager.crds.yaml

echo "Applying registry-creds CRD"
kubectl apply -f "${REPO_ROOT}"/kube-system/registry-creds/registry-creds-crd.yaml

echo "Applying Prometheus CRD"
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_prometheusrules.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/v0.50.0/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml
