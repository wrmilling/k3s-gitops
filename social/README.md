# `social` Namespace

Provides configuration for all my social media focused applications.

## Dendrite

[Dendrite](https://matrix-org.github.io/dendrite/) is a second-generation Matrix homeserver written in Go! Following the microservice architecture model, Dendrite is designed to be efficient, reliable and scalable.

* [dendrite/dendrite.sops.yaml](dendrite/dendrite.sops.yaml) - Matrix secret for for dendrite server
* [dendrite/dendrite.yaml](dendrite/dendrite.yaml) - HelmRelease for Dendrite using app-template
* [dendrite/pvc.yaml](dendrite/pvc.yaml) - PVCs for dendrite, postgres, and jetstream
* [dendrite/syncapi.yaml](dendrite/syncapi.yaml) - Sliding sync API for Dendrite, faster updates
* [dendrite/volsync.yaml](dendrite/volsync.yaml) - Restic backup definition using Volsync

## Mastodon

[Mastodon](https://joinmastodon.org/) is decentralized social media. Currently using the [Glitch-soc](https://github.com/glitch-soc/mastodon) fork of the official mastodon.

* [mastodon/mastodon.sops.yaml](mastodon/mastodon.sops.yaml) - Secrets for the Mastodon Helm Release
* [mastodon/mastodon.yaml](mastodon/mastodon.yaml) - Official HelmRelease for Mastodon with minor changes
* [mastodon/minio.yaml](mastodon/minio.yaml) - S3 Compatible storage for Mastodon via Minio
