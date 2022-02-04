# `cert-manager` Namespace

## cert-manager

[cert-manager](https://github.com/jetstack/cert-manager) automatically obtains and renews certificates for the cluster using [Let's Encrypt](https://letsencrypt.org/). This implementation uses Route53 as a dns01 verification path for Let's Encrypt.

* [cert-manager/chart/cert-manager.yaml](cert-manager/chart/cert-manager.yaml) - Main HelmRelease for cert-manager
* [cert-manager/crds/kustomization.yaml](cert-manager/crds/kustomization.yaml) - Related CRDs for the main HelmRelease
* [cert-manager/route53/cert-manager-letsencrypt.yaml](cert-manager/route53/cert-manager-letsencrypt.yaml) - ClusterIssuer(s) and Certificate for the cluster
* [cert-manager/route53/route53-api-key.sops.yaml](cert-manager/route53/route53-api-key.sops.yaml) - My encrypted secret for route53
