# Cluster setup with k3s

## .env File

I use a .env file which is encrypted using git-crypt and is referenced in any script below. I have provided a .env.sample file which should show all the environment variables potentially needed for any of the following to function. If copying this repo, you may want to re-initialize git-crypt and copy the `.env.sample` file to .env and over-write default values with your specific ones. 

## amd64 + arm64 Cluster Installation (One-Time Actions)

### k3s Node Setup

Check out [homelab-infrastructure/k3s](https://github.com/WRMilling/homelab-infrastructure/tree/master/k3s) for information on creating the physical/virtual cluster. Make sure you have `kubectl` setup on the machine you run these steps on and that it has access to the cluster. This requires either `$KUBECONFIG` being set properly or `~/.kube/config` being populated. 

### Bootstrapping the Cluster

Simply run `./bootstrap-cluster.sh` located in this directory to setup the cluster. This does the following things: 

1. Installs flux2

This script was originally pulled from [billimek/k8s-gitops](https://github.com/billimek/k8s-gitops/blob/master/setup/bootstrap-cluster.sh) but may have some modifications based on my needs. 

## Cluster Maintenance

### Setting up Sealed Secrets 

TBD
