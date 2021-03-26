# `default` Namespace

Default namespace for applications.

## FreshRSS

Self-hosted RSS reader akin to the old (and now gone) Google Reader.

* [freshrss/freshrss.yaml](freshrss/freshrss.yaml) - HelmRelease for FreshRSS from the k8s-at-home repo

## PiHole

[Pi-hole](https://pi-hole.net/) is a DNS resolver that likes to help you block ads as well. This implementation uses MetalLB to expose the DNS server on its own dedicated IP, allows authenticated and secure ingress through nginx-ingress and authelia, and has implemented DNS-over-HTTPS (DoH) for secure querying. I also use it to do DNS resolution on internal domains.

* [pihole/pihole-helm-values.template](pihole/pihole-helm-values.template) - Encrypted Template used to create helm value secrets for pihole via [seal-secrets.sh](/setup/seal-secrets.sh)
* [pihole/pihole-helm-values.template.sample](pihole/pihole-helm-values.template.sample) - Sample template so that you can create your own pihole-helm-values template file
* [pihole/pihole-helm-values.yaml](pihole/pihole-helm-values.yaml) - Encrypted helm values for Pi-hole
* [pihole/pihole-secret.template](pihole/pihole-secret.template) - Template used to create helm value secrets for pihole via [seal-secrets.sh](/setup/seal-secrets.sh)
* [pihole/pihole-secret.yaml](pihole/pihole-secret.yaml) - Encrypted admin secret for Pi-hole
* [pihole/pihole.yaml](pihole/pihole.yaml) - HelmRelease for Pi-hole from mojo2600 on GitHub