# k3s-gitops

Currently re-setting the whole repository to start again with a new rPi based cluster. Will be updated in the coming weeks/months. (02-02-2021)

## Overview

This repository utilizes [Flux2](https://fluxcd.io/) to implement GitOps principals and define the state of my cluster using code.

## Cluster Setup

Setup for the individual nodes OS and base k3s istall can be found in [WRMilling/homelab-infrastructure]() repository.

Setup for [Flux2](https://fluxcd.io), secrets, and the rest of the GitOps setup can be found here under the [setup](setup) directory.

## Credits / Influences

 * [billimek/k8s-gitops](https://github.com/billimek/k8s-gitops)
 * [carpenike/k8s-gitops](https://github.com/carpenike/k8s-gitops)
 * [Marx2/homelab](https://github.com/Marx2/homelab/)
