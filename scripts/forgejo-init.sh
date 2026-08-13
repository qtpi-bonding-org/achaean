#!/bin/sh
# Auto-provisions Forgejo: admin user, OAuth2 app, system webhooks.
# Idempotent — safe to run on every `docker compose up`.
#
# Usage: ./scripts/forgejo-init.sh
#   Requires: docker, running achaean-forgejo and achaean-postgres

set -e

# Read a named .env value without sourcing the file. Compose-compatible .env
# files may contain unquoted spaces and must not be evaluated as shell code.
SCRIPT_DIR=$(cd "$(dirname "$0")" && pwd)
ENV_FILE="$SCRIPT_DIR/../.env"
env_value() {
  key="$1"
  default="${2:-}"
  if [ -f "$ENV_FILE" ]; then
    value=$(grep -m 1 "^${key}=" "$ENV_FILE" | cut -d= -f2-)
  fi
  printf '%s' "${value:-$default}"
}

FORGEJO=achaean-forgejo
POSTGRES=achaean-postgres

ADMIN_USER=$(env_value FORGEJO_ADMIN_USER achaean)
ADMIN_PASS=$(env_value FORGEJO_ADMIN_PASS)
ADMIN_EMAIL=$(env_value FORGEJO_ADMIN_EMAIL admin@achaean.local)
RUNNER_SECRET=$(env_value FORGEJO_RUNNER_SECRET)

if [ -z "$ADMIN_PASS" ]; then
  echo "FORGEJO_ADMIN_PASS must be set in .env" >&2
  exit 1
fi

OAUTH_APP_NAME="achaean-flutter"
OAUTH_CLIENT_ID="achaean"
# Redirect URIs: native custom scheme + web dev (use: flutter run -d chrome --web-port=59480)
OAUTH_REDIRECT_URIS='["achaean://oauth-callback","http://localhost:59480/auth.html"]'

# Forgejo CLI must run as non-root (UID 1000 = git user in container)
forgejo_cli() {
  docker exec --user 1000 "$FORGEJO" forgejo "$@"
}

# --- Wait for Forgejo to be ready ---
echo "Waiting for Forgejo..."
until docker exec "$FORGEJO" curl -sf http://localhost:3000/api/v1/version > /dev/null 2>&1; do
  sleep 2
done
echo "Forgejo is ready."

# --- Create admin user ---
echo "Creating admin user '$ADMIN_USER'..."
forgejo_cli admin user create \
  --admin \
  --username "$ADMIN_USER" \
  --password "$ADMIN_PASS" \
  --email "$ADMIN_EMAIL" \
  --must-change-password=false 2>&1 \
  && echo "Admin user created." \
  || echo "Admin user already exists."

# --- Create OAuth2 app for Flutter ---
echo "Checking OAuth2 app '$OAUTH_APP_NAME'..."
EXISTING_APP=$(docker exec "$POSTGRES" psql -U achaean -d forgejo -tAc \
  "SELECT count(*) FROM oauth2_application WHERE name = '$OAUTH_APP_NAME';" 2>/dev/null || echo "0")

if [ "$EXISTING_APP" -gt "0" ] 2>/dev/null; then
  CLIENT_ID=$(docker exec "$POSTGRES" psql -U achaean -d forgejo -tAc \
    "SELECT client_id FROM oauth2_application WHERE name = '$OAUTH_APP_NAME';")
  echo "OAuth2 app already exists. client_id: $CLIENT_ID"
else
  echo "Creating OAuth2 app via API..."
  RESPONSE=$(curl -sf \
    -X POST "http://localhost:3000/api/v1/user/applications/oauth2" \
    -u "$ADMIN_USER:$ADMIN_PASS" \
    -H "Content-Type: application/json" \
    -d "{\"name\": \"$OAUTH_APP_NAME\", \"redirect_uris\": [\"achaean://oauth-callback\"], \"confidential_client\": false}")
  # Forgejo generates a UUID client_id — override to match Flutter's hardcoded default
  docker exec "$POSTGRES" psql -U achaean -d forgejo -c \
    "UPDATE oauth2_application SET client_id = '$OAUTH_CLIENT_ID', redirect_uris = '$OAUTH_REDIRECT_URIS' WHERE name = '$OAUTH_APP_NAME';" > /dev/null
  echo "OAuth2 app created. client_id: $OAUTH_CLIENT_ID"
fi

# --- System webhooks ---
create_webhook() {
  local URL="$1"
  local NAME="$2"

  EXISTING=$(docker exec "$POSTGRES" psql -U achaean -d forgejo -tAc \
    "SELECT count(*) FROM webhook WHERE is_system_webhook = true AND url = '$URL';")

  if [ "$EXISTING" -gt "0" ]; then
    echo "$NAME webhook already exists."
  else
    echo "Creating $NAME system webhook -> $URL"
    docker exec "$POSTGRES" psql -U achaean -d forgejo -c "
      INSERT INTO webhook (repo_id, owner_id, is_system_webhook, url, http_method, content_type, events, is_active, type, meta, last_status, header_authorization_encrypted, created_unix, updated_unix)
      VALUES (0, 0, true, '$URL', 'POST', 1,
        '{\"push_only\":false,\"send_everything\":false,\"choose_events\":true,\"branch_filter\":\"\",\"events\":{\"create\":false,\"delete\":false,\"fork\":false,\"push\":true,\"issues\":false,\"issue_assign\":false,\"issue_label\":false,\"issue_milestone\":false,\"issue_comment\":false,\"pull_request\":false,\"pull_request_assign\":false,\"pull_request_label\":false,\"pull_request_milestone\":false,\"pull_request_comment\":false,\"pull_request_review\":false,\"pull_request_sync\":false,\"pull_request_review_request\":false,\"wiki\":false,\"repository\":false,\"release\":false,\"package\":false}}',
        true, 'forgejo', '', 0, '', extract(epoch from now())::bigint, extract(epoch from now())::bigint);
    " > /dev/null
    echo "$NAME webhook created."
  fi
}

create_webhook "http://synedrion:8082/webhook" "Synedrion"
create_webhook "http://radicle:8080/webhook" "Radicle"

# --- Register Actions runner (offline registration) ---
if [ -n "$RUNNER_SECRET" ]; then
  echo "Registering Forgejo Actions runner..."
  forgejo_cli forgejo-cli actions register \
    --name aigion-runner \
    --secret "$RUNNER_SECRET" 2>&1 \
    && echo "Runner registered." \
    || echo "Runner already registered or registration failed."
fi

echo ""
echo "=== Achaean stack initialized ==="
echo "  Forgejo:    http://localhost:3000"
echo "  Synedrion:  http://localhost:8080"
echo "  Admin user: $ADMIN_USER"
echo ""
