# `social` Namespace

Provides configuration for all my social media focused applications.

## Mastodon

[Mastodon](https://joinmastodon.org/) is decentralized social media. Currently using the [Glitch-soc](https://github.com/glitch-soc/mastodon) fork of the official mastodon.

* [mastodon/mastodon.yaml](mastodon/mastodon.yaml) - HelmRelease for Mastodon
* [mastodon/mastodon.sops.yaml](mastodon/mastodon.sops.yaml) - Core secrets for Mastodon
* [mastodon/mastodon-legacy.yaml](mastodon/mastodon-legacy.yaml) - Legacy deployment configuration
* [mastodon/mastodon-postgresql.sops.yaml](mastodon/mastodon-postgresql.sops.yaml) - PostgreSQL credentials
* [mastodon/mastodon-redis.sops.yaml](mastodon/mastodon-redis.sops.yaml) - Redis credentials
* [mastodon/mastodon-s3.sops.yaml](mastodon/mastodon-s3.sops.yaml) - S3 credentials
* [mastodon/mastodon-smtp.sops.yaml](mastodon/mastodon-smtp.sops.yaml) - SMTP credentials
* [mastodon/minio.yaml](mastodon/minio.yaml) - S3-compatible storage via Minio
* [mastodon/valkey.yaml](mastodon/valkey.yaml) - Valkey deployment for caching
* [mastodon/valkey-pvc.yaml](mastodon/valkey-pvc.yaml) - PVC for Valkey data

## Mautrix Slack

* [mautrix/slack-bridge.yaml](mautrix/slack-bridge.yaml) - Slack bridge deployment
* [mautrix/slack-bridge.secret.yaml](mautrix/slack-bridge.secret.yaml) - Slack bridge secret
* [mautrix/pvc.yaml](mautrix/pvc.yaml) - PVC for Mautrix data

## Synapse

* [synapse/synapse.yaml](synapse/synapse.yaml) - HelmRelease for Synapse
* [synapse/synapse-test.yaml](synapse/synapse-test.yaml) - Test Synapse deployment
* [synapse/pvc.yaml](synapse/pvc.yaml) - PVC for Synapse
* [synapse/appservices.secret.yaml](synapse/appservices.secret.yaml) - Appservice secrets
