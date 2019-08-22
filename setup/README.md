# Cluster Setup Instructions

## VM Setup

I will be creating a simple 3 node cluster, no high availability, mostly just messing with the clustering of resources and the operation of flux. In my case, I am using ProxMox as the underlying virtualization platform to create these VMs. I have a single server with 8-cores (dual socket Xeon L5420), 16 GB RAM, and 200GB of HDD space. I will be leaving some space on the server for other projects and will have 4 VMs in total for the cluster (1 VM for NFS persistent storage and 3 for the master and child nodes). They will be setup as follows; 

NFS VM: 
* **OS:** Debian
* **CPU:** 1 Core
* **RAM:** 512 MB
* **HDD:** 64 GB

Node VMs: 
* **OS:** Debian
* **CPU:** 2 Cores
* **RAM:** 4 GB
* **HDD:** 32 GB

The VMs will have an internal network for them to communicate over for cluster communications as well as an external network for internet access. I am banking on the fact that none of the HDD space will actually fill up at the same time, and if it does I will just deal with it then. I will leave actual VM creation to your imagination as you may be using a different platform or know how to do it already. If not, feel free to open an issue on the repo and I will see what I can do. 

## k3s Install

We will be pretty much following the book for installing k3s, so I will keep it short and sweet across my three nodes. Lets start with the master node: 

```
# Install k3s to the server, don't deploy traefik and use my internal network for flannel
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--no-deploy traefik --flannel-iface eth1" sh -

# Grab the node keys for setting up the two agents. Save somewhere.
sudo cat /var/lib/rancher/k3s/server/node-token
```

Now repeat the following steps for the two agents:

```
# Install k3s agent setting the K3S_URL for master, and using the K3S_TOKEN gathered above
export K3S_URL="https://<MASTER_INTERNAL_IP>:6443"
export K3S_TOKEN="<NODE_TOKEN>"
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" sh -
```

## Helm Install

TODO

## Manual Steps

TODO

## Flux Install

TODO
