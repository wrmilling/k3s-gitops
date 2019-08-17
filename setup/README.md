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

I am banking on the fact that none of the HDD space will actually fill up at the same time, and if it does I will just deal with it then. I will leave actual VM creation to your imagination as you may be using a different platform or know how to do it already. If not, feel free to open an issue on the repo and I will see what I can do. 

## k3s Install

TODO

## Helm Install

TODO

## Manual Steps

TODO

## Flux Install

TODO
