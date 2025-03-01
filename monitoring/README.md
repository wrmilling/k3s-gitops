# `monitoring` Namespace

Provides configuration for all the monitoring applications used on the cluster.

## botkube

![BotKube Discord Message](https://i.imgur.com/UhuC0k9.png)

[botkube](https://www.botkube.io/) provides richer integration with multiple chat clients for alerts and cluster management if desired. This configuration is using discord for the alerting.

* [botkube/botkube.yaml] - HelmRelease and configuration for which events need to notify the supplied discord configuration

## grafana

![](https://i.imgur.com/iPzCQlB.png)

[Grafana](https://grafana.com/) is the dashboarding software backed by Prometheus, InfluxDB, and others for visualizing metrics and data.

* [grafana/dashboards/](grafana/dashboards/) - Dashboard definitions for Grafana
* [grafana/grafana.yaml](grafana/grafana.yaml) - HelmRelease for Grafana

## victoria-metrics

Fast, cost-effective monitoring solution and time series database.

* [victoria-metrics/victoria-metrics.yaml](victoria-metrics/victoria-metrics.yaml) - HelmRelease for Victoria Metrics