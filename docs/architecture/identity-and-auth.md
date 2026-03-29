# Identity and Authentication Architecture

## Core Principle

Identity is a cryptographic keypair. The user holds the private key. The public key lives in their git repo at `identity/pubkey.json`. Everything else is a translation layer.

## Authentication Paths

The system uses two auth mechanisms depending on the target:

### 1. Keypair Signature (Achaean-native)

Used for: Synedrion API calls

The Flutter client signs requests with the private key. The synedrion verifies against the public key. No intermediary involved. Fully sovereign — works even if the forge is down.

Already implemented via `KoinonAuthHandler`.

### 2. Forgejo OAuth2/OIDC (bridge to OIDC-land)

Used for: Git operations, Matrix chat (future)

Forgejo (the git host / archeion) has built-in OAuth2 provider endpoints. It serves as the OIDC identity provider for services that require standard OIDC tokens.

Endpoints (built into Forgejo):
- Authorization: `https://<forge>/login/oauth/authorize`
- Token: `https://<forge>/login/oauth/access_token`
- Userinfo: `https://<forge>/api/v1/user`

No separate IDP service needed (no Keycloak, no Dex, no custom service).

### Why two paths?

| Concern | Keypair auth | Forgejo OIDC |
|---------|-------------|--------------|
| Sovereignty | Full — no intermediary | Depends on forge being up |
| Standards compat | Custom (Koinon-specific) | Standard OIDC — works with any OIDC consumer |
| Use case | Synedrion, P2P | Matrix, third-party services |
| Already built | Yes (KoinonAuthHandler) | Yes (Forgejo built-in) |

## Auth Flow Per Service

```
Flutter app
  ├── Git operations → Forgejo OAuth token (existing)
  ├── Synedrion API  → Keypair signature (existing)
  └── Matrix chat    → Forgejo OIDC → Matrix Auth Service (future)
```

## Matrix Integration (Future)

Matrix Synapse supports Forgejo/Gitea as an upstream OIDC provider. Documented config:

```yaml
oidc_providers:
  - idp_id: forgejo
    idp_name: Forgejo
    discover: false
    issuer: "https://<forge>/"
    client_id: "<client-id>"
    client_secret: "<client-secret>"
    client_auth_method: client_secret_post
    scopes: []
    authorization_endpoint: "https://<forge>/login/oauth/authorize"
    token_endpoint: "https://<forge>/login/oauth/access_token"
    userinfo_endpoint: "https://<forge>/api/v1/user"
    user_mapping_provider:
      config:
        subject_claim: "id"
        localpart_template: "{{ user.login }}"
        display_name_template: "{{ user.full_name }}"
```

User logs into Matrix with their Forgejo account. Same identity across git, chat, and the synedrion. One keypair, one forge account, multiple services.

## Trust Chain

```
Keypair (cryptographic root of identity)
  │
  ├── identity/pubkey.json in git repo (verifiable by anyone)
  │
  ├── Forgejo account (access layer — controls repo, provides OIDC)
  │     ├── Matrix trusts Forgejo via OIDC
  │     └── Git operations use Forgejo tokens
  │
  └── Synedrion verifies keypair signatures directly
        (no Forgejo dependency for API auth)
```

## Design Decisions

1. **No separate IDP service** — Forgejo already has OAuth2/OIDC. Adding Keycloak/Dex/custom service is unnecessary infrastructure.

2. **Synedrion stays keypair-based** — More sovereign, simpler, already built. No reason to add OIDC dependency.

3. **Matrix uses Forgejo OIDC** — Matrix requires standard OIDC. Forgejo provides it. Config-only integration, no code changes.

4. **The forge is trusted infrastructure** — Users already trust their forge (it hosts their data). Making it the IDP doesn't add new trust assumptions.
