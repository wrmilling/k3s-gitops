# `social` Namespace

Provides configuration for all my social media focused applications.

## Mastodon

[Mastodon](https://joinmastodon.org/) is decentralized social media. Currently using the [Glitch-soc](https://github.com/glitch-soc/mastodon) fork of the official mastodon.

* [mastodon/mastodon.yaml](mastodon/mastodon.yaml) - HelmRelease for a from-scratch Mastodon deployment on the community chart; entirely disabled (commented out), superseded by `mastodon-legacy.yaml` below.
* [mastodon/mastodon.sops.yaml](mastodon/mastodon.sops.yaml) - Core secrets for Mastodon
* [mastodon/mastodon-legacy.yaml](mastodon/mastodon-legacy.yaml) - The currently active Mastodon deployment (name is historical, not a status)
* [mastodon/mastodon-postgresql.sops.yaml](mastodon/mastodon-postgresql.sops.yaml) - PostgreSQL credentials
* [mastodon/mastodon-s3.sops.yaml](mastodon/mastodon-s3.sops.yaml) - S3 credentials
* [mastodon/mastodon-smtp.sops.yaml](mastodon/mastodon-smtp.sops.yaml) - SMTP credentials
* [mastodon/garage.yaml](mastodon/garage.yaml) - S3-compatible media storage via Garage, with the web endpoint serving public media as the BunnyCDN (`mcdn.`) origin on `mfile.`
* [mastodon/media-httproute.yaml](mastodon/media-httproute.yaml) - HTTPRoute exposing Garage's read-only web endpoint on `mfile.` as the BunnyCDN origin
* [mastodon/garage-pvc.yaml](mastodon/garage-pvc.yaml) - PVC for Garage metadata
* [mastodon/vmservicescrape-garage.yaml](mastodon/vmservicescrape-garage.yaml) - VMServiceScrape for Garage metrics
* [mastodon/valkey.yaml](mastodon/valkey.yaml) - Valkey deployment for caching
* [mastodon/valkey-pvc.yaml](mastodon/valkey-pvc.yaml) - PVC for Valkey data
* [mastodon/vmservicescrape-valkey.yaml](mastodon/vmservicescrape-valkey.yaml) - VMServiceScrape for the Valkey cache's redis_exporter metrics
* [mastodon/gateway-policies.yaml](mastodon/gateway-policies.yaml) - BackendTrafficPolicy raising the upload body-size limit and SecurityPolicies bypassing Authelia for Mastodon and its public media origin

## Mautrix Slack

* [mautrix/slack-bridge.yaml](mautrix/slack-bridge.yaml) - Slack bridge deployment
* [mautrix/slack-bridge.secret.yaml](mautrix/slack-bridge.secret.yaml) - Slack bridge secret
* [mautrix/pvc.yaml](mautrix/pvc.yaml) - PVC for Mautrix data
* [mautrix/gateway-policies.yaml](mautrix/gateway-policies.yaml) - BackendTrafficPolicy raising the upload body-size limit and SecurityPolicy bypassing Authelia

## Synapse

* [synapse/synapse.yaml](synapse/synapse.yaml) - HelmRelease for Synapse, including the Hookshot generic-webhook bridge used to deliver Alertmanager and Kubernetes-event notifications to Matrix
* [synapse/synapse-test.yaml](synapse/synapse-test.yaml) - Test Synapse deployment
* [synapse/synapse-httproutes.yaml](synapse/synapse-httproutes.yaml) - HTTPRoutes for Synapse and the Hookshot bridge
* [synapse/pvc.yaml](synapse/pvc.yaml) - PVC for Synapse (and Hookshot's `synapse-hookshot-pvc`)
* [synapse/appservices.secret.yaml](synapse/appservices.secret.yaml) - Appservice secrets
* [synapse/gateway-policies.yaml](synapse/gateway-policies.yaml) - BackendTrafficPolicy raising the upload body-size limit and SecurityPolicy bypassing Authelia
