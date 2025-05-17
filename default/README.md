# `default` Namespace

Default namespace for applications.

## CloundNativePG

[CloudNativePG](https://cloudnative-pg.io/) is the Kubernetes operator that covers the full lifecycle of a highly available PostgreSQL database cluster with a primary/standby architecture, using native streaming replication.

* [cloudnative-pg/cloudnative-pg.secret.yaml](cloudnative-pg/cloudnative-pg.secret.yaml) - Secrets for the CloudNative-PG Helm Release.
* [cloudnative-pg/cloudnative-pg.yaml](cloudnative-pg/cloudnative-pg.yaml) - CloudNativePG Helm Release.
* [cloudnative-pg/cluster/dendrite-v17.yaml](cloudnative-pg/cluster/dendrite-v17.yaml) - Postgres v17 Cluster for Dendrite deployment.
* [cloudnative-pg/cluster/mastodon-v17.yaml](cloudnative-pg/cluster/mastodon-v17.yaml) - Postgres v17 Cluster for Mastodon deployment.
* [cloudnative-pg/cluster/prometheus-rules.yaml](cloudnative-pg/cluster/prometheus-rules.yaml) - Monitoring rules for CloudNativePG to Prometheus.
* [cloudnative-pg/cluster/scheduled-backups.yaml](cloudnative-pg/cluster/scheduled-backups.yaml) - Backup Schedule for Postgres using native backup method.
* [cloudnative-pg/cluster/shared-v17.yaml](cloudnative-pg/cluster/shared-v17.yaml) - Postgres v17 Cluster for all other use cases.

## emqx

[emqx](https://www.emqx.io/) is a scalable MQTT broker used in conjunction with Home Assistant to enable communication with specific wifi smart devices.

* [emqx/emqx.yaml](emqx/emqx.yaml) - HelmRelease for emqx using their official chart.

## Foundry VTT

[Foundry VTT](https://foundryvtt.com/) is a self-hosted and modern roleplaying platform.

* [foundry/foundry-vtt-test.yaml](foundry/foundry-vtt-test.yaml) - Test deployment of Foundry VTT for testing out features as a GM.
* [foundry/foundry-vtt.yaml](foundry/foundry-vtt.yaml) - Proper deployment of Foundry VTT for use in active games.
* [foundry/pvc.yaml](foundry/pvc.yaml) - Rook-ceph persistent volumes for the FoundryVTT instances.
* [foundry/volsync.yaml](foundry/volsync.yaml) - Restic backup definition for use with Volsync.

## Home Assistant

[Home Assistant](https://www.home-assistant.io/) is an open source home automation solution that puts local control and privacy first. Powered by a worldwide community of tinkerers and DIY enthusiasts.

* [home-assistant/home-assistant.yaml](home-assistant/home-assistant.yaml) - Deployment of Home Assistant using the app-template helm chart.
* [home-assistant/postgres.yaml](home-assistant/postgres.yaml) - PostgreSQL deployment utilizing the Bitnami helm chart.
* [home-assistant/pvc.yaml](home-assistant/pvc.yaml) - Rook-ceph persistent volume claims for the Home Assistant and PostgreSQL deployments.

## Invidious

[Invidious](https://invidious.io/) is an open source alternative front-end to YouTube.

* [invidious/invidious.yaml](invidious/invidious.yaml) - Simple [app-template](https://bjw-s-labs.github.io/helm-charts/docs/app-template/) deployment of the Invidious docker image.

## OneDrive

Using the [onedrive](https://github.com/abraunegg/onedrive) client for linux to sync my personal OneDrive for backup.

* [onedrive/onedrive-pvc.yaml](onedrive/onedrive-pvc.yaml) - Config PVC for OneDrive.
* [onedrive/onedrive-secret.sops.yaml](onedrive/onedrive-secret.sops.yaml) - Secrets for OneDrive Auth.
* [onedrive/onedrive.yaml](onedrive/onedrive.yaml) - HelmRelease for OneDrive using app-template.

## PiHole

![](https://i.imgur.com/o2X1qU0.png)

[Pi-hole](https://pi-hole.net/) is a DNS resolver that likes to help you block ads as well. This implementation uses MetalLB to expose the DNS server on its own dedicated IP, allows authenticated and secure ingress through nginx-ingress and authelia, and has implemented DNS-over-HTTPS (DoH) for secure querying. I also use it to do DNS resolution on internal domains.

* [pihole/pihole-helm-values.sops.yaml](pihole/pihole-helm-values.sops.yaml) - Encrypted helm values for Pi-hole.
* [pihole/pihole.yaml](pihole/pihole.yaml) - HelmRelease for Pi-hole from mojo2600 on GitHub.

## Valheim

A battle-slain warrior, the Valkyries have ferried your soul to [Valheim](https://www.valheimgame.com/), the tenth Norse world. Besieged by creatures of chaos and ancient enemies of the gods, you are the newest custodian of the primordial purgatory, tasked with slaying Odin’s ancient rivals and bringing order to Valheim. Dedicated server deployment.

* [valheim/valheim-pvc.yaml](valheim/valheim-pvc.yaml) - PVC for valheim game data and configuration.
* [valheim/valheim.yaml](valheim/valheim.yaml) - HelmRelease for Valheim dedicated game server.
* [valheim/volsync.yaml](valheim/volsync.yaml) - Restic backup definition for Valheim via Volsync.
