# `default` Namespace

Default namespace for applications.

## FreshRSS

Self-hosted RSS reader akin to the old (and now gone) Google Reader.

* [freshrss/freshrss-pvc.yaml](freshrss/freshrss-pvc.yaml) - PVC for freshrss configuration files
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

* [minio/ingress.yaml](minio/ingress.yaml) - Ingresss for minio due to the fact that I am using a really old helm repo
* [minio/minio.yaml](minio/minio.yaml) - HelmRelease for minio from the helm.min.io repo

## Monica

[Monica](https://github.com/monicahq/monica) is an opensource Source personal CRM.

* [monica/monica-pvc.yaml](monica/monica-pvc.yaml) - PVC for monica configuration files
* [monica/monica.yaml](monica/monica.yaml) - HelmRelease for Monica

## OneDrive

Using the [onedrive](https://github.com/abraunegg/onedrive) client for linux to sync my personal OneDrive for backup.

* [onedrive/onedrive.yaml](onedrive/onedrive.yaml) - HelmRelease for onedrive

## PiHole

[Pi-hole](https://pi-hole.net/) is a DNS resolver that likes to help you block ads as well. This implementation uses MetalLB to expose the DNS server on its own dedicated IP, allows authenticated and secure ingress through nginx-ingress and authelia, and has implemented DNS-over-HTTPS (DoH) for secure querying. I also use it to do DNS resolution on internal domains.

* [pihole/pihole-helm-values.sops.yaml](pihole/pihole-helm-values.sops.yaml) - Encrypted helm values for Pi-hole
* [pihole/pihole.yaml](pihole/pihole.yaml) - HelmRelease for Pi-hole from mojo2600 on GitHub

## Valheim

A battle-slain warrior, the Valkyries have ferried your soul to [Valheim](https://www.valheimgame.com/), the tenth Norse world. Besieged by creatures of chaos and ancient enemies of the gods, you are the newest custodian of the primordial purgatory, tasked with slaying Odin’s ancient rivals and bringing order to Valheim. Dedicated server deployment.

* [valheim/valheim-pvc.yaml](valheim/valheim-pvc.yaml) - PVC for valheim game data and configuration
* [valheim/valheim.yaml](valheim/valheim.yaml) - HelmRelease for Valheim dedicated game server