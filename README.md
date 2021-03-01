# <center> k3s-gitops </center>

<p align="center">
  <img src="https://avatars.githubusercontent.com/u/61287648" />
</p>

<p align="center">
  <a href="https://k3s.io/"><img alt="k3s" src="https://img.shields.io/badge/k3s-v1.20.2-orange?style=flat-square"></a> <a href="https://github.com/WRMilling/k3s-gitops/stargazers"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/WRMilling/k3s-gitops?color=green&style=flat-square"></a> <a href="https://github.com/WRMilling/k3s-gitops/commits/master"><img alt="GitHub Last Commit" src="https://img.shields.io/github/last-commit/WRMilling/k3s-gitops?color=purple&style=flat-square"></a> <a href="https://discord.gg/Yv2gzFy"><img alt="K8s-at-home Discord" src="https://img.shields.io/badge/discord-chat-7289DA.svg?maxAge=60&style=flat-square"></a>
</p>


<p align="center">
Using GitOps principals and workflow to manage a lightweight <a href="https://k3s.io">k3s</a> cluster.
</p>

## Overview

![k3s Nodes](https://i.imgur.com/8Zgf3jS.png)

This repository utilizes [Flux2](https://fluxcd.io/) to implement GitOps principals and define the state of my cluster using code.

## Infrastructure

Setup for the individual nodes OS and base k3s istall can be found in [WRMilling/homelab-infrastructure](https://github.com/WRMilling/homelab-infrastructure/) repository.

## Setup

Setup for Flux2, secrets, and the rest of the GitOps workflow can be found here under the [setup](/setup) directory.

## Namespaces

  * [cert-manager](/cert-manager)
  * [default](/default)
  * [flux-system](/flux-system)
  * [kube-system](/kube-system)
  * [longhorn-system](/longhorn-system)
  * [monitoring](/monitoring)

## Credits + Community

Direct credit to the following repositories for great examples:

 * [billimek/k8s-gitops](https://github.com/billimek/k8s-gitops)
 * [carpenike/k8s-gitops](https://github.com/carpenike/k8s-gitops)
 * [Marx2/homelab](https://github.com/Marx2/homelab/)

As well as a huge thanks to the larger community at k8s-at-home via [awesome-home-kubernetes](https://github.com/k8s-at-home/awesome-home-kubernetes) and the [discord chat](https://discord.gg/7PbmHRK).
