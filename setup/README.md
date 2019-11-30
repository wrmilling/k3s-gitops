# Cluster Setup Instructions

## Prerequisite

You are assumed to have the right utilities to install the different aspects of this guide (kubectl, helm, fluxctl, etc). 

## VM Setup

I will be creating a simple 3 node cluster, no high availability, mostly just messing with the clustering of resources and the operation of flux. In my case, I am using ProxMox as the underlying virtualization platform to create these VMs. I have a single server with 12-cores / 24-threads (dual socket Xeon E5-2640), 96 GB RAM, and 1.2TB of HDD space. I will be leaving some space on the server for other projects and will have 3 VMs in total for the cluster. They will be setup as follows; 

Node VMs: 
* **OS:** Debian
* **CPU:** 6 Cores
* **RAM:** 16 GB
* **HDD:** 64 GB

The VMs will have an internal network for them to communicate over for cluster communications as well as an external network for internet access. I am banking on the fact that none of the HDD space will actually fill up at the same time, and if it does I will just deal with it then. I will leave actual VM creation to your imagination as you may be using a different platform or know how to do it already. If not, feel free to open an issue on the repo and I will see what I can do. 

## k3s Install

We will be pretty much following the book for installing k3s, so I will keep it short and sweet across my three nodes. Lets start with the master node: 

```
# Install k3s to the server, don't deploy traefik and use my internal network for flannel
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik --flannel-iface ens19" sh -

# Grab the node keys for setting up the two agents. Save somewhere.
sudo cat /var/lib/rancher/k3s/server/node-token
```

Now repeat the following steps for the two agents:

```
# Install k3s agent setting the K3S_URL for master, and using the K3S_TOKEN gathered above
export K3S_URL="https://<MASTER_INTERNAL_IP>:6443"
export K3S_TOKEN="<NODE_TOKEN>"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface ens19" sh -
```

## Helm Install (tiller)

Basic helm install, may not be secure. Need to look into the securing of tiller. 

```
# Create a service account for tiller 
kubectl -n kube-system create sa tiller

# Create a cluster role binding for tiller
kubectl create clusterrolebinding tiller-cluster-rule \
  --clusterrole=cluster-admin \
  --serviceaccount=kube-system:tiller

# Deploy tiller to kube-system
helm init --skip-refresh --upgrade --service-account tiller --history-max 20
```

## Flux Install

Now its time for a by-the-book flux install.

```
# Add the repo
helm repo add fluxcd https://charts.fluxcd.io

# Apply the Helm Release CRD
kubectl apply -f https://raw.githubusercontent.com/fluxcd/flux/helm-0.10.1/deploy-helm/flux-helm-release-crd.yaml

# Install flux
helm upgrade -i flux \
  --set helmOperator.create=true \
  --set helmOperator.createCRD=false \
  --set git.url=git@github.com:WRMilling/k3s-gitops \
  --set registry.rps=1 \
  --set registry.burst=1 \
  --namespace flux \
  fluxcd/flux
```

