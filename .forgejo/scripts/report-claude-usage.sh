#!/usr/bin/env bash
# Summarize Claude Code usage from the run's captured result JSON.
# Posts (or upserts) a sticky issue comment (as the Claude reviewer bot) with a
# cumulative table -- one row per workflow run -- so every review run's cost is
# visible rather than overwriting the previous run's numbers.
#
# The Claude invocation pipes `--output-format stream-json` through `tail -1`
# before writing RESULT_FILE, so RESULT_FILE is already a single "result" JSON
# object -- no map()/select() over an array needed (unlike the old GitHub
# Action's execution-file format).
#
# Required env:
#   RESULT_FILE            - path to the captured result JSON (tail -1 of stream-json)
#   MODEL                   - model name (steps.model_tier.outputs.model)
#
# Optional env (sticky PR comment, posted as the CLAUDE_REVIEWER_TOKEN identity):
#   PR, REPO, API           - PR number / owner/repo / Forgejo API base URL
#   CLAUDE_REVIEWER_TOKEN   - Forgejo API token used to read/write the comment

set -u

MARKER="<!-- claude-renovate-usage -->"
out="${GITHUB_STEP_SUMMARY:-/dev/stdout}"

r=""
if [ -n "${RESULT_FILE:-}" ] && [ -s "$RESULT_FILE" ]; then
  r=$(cat "$RESULT_FILE")
fi

# NOTE: computed fields must guard the source field INSIDE the expression. jq's //
# binds looser than / and *, so a trailing `// 0` does NOT prevent a null/number
# division or multiply error. Use `(.x // 0)/...` not `(.x/...) // 0`.
get() { printf '%s' "$r" | jq -r "$1 // 0"; }

# ---------------------------------------------------------------------------
# Actions step summary -- single-run detail table
# ---------------------------------------------------------------------------
if [ -n "$r" ] && [ "$r" != "null" ]; then
  {
    echo "### Claude Review Usage"
    echo "| Metric | Value |"
    echo "|---|---|"
    echo "| Model | \`${MODEL:-unknown}\` |"
    echo "| Turns | $(get '.num_turns') |"
    echo "| Duration | $(get '(.duration_ms // 0)/1000 | floor')s |"
    echo "| Input tokens | $(get '.usage.input_tokens') |"
    echo "| Output tokens | $(get '.usage.output_tokens') |"
    echo "| Cache read | $(get '.usage.cache_read_input_tokens') |"
    echo "| Cache create | $(get '.usage.cache_creation_input_tokens') |"
    echo "| Cost (USD) | \$$(get '(.total_cost_usd // 0)|(.*10000|round)/10000') |"
  } >> "$out"
else
  echo "model=${MODEL:-unknown} (no usage data: result file missing or unparseable)" >> "$out"
fi

# ---------------------------------------------------------------------------
# Sticky PR comment -- cumulative table (one row appended per run)
# ---------------------------------------------------------------------------
if [ -z "${PR:-}" ] || [ -z "${REPO:-}" ] || [ -z "${API:-}" ] || [ -z "${CLAUDE_REVIEWER_TOKEN:-}" ]; then
  exit 0
fi

when=$(date -u +'%Y-%m-%d %H:%M')

# Extract version range from the PR title.
# Renovate titles look like:
#   "feat(container): update image ghcr.io/org/name ( 1.0.0 → 1.1.0 )"
# We want "1.0.0 -> 1.1.0" (ASCII arrow, compact).
version="-"
pr_title=$(curl -sf -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" "$API/repos/$REPO/pulls/$PR" 2>/dev/null | jq -r '.title // ""' 2>/dev/null || true)
if [ -n "$pr_title" ]; then
  from_ver=$(printf '%s' "$pr_title" | grep -oE '\( [^ ]+ [→>-]' | grep -oE '[0-9][^ ]+' | head -1 || true)
  to_ver=$(printf '%s' "$pr_title" | grep -oE '[→>-] [^ ]+ \)' | grep -oE '[0-9][^ ]+' | head -1 || true)
  if [ -n "$from_ver" ] && [ -n "$to_ver" ]; then
    version="${from_ver} -> ${to_ver}"
  elif [ -n "$to_ver" ]; then
    version="-> ${to_ver}"
  fi
fi

model_short="${MODEL:-unknown}"
if [ -n "$r" ] && [ "$r" != "null" ]; then
  turns=$(get '.num_turns')
  cost=$(get '(.total_cost_usd // 0)|(.*10000|round)/10000')
  newrow="| ${when} | ${version} | \`${model_short}\` | ${turns} | \$${cost} |"
else
  newrow="| ${when} | ${version} | \`${model_short}\` | - | - (no data) |"
fi

# Fetch existing comments and find the sticky one: id + body.
comments=$(curl -sf -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" "$API/repos/$REPO/issues/$PR/comments" 2>/dev/null || echo '[]')
existing=$(printf '%s' "$comments" | jq -c --arg m "$MARKER" '[.[] | select(.body | startswith($m))] | last // empty' 2>/dev/null || true)

cid=""
prior_rows=""
if [ -n "$existing" ] && [ "$existing" != "null" ] && [ "$existing" != "empty" ]; then
  cid=$(printf '%s' "$existing" | jq -r '.id // empty' 2>/dev/null || true)
  existing_body=$(printf '%s' "$existing" | jq -r '.body // ""' 2>/dev/null || true)
  # Extract prior data rows: lines that start with "| " but are NOT the header
  # ("| When") or the separator ("| ---").
  if [ -n "$existing_body" ]; then
    prior_rows=$(printf '%s' "$existing_body" \
      | grep -E '^\| ' \
      | grep -vE '^\| (When|---)' \
      || true)
    # Cap at 30 rows to stay well within the comment size limit.
    prior_rows=$(printf '%s' "$prior_rows" | tail -30 || true)
  fi
fi

# Build the full comment body from scratch each time.
header="| When (UTC) | Version | Model | Turns | Cost |"
sep="|---|---|---|---|---|"

body_lines="${MARKER}
### Claude Review Usage
${header}
${sep}"

if [ -n "$prior_rows" ]; then
  body_lines="${body_lines}
${prior_rows}"
fi
body_lines="${body_lines}
${newrow}"

comment_body="$body_lines"
payload=$(jq -n --arg b "$comment_body" '{body: $b}')

if [ -n "$cid" ] && [[ "$cid" =~ ^[0-9]+$ ]]; then
  curl -sf -X PATCH -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" -H "Content-Type: application/json" \
    "$API/repos/$REPO/issues/comments/$cid" -d "$payload" || true
else
  echo "Usage comment cid lookup result: ${cid:-(empty)} — posting new comment"
  curl -sf -X POST -H "Authorization: token $CLAUDE_REVIEWER_TOKEN" -H "Content-Type: application/json" \
    "$API/repos/$REPO/issues/$PR/comments" -d "$payload" || true
fi
