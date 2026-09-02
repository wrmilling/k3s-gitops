#!/usr/bin/env bash
# Dismiss the reviewer's own stale reviews on this PR (if any) and post a new one.
# Claude invokes this as a single tool call instead of separately curling to fetch
# reviews, reasoning about which IDs to dismiss, dismissing each in a loop, building
# a JSON payload, and POSTing -- collapsing what would otherwise be several turns
# worth of raw Forgejo API calls into one.
#
# Usage: post-review.sh <APPROVED|REQUEST_CHANGES> <body-file>
#
# Required env: FORGEJO_API, REPO, PR, CLAUDE_REVIEWER_TOKEN, REVIEWER_LOGIN
# Optional env: DIFF_PATCH_ID -- if set, appended to the posted body as a hidden
#   HTML-comment marker so the next run's "Check for redundant review" workflow
#   step can detect an unchanged diff (a pure Renovate rebase) and skip re-running
#   Claude entirely. Not consumed by Claude itself -- purely CI bookkeeping.

set -euo pipefail

event="${1:?usage: post-review.sh <APPROVED|REQUEST_CHANGES> <body-file>}"
body_file="${2:?usage: post-review.sh <APPROVED|REQUEST_CHANGES> <body-file>}"

if [[ "$event" != "APPROVED" && "$event" != "REQUEST_CHANGES" ]]; then
  echo "ERROR: event must be APPROVED or REQUEST_CHANGES, got: $event" >&2
  exit 1
fi

if [[ ! -f "$body_file" ]]; then
  echo "ERROR: body file not found: $body_file" >&2
  exit 1
fi

base="$FORGEJO_API/repos/$REPO/pulls/$PR/reviews"

# Dismiss this bot's own prior active reviews so only the current verdict is visible.
stale_ids=$(curl -sf -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" "$base" \
  | jq -r --arg me "$REVIEWER_LOGIN" \
    '.[] | select(.user.login == $me and (.state == "APPROVED" or .state == "CHANGES_REQUESTED")) | .id')

for id in $stale_ids; do
  echo "Dismissing stale review $id"
  curl -sf -X POST -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" -H "Content-Type: application/json" \
    "$base/$id/dismissals" -d '{"message":"Superseded by updated review"}' || true
done

payload=$(jq -n --arg event "$event" --rawfile body "$body_file" --arg patch_id "${DIFF_PATCH_ID:-}" '
  {event: $event, body: (if $patch_id != "" then ($body + "\n\n<!-- diff-patch-id: " + $patch_id + " -->") else $body end)}
')
curl -sf -X POST -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" -H "Content-Type: application/json" \
  "$base" -d "$payload"
