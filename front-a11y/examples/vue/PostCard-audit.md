# Accessibility Audit: PostCard.vue

---

## 🔴 Critical

**[line 4] Link has no accessible name**
Element: `<RouterLink :to="'/blog/' + post.slug"><img :src="post.thumbnail"></RouterLink>`
Problem: The link wraps an image with no `alt` attribute. Screen readers have no text to announce for this link.
Fix: Add `:alt="post.title"` (or a descriptive alternative) to the `<img>`. This will also serve as the link's accessible name.

---

**[line 4] Missing `alt` attribute on `<img>`**
Element: `<img :src="post.thumbnail">`
Problem: No `alt` or `:alt` attribute. The thumbnail likely represents the post and should have a meaningful description.
Fix: Add `:alt="post.title"` or `:alt="post.thumbnailAlt"` if a dedicated alt field is available.

---

**[line 27] Button has no accessible name**
Element: `<button @click="emit('bookmark', post)"><svg>...</svg></button>`
Problem: The button contains only an SVG with no `aria-label`. Screen readers cannot announce its purpose.
Fix: Add `:aria-label="\`Bookmark \${post.title}\`"` to the button and `aria-hidden="true"` to the SVG.

---

## 🟠 Major

**[line 14] Non-interactive element with `@click` but no keyboard support**
Element: `<span @click="emit('filter', tag)">`
Problem: Clicking a `<span>` to filter by tag is not keyboard-accessible. There is no `role`, `tabindex`, or keyboard handler.
Fix: Add `role="button"` and `tabindex="0"` to each `<span>`. Also add `@keydown.enter="emit('filter', tag)"` and `@keydown.space.prevent="emit('filter', tag)"`.

---

**[line 28] Decorative SVG not hidden from assistive technology**
Element: `<svg>` inside the bookmark button
Problem: The SVG has no `aria-hidden="true"`. Screen readers will attempt to read the path data.
Fix: Add `aria-hidden="true"` to the SVG.

---

## 🟡 Minor

**[line 24] Generic link text**
Element: `<RouterLink :to="'/blog/' + post.slug">Read more</RouterLink>`
Problem: "Read more" is ambiguous for screen reader users navigating a list of cards. Each link has the same text with no distinguishable context.
Fix: Add `:aria-label="\`Read more about \${post.title}\`"` to the link.

---

**[line 11] `v-for` list without semantic list element**
Element: `<span v-for="tag in post.tags">` inside `<div class="post-card__tags">`
Problem: The tags are rendered as a flat list of `<span>` elements. Screen readers will not announce them as a list.
Fix: Replace the wrapper `<div>` with `<ul>` and each `<span>` with `<li>`. Remove the `role` workaround.

---

## Summary

| Severity | Count |
|---|---|
| 🔴 Critical | 3 |
| 🟠 Major | 2 |
| 🟡 Minor | 2 |
| **Total** | **7** |
