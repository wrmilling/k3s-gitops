# `development` Namespace

## AppFlowy

[AppFlowy](https://appflowy.io/) is an open-source, self-hosted alternative to Notion for notes and collaborative workspaces. Deployed as the free/open-source AppFlowy Cloud stack (gotrue, appflowy-cloud, admin-frontend, appflowy-worker, appflowy-web, appflowy-search) via the bjw-s app-template chart, using the shared `shared-psql-v17` CloudNativePG cluster (namespace `default`) for Postgres and the shared `kube-system` MinIO for object storage.

* [appflowy/appflowy.yaml](appflowy/appflowy.yaml) - HelmRelease with one controller per AppFlowy service (gotrue, cloud, admin, worker, web, search) and the combined HTTPRoute.
* [appflowy/appflowy-db-init.configmap.yaml](appflowy/appflowy-db-init.configmap.yaml) - SQL run once against the `appflowy` database to enable the `vector`/`pg_trgm` extensions.
* [appflowy/valkey.yaml](appflowy/valkey.yaml) - Dedicated Valkey (Redis) HelmRelease for AppFlowy.
* [appflowy/pvc.yaml](appflowy/pvc.yaml) - Rook-ceph persistent volumes for the Valkey instance and the appflowy-search keyword index.
* [appflowy/gateway-policies.yaml](appflowy/gateway-policies.yaml) - BackendTrafficPolicy (body size/timeout) and SecurityPolicy (Authelia bypass, since AppFlowy has its own auth) for the HTTPRoute.

## Forgejo

![](https://i.imgur.com/lLZSmSA.png)

[Forgejo](https://forgejo.org/) is a self-hosted lightweight software forge.

* [forgejo/forgejo.yaml](forgejo/forgejo.yaml) - HelmRelease for Forgejo
* [forgejo/pvc.yaml](forgejo/pvc.yaml) - PVCs for Forgejo config and data storage
* [forgejo/valkey.yaml](forgejo/valkey.yaml) - Valkey cache for Forgejo
* [forgejo/volsync.yaml](forgejo/volsync.yaml) - Backup schedule for the Forgejo PVCs

## OpenGist

![](https://i.imgur.com/rqaS5pc.png)

[OpenGist](https://github.com/thomiceli/opengist) is a self-hosted pastebin powered by Git, open-source alternative to Github Gist.

* [opengist/opengist.yaml](opengist/opengist.yaml) - HelmRelease for OpenGist
* [opengist/pvc.yaml](opengist/pvc.yaml) - PVCs for OpenGist data storage
* [opengist/volsync.yaml](opengist/volsync.yaml) - Backup schedule for the OpenGist PVCs
