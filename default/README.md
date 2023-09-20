# `default` Namespace

Default namespace for applications.

## Dedrite

[Dendrite](https://matrix-org.github.io/dendrite/) is a second-generation Matrix homeserver written in Go! Following the microservice architecture model, Dendrite is designed to be efficient, reliable and scalable.

* [dendrite/dendrite.sops.yaml](dendrite/dendrite.sops.yaml) - Matrix secret for for dendrite server
* [dendrite/dendrite.yaml](dendrite/dendrite.yaml) - HelmRelease for Dendrite using app-template
* [dendrite/postgres.yaml](dendrite/postgres.yaml) - PostgreSQL deployment for dendrite
* [dendrite/pvc.yaml](dendrite/pvc.yaml) - PVCs for dendrite, postgres, and jetstream

## emqx

[emqx](https://www.emqx.io/) is a scalable MQTT broker used in conjunction with Home Assistant to enable communication with specific wifi smart devices.

* [emqx/emqx.yaml](emqx/emqx.yaml) - HelmRelease for emqx using their official chart.

## Home Assistant

[Home Assistant](https://www.home-assistant.io/) is an open source home automation solution that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts.

* [home-assistant/home-assistant.yaml](home-assistant/home-assistant.yaml) - Deployment of Home Assistant using the app-template helm chart.
* [home-assistant/postgres.yaml](home-assistant/postgres.yaml) - PostgreSQL deployment utilizing the Bitnami helm chart.
* [home-assistant/pvc.yaml](home-assistant/pvc.yaml) - Rook-ceph persistant volume claims for the Home Assistant and PostgreSQL deployments.

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
