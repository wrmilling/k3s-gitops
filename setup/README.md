# Cluster setup with k3s

## amd64 + arm64 Cluster Installation (One-Time Actions)

### k3s Node Setup

Check out [homelab-infrastructure/k3s](https://github.com/WRMilling/homelab-infrastructure/tree/master/k3s) for information on creating the physical/virtual cluster. Make sure you have `kubectl` setup on the machine you run these steps on and that it has access to the cluster. This requires either `$KUBECONFIG` being set properly or `~/.kube/config` being populated. 

### Bootstrapping the Cluster

Simply run `./bootstrap-cluster.sh` located in this directory to setup the cluster. This does the following things: 

1. Installs flux2

This script was originally pulled from [billimek/k8s-gitops](https://github.com/billimek/k8s-gitops/blob/master/setup/bootstrap-cluster.sh) but may have some modifications based on my needs. 