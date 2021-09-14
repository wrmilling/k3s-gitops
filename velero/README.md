# `velero` Namespace

This namespace contains the configuration for the cluster backup and restore solution [velero](https://velero.io).

## velero

[Velero](https://velero.io/) is an open source tool to safely backup and restore, perform disaster recovery, and migrate Kubernetes cluster resources and persistent volumes.

* [velero/velero.yaml](velero/velero.yaml) - HelmRelease for velero
* [velero/velero-helm-values.sops.yaml](velero/velero-helm-values.sops.yaml) - SOPS encrypted secret helm values for velero, check out the [velero-helm-values.template](/setup/secrets-templates/velero-helm-values.template) for the contents
* [velero/crds/kustomizations.yaml](velero/crds/kustomizations.yaml) - CRDs required by velero

### Restore Process

(credit [billimek](https://github.com/billimek/k8s-gitops/blob/master/velero/README.md))

In order to restore a given workload, the follow steps should work:

1. A backup should already be created either via:
   * a global backup (e.g. a scheduled backup),
   * or via a backup created using a label selector (that's present on the deployment, pv, & pvc) for the application, e.g. `velero backup create test-minecraft --selector "app=mc-test-minecraft" --wait`
2. <Do whatever action results in the active data getting lost (e.g. `kubectl delete hr mc-test`)>
3. Delete the unwanted new data & associate Deployment/StatefulSet/Daemonset, e.g. `kubectl delete deployment mc-test-minecraft && kubectl delete pvc mc-test-minecraft-datadir`
4. Restore from restic the backup with only the label selector, e.g. `velero restore create --from-backup test-minecraft --selector "app=mc-test-minecraft" --wait`

* This should not interfere with the HelmRelease or require scaling helm-operator
* You don't need to worry about adding labels to the HelmRelease or backing-up the helm secret object
