#!/usr/bin/env bash
# Run this after you change a Job Hunter workflow in the n8n editor (Git Bash: bash scripts/export-workflows.sh).
# It saves clean copies to workflows/, with credential IDs replaced by placeholders.
set -e
export MSYS_NO_PATHCONV=1              # stops Git Bash from rewriting /tmp paths
REPO="$(cd "$(dirname "$0")/.." && pwd)"
C=jobhunter-n8n

docker exec $C mkdir -p /tmp/export
for pair in "jobHunterDaily:job-hunter-daily" "jobHunterPaste:job-hunter-paste" "jobHunterProc:job-hunter-process" "jobHunterError:job-hunter-error-alert"; do
  id=${pair%%:*}; name=${pair#*:}
  docker exec $C n8n export:workflow --id="$id" --pretty --output="/tmp/export/$name.raw.json" 2>&1 | grep -v "Error tracking" || true
  docker exec -i $C node - "/tmp/export/$name.raw.json" "/tmp/export/$name.json" < "$REPO/scripts/sanitize.js"
  docker cp "$C:/tmp/export/$name.json" "$(cygpath -w "$REPO/workflows/$name.json" 2>/dev/null || echo "$REPO/workflows/$name.json")" >/dev/null
done

# Safety check: every credential ID in the public copies must be a placeholder
if grep -A1 -E '"(telegramApi|googleApi)": \{' "$REPO"/workflows/*.json | grep '"id"' | grep -qv 'YOUR_'; then
  echo "WARNING: a real credential ID is still in workflows/"; exit 1
fi
echo "Done. See what changed with: git -C \"$REPO\" diff --stat"
