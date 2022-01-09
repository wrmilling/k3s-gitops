# `monitoring` Namespace

Provides configuration for all the monitoring applications used on the cluster.

## botkube

![BotKube Discord Message](https://i.imgur.com/UhuC0k9.png)

[botkube](https://www.botkube.io/) provides richer integration with multiple chat clients for alerts and cluster management if desired. This configuration is using discord for the alerting.

* [botkube/botkube.yaml] - HelmRelease and configuration for which events need to notify the supplied discord configuration

## grafana

[Grafana](https://grafana.com/) is the dashboarding software backed by Prometheus, InfluxDB, and others for visualizing metrics and data.

* [grafana/dashboards/](grafana/dashboards/) - Dashboard definitions for Grafana
* [grafana/grafana.yaml](grafana/grafana.yaml) - HelmRelease for Grafana

## kube-prometheus-stack

[kube-prometheus-stack](https://github.com/prometheus-community/helm-charts/tree/main/charts/kube-prometheus-stack) installs Prometheus Operator, required CRDs, and a default altering ruleset.

* [kube-prometheus-stack/crds/](kube-prometheus-stack/crds/) - CRDs required for kube-prometheus-stack to function
* [kube-prometheus-stack/prometheus-rules/](kube-prometheus-stack/prometheus-rules/) - Custom rule sets for Prometheus
* [kube-prometheus-stack/kube-prometheus-stack.yaml](kube-prometheus-stack/kube-prometheus-stack.yaml) - HelmRelease for kube-prometheus-stack

## thanos

[Thanos](https://github.com/thanos-io/thanos) is a highly available Prometheus setup with long term storage capabilities (backed by [minio](../default/minio/) in this case).

* [thanos/thanos.yaml](thanos/thanos.yaml) - HelmRelease for thanos
