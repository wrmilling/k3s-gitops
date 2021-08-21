# `default` Namespace

Default namespace for applications.

## FreshRSS

Self-hosted RSS reader akin to the old (and now gone) Google Reader.

* [freshrss/freshrss.yaml](freshrss/freshrss.yaml) - HelmRelease for FreshRSS from the k8s-at-home repo

## Hajimari

[Hajimari](https://hajimari.io) is a beautiful & customizable browser startpage/dashboard with Kubernetes application discovery.

* [hajimari/hajimari-external.yaml](hajimari/hajimari-external.yaml) - HelmRelease which deploys Hajimari, this release covering externally accesible applications.
* [hajimari/hajimari-internal.yaml](hajimari/hajimari-internal.yaml) - HelmRelease which deploys Hajimari, this release covering internally accesible applications.

## Haste

[Haste](https://github.com/seejohnrun/haste-server) is an open-source pastebin software written in node.js.

* [haste-server/haste-server.yaml](haste-server/haste-server.yaml) - HelmRelease for haste-server froom the k8s-at-home repo
* [haste-server/redis.yaml](haste-server/redis.yaml) - Key/Value store which acts as storage for Haste

## Minio

[Minio](https://min.io/) is a high performance S3-compatible kubernetes object storage solution / bucket service.

* [minio/minio-helm-values.sops.yaml](minio/minio-helm-values.sops.yaml) - Encrypted minio helm values
* [minio/minio.yaml](minio/minio.yaml) - HelmRelease for minio from the helm.min.io repo

## Monica

[Monica](https://github.com/monicahq/monica) is an opensource Source personal CRM.

* [monica/monica-helm-values.sops.yaml](monica/monica-helm-values.sops.yaml) - Encrypted Monica helm values
* [monica/monica.yaml](monica/monica.yaml) - HelmRelease for Monica

## PiHole

[Pi-hole](https://pi-hole.net/) is a DNS resolver that likes to help you block ads as well. This implementation uses MetalLB to expose the DNS server on its own dedicated IP, allows authenticated and secure ingress through nginx-ingress and authelia, and has implemented DNS-over-HTTPS (DoH) for secure querying. I also use it to do DNS resolution on internal domains.

* [pihole/pihole-helm-values.sops.yaml](pihole/pihole-helm-values.sops.yaml) - Encrypted helm values for Pi-hole
* [pihole/pihole-secret.sops.yaml](pihole/pihole-secret.sops.yaml) - Encrypted admin secret for Pi-hole
* [pihole/pihole.yaml](pihole/pihole.yaml) - HelmRelease for Pi-hole from mojo2600 on GitHub
