# CLAUDE.md

Flux2 GitOps repo for a single homelab k3s cluster. Flux reconciles the whole repo from `main` via one Kustomization (`flux-system/gotk-sync.yaml`) with SOPS decryption and `postBuild.substituteFrom` injecting the `cluster-settings` ConfigMap and `cluster-secrets` Secret (`flux-system-extra/cluster/`). Changes take effect only after commit + push.

## Layout
- Top-level dirs are namespaces (`default/`, `media/`, `social/`, `kube-system/`, …), each with a `README.md` index — keep it updated when adding/removing apps.
- HelmRepository sources: `flux-system-extra/helm-chart-repositories/`.
- Core stack: Envoy Gateway (Gateway API), Rook-Ceph (`rook-ceph-block`), MetalLB, Authelia, cert-manager, SOPS, VolSync.

## Adding an app
Create `<namespace>/<app>/` with:
- `<app>.yaml` — HelmRelease; prefer the bjw-s `app-template` chart (HelmRepository `bjw-s-helm-charts`).
- `pvc.yaml` if persistent storage (storageClass `rook-ceph-block`).
- `volsync.yaml` if backups: per-app restic config Secret (MinIO S3 repo, `${SECRET_VOLSYNC_*}` creds) + `ReplicationSource`.
- `gateway-policies.yaml` only if the app must bypass Authelia (see Auth).
- Use `${SECRET_*}` / `${SVC_*}` Flux substitutions for secrets and service IPs.
- Add the app to the namespace README.

Every YAML file gets a `# yaml-language-server: $schema=...` header:
- bjw-s app-template values: `https://raw.githubusercontent.com/bjw-s-labs/helm-charts/common-5.0.0/charts/library/common/values.schema.json`
- HelmRelease: `https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/main/helmrelease-helm-v2.json`
- HelmRepository: `https://kubernetes-schemas.devbu.io/helmrepository_v1beta2.json`

## Routing
Expose HTTP/S apps with an `HTTPRoute` attached to the `internal` or `external` Gateway (namespace `kube-system`, `sectionName: https`), hostname `<app>.${SECRET_DOMAIN}` (external) or `<app>.${SECRET_DOMAIN}` (internal). Gateway infra: `kube-system/envoy-gateway/`.

```yaml
spec:
  parentRefs:
    - name: internal        # or external
      namespace: kube-system
      sectionName: https
  hostnames: ["myapp.${SECRET_DOMAIN}"]
  rules:
    - matches: [{ path: { type: PathPrefix, value: / } }]
      backendRefs: [{ name: myapp, port: 8080 }]
```

- Label `error-pages: enabled` on an HTTPRoute opts into the default `BackendTrafficPolicy` (custom error pages, compression, retries).
- **Auth**: Authelia is enforced on *all* routes by default — a Gateway-scoped `SecurityPolicy` (`kube-system/envoy-gateway/policies/security-policy-authelia.yaml`) targets both Gateways. Apps with their own auth opt out via a per-app `<app>-no-authz` SecurityPolicy targeting their HTTPRoute (see any `gateway-policies.yaml`, e.g. `media/plex/`).
- **TLS** terminates at the Gateway listeners (shared `acme-crt-secret`, `letsencrypt-prod` ClusterIssuer). No per-route TLS config.
- Non-HTTP workloads (e.g. `media/plex`, `default/valheim`) use `type: LoadBalancer` with a MetalLB IP from a `${SVC_*_IP}` substitution.

## Secrets
- Kubernetes Secrets go in `*.sops.yaml`, SOPS-encrypted (`.sops.yaml` encrypts only `data`/`stringData`). Inline `${SECRET_*}` substitution is fine where a value can live in `cluster-secrets`.
- **Never create or commit real secret values.** Stub what's needed and tell the user how to create it.

## Dependencies
Renovate manages image/chart bumps (`.github/renovate.json5` + `.github/renovate/`); images are digest-pinned. A Claude workflow (`.github/workflows/renovate-review.yaml`) reviews Renovate PRs.

## Working notes
- Flux and Kubernetes MCP tools are available for live cluster state (logs, events, resources, Flux reconciliation status) — use them to investigate and verify.
- Stage changes with `git add`; do **not** commit — GPG signing needs interactive pinentry, the user commits.
- Interactive shell is fish: `(…)` not `$(…)`, `and`/`or` not `&&`/`||`, `set -gx` not `export`. Script files may be bash/POSIX sh.
- Missing utilities: run via `nix-shell -p <pkg> --run '…'`; never install globally.

## CodeGraph

If `.codegraph/` exists at the repo root, prefer CodeGraph over grep/find/Read for understanding or locating code:

- **MCP** (if loaded): `codegraph_explore("<names or question>")` — one call returns verbatim source, call paths, and dynamic-dispatch hops grep misses. If deferred, load it via tool search first.
- **Shell** (fallback): `codegraph explore "<names or question>"`.

No `.codegraph/` directory → skip CodeGraph.
