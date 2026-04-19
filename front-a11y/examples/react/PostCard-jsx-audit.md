# Accessibility Audit: PostCard.jsx

---

## 🔴 Critical

**[line 7] Link has no accessible name**
Element: `<Link to={'/blog/' + post.slug}><img src={post.thumbnail} /></Link>`
Problem: The link wraps an image with no `alt` prop. Screen readers have no text to announce for this link.
Fix: Add `alt={post.title}` (or a dedicated alt field) to the `<img>`. This will also serve as the link's accessible name.

---

**[line 7] Missing `alt` prop on `<img>`**
Element: `<img src={post.thumbnail} />`
Problem: No `alt` prop. The thumbnail represents the post and should have a meaningful description.
Fix: Add `alt={post.title}` or `alt={post.thumbnailAlt}` if a dedicated field is available.

---

**[line 31] Button has no accessible name**
Element: `<button onClick={() => onBookmark(post)}><svg>...</svg></button>`
Problem: The button contains only an SVG with no `aria-label`. Screen readers cannot announce its purpose.
Fix: Add `aria-label={\`Bookmark ${post.title}\`}` to the button and `aria-hidden="true"` to the SVG.

---

## 🟠 Major

**[line 16] Non-interactive element with `onClick` but no keyboard support**
Element: `<span onClick={() => onFilter(tag)}>`
Problem: Clicking a `<span>` to filter by tag is not keyboard-accessible. There is no `role`, `tabIndex`, or keyboard handler.
Fix: Add `role="button"` and `tabIndex={0}` to each `<span>`. Also add:
```jsx
onKeyDown={(e) => { if (e.key === 'Enter' || e.key === ' ') onFilter(tag); }}
```

---

**[line 32] Decorative SVG not hidden from assistive technology**
Element: `<svg>` inside the bookmark button
Problem: The SVG has no `aria-hidden="true"`. Screen readers will attempt to read the path data.
Fix: Add `aria-hidden="true"` to the SVG.

---

## 🟡 Minor

**[line 27] Generic link text**
Element: `<Link to={'/blog/' + post.slug}>Read more</Link>`
Problem: "Read more" is ambiguous for screen reader users navigating a list of cards. Each card exposes the same link text with no distinguishable context.
Fix: Add `aria-label={\`Read more about ${post.title}\`}` to the link.

---

**[line 13] `.map()` list without semantic list element**
Element: `{post.tags.map(...)}` inside `<div className="post-card__tags">`
Problem: Tags are rendered as `<span>` elements inside a `<div>`. Screen readers will not announce them as a list.
Fix: Replace the `<div>` wrapper with `<ul>` and each `<span>` with `<li>`.

---

## Summary

| Severity | Count |
|---|---|
| 🔴 Critical | 3 |
| 🟠 Major | 2 |
| 🟡 Minor | 2 |
| **Total** | **7** |
