# AGENTS.md

Guidance for AI agents working in this repository.

## Architecture

- **GitOps**: Flux2 manages all cluster state from this repo (`flux-system/gotk-sync.yaml`).
- **Namespaces**: Organized by function (`default/`, `media/`, `social/`, `kube-system/`, etc.) with per-namespace README indexes.
- **Core stack**:
  - Ingress: `ingress-nginx` (internal + external)
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

## Ingress Handling

Two ingress classes exist:

### Internal routes

- Class: `nginx-internal`
- Example: `rook-ceph/dashboard/ingress.yaml`

### External routes

- Class: `nginx-external`
- Example: `media/plex/plex.yaml`

### Annotations:

- Uses Authelia for auth if the deployed chart does not provide its own authentication.
  - `nginx.ingress.kubernetes.io/auth-signin`
  - `nginx.ingress.kubernetes.io/auth-url`
- TLS via cert-manager for all instances of HTTPS traffic.
  - `kubernetes.io/tls-acme: "true"`
  - `cert-manager.io/cluster-issuer: letsencrypt-prod`

## YAML Schema Documentation

Always include schema validation:
- **HelmRelease (bjw-s)**: `$schema=https://raw.githubusercontent.com/bjw-s/helm-charts/main/charts/other/app-template/schemas/helmrelease-helm-v4.schema.json`

## Storage & Backups

- **PVCs** generally use `rook-ceph-block`.
- **Volsync** is used for backups with `ReplicationSource` + Restic.

## AI Agent Notes

- Prefer the **bjw-s app-template** unless a service requires its own chart.
- Maintain **namespace README.md** indexes.
- Keep ingress class and auth consistent with internal/external intent.
- Ensure secrets are encrypted and referenced via `${SECRET_*}`.
- Keep schema headers for YAML validation.
