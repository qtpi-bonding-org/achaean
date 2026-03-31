#!/bin/bash
# End-to-end test for Dex + Tuwunel (chat profile).
# Requires: docker compose --profile chat up -d
#
# Usage: ./dex/test-e2e.sh

set -e

FORGEJO_URL="http://localhost:3000"
DEX_URL="http://localhost:5556"
TUWUNEL_URL="http://localhost:8008"
ADMIN_USER="${FORGEJO_ADMIN_USER:-aigion-admin}"
ADMIN_PASS="${FORGEJO_ADMIN_PASS}"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m'

pass() { echo -e "${GREEN}✓ $1${NC}"; }
fail() { echo -e "${RED}✗ $1${NC}"; exit 1; }
info() { echo -e "${YELLOW}→ $1${NC}"; }

# Load .env if ADMIN_PASS not set
if [ -z "$ADMIN_PASS" ]; then
  for f in .env ../.env; do
    if [ -f "$f" ]; then
      ADMIN_PASS=$(grep FORGEJO_ADMIN_PASS "$f" | cut -d= -f2)
      break
    fi
  done
fi
[ -z "$ADMIN_PASS" ] && fail "FORGEJO_ADMIN_PASS not set and .env not found"

# --- Preflight ---
info "Checking stack is running..."
docker compose ps --format "{{.Name}}" | grep -q "achaean-forgejo" || fail "Forgejo not running"
docker compose ps --format "{{.Name}}" | grep -q "achaean-dex" || fail "Dex not running (did you use --profile chat?)"
docker compose ps --format "{{.Name}}" | grep -q "achaean-tuwunel" || fail "Tuwunel not running (did you use --profile chat?)"
pass "Stack is running (Forgejo + Dex + Tuwunel)"

# --- Test 1: Dex OIDC discovery ---
info "Checking Dex OIDC discovery endpoint..."
ISSUER=$(curl -sf "$DEX_URL/.well-known/openid-configuration" | python3 -c "import sys,json; print(json.load(sys.stdin)['issuer'])" 2>/dev/null)
[ -z "$ISSUER" ] && fail "Dex not responding or invalid OIDC discovery"
pass "Dex OIDC discovery works (issuer: $ISSUER)"

# --- Test 2: Credentials persisted (including tuwunel_secret) ---
info "Checking credentials were saved..."
CREDS=$(docker compose exec forgejo cat /data/gitea/dex/credentials.json 2>/dev/null)
echo "$CREDS" | grep -q "client_id" || fail "credentials.json missing client_id"
echo "$CREDS" | grep -q "client_secret" || fail "credentials.json missing client_secret"
echo "$CREDS" | grep -q "tuwunel_secret" || fail "credentials.json missing tuwunel_secret"
pass "All credentials persisted (Dex + Tuwunel)"

# --- Test 3: OAuth2 app in Forgejo ---
info "Checking OAuth2 app exists in Forgejo..."
OAUTH_APPS=$(curl -sf "$FORGEJO_URL/api/v1/user/applications/oauth2" \
  -u "$ADMIN_USER:$ADMIN_PASS" 2>/dev/null)
echo "$OAUTH_APPS" | grep -q '"name":"dex"' || fail "OAuth2 app 'dex' not found in Forgejo"
pass "OAuth2 app 'dex' registered in Forgejo"

# --- Test 4: Dex config has Tuwunel static client ---
info "Checking Dex config has Tuwunel static client..."
DEX_CONFIG=$(docker compose exec forgejo cat /data/gitea/dex/config.yaml 2>/dev/null)
echo "$DEX_CONFIG" | grep -q "id: tuwunel" || fail "Dex config missing Tuwunel static client"
echo "$DEX_CONFIG" | grep -q "__" && fail "Dex config has un-templated placeholders"
pass "Dex config has Tuwunel static client, no placeholders"

# --- Test 5: Tuwunel config templated ---
info "Checking Tuwunel config was templated..."
TUW_CONFIG=$(docker compose exec forgejo cat /data/gitea/tuwunel/config.toml 2>/dev/null)
echo "$TUW_CONFIG" | grep -q "server_name" || fail "Tuwunel config missing server_name"
echo "$TUW_CONFIG" | grep -q 'client_id = "tuwunel"' || fail "Tuwunel config missing OIDC client_id"
echo "$TUW_CONFIG" | grep -q "__" && fail "Tuwunel config has un-templated placeholders"
pass "Tuwunel config templated correctly"

# --- Test 6: Tuwunel Matrix API responds ---
info "Checking Tuwunel Matrix API..."
VERSIONS=$(curl -sf "$TUWUNEL_URL/_matrix/client/versions" 2>/dev/null)
echo "$VERSIONS" | grep -q "versions" || fail "Tuwunel not responding on /_matrix/client/versions"
pass "Tuwunel Matrix API responds"

# --- Test 7: Idempotent restart ---
info "Testing idempotent restart..."
docker compose --profile chat rm -f dex-setup > /dev/null 2>&1
docker compose --profile chat up -d dex-setup > /dev/null 2>&1
sleep 5
LOGS=$(docker compose logs dex-setup 2>&1)
echo "$LOGS" | grep -q "skipping registration" || fail "Idempotent restart did not skip registration"
pass "Idempotent restart works (skipped registration)"

echo ""
echo -e "${GREEN}All Dex + Tuwunel e2e tests passed!${NC}"
