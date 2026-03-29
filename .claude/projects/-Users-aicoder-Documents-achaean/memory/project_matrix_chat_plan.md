---
name: Matrix chat integration plan
description: Post-MVP plan to add real-time chat via Matrix protocol, leveraging user's prior experience with Flutter+Matrix+OIDC from Qtpi dating app
type: project
---

Post-MVP feature: add real-time chat to Achaean using Matrix protocol.

**Why:** Polis communities need both async posts (agora) and real-time chat. Matrix is federated, E2E encrypted, self-hostable, and has a Dart SDK.

**Prior art:** User built Qtpi (dating app) using Flutter + Matrix Dart SDK (behind FluffyChat) + Keycloak OIDC. Same cubit/DI patterns as Achaean. Full repo exists.

**Architecture:**
- Achaean keypair → OIDC provider → Matrix Authentication Service → homeserver
- Polis membership (trust graph) → Matrix room ACLs
- Chat UI built in Flutter using Matrix Dart SDK directly (not Element)
- One identity (keypair) governs both posts and chat

**Key insight:** Matrix protocol is solid; Element client is the problem. Building our own UI avoids all the UX complaints.

**How to apply:** When chat feature is prioritized, port Matrix integration patterns from Qtpi repo. The genuinely new work is trust graph → room ACL mapping.
