# `longhorn-system` Namespace

This namespace stores the configuration for [longhorn](https://rancher.com/products/longhorn/), a persistent storage provider for Kuberenetes.

## longhorn

![Longhorn Dashboard](https://i.imgur.com/1bCOYok.png)

Persistent storage provider for Kuberenetes which utilizes and syncs local storage on given nodes to provide persistent volumes.

  * [longhorn/longhorn.yaml](longhorn/longhorn.yaml) - HelmRelease for longhorn with storage configuration and ingress configuration.

### Prepare Nodes

Preparing a node takes two main steps, labeling the node for disk create and preparing the disks/storage to be used.

#### Labeling Nodes

This is normally done via the bootstrap of the cluster in [setup](/setup), but otherwise the following label needs to be applied to the nodes for storage:

```
kubectl label nodes k3s-amd64-a node.longhorn.io/create-default-disk=true
```

#### Preparing Storage

The bootstrap scripts should also be doing this, otherwise assuming root or sudo in the case that you are not:

```
# Create a new partition table, gpt in this case
sudo parted -s /dev/sdb mklabel gpt
# Create a new partition, marked ext4, which takes the whole drive
sudo parted -s -a opt /dev/sdb mkpart primary ext4 0% 100%
# Format the new partition as ext4 with the longhorn label
mkfs.ext4 -L longhorn /dev/sdb1
# Create a mount directory for the new partition
mkdir /longhorn
# Update fstab to mount the partition
echo "LABEL=longhorn  /longhorn       auto    defaults        0 0" >> /etc/fstab
# Mount the new partition
mount /longhorn
```