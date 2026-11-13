#!/usr/bin/env bash
# First-time setup: loads the 4 workflows from workflows/ into jobhunter-n8n and turns them on.
# After this, open n8n and pick your Telegram and Google credentials in the nodes that show a red warning.
set -e
export MSYS_NO_PATHCONV=1
REPO="$(cd "$(dirname "$0")/.." && pwd)"
C=jobhunter-n8n

docker exec $C mkdir -p /tmp/import
for name in job-hunter-error-alert job-hunter-process job-hunter-daily job-hunter-paste; do
  docker cp "$(cygpath -w "$REPO/workflows/$name.json" 2>/dev/null || echo "$REPO/workflows/$name.json")" "$C:/tmp/import/$name.json" >/dev/null
  docker exec $C n8n import:workflow --input="/tmp/import/$name.json" 2>&1 | grep -i "success\|error" | grep -v tracking
done
for id in jobHunterError jobHunterProc jobHunterDaily jobHunterPaste; do
  docker exec $C n8n publish:workflow --id=$id >/dev/null 2>&1
done
docker restart $C >/dev/null
echo "Imported and published. Open http://localhost:5680 (the paste form is http://localhost:5680/form/job-paste)"
