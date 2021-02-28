# `monitoring` Namespace

Provides configuration for all the monitoring applications used on the cluster.

## botkube

_Image Pending_

[botkube](https://www.botkube.io/) provides richer integration with multiple chat clients for alerts and cluster management if desired. This configuration is using discord for the alerting.

  * [botkube/botkube.yaml] - HelmRelease and configuration for which events need to notify the supplied discord configuration
  * [botkube/botkube-helm-values.template](botkube/botkube-helm-values.template) - Template used to create a secret set of HelmRelease values via [seal-secrets.sh](/setup/seal-secrets.sh)
  * [botkube/botkube-helm-values.yaml](botkube/botkube-helm-values.yaml) - Encrypted secret configuration values for botkube