# Post Schema Design

## Platforms and How They Map

| Platform | What users do | Fields used |
|---|---|---|
| **Twitter/X, Bluesky, Mastodon** | Short text, images, threads | `content.text`, `content.media` |
| **Reddit, Lemmy, Hacker News** | Share link, discuss in thread | `content.text`, `content.url`, replies |
| **Medium, Substack, Ghost** | Long-form writing | `content.text` + presentation hook |
| **Newsletters (Substack, Buttondown)** | Serialized writing to subscribers | `content.text` + RSS (already built in) |
| **Forums (Discourse, phpBB)** | Threaded discussions | `content.text`, `parent` |
| **Stack Overflow, Q&A** | Ask question, answer threads | `content.text`, `parent` |
| **Wikis (Wikipedia, wiki.js)** | Collaboratively edited docs | `content.text` (edits are git commits, collab via Forgejo) |
| **Polls (Strawpoll, Twitter polls)** | Vote on options | `content.text`, `details.options` |
| **Event listings (Meetup)** | Date/location/RSVP | `content.text`, `details.date`, `details.location` |
| **Code sharing (Gists, Pastebin)** | Share code snippets | `content.text`, `details.language` |
| **Classifieds (Craigslist)** | Listings with price/location | `content.text`, `content.media`, `details.price`, `details.location` |
| **Bookmarks/curation (Pinboard, Are.na)** | Curated link collections | `content.text`, `content.url`, `routing.tags` |
| **Personal sites/blogs (WordPress)** | Full website with custom design | `content.text` + presentation hook (HTML+CSS) |
| **RSS readers (Feedly)** | Content aggregation | The agora IS this |

---

## The Schema

Two schemas: **Post** and **Reply**. A reply has everything a post has, plus a `parent` reference. Both have full `content` — replies can include images, links, everything.

### Post

```json
{
  "content": {
    "title": "",
    "text": "",
    "url": "",
    "media": []
  },
  "routing": {
    "poleis": [],
    "tags": [],
    "mentions": []
  },
  "details": {},
  "crosspost": {},
  "timestamp": "",
  "signature": ""
}
```

### Reply

```json
{
  "content": {
    "title": "",
    "text": "",
    "url": "",
    "media": []
  },
  "parent": {
    "author": "",
    "repo": "",
    "path": "",
    "commit": ""
  },
  "timestamp": "",
  "signature": ""
}
```

Replies inherit `routing` from their parent — they don't need to declare poleis, tags, or mentions separately. They're part of the parent's thread. But they get full `content` — a reply can have images, links, everything a post can.

Replies don't have `crosspost` — replies on other platforms happen natively via the client, not through the repo.

---

## Layer 1: Content (what you're saying)

Always present. At minimum `text`.

| Field | Type | Required | Description |
|---|---|---|---|
| `text` | string | yes | The content. One sentence or ten paragraphs. |
| `title` | string | no | Headline. Rendered prominently when present. Natural for link shares, blog posts, events, listings. Absent for short posts and most replies. |
| `url` | string | no | A link. Client renders a preview. |
| `media` | string[] | no | Filenames of images/assets in the post directory. |

---

## Layer 2: Routing (where it goes, who it references)

Only on posts. Replies inherit from parent.

| Field | Type | Required | Description |
|---|---|---|---|
| `poleis` | string[] | no | Which poleis this post is tagged for. |
| `tags` | string[] | no | Hashtags / topic tags. |
| `mentions` | string[] | no | Public keys of mentioned politai. |

---

## Layer 3: Details (structured metadata about the content)

Optional. Freeform object. The protocol doesn't define or constrain it — the polis README and client agree on what fields to expect.

**Poll:**
```json
{ "options": ["Rust", "Go", "Zig"] }
```

**Event:**
```json
{ "date": "2026-04-01T18:00:00Z", "location": "Berlin, c-base" }
```

**Listing:**
```json
{ "price": "500 EUR", "location": "Berlin", "status": "available" }
```

**Code:**
```json
{ "language": "rust" }
```

New community formats don't require protocol changes — just new `details` conventions and a client that knows how to render them.

---

## Layer 4: Crosspost (interoperability with other platforms)

Optional. Only on posts. Each key is a platform, each value is whatever that platform needs. The protocol doesn't define or constrain these — each bridge reads its own key and ignores the rest. The client fills this in from the user's connected accounts.

```json
{
  "crosspost": {
    "nostr": {
      "relays": ["wss://relay.damus.io", "wss://nos.lol"],
      "pubkey": "<nostr-hex-pubkey>"
    },
    "bluesky": {
      "did": "did:plc:abc123",
      "handle": "alice.bsky.social"
    },
    "mastodon": {
      "instance": "mastodon.social",
      "visibility": "public"
    }
  }
}
```

The crosspost bridges read `content` for the actual post data and `crosspost.<platform>` for platform-specific config. Adding a new platform is just a new key and a new bridge — no protocol changes.

---

## Presentation (optional rich rendering)

The `post.json` is always the canonical content — it's what gets crossposted, indexed, and searched. Optionally, presentation files can live alongside it in the same directory for rich rendering in the Koinon agora.

```
posts/
  2026-03-08-hello/
    post.json                ← canonical (always present)
```

