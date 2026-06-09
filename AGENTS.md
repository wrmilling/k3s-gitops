# AGENTS.md

Guidance for AI agents working in this repository.

## Architecture

- **GitOps**: Flux2 manages all cluster state from this repo (`flux-system/gotk-sync.yaml`).
- **Namespaces**: Organized by function (`default/`, `media/`, `social/`, `kube-system/`, etc.) with per-namespace README indexes.
- **Chart Repositories**: Stored in the `flux-system-extra/helm-chart-repositories` directory.
- **Core stack**:
  - Gateway: Envoy Gateway (Gateway API) with internal + external Gateways
  - Storage: Rook-Ceph (`rook-ceph-block` for PVCs)
  - LoadBalancer: MetalLB
  - Secrets: SOPS + Flux substitutions

## Adding New Applications

1. **Pick the namespace** (or create one with a README entry).
2. **Create app directory** under the namespace with:
   - `appname.yaml` (usually a `HelmRelease`).
   - `pvc.yaml` if persistent storage is required.
   - `volsync.yaml` if backups are needed.
3. **Prefer bjw-s app-template**:
   - Most apps use `bjw-s-labs/app-template`.
   - Include YAML schema header for editor validation.
4. **Use Flux substitutions**:
   - `${SECRET_*}` for secrets (from `cluster-secrets`)
   - `${SVC_*}` for service IPs (from `cluster-settings`)
5. **Add to namespace README** with a short description and file links.

## Secrets Handling

- **SOPS required** for secrets if the helm release requires a kubernetes secret. Substitution is allowed if the secret can be in-line.
  - `.sops.yaml` encrypts only `data`/`stringData`.
  - Secrets are stored as `*.sops.yaml`.
- **Substitutions**:
  - `cluster-secrets` Secret and `cluster-settings` ConfigMap are injected via `postBuild.substituteFrom`.

**Do not create a secret yourself** only stub out the secrets needed and prompt the user on how to create the secret required.
**Do not commit plaintext secrets**.

## Gateway & Routing

HTTP/S traffic is served by **Envoy Gateway** (Gateway API), apps are exposed with `HTTPRoute`.
Gateway infrastructure lives in `kube-system/envoy-gateway/`.

Two `Gateway`s exist in the `kube-system` namespace, each with a matching
`GatewayClass`:

### Internal routes

- Gateway: `internal` (GatewayClass `eg-internal`)
- Example: `rook-ceph/dashboard/rook-ceph-dashboard.yaml`

### External routes

- Gateway: `external` (GatewayClass `eg-external`)
- Example: `social/synapse/synapse-httproutes.yaml`

### Attaching an HTTPRoute:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: myapp
  namespace: default
  labels:
    ext-auth: enabled   # opt into Authelia (see below); omit if app handles its own auth
spec:
  parentRefs:
    - name: internal     # or external
      namespace: kube-system
      sectionName: https
  hostnames:
    - myapp.${SECRET_DOMAIN}
  rules:
    - matches:
        - path: { type: PathPrefix, value: / }
      backendRefs:
        - name: myapp
          port: 8080
```

### Auth & TLS:

- **Authelia** is wired via an Envoy Gateway `SecurityPolicy`
  (`kube-system/envoy-gateway/policies/security-policy-authelia.yaml`), which
  targets any `HTTPRoute` carrying the label `ext-auth: enabled`. Add that label
  to protect a route; omit it if the chart provides its own authentication.
- **TLS** is terminated at the Gateway listeners using a shared cert-manager
  certificate (`acme-crt-secret` in the `cert-manager` namespace) backed by the
  `letsencrypt-prod` ClusterIssuer. Per-route TLS annotations are not used.

### LoadBalancer services:

Some workloads (e.g. `media/plex/plex.yaml`, `default/valheim`) are exposed
directly via `type: LoadBalancer` with a MetalLB IP from a `${SVC_*_IP}`
substitution instead of an HTTPRoute.

## YAML Schema Documentation

Always include a `# yaml-language-server: $schema=...` header for editor validation.
The schemas actually in use in this repo:
- **bjw-s app-template values**: `$schema=https://raw.githubusercontent.com/bjw-s-labs/helm-charts/common-5.0.0/charts/library/common/values.schema.json`
- **HelmRelease**: `$schema=https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/helmrelease-helm-v2.json`
- **HelmRepository**: `$schema=https://kubernetes-schemas.devbu.io/helmrepository_v1beta2.json`

## Storage & Backups

- **PVCs** generally use `rook-ceph-block`.
- **Volsync** is used for backups with `ReplicationSource` + Restic.

## AI Agent Notes

- Prefer the **bjw-s app-template** (HelmRepository `bjw-s-helm-charts`, chart
  `app-template`) unless a service requires its own chart.
- Maintain **namespace README.md** indexes.
- Expose apps with an `HTTPRoute` on the `internal` or `external` Gateway; add the
  `ext-auth: enabled` label when Authelia protection is wanted.
- Ensure secrets are encrypted and referenced via `${SECRET_*}`.
- Keep schema headers for YAML validation.
