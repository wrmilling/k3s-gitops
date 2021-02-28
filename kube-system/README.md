# `kube-system` Namespace

## metallb

[MetalLB](https://metallb.universe.tf/) is an on-cluster LoadBalancer in the Layer 2 configuration to allow for "external" IPs to be assigned. Primarily used with nginx below.

  * [metallb/metallb.yaml](metallb/metallb.yaml) - HelmRelease for metallb, including values configuration.

## nginx

[Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/) for the cluster, works with cert-manager to secure and route traffic to specific pods/applications.

  * [nginx/nginx.yaml](nginx/nginx.yaml) - HelmRelease for nginx-ingress, including custom 404 pages from billimek/custom-error-pages
  * [nginx/nginx-basic-auth-winston.template](nginx/nginx-basic-auth-winston.template) - Template used to create a basic-auth secret via [seal-secrets.sh](/setup/seal-secrets.sh)
  * [nginx/nginx-basic-auth-winston.yaml](nginx/nginx-basic-auth-winston.yaml) - My encrypted basic-auth secret.

## sealed-secrets

[sealed-secrets](https://github.com/bitnami-labs/sealed-secrets) provides a Kubernetes controller and tool for creating one-way encrypted secrets so that they can be stored and managed in the git repository. First time setup of sealed-secrets is managed as part of the [bootstrap process](/setup/README.md) for the cluster. Sealing new secrets to add to the repo is through the [seal-secrets.sh](/setup/seal-secrets.sh) script.

  * [sealed-secrets/sealed-secrets.yaml](sealed-secrets/sealed-secrets.yaml) - HelmRelease for the sealed-secrets controller and system.
