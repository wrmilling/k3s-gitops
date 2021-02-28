# `flux-system` Namespace

I am using [flux2](https://github.com/fluxcd/flux2) to automate management of the cluster and setting the cluster state as defined in this repository. All items below are actually in the flux-system namespace, but unable to reside in the [flux-system](/flux-system) directory due to some issues with Kustomize.

## discord-alerts

_Image Pending_

Uses [BotKube](https://www.botkube.io/) to provide discord messages on the state of deployments and other such information about the cluster.

  * [discord-alerts/alert.yaml](discord-alerts/alert.yaml) - Defines the alerts that are valid for discord
  * [discord-alerts/provider.yaml](discord-alerts/provider.yaml) - Defines where the alerts go and via what path
  * [discord-alerts/discord-webhook-url.template](discord-alerts/discord-webhook-url.template) - Template used to create the discord webhook secret via [seal-secrets.sh](/setup/seal-secrets.sh)
  * [discord-alerts/discord-webhook-url.yaml](discord-alerts/discord-webhook-url.yaml) - My encrypted secret for the discord webhook

## github-alerts

_Image Pending_

  * [github-alerts/alert.yaml](github-alerts/alert.yaml) - Defines the alerts that are valid for github
  * [github-alerts/provider.yaml](github-alerts/provider.yaml) - Defines where the alerts go and via what path
  * [github-alerts/github-api-token.template](github-alerts/github-api-token.template) - Template used to create the github api token secret via [seal-secrets.sh](/setup/seal-secrets.sh)
  * [github-alerts/github-api-token.yaml](github-alerts/github-api-token.yaml) - My encrypted secret for the github api token


## helm-chart-repositories

A yaml for each of the chart repositories used by HelmReleases in this repo.