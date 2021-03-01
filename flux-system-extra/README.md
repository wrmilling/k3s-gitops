# `flux-system` Namespace

I am using [flux2](https://github.com/fluxcd/flux2) to automate management of the cluster and setting the cluster state as defined in this repository. All items below are actually in the flux-system namespace, but unable to reside in the [flux-system](/flux-system) directory due to some issues with Kustomize.

## discord-alerts

![FluxBot Alert](https://i.imgur.com/XRnEra4.png)

Basic discord alerts from flux to my private discord channel.

* [discord-alerts/alert.yaml](discord-alerts/alert.yaml) - Defines the alerts that are valid for discord
* [discord-alerts/provider.yaml](discord-alerts/provider.yaml) - Defines where the alerts go and via what path
* [discord-alerts/discord-webhook-url.template](discord-alerts/discord-webhook-url.template) - Template used to create the discord webhook secret via [seal-secrets.sh](/setup/seal-secrets.sh)
* [discord-alerts/discord-webhook-url.yaml](discord-alerts/discord-webhook-url.yaml) - My encrypted secret for the discord webhook

## github-alerts

![GitHub Commit Alert](https://i.imgur.com/06rhLWP.png)

* [github-alerts/alert.yaml](github-alerts/alert.yaml) - Defines the alerts that are valid for github
* [github-alerts/provider.yaml](github-alerts/provider.yaml) - Defines where the alerts go and via what path
* [github-alerts/github-api-token.template](github-alerts/github-api-token.template) - Template used to create the github api token secret via [seal-secrets.sh](/setup/seal-secrets.sh)
* [github-alerts/github-api-token.yaml](github-alerts/github-api-token.yaml) - My encrypted secret for the github api token

## helm-chart-repositories

A yaml for each of the chart repositories used by HelmReleases in this repo.
