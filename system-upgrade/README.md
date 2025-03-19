# System Upgrade Controller

## NOTE

Removed for now as there have been issues with automatic draining/restart for nodes. Will revisit later on, otherwise doing manual restarts when I upgrade the node's OS.

---

This handles the automatic upgrade of the k3s kubernetes cluster.  See [system-upgrade-controller](https://github.com/rancher/system-upgrade-controller) for more details on the operation of this component.

* [system-upgrade-controller.yaml](system-upgrade-controller.yaml) - This is the foundational YAML to deploy the controller and CRDs to make this capability work
* [k3s-plan.yaml](k3s-plan.yaml) - This Plan will automatically upgrade to the latest k3s kubernetes version as they are released.
