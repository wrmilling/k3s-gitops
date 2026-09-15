#!/usr/bin/env fish
# Cluster healthcheck: Flux reconciliation, workload health, nodes, and
# Rook-Ceph status. Read-only — uses the same kubectl/flux access as the
# agent-readonly ServiceAccount (kube-system/agent-readonly/rbac.yaml),
# which must include the node and rook-ceph grants for the Nodes/Ceph
# sections to work.
#
# Usage: ./scripts/healthcheck.fish [--events-since="2 hours"]
# --events-since takes anything `date -d` understands as a relative time,
# e.g. "30 minutes", "2 hours", "1 day".

set -g ISSUES 0
set -l EVENTS_SINCE "2 hours"

for arg in $argv
    switch $arg
        case '--events-since=*'
            set EVENTS_SINCE (string split -m1 -- '=' $arg)[2]
    end
end

for bin in kubectl flux jq
    if not type -q $bin
        set_color red
        echo "✗ required binary '$bin' not found in PATH"
        set_color normal
        exit 1
    end
end

set -l cutoff (date -u -d "$EVENTS_SINCE ago" +%Y-%m-%dT%H:%M:%SZ 2>/dev/null)
if test -z "$cutoff"
    set_color red
    echo "✗ could not parse --events-since value '$EVENTS_SINCE' with 'date -d'"
    set_color normal
    exit 1
end

function section
    echo
    set_color --bold cyan
    echo "== $argv[1] =="
    set_color normal
end

function ok
    set_color green
    echo "  ✓ $argv[1]"
    set_color normal
end

function warn
    set_color yellow
    echo "  ! $argv[1]"
    set_color normal
end

function fail
    set_color red
    echo "  ✗ $argv[1]"
    set_color normal
    set -g ISSUES (math $ISSUES + 1)
end

