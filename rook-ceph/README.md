# `rook-ceph` Namespace

![](https://i.imgur.com/CHIX1mt.png)

[Rook](https://rook.io) is production ready management for File, Block and Object Storage.

## CRDs

* [crds/crds.yaml](crds/crds.yaml) - Rook Ceph CRDs
* [crds/kustomization.yaml](crds/kustomization.yaml) - Kustomization for CRDs

## Rook Ceph Operator

* [chart/rook-ceph-chart.yaml](chart/rook-ceph-chart.yaml) - HelmRelease for Rook Ceph operator
* [chart/rook-ceph-system-psp-user.yaml](chart/rook-ceph-system-psp-user.yaml) - PSP user bindings for Rook Ceph

## Cluster

* [cluster/cluster.yaml](cluster/cluster.yaml) - Ceph cluster definition

## Storage

* [ceph-block/cephblockpool.yaml](ceph-block/cephblockpool.yaml) - CephBlockPool for block storage
* [ceph-block/ceph-storageclass.yaml](ceph-block/ceph-storageclass.yaml) - StorageClass for Ceph block pool

## Dashboard

* [dashboard/ingress.yaml](dashboard/ingress.yaml) - Ingress for Ceph dashboard

## Monitoring

* [monitoring/csi-metrics-service-monitor.yaml](monitoring/csi-metrics-service-monitor.yaml) - CSI metrics ServiceMonitor
* [monitoring/service-monitor.yaml](monitoring/service-monitor.yaml) - Ceph ServiceMonitor
* [monitoring/rbac.yaml](monitoring/rbac.yaml) - Monitoring RBAC

## Toolbox

* [toolbox/toolbox.yaml](toolbox/toolbox.yaml) - Rook toolbox deployment
* [toolbox/direct-mount.yaml](toolbox/direct-mount.yaml) - Direct mount configuration
