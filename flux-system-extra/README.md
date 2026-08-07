# `flux-system` Namespace

I am using [flux2](https://github.com/fluxcd/flux2) to automate management of the cluster and setting the cluster state as defined in this repository. All items below are actually in the flux-system namespace, but unable to reside in the [flux-system](/flux-system) directory due to some issues with Kustomize.

## cluster

Service configurations and secrets that can be used cluster wide for consistency. These are referenced at the end of [gotk-sync.yaml](/flux-system/gotk-sync.yaml) and provided as part of reconcilliation for creation of managed deployments.

* [cluster/cluster-secrets.sops.yaml](cluster/cluster-secrets.sops.yaml) - Cluster secrets encrypted with Mozilla SOPS
* [cluster/cluster-settings.yaml](cluster/cluster-settings.yaml) - Cluster settings in a config map

## matrix-alerts

Basic Flux alerts sent to a private Matrix room via the notification-controller's native
`matrix` provider (no bridge required).

* [matrix-alerts/alert.yaml](matrix-alerts/alert.yaml) - Defines the alerts that are valid for Matrix
* [matrix-alerts/provider.yaml](matrix-alerts/provider.yaml) - Defines where the alerts go and via what path
* [matrix-alerts/matrix-token.secret.yaml](matrix-alerts/matrix-token.secret.yaml) - References the Matrix bot access token from cluster-secrets

## github-alerts

![GitHub Commit Alert](https://i.imgur.com/06rhLWP.png)

* [github-alerts/alert.yaml](github-alerts/alert.yaml) - Defines the alerts that are valid for github
* [github-alerts/provider.yaml](github-alerts/provider.yaml) - Defines where the alerts go and via what path
* [github-alerts/github-api-token.sops.yaml](github-alerts/github-api-token.sops.yaml) - My encrypted secret for the github api token

## helm-chart-repositories

A yaml for each of the chart repositories used by HelmReleases in this repo.

## monitoring

* [monitoring/flux-podmonitors.yaml](monitoring/flux-podmonitors.yaml) - PodMonitors to export metrics from Flux to Prometheus for use in Grafana