# Ready-condition check shared by every Flux CRD kind: skips suspended
# objects (deliberately off, not a failure) and flags anything whose Ready
# condition isn't exactly "True". HelmRepositories with spec.type=="oci"
# are passive references source-controller never populates a status for
# (flux CLI hardcodes them as Ready in its own table output) — skipped the
# same way here rather than reported as a false failure.
function flux_ready_check
    set -l label $argv[1]
    set -l plural $argv[2]

    set -l items (kubectl get $plural -A -o json 2>/dev/null)
    if test -z "$items"
        warn "$label: no resources found or inaccessible"
        return
    end

    set -l total (string join \n -- $items | jq '.items | length')
    if test "$total" = 0
        return
    end

    set -l bad (string join \n -- $items | jq -r '
        .items[] as $i
        | select(($i.spec.suspend // false) != true)
        | select(($i.spec.type // "") != "oci" or (($i.status.conditions // []) | length) > 0)
        | ($i.status.conditions // [] | map(select(.type=="Ready")) | .[0]) as $c
        | select(($c == null) or ($c.status != "True"))
        | "\($i.metadata.namespace)/\($i.metadata.name): \($c.message // "no Ready condition")"
    ')

    if test -z "$bad"
        ok "$label ($total) all Ready"
    else
        for line in $bad
            fail "$label $line"
        end
    end
end

echo (set_color --bold)"k3s-gitops healthcheck — "(date)(set_color normal)

# ---------------------------------------------------------------- Flux ----
section "Flux"
for entry in \
    "Kustomizations|kustomizations.kustomize.toolkit.fluxcd.io" \
    "HelmReleases|helmreleases.helm.toolkit.fluxcd.io" \
    "GitRepositories|gitrepositories.source.toolkit.fluxcd.io" \
    "HelmRepositories|helmrepositories.source.toolkit.fluxcd.io" \
    "HelmCharts|helmcharts.source.toolkit.fluxcd.io" \
    "OCIRepositories|ocirepositories.source.toolkit.fluxcd.io"
    set -l parts (string split "|" $entry)
    flux_ready_check $parts[1] $parts[2]
end

# ---------------------------------------------------------------- Pods ----
section "Pods"
set -l bad_pods (kubectl get pods -A --no-headers 2>/dev/null | awk '$4!="Running" && $4!="Completed" {print $1"/"$2" - "$4}')
if test -z "$bad_pods"
    set -l total (kubectl get pods -A --no-headers 2>/dev/null | wc -l)
    ok "All $total pods Running/Completed"
else
    for p in $bad_pods
        fail $p
    end
end

set -l recent_restarts (kubectl get pods -A -o json 2>/dev/null | jq -r --arg cutoff "$cutoff" '
    .items[] as $p
    | ($p.status.containerStatuses // [])[]
    | select(.lastState.terminated.finishedAt != null and .lastState.terminated.finishedAt > $cutoff)
    | "\($p.metadata.namespace)/\($p.metadata.name) [\(.name)] restarts=\(.restartCount) reason=\(.lastState.terminated.reason // "Unknown")"
')
if test -z "$recent_restarts"
    ok "No container restarts in the last $EVENTS_SINCE"
else
    for r in $recent_restarts
        warn $r
    end
end

# --------------------------------------------------- Deployments/etc. ----
section "Deployments / StatefulSets / DaemonSets"
set -l bad_deploy (kubectl get deployments -A --no-headers 2>/dev/null | awk '{n=split($3,r,"/"); if (r[1]!=r[2]) print $1"/"$2" ready="$3}')
set -l bad_sts (kubectl get statefulsets -A --no-headers 2>/dev/null | awk '{n=split($3,r,"/"); if (r[1]!=r[2]) print $1"/"$2" ready="$3}')
set -l bad_ds (kubectl get daemonsets -A --no-headers 2>/dev/null | awk '$3!=$5 {print $1"/"$2" desired="$3" ready="$5}')

if test -z "$bad_deploy$bad_sts$bad_ds"
    set -l nd (kubectl get deployments -A --no-headers 2>/dev/null | wc -l)
    set -l ns (kubectl get statefulsets -A --no-headers 2>/dev/null | wc -l)
    set -l nds (kubectl get daemonsets -A --no-headers 2>/dev/null | wc -l)
    ok "All $nd Deployments, $ns StatefulSets, $nds DaemonSets fully ready"
else
    for x in $bad_deploy $bad_sts $bad_ds
        fail $x
    end
end

# --------------------------------------------------------------- PVCs ----
section "PersistentVolumeClaims"
set -l bad_pvc (kubectl get pvc -A --no-headers 2>/dev/null | awk '$3!="Bound" {print $1"/"$2" - "$3}')
if test -z "$bad_pvc"
    set -l total (kubectl get pvc -A --no-headers 2>/dev/null | wc -l)
    ok "All $total PVCs Bound"
else
    for p in $bad_pvc
        fail $p
    end
end

# --------------------------------------------------------- Certificates --
section "Certificates (cert-manager)"
set -l cert_items (kubectl get certificates.cert-manager.io -A -o json 2>/dev/null)
if test -z "$cert_items"
    warn "No Certificates found or cert-manager CRDs inaccessible"
else
    set -l total (string join \n -- $cert_items | jq '.items | length')
    set -l bad_certs (string join \n -- $cert_items | jq -r '
        .items[] as $c
        | ($c.status.conditions // [] | map(select(.type=="Ready")) | .[0]) as $r
        | select(($r == null) or ($r.status != "True"))
        | "\($c.metadata.namespace)/\($c.metadata.name): \($r.message // "no Ready condition")"
    ')
    if test -z "$bad_certs"
        ok "All $total Certificates Ready"
    else
        for c in $bad_certs
            fail $c
        end
    end
end

# -------------------------------------------------------------- Nodes ----
section "Nodes"
set -l bad_nodes (kubectl get nodes --no-headers 2>/dev/null | awk '$2!="Ready" {print $1" - "$2}')
if test -z "$bad_nodes"
    set -l total (kubectl get nodes --no-headers 2>/dev/null | wc -l)
    ok "All $total nodes Ready"
else
    for n in $bad_nodes
        fail $n
    end
end

set -l top_nodes (kubectl top nodes 2>/dev/null)
if test -z "$top_nodes"
    warn "metrics-server unavailable / insufficient permissions for 'kubectl top nodes'"
else
    for line in $top_nodes
        echo "  $line"
    end
end

# ----------------------------------------------------------- Rook-Ceph ---
section "Rook-Ceph"
set -l ceph_json (kubectl get cephcluster -n rook-ceph -o json 2>/dev/null)
set -l ceph_count (string join \n -- $ceph_json | jq '.items | length' 2>/dev/null)
if test -z "$ceph_json" -o "$ceph_count" = 0
    warn "No CephCluster found or inaccessible"
else
    set -l health (string join \n -- $ceph_json | jq -r '.items[0].status.ceph.health // "UNKNOWN"')
    set -l phase (string join \n -- $ceph_json | jq -r '.items[0].status.phase // "Unknown"')
    set -l used (string join \n -- $ceph_json | jq -r '.items[0].status.ceph.capacity.bytesUsed // 0')
    set -l total_bytes (string join \n -- $ceph_json | jq -r '.items[0].status.ceph.capacity.bytesTotal // 0')

    if test "$health" = "HEALTH_OK"
        ok "CephCluster phase=$phase health=$health"
    else
        fail "CephCluster phase=$phase health=$health"
    end

    if test "$total_bytes" -gt 0 2>/dev/null
        set -l used_gib (math --scale=1 "$used / 1073741824")
        set -l total_gib (math --scale=1 "$total_bytes / 1073741824")
        set -l pct (math --scale=0 "$used / $total_bytes * 100")
        echo "    capacity: $used_gib GiB used / $total_gib GiB total ($pct%)"
    end

    set -l pool_items (kubectl get cephblockpools -n rook-ceph -o json 2>/dev/null)
    set -l bad_pools (string join \n -- $pool_items | jq -r '.items[] | select(.status.phase != "Ready") | "\(.metadata.name): \(.status.phase)"')
    set -l npools (string join \n -- $pool_items | jq '.items | length' 2>/dev/null)
    if test -z "$bad_pools"
        ok "$npools CephBlockPool(s) Ready"
    else
        for p in $bad_pools
            fail "CephBlockPool $p"
        end
    end
end

# ---------------------------------------------------- Recent Warnings ----
section "Recent Warning Events (last $EVENTS_SINCE)"
set -l warn_events (kubectl get events -A --field-selector type=Warning -o json 2>/dev/null | jq -r --arg since "$cutoff" '
    .items[]
    | select((.lastTimestamp // .eventTime // .metadata.creationTimestamp) > $since)
    | "\(.involvedObject.namespace)/\(.involvedObject.name) [\(.reason)]: \(.message)"
' | sort -u)
if test -z "$warn_events"
    ok "No Warning events in the last $EVENTS_SINCE"
else
    for e in $warn_events
        warn $e
    end
end

# ------------------------------------------------------------- Summary ---
section "Summary"
if test $ISSUES -eq 0
    ok "No issues found"
    exit 0
else
    set_color red
    echo "  ✗ $ISSUES issue(s) found — see above"
    set_color normal
    exit 1
end
