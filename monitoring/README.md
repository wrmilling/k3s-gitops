# `monitoring` Namespace

Provides configuration for all the monitoring applications used on the cluster.

## botkube

![BotKube Discord Message](https://i.imgur.com/UhuC0k9.png)

[botkube](https://www.botkube.io/) provides richer integration with multiple chat clients for alerts and cluster management if desired. This configuration is using discord for the alerting.

* [botkube/botkube.yaml](botkube/botkube.yaml) - HelmRelease and configuration for notification events

## victoria-metrics

[VictoriaMetrics k8s stack](https://docs.victoriametrics.com/helm/victoria-metrics-k8s-stack/) provides cluster-wide monitoring, alerting, and dashboards.

* [victoria-metrics/victoria-metrics.yaml](victoria-metrics/victoria-metrics.yaml) - OCIRepository and HelmRelease for the stack

## grafana

[Grafana](https://grafana.com/) provides dashboards and visualization for cluster metrics.

* [grafana/grafana.yaml](grafana/grafana.yaml) - HelmRelease for Grafana

## victoria-logs

[VictoriaLogs](https://docs.victoriametrics.com/victorialogs/) provides log storage and querying.

* [victoria-logs/victoria-logs.yaml](victoria-logs/victoria-logs.yaml) - HelmRelease for VictoriaLogs

## smokeping-prober

[smokeping-prober](https://github.com/SuperQ/smokeping_prober) provides ICMP latency and packet loss probing for Prometheus.

* [smokeping-prober/smokeping-prober.yaml](smokeping-prober/smokeping-prober.yaml) - HelmRelease and configuration
* [smokeping-prober/servicemonitor.yaml](smokeping-prober/servicemonitor.yaml) - ServiceMonitor for metrics scraping
* [smokeping-prober/prometheusrule.yaml](smokeping-prober/prometheusrule.yaml) - Prometheus alert rules
