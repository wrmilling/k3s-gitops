# `cert-manager` Namespace

## cert-manager

[cert-manager](https://github.com/jetstack/cert-manager) automatically obtains and renews certificates for the cluster using [Let's Encrypt](https://letsencrypt.org/). This implementation uses Route53 as a dns01 verification path for Let's Encrypt.

* [cert-manager/cert-manager.yaml](cert-manager/cert-manager.yaml) - Main HelmRelease for cert-manager
* [cert-manager/cert-manager-letsencrypt.yaml](cert-manager/cert-manager-letsencrypt.yaml) - ClusterIssuer(s) and Certificate for the cluster
* [cert-manager/route53-api-key.template](cert-manager/route53-api-key.template) - Template used to create the route53 secret via [seal-secrets.sh](/setup/seal-secrets.sh)
* [cert-manager/route53-api-key.yaml](cert-manager/route53-api-key.yaml) - My encrypted secret for route53
