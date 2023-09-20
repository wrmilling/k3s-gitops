# `kube-system` Namespace

## authelia

![](https://i.imgur.com/GyZQTB9.png)

This is probably overly-complicated for what I actually need and I will probably simplify it in the future. Authelia provides SSO capabilities for the cluster and is integrated with nginx-ingress.

* [authelia/authelia.yaml](authelia/authelia.yaml) - Authelia SSO Server Helm Chart deployment
* [authelia/postgres-pvc.yaml](authelia/postgres-pvc.yaml) - PVC to store config and data for Postgres
* [authelia/postgres.yaml](authelia/postgres.yaml) - Postgres deployment for use by Authelia for registering user second-factor
* [authelia/redis-pvc.yaml](authelia/redis-pvc.yaml) - PVC to store config for Redis
* [authelia/redis.yaml](authelia/redis.yaml) - Redis deployment for use by Authelia for sessions

## dynamic-dns

A custom docker image and cron job that uses the AWS cli to udpate a dns reocord pointing to the cluster's external IP address.

* [dynamic-dns/cronjob.yaml](dynamic-dns/cronjob.yaml) - Cron Job which schedules the DNS update

## kured

[Kured](https://github.com/weaveworks/kured) is a Kubernetes daemonset that performs safe automatic node reboots when the need to do so is indicated by the package management system of the underlying OS.

* [kured/kured.yaml](kured/kured.yaml) - HelmRelease for kured

## metallb

[MetalLB](https://metallb.universe.tf/) is an on-cluster LoadBalancer in the Layer 2 configuration to allow for "external" IPs to be assigned. Primarily used with nginx below.

* [metallb/metallb.yaml](metallb/metallb.yaml) - HelmRelease for metallb, including values configuration.

## nfs-pv

Persistent Volume configuration for shared NFS storage.

* [nfs-pv/media-pv.yaml](nfs-pv/media-pv.yaml) - Bulk media storage backed by a TrueNAS NFS share
* [nfs-pv/minio-pv.yaml](nfs-pv/minio-pv.yaml) - Storage for Minio S3 Compatible storage backed by TrueNAS NFS share
* [nfs-pv/onedrive-pv.yaml](nfs-pv/onedrive-pv.yaml) - Storage for OneDrive image backed by TrueNAS NFS share

## nginx

![](https://i.imgur.com/W5roLT7.png)

[Nginx ingress controller](https://kubernetes.github.io/ingress-nginx/) for the cluster, works with cert-manager to secure and route traffic to specific pods/applications.

* [nginx/nginx-internal.yaml](nginx/nginx-internal.yaml) - HelmRelease for nginx-ingress serving internal traffic, including custom 404 pages from billimek/custom-error-pages
* [nginx/nginx-external.yaml](nginx/nginx-external.yaml) - HelmRelease for nginx-ingress serving external traffic, including custom 404 pages from billimek/custom-error-pages

## openldap

Trying out creating an LDAP provider for the cluster to do authentication at the nginx-ingress level.

* [openldap/openldap.yaml](openldap/openldap.yaml) - Deployment and Service to expose an OpenLDAP instance based on bitnami containers
* [openldap/openldap-secrets.sops.yaml](openldap/openldap-secrets.sops.yaml) - My encrypted open ldap secrets

## registrycreds

Provide authentication using [alexellis' registry-creds](https://github.com/alexellis/registry-creds) across the cluster for Docker Hub and raise the pull limit a bit so that we are less likely to hit it.

* [registry-creds/dockerhub.yaml](registry-creds/dockerhub.yaml) - The ClusterPullSecret which binds the docker-registry secrets to teh registry-creds deployment to be used by kubernetes
* [registry-creds/registry-creds-secret.sops.yaml](registry-creds/registry-creds-secret.sops.yaml) - My encrypted open dockerhub secret
* [registry-creds/registry-creds.yaml](registry-creds/registry-creds.yaml) - Deployment for registry-creds.

## snapshot-controller

Placeholder

## volsync

Placeholder
