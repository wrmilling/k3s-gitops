# `kube-system` Namespace

## authelia

![](https://i.imgur.com/GyZQTB9.png)

This is probably overly-complicated for what I actually need and I will probably simplify it in the future. Authelia provides SSO capabilities for the cluster and is integrated with nginx-ingress.

* [authelia/authelia.yaml](authelia/authelia.yaml) - Authelia SSO Server Helm Chart deployment

## dynamic-dns

A custom docker image and cron job that uses the AWS cli to udpate a dns reocord pointing to the cluster's external IP address.

* [dynamic-dns/cronjob.yaml](dynamic-dns/cronjob.yaml) - Cron Job which schedules the DNS update

## intel-devices-plugins

* [intel-device-plugins/gpu-plugin.yaml](intel-device-plugins/gpu-plugin.yaml)
* [intel-device-plugins/operator.yaml](intel-device-plugins/operator.yaml)

## kured

[Kured](https://github.com/weaveworks/kured) is a Kubernetes daemonset that performs safe automatic node reboots when the need to do so is indicated by the package management system of the underlying OS.

* [kured/kured.yaml](kured/kured.yaml) - HelmRelease for kured

## metallb

[MetalLB](https://metallb.universe.tf/) is an on-cluster LoadBalancer in the Layer 2 configuration to allow for "external" IPs to be assigned. Primarily used with nginx below. There is a bit of chicken and egg with this chart right now as I have not solved the CRDs needing to be installed before you can have an IPAddressPool object. Either remove the IPAddressPool definition before chart install or manually install the CRDs before install.

* [metallb/metallb.yaml](metallb/metallb.yaml) - HelmRelease for metallb, including values configuration.

## minio

[Minio](https://min.io/) is a high-performance, S3 compatible object store.

* [minio/minio.yaml](minio/minio.yaml) - HelmRelease using the official minio charts, backed by NFS.

## nfs-pv

Persistent Volume configuration for shared NFS storage.

* [nfs-pv/mastodon-pv.yaml](nfs-pv/mastodon-pv.yaml) - Bulk storage backed by a TrueNAS NFS share for Mastodon's Minio instance.
* [nfs-pv/media-pv.yaml](nfs-pv/media-pv.yaml) - Storage for Bulk Media backed by TrueNAS NFS share.
* [nfs-pv/minio-pv.yaml](nfs-pv/minio-pv.yaml) - Storage for Minio S3 Compatible storage backed by TrueNAS NFS share.
* [nfs-pv/onedrive-pv.yaml](nfs-pv/onedrive-pv.yaml) - Storage for OneDrive image backed by TrueNAS NFS share.

## nginx

![](https://i.imgur.com/W5roLT7.png)

[Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/) for the cluster, works with cert-manager to secure and route traffic to specific pods/applications.

* [nginx/nginx-internal.yaml](nginx/nginx-internal.yaml) - HelmRelease for nginx-ingress serving internal traffic, including custom 404 pages from billimek/custom-error-pages.
* [nginx/nginx-external.yaml](nginx/nginx-external.yaml) - HelmRelease for nginx-ingress serving external traffic, including custom 404 pages from billimek/custom-error-pages.

## node-feature-discovery

Operator that facilitates the auto tagging of nodes based on feature avalable (e.g. GPU)

* [node-feature-discovery/node-feature-discovery.yaml](node-feature-discovery/node-feature-discovery.yaml) - HelmRelease for node-feature-discovery

## openldap

Trying out creating an LDAP provider for the cluster to do authentication at the nginx-ingress level.

* [openldap/openldap.yaml](openldap/openldap.yaml) - Deployment and Service to expose an OpenLDAP instance based on bitnami containers.
* [openldap/openldap-secrets.sops.yaml](openldap/openldap-secrets.sops.yaml) - My encrypted open ldap secrets.

## registry-creds

Provide authentication using [alexellis' registry-creds](https://github.com/alexellis/registry-creds) across the cluster for Docker Hub and raise the pull limit a bit so that we are less likely to hit it.

* [registry-creds/dockerhub.yaml](registry-creds/dockerhub.yaml) - The ClusterPullSecret which binds the docker-registry secrets to teh registry-creds deployment to be used by kubernetes.
* [registry-creds/registry-creds-secret.sops.yaml](registry-creds/registry-creds-secret.sops.yaml) - My encrypted open dockerhub secret.
* [registry-creds/registry-creds.yaml](registry-creds/registry-creds.yaml) - Deployment for registry-creds.

## reloader

[Reloader](https://github.com/stakater/Reloader) is a Kubernetes controller to watch changes in ConfigMap and Secrets and do rolling upgrades on Pods with their associated Deployment, StatefulSet, DaemonSet and DeploymentConfig

* [reloader/reloader.yaml](reloader/reloader.yaml) Simple HelmRelease using the official chart.

## snapshot-controller

[Snashot Controller](https://github.com/piraeusdatastore/helm-charts/tree/main/charts/snapshot-controller) is a snapshoting helper required for CSI snapshotting to work. Not specific to Rook/Ceph, but required for the Volsync setup.

* [snapshot-controller/ks.yaml](snapshot-controller/ks.yaml) - Health checks for Snapshot Controller.
* [snapshot-controller/snapshot-controller.yaml](snapshot-controller/snapshot-controller.yaml) - Helm Release for Snapshot Controller using the [Piraus Charts](https://github.com/piraeusdatastore/helm-charts/).

## volsync

[Volsync](https://github.com/backube/volsync) is asynchronous data replication for Kubernetes volumes.

* [volsync/ks.yaml](volsync/ks.yaml) - Healthchecks for Volsync.
* [volsync/kustomization.yaml](volsync/kustomization.yaml) - Install ordering for ks and Volsync.
* [volsync/volsync.yaml](volsync/volsync.yaml) - HelmRelease for Volsync.
