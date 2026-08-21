# Temporary patched cephcsi image: upstream ceph-csi v3.17.0 bundles a Ceph 20.2.1
# client, which predates the aes256k cephx key type introduced in Ceph 20.2.4
# (CVE-2025-30156 fix). Since our CephCluster's csi cephx keys are rotated to
# aes256k (rook-ceph/cluster/cluster.yaml, security.cephx.csi.keyGeneration), the
# stock image can't authenticate at all -- every fresh RBD volume attach fails with
# `rados: ret=-22, Invalid argument` ("auth: failed to decode key").
#
# This just upgrades the Ceph client libraries in place from the same official
# Tentacle RPM repo the base image already has configured, pinned to match the
# exact Ceph version this cluster's daemons run (quay.io/ceph/ceph:v20.2.4).
#
# Built and pushed manually (not via a Forgejo Actions workflow):
#   docker build -t git.${SECRET_DOMAIN}/wrmilling/cephcsi-patched:v3.17.0-ceph20.2.4 .
#   docker push git.${SECRET_DOMAIN}/wrmilling/cephcsi-patched:v3.17.0-ceph20.2.4
#
# Revert once ceph-csi ships a release bundling a Ceph 20.2.4+ client: drop this
# directory, and reset csi.cephcsi.repository/tag in
# rook-ceph/chart/rook-ceph-chart.yaml back to the chart defaults
# (quay.io/cephcsi/cephcsi). No cephx/cluster-side state to unwind -- this is a
# pure image swap.
FROM quay.io/cephcsi/cephcsi:v3.17.0
RUN dnf install -y --allowerasing \
      librados2-20.2.4-0.el9 \
      librbd1-20.2.4-0.el9 \
      libcephfs2-20.2.4-0.el9 \
      libradosstriper1-20.2.4-0.el9 \
      libcephsqlite-20.2.4-0.el9 \
    && dnf clean all
