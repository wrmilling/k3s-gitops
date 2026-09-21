# `development` Namespace

## Forgejo

![](https://i.imgur.com/lLZSmSA.png)

[Forgejo](https://forgejo.org/) is a self-hosted lightweight software forge.

* [forgejo/forgejo.yaml](forgejo/forgejo.yaml) - HelmRelease for Forgejo
* [forgejo/pvc.yaml](forgejo/pvc.yaml) - PVCs for Forgejo config and data storage
* [forgejo/valkey.yaml](forgejo/valkey.yaml) - Valkey cache for Forgejo
* [forgejo/vmservicescrape-valkey.yaml](forgejo/vmservicescrape-valkey.yaml) - VMServiceScrape for the Valkey cache's redis_exporter metrics
* [forgejo/volsync.yaml](forgejo/volsync.yaml) - Backup schedule for the Forgejo PVCs
* [forgejo/anubis-configmap.yaml](forgejo/anubis-configmap.yaml) - Anubis anti-scraper configuration
* [forgejo/gateway-policies.yaml](forgejo/gateway-policies.yaml) - BackendTrafficPolicy raising the upload body-size limit and SecurityPolicy bypassing Authelia

## OpenGist

![](https://i.imgur.com/rqaS5pc.png)

[OpenGist](https://github.com/thomiceli/opengist) is a self-hosted pastebin powered by Git, open-source alternative to Github Gist.

* [opengist/opengist.yaml](opengist/opengist.yaml) - HelmRelease for OpenGist
* [opengist/pvc.yaml](opengist/pvc.yaml) - PVCs for OpenGist data storage
* [opengist/volsync.yaml](opengist/volsync.yaml) - Backup schedule for the OpenGist PVCs
* [opengist/gateway-policies.yaml](opengist/gateway-policies.yaml) - SecurityPolicy bypassing Authelia
