# k3s-gitops

Using GitOps principals and workflow to manage a lightweight [k3s](https;//k3s.io) cluster.

## Overview

_Images Pending_

This repository utilizes [Flux2](https://fluxcd.io/) to implement GitOps principals and define the state of my cluster using code.

## Infrastructure

Setup for the individual nodes OS and base k3s istall can be found in [WRMilling/homelab-infrastructure](https://github.com/WRMilling/homelab-infrastructure/) repository.

## Setup

Setup for [Flux2](https://fluxcd.io), secrets, and the rest of the GitOps workflow can be found here under the [setup](/setup) directory.

## Workloads

_TBD_

## Credits / Influences

Direct credit to the following repositories for great examples:

 * [billimek/k8s-gitops](https://github.com/billimek/k8s-gitops)
 * [carpenike/k8s-gitops](https://github.com/carpenike/k8s-gitops)
 * [Marx2/homelab](https://github.com/Marx2/homelab/)

As well as a large thanks to the larger community at k8s-at-home via [awesome-home-kubernetes](https://github.com/k8s-at-home/awesome-home-kubernetes) and the [discord chat](https://discord.gg/7PbmHRK).