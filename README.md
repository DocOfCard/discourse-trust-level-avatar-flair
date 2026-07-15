# Trust Level Avatar Flair - Emoji Fixed

A compatibility-fixed build of `tshenry/discourse-trust-level-avatar-flair`.

## Fix

The upstream component only rendered values containing `fa-`; plain Emoji values produced an empty flair element and only the background circle was visible. This build renders plain Emoji directly while retaining image URL and Font Awesome support.

## Defaults

- TL0: 🌱
- TL1: ⚔️
- TL2: 🏅
- TL3: 💎
- TL4: 👑

For Emoji, keep **Use Font Awesome** disabled.
