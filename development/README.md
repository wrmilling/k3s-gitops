# `development` Namespace

## Forgejo

![](https://i.imgur.com/lLZSmSA.png)

[Forgejo](https://forgejo.org/) is a self-hosted lightweight software forge.

* [forgejo/forgejo.yaml](forgejo/forgejo.yaml) - HelmRelease for Forgejo
* [forgejo/pvc.yaml](forgejo/pvc.yaml) - PVCs for Forgejo config and data storage
* [forgejo/redis.yaml](forgejo/redis.yaml) - Caching server for Forgejo
* [forgejo/volsync.yaml](forgejo/volsync.yaml) - Backup schedule for the Forgejo PVCs

## OpenGist

![](https://i.imgur.com/rqaS5pc.png)

[OpenGist](https://github.com/thomiceli/opengist) is a self-hosted pastebin powered by Git, open-source alternative to Github Gist.

* [opengist/opengist.yaml](opengist/opengist.yaml) - HelmRelease for OpenGist
* [opengist/pvc.yaml](opengist/pvc.yaml) - PVCs for OpenGist data storage
* [opengist/volsync.yaml](opengist/volsync.yaml) - Backup schedule for the OpenGist PVCs
