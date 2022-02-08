# `development` Namespace

## code-server

[code-server](https://coder.com/docs/code-server/latest) allows you to run VS Code on any machine anywhere and access it in the browser.

* [code-server/code-server-pvc.yaml](code-server/code-server-pvc.yaml) - PVCs for code-server config and data storage
* [code-server/code-server.yaml](code-server/code-server.yaml) - HelmRelease for code-server

## Gitea

![](https://i.imgur.com/mwVDZnE.png)

[Gitea](https://gitea.com/) is a painless, self-hosted Git service.

* [gitea/gitea-pvc.yaml](gitea/gitea-pvc.yaml) - PVCs for Gitea config and data storage
* [gitea/gitea.yaml](gitea/gitea.yaml) - HelmRelease for Gitea