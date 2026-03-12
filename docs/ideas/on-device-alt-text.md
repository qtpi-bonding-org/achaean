# On-Device Alt Text Generation

## Idea

When a user attaches an image to a post, the client auto-generates an alt text description using an on-device vision model. The user reviews/edits it before posting. The description is stored in the post's `media` field alongside the filename.

## Why

- Accessibility without friction — feels like autocomplete, not a chore
- One-time cost at post time, not repeated by every reader
- Author can correct mistakes before publishing
- No protocol change required — purely a client feature
- No API costs — runs on device, data stays private

## On-Device Models

| Platform | Model | Availability |
|---|---|---|
| iOS 26+ | Apple Foundation Models | Built-in, free, private |
| Android (Pixel+) | Gemini Nano (multimodal) | Built-in, free, private |
| Fallback | LLaVA / PaliGemma via MLC | Any device, heavier on battery/RAM |

Platform models (Apple, Google) are preferred — already on device, already optimized. Access via Flutter platform channels.

## Quality

Small on-device models produce shorter, simpler descriptions ("a laptop on a desk") compared to large cloud models ("a silver ThinkPad X1 Carbon with the lid open on a wooden desk, showing a terminal with green text"). For alt text, simpler is usually fine, and the author can always edit.

## Behavior

1. User attaches image in post composer
2. If on-device vision model is available → auto-generate description, pre-fill alt text field
3. If not available → show empty field with hint text
4. User can edit, accept, or clear the suggestion
5. Alt text is stored with the media reference in `post.json`

## Schema Consideration

Currently `media` is `string[]` (filenames). To store alt text, either:

- Change to objects: `[{ "file": "photo.jpg", "alt": "description" }]`
- Or store separately: `"media_alt": { "photo.jpg": "description" }`

This is a schema decision, not a protocol decision. Alt text is not required by the protocol — poleis can require it as a community norm via their README, enforced by the flag system.

## When to Build

Post composer screen implementation. Not before.
