# `social` Namespace

Provides configuration for all my social media focused applications.

## Dendrite

WIP, need to move storage from default and make this change eventually.

## Mastodon

[Mastodon](https://joinmastodon.org/) is decentralized social media. Currently using the [Glitch-soc](https://github.com/glitch-soc/mastodon) fork of the official mastodon.

* [mastodon/mastodon-redis.sops.yaml](mastodon/mastodon-redis.sops.yaml) - Encrypted secret for the Redis password
* [mastodon/mastodon.yaml](mastodon/mastodon.yaml) - Official HelmRelease for Mastodon with minor changes.
* [mastodon/minio.yaml](mastodon/minio.yaml) - S3 Compatible storage for Mastodon via Minio.
* [mastodon/pvc.yaml](mastodon/pvc.yaml) - PersistantVolumeClaim for mastodon configuration storage.
