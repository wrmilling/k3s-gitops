# `system-upgrade` Namespace

This namespace stores the configuration for [system-upgrade-controller](https://github.com/rancher/system-upgrade-controller), a component which handles the automatic upgrade of k3s in the cluster.

## system-upgrade-controller

* [system-upgrade-controller/system-upgrade-controller.yaml](system-upgrade-controller/system-upgrade-controller.yaml) - This is the foundational YAML to deploy the controller and CRDs to make this capability work
* [system-upgrade-controller/k3s-plan.yaml](system-upgrade-controller/k3s-plan.yaml) - This Plan will automatically upgrade to the latest k3s kubernetes version as they are released.
* [system-upgrade-controller/ubuntu-plan.yaml](system-upgrade-controller/ubuntu-plan.yaml) - This Plan will automatically reboot the ubuntu host if `/run/reboot-required` exists. It depends on the host already being setup with [unattended-upgrades](https://help.ubuntu.com/community/AutomaticSecurityUpdates)
