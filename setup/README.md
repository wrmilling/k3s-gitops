# Cluster setup with k3s

## .env File

I use a .env file which is encrypted using git-crypt and is referenced in any script below. I have provided a .env.sample file which should show all the environment variables potentially needed for any of the following to function. If copying this repo, you may want to re-initialize git-crypt and copy the `.env.sample` file to .env and over-write default values with your specific ones.

## amd64 + arm64 Cluster Installation (One-Time Actions)

### k3s Node Setup

Check out [homelab-infrastructure/k3s](https://github.com/WRMilling/homelab-infrastructure/tree/master/k3s) for information on creating the physical/virtual cluster. Make sure you have `kubectl` setup on the machine you run these steps on and that it has access to the cluster. This requires either `$KUBECONFIG` being set properly or `~/.kube/config` being populated.

### Bootstrapping the Cluster

Simply run `./bootstrap-cluster.sh` located in this directory to setup the cluster. This does the following things:

1. Sets up sealed-secrets key
   * If key does not exist, it will generate one (encrypted with git-crypt)
2. Installs flux2

This script was originally pulled from [billimek/k8s-gitops](https://github.com/billimek/k8s-gitops/blob/master/setup/bootstrap-cluster.sh) but may have some modifications based on my needs.

## Cluster Maintenance

### Setting up Sealed Secrets

The `bootstrap-secrets.sh` script has been added to take care of pushing a common key to teh cluster so that secrets can survive a cluster rebuild. It gets run as part of the `bootstrap-cluster.sh` script but can be run again individually if a new secrets key needs to be generated. If a new key is generated and uploaded, delete the sealed secrets controller and let flux rebuild it to pull in the new key. `kubeseal` needs to be told to use the new public key, I use an alias to ensure its always used: `alias TBD`.

### Sealing New Secrets

The script [seal-secrets.sh](seal-secrets.sh) will take care of encrypting defined secrets using a `*.template` file located in the directory you wish the secret to be stored. Take a look at [flux-system-extra/github-alerts/github-api-token](/flux-system-extra/github-alerts/github-api-token) for an example of what one of the template files looks like. For the script to function you must have `kubeseal` installed and the proper `sealed-secrets.crt` file in the setup directory. Definitions for what secrets need to be encrypted are currently part of the script itself.