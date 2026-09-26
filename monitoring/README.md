# `monitoring` Namespace

Provides configuration for all the monitoring applications used on the cluster.

## k8s-event-exporter

[kubernetes-event-exporter](https://github.com/resmoio/kubernetes-event-exporter) forwards the cluster's Kubernetes Event objects (scheduling, image pull, crashloop, OOMKilled, probe failures, evictions, etc.) to a Matrix room via a Hookshot generic webhook.

* [k8s-event-exporter/k8s-event-exporter.yaml](k8s-event-exporter/k8s-event-exporter.yaml) - HelmRelease
* [k8s-event-exporter/configmap.yaml](k8s-event-exporter/configmap.yaml) - Routing config and webhook target
* [k8s-event-exporter/rbac.yaml](k8s-event-exporter/rbac.yaml) - ServiceAccount/ClusterRole for reading events

## kubewatch

[kubewatch](https://github.com/robusta-dev/kubewatch) watches direct resource create/update/delete (pods, deployments, secrets, configmaps, RBAC objects, etc. - things the Kubernetes Events API doesn't cover) and forwards them to a Matrix room via a Hookshot generic webhook. Paired with `k8s-event-exporter` above for full cluster notification coverage.

* [kubewatch/kubewatch.yaml](kubewatch/kubewatch.yaml) - HelmRelease
* [kubewatch/configmap.yaml](kubewatch/configmap.yaml) - Watched resource types and webhook target
* [kubewatch/rbac.yaml](kubewatch/rbac.yaml) - ServiceAccount/ClusterRole for watching resources

## victoria-metrics

[VictoriaMetrics k8s stack](https://docs.victoriametrics.com/helm/victoria-metrics-k8s-stack/) provides cluster-wide monitoring, alerting, and dashboards.

* [victoria-metrics/victoria-metrics.yaml](victoria-metrics/victoria-metrics.yaml) - OCIRepository and HelmRelease for the stack

## grafana

[Grafana](https://grafana.com/) provides dashboards and visualization for cluster metrics.

* [grafana/grafana.yaml](grafana/grafana.yaml) - HelmRelease for Grafana
* [grafana/gateway-policies.yaml](grafana/gateway-policies.yaml) - SecurityPolicy bypassing Authelia

## victoria-logs

[VictoriaLogs](https://docs.victoriametrics.com/victorialogs/) provides log storage and querying.

* [victoria-logs/victoria-logs.yaml](victoria-logs/victoria-logs.yaml) - HelmRelease for VictoriaLogs
* [victoria-logs/collector.yaml](victoria-logs/collector.yaml) - HelmRelease for `victoria-logs-collector` (`vlagent`), a DaemonSet that ships container logs from every node to VictoriaLogs
* [victoria-logs/gateway-policies.yaml](victoria-logs/gateway-policies.yaml) - SecurityPolicy bypassing Authelia on the VictoriaLogs server route

## smokeping-prober

[smokeping-prober](https://github.com/SuperQ/smokeping_prober) provides ICMP latency and packet loss probing for Prometheus.

* [smokeping-prober/smokeping-prober.yaml](smokeping-prober/smokeping-prober.yaml) - HelmRelease and configuration
* [smokeping-prober/servicemonitor.yaml](smokeping-prober/servicemonitor.yaml) - ServiceMonitor for metrics scraping
* [smokeping-prober/prometheusrule.yaml](smokeping-prober/prometheusrule.yaml) - Prometheus alert rules
