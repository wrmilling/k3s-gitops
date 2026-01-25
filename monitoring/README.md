# `monitoring` Namespace

Provides configuration for all the monitoring applications used on the cluster.

## botkube

![BotKube Discord Message](https://i.imgur.com/UhuC0k9.png)

[botkube](https://www.botkube.io/) provides richer integration with multiple chat clients for alerts and cluster management if desired. This configuration is using discord for the alerting.

* [botkube/botkube.yaml](botkube/botkube.yaml) - HelmRelease and configuration for notification events
