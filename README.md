<!-- markdownlint-disable MD033 -->

<h1 align="center">
  <a id="user-content--k3s-gitops-" class="anchor" aria-hidden="true" href="#-k3s-gitops-">
    <svg class="octicon octicon-link" viewBox="0 0 16 16" version="1.1" width="16" height="16" aria-hidden="true">
      <path fill-rule="evenodd" d="M7.775 3.275a.75.75 0 001.06 1.06l1.25-1.25a2 2 0 112.83 2.83l-2.5 2.5a2 2 0 01-2.83 0 .75.75 0 00-1.06 1.06 3.5 3.5 0 004.95 0l2.5-2.5a3.5 3.5 0 00-4.95-4.95l-1.25 1.25zm-4.69 9.64a2 2 0 010-2.83l2.5-2.5a2 2 0 012.83 0 .75.75 0 001.06-1.06 3.5 3.5 0 00-4.95 0l-2.5 2.5a3.5 3.5 0 004.95 4.95l1.25-1.25a.75.75 0 00-1.06-1.06l-1.25 1.25a2 2 0 01-2.83 0z"></path>
    </svg>
  </a> k3s-gitops
</h1>

<p align="center">
  <a href="https://github.com/k8s-at-home" alt="Image used with permission from k8s-at-home"><img alt="Image used with permission from k8s-at-home" src="https://avatars.githubusercontent.com/u/61287648" /></a>
</p>

<p align="center">
  <a href="https://k3s.io/"><img alt="k3s" src="https://img.shields.io/badge/k3s-v1.34.1-orange?logo=kubernetes&logoColor=white&style=flat-square"></a> <a href="https://github.com/WRMilling/k3s-gitops/stargazers"><img alt="GitHub Stars" src="https://img.shields.io/github/stars/WRMilling/k3s-gitops?logo=github&color=green&logoColor=white&style=flat-square"></a> <a href="https://github.com/WRMilling/k3s-gitops/commits/master"><img alt="GitHub Last Commit" src="https://img.shields.io/github/last-commit/WRMilling/k3s-gitops?logo=git&logoColor=white&color=purple&style=flat-square"></a> <a href="https://discord.gg/home-operations"><img alt="Home Operations Discord" src="https://img.shields.io/badge/discord-chat-7289DA.svg?logo=discord&logoColor=white&maxAge=60&style=flat-square"></a>
</p>

<p align="center">
Using GitOps principals and workflow to manage a lightweight <a href="https://k3s.io">k3s</a> cluster.
</p>

## :book:&nbsp; Overview

![k3s Nodes](https://i.imgur.com/2hBUBi1.png)

This repository utilizes [Flux2](https://fluxcd.io/) to implement GitOps principals and define the state of my cluster using code.

## :computer:&nbsp; Infrastructure

Setup for the individual nodes is now via NixOS and my [nixos-configuration](https://github.com/wrmilling/nixos-configuration) repository. Individual node names from the screenshot in [overview](#overview) can be searched for under the `hosts` directory of the aforementioned repo.

The current cluster consists of one (1) virtual master node, hosted on my TrueNAS Scale NAS, three (3) Minisforum UN100C mini-PCs, and one (1) BMax B4 Plus mini-PC. The mini-PCs double as both compute and ceph nodes.

## :gear:&nbsp; Setup

Setup for Flux2, secrets, and the rest of the GitOps workflow can be found here under the [setup](setup/README.md) directory.

## :wrench:&nbsp; Namespaces

* [cert-manager](cert-manager/README.md)
* [default](default/README.md)
* [development](development/README.md)
* [flux-system](flux-system-extra/README.md)
* [kube-system](kube-system/README.md)
* [media](media/README.md)
* [monitoring](monitoring/README.md)
* [rook-ceph](rook-ceph/README.md)
* [social](social/README.md)

## :handshake:&nbsp; Credits + Community

A huge thanks to the community at Home Operations via [discord chat](https://discord.gg/home-operations). Home Operations Logo image used with permission, check out the community for some awesome and helpful people.
