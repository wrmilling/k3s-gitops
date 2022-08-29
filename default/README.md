# `default` Namespace

Default namespace for applications.

## Dedrite

[Dendrite](https://matrix-org.github.io/dendrite/) is a second-generation Matrix homeserver written in Go! Following the microservice architecture model, Dendrite is designed to be efficient, reliable and scalable.

* [dendrite/dendrite.sops.yaml](dendrite/dendrite.sops.yaml) - Matrix secret for for dendrite server
* [dendrite/dendrite.yaml](dendrite/dendrite.yaml) - HelmRelease for Dendrite using app-template
* [dendrite/postgres.yaml](dendrite/postgres.yaml) - PostgreSQL deployment for dendrite
* [dendrite/pvc.yaml](dendrite/pvc.yaml) - PVCs for dendrite, postgres, and jetstream

## FreshRSS

![](https://i.imgur.com/KbI1XXx.png)

Self-hosted RSS reader akin to the old (and now gone) Google Reader.

* [freshrss/freshrss-pvc.yaml](freshrss/freshrss-pvc.yaml) - PVC for freshrss configuration files
* [freshrss/freshrss.yaml](freshrss/freshrss.yaml) - HelmRelease for FreshRSS using app-template

## Hajimari

![](https://i.imgur.com/HvBLy48.png)

[Hajimari](https://hajimari.io) is a beautiful & customizable browser startpage/dashboard with Kubernetes application discovery.

* [hajimari/hajimari-external.yaml](hajimari/hajimari-external.yaml) - HelmRelease which deploys Hajimari, this release covering externally accesible applications.
* [hajimari/hajimari-internal.yaml](hajimari/hajimari-internal.yaml) - HelmRelease which deploys Hajimari, this release covering internally accesible applications.

## Haste

![](https://i.imgur.com/vpB5jFe.png)

[Haste](https://github.com/seejohnrun/haste-server) is an open-source pastebin software written in node.js.

* [haste-server/haste-server.yaml](haste-server/haste-server.yaml) - HelmRelease for haste-server using app-template
* [haste-server/redis.yaml](haste-server/redis.yaml) - Key/Value store which acts as storage for Haste

## Minio

[Minio](https://min.io/) is a high performance S3-compatible kubernetes object storage solution / bucket service.

* [minio/minio.yaml](minio/minio.yaml) - HelmRelease for minio from the charts.min.io repo

## OneDrive

Using the [onedrive](https://github.com/abraunegg/onedrive) client for linux to sync my personal OneDrive for backup.

* [onedrive/onedrive-pvc.yaml](onedrive/onedrive-pvc.yaml) - Config PVC for OneDrive
* [onedrive/onedrive.yaml](onedrive/onedrive.yaml) - HelmRelease for OneDrive using app-template

## PiHole

![](https://i.imgur.com/o2X1qU0.png)

[Pi-hole](https://pi-hole.net/) is a DNS resolver that likes to help you block ads as well. This implementation uses MetalLB to expose the DNS server on its own dedicated IP, allows authenticated and secure ingress through nginx-ingress and authelia, and has implemented DNS-over-HTTPS (DoH) for secure querying. I also use it to do DNS resolution on internal domains.

* [pihole/pihole-helm-values.sops.yaml](pihole/pihole-helm-values.sops.yaml) - Encrypted helm values for Pi-hole
* [pihole/pihole.yaml](pihole/pihole.yaml) - HelmRelease for Pi-hole from mojo2600 on GitHub

## Valheim

A battle-slain warrior, the Valkyries have ferried your soul to [Valheim](https://www.valheimgame.com/), the tenth Norse world. Besieged by creatures of chaos and ancient enemies of the gods, you are the newest custodian of the primordial purgatory, tasked with slaying Odin’s ancient rivals and bringing order to Valheim. Dedicated server deployment.

* [valheim/valheim-pvc.yaml](valheim/valheim-pvc.yaml) - PVC for valheim game data and configuration
* [valheim/valheim.yaml](valheim/valheim.yaml) - HelmRelease for Valheim dedicated game server