```
posts/
  2026-03-08-rust-essay/
    post.json                ← canonical (always present)
    index.html               ← rich presentation (optional)
    style.css
    hero.png
```

**No explicit link between `post.json` and the presentation files.** The client just checks: does `index.html` exist in this directory? If yes, render it in a sandboxed webview (JS disabled). If no, render from `post.json` using the default template.

The HTML+CSS can reference `content.text`, `content.media`, or completely ignore the JSON and do its own thing. The JSON remains the source of truth for crossposting, search, and aggregator indexing regardless.

**JavaScript is not allowed.** HTML + CSS only, rendered in sandbox with JS disabled. This is the security boundary.

---

## Always Present

| Field | Type | Description |
|---|---|---|
| `timestamp` | string (ISO 8601) | When it was posted. |
| `signature` | string | Web Crypto signature of the post content. |

---

## Parent Reference (replies only)

Pins the reply to an exact version of the parent post. Immutable — even if the parent is edited or deleted, the reply points to the exact version it was responding to.

| Field | Type | Description |
|---|---|---|
| `author` | string | Parent author's public key. |
| `repo` | string | Parent author's repo ID. |
| `path` | string | Path to parent's `post.json`. |
| `commit` | string | Git commit hash of the parent post. |

---

## Rendering Rules

The client looks at what's present and composes the rendering:

1. Has `parent`? → render as threaded reply
2. Has `content.url`? → render link preview
3. Has `content.media`? → render images
4. Has `details.options`? → render poll
5. Has `details.date`? → render event card
6. Has `details.price`? → render listing
7. Has `details.language`? → render code block
8. Has presentation files in directory (`index.html`)? → render rich layout in sandbox
9. Just `content.text`? → render as plain post

These compose. A post with `content.url` + `content.media` + `content.text` renders as a link share with an image and commentary. A reply with `content.media` renders as a reply with attached images. The client just renders what's there.

---

## What the Polis README Declares

The polis README can optionally hint at what kind of community it is, which tells the client how to sort and display the agora:

```json
{ "format": "links", "sort": "replies" }
```

```json
{ "format": "microblog", "sort": "chronological" }
```

```json
{ "format": "events", "sort": "date" }
```

This is a hint to the client, not a constraint. The protocol doesn't enforce it. A "links" polis can still have text-only posts. The client just defaults to a link-aggregator layout.

---

## Examples

**A tweet:**
```json
{
  "content": { "text": "Linux is better and here's why..." },
  "routing": { "poleis": ["<polis-id>"], "tags": ["linux"] },
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<sig>"
}
```

**A link share (Reddit-style):**
```json
{
  "content": {
    "title": "This Rust memory safety article is incredible",
    "text": "Especially the section on borrow checking — finally an explanation that makes sense.",
    "url": "https://example.com/rust-article"
  },
  "routing": { "poleis": ["<polis-id>"], "tags": ["rust", "programming"] },
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<sig>"
}
```

**A classified listing:**
```json
{
  "content": {
    "title": "ThinkPad X1 Carbon for sale",
    "text": "Great condition, 3 years old, new battery. Pickup in Berlin.",
    "media": ["front.jpg", "back.jpg"]
  },
  "routing": { "poleis": ["<polis-id>"], "tags": ["for-sale", "laptop"] },
  "details": { "price": "500 EUR", "location": "Berlin", "status": "available" },
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<sig>"
}
```

**An event:**
```json
{
  "content": { "title": "FOSS Meetup Berlin", "text": "Monthly meetup — all welcome, bring a laptop" },
  "routing": { "poleis": ["<polis-id>"] },
  "details": { "date": "2026-04-01T18:00:00Z", "location": "Berlin, c-base" },
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<sig>"
}
```

**A reply with an image:**
```json
{
  "content": {
    "text": "Here's what mine looks like after 3 years",
    "media": ["my-thinkpad.jpg"]
  },
  "parent": {
    "author": "<their-pubkey>",
    "repo": "<their-repo>",
    "path": "posts/2026-03-08-thinkpad/post.json",
    "commit": "a1b2c3d4..."
  },
  "timestamp": "2026-03-08T13:00:00Z",
  "signature": "<sig>"
}
```

**A poll:**
```json
{
  "content": { "text": "Best systems language?" },
  "routing": { "poleis": ["<polis-id>"], "tags": ["programming"] },
  "details": { "options": ["Rust", "Go", "Zig"] },
  "timestamp": "2026-03-08T12:00:00Z",
  "signature": "<sig>"
}
```

**A crossposted link share:**
```json
{
  "content": {
    "title": "Why I switched from VS Code to Helix",
    "text": "After 5 years of VS Code I finally made the jump...",
    "url": "https://example.com/helix-switch"
  },
  "routing": { "poleis": ["<polis-id>"], "tags": ["editors", "helix"] },
  "crosspost": {
    "nostr": { "relays": ["wss://relay.damus.io"], "pubkey": "<nostr-pubkey>" },
    "bluesky": { "did": "did:plc:abc123" }
  },
  "timestamp": "2026-03-08T14:00:00Z",
  "signature": "<sig>"
}
```

**A blog post with rich presentation:**
```
posts/
  2026-03-08-helix-switch/
    post.json                ← JSON canonical content (crossposted as plain text)
    index.html               ← rich layout with custom typography and screenshots
    style.css
    screenshot-1.png
    screenshot-2.png
```
