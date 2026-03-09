#!/bin/sh
# Sets up the Forgejo system webhook for Radicle mirroring.
#
# Workaround: Forgejo 14's admin hooks API creates webhooks with
# is_system_webhook=false, so they never fire. We insert directly
# into the DB with the correct flag.
#
# Usage: ./scripts/setup-forgejo-webhook.sh
#   Requires: docker, running achaean-postgres with forgejo DB

set -e

WEBHOOK_URL="${WEBHOOK_URL:-http://radicle:8080/webhook}"

# Check if system webhook already exists
EXISTING=$(docker exec achaean-postgres psql -U achaean -d forgejo -tAc \
  "SELECT count(*) FROM webhook WHERE is_system_webhook = true AND url = '$WEBHOOK_URL';")

if [ "$EXISTING" -gt "0" ]; then
  echo "System webhook already exists for $WEBHOOK_URL"
  exit 0
fi

echo "Creating system webhook -> $WEBHOOK_URL"
docker exec achaean-postgres psql -U achaean -d forgejo -c "
  INSERT INTO webhook (repo_id, owner_id, is_system_webhook, url, http_method, content_type, events, is_active, type, meta, last_status, header_authorization_encrypted, created_unix, updated_unix)
  VALUES (0, 0, true, '$WEBHOOK_URL', 'POST', 1,
    '{\"push_only\":false,\"send_everything\":false,\"choose_events\":true,\"branch_filter\":\"\",\"events\":{\"create\":false,\"delete\":false,\"fork\":false,\"push\":true,\"issues\":false,\"issue_assign\":false,\"issue_label\":false,\"issue_milestone\":false,\"issue_comment\":false,\"pull_request\":false,\"pull_request_assign\":false,\"pull_request_label\":false,\"pull_request_milestone\":false,\"pull_request_comment\":false,\"pull_request_review\":false,\"pull_request_sync\":false,\"pull_request_review_request\":false,\"wiki\":false,\"repository\":false,\"release\":false,\"package\":false}}',
    true, 'forgejo', '', 0, '', extract(epoch from now())::bigint, extract(epoch from now())::bigint);
"

echo "Done. System webhook created."
