# `flux-system` Namespace

I am using [flux2](https://github.com/fluxcd/flux2) to automate management of the cluster and setting the cluster state as defined in this repository. All items below are actually in the flux-system namespace, but unable to reside in the [flux-system](/flux-system) directory due to some issues with Kustomize.

## discord-alerts

![FluxBot Alert](https://i.imgur.com/XRnEra4.png)

Basic discord alerts from flux to my private discord channel.

* [discord-alerts/alert.yaml](discord-alerts/alert.yaml) - Defines the alerts that are valid for discord
* [discord-alerts/provider.yaml](discord-alerts/provider.yaml) - Defines where the alerts go and via what path
* [discord-alerts/discord-webhook-url.sops.yaml](discord-alerts/discord-webhook-url.sops.yaml) - My encrypted secret for the discord webhook

## github-alerts

![GitHub Commit Alert](https://i.imgur.com/06rhLWP.png)

* [github-alerts/alert.yaml](github-alerts/alert.yaml) - Defines the alerts that are valid for github
* [github-alerts/provider.yaml](github-alerts/provider.yaml) - Defines where the alerts go and via what path
* [github-alerts/github-api-token.sops.yaml](github-alerts/github-api-token.sops.yaml) - My encrypted secret for the github api token

## helm-chart-repositories

A yaml for each of the chart repositories used by HelmReleases in this repo.

## monitoring

* [monitoring/flux-podmonitors.yaml](monitoring/flux-podmonitors.yaml) - PodMonitors to export metrics from Flux to Prometheus for use in Grafana