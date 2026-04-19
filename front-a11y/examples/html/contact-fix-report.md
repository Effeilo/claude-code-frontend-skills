# Fix Report — contact.html

---

## ✅ Fixed

- [line 2] Added `lang="en"` to `<html>`
- [line 11] Added `aria-hidden="true"` to the decorative SVG inside the search button
- [line 52] Replaced `tabindex="2"` with `tabindex="0"` on `.btn-secondary` div
- [line 52] Added `role="button"` to `<div onclick="clearForm()">`
- [line 53] Removed `tabindex="3"` from `<button>` (natively focusable)
- [line 82] Added `role="button"`, `tabindex="0"`, and `aria-label="Scroll to top"` to `.scroll-top` div
- [line 83] Added `aria-hidden="true"` to the decorative SVG inside `.scroll-top`

---

## ⚠️ Requires manual attention

- [line 11] `<button onclick="toggleSearch()">` — add `aria-label="Open search"` (or the appropriate label for this action)
- [line 22] `<img src="/assets/contact-hero.jpg">` — add a meaningful `alt` description of the image
- [line 25] `<a href="/faq" target="_blank">Read more</a>` — generic link text + opens in new tab without warning: rewrite or add an `aria-label` with destination and "(opens in a new tab)"
- [line 35] `<input type="text" id="name">` — add `<label for="name">Your name</label>`
- [line 39] `<input type="email" id="email">` — add `<label for="email">Your email</label>`
- [line 52] `<div onclick="clearForm()">` — add an `onkeydown` handler to trigger the action on Enter/Space for keyboard users
- [line 57] `<img src="/assets/team-alice.jpg">` — add `alt="Alice Martin"` or a more descriptive alternative
- [line 59] `<a href="/team/alice">Read more</a>` — generic link text: add `aria-label="Read more about Alice Martin"`
- [line 62] `<img src="/assets/team-bob.jpg">` — add `alt="Bob Chen"` or a more descriptive alternative
- [line 64] `<a href="/team/bob">Read more</a>` — generic link text: add `aria-label="Read more about Bob Chen"`
- [line 74] `<iframe>` — add `title="Map showing our office location"`
- [line 77] `<a href="/legal" target="_blank">` — opens in new tab without warning: add `aria-label="Legal notices (opens in a new tab)"`
- [line 82] `<div onclick="scrollToTop()">` — add an `onkeydown` handler for Enter/Space keyboard support
