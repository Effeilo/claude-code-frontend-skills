# Supported languages

Language support varies by skill. This page provides a consolidated view across the entire collection.

---

## Support matrix

| Extension | Language | front-comments | front-a11y | front-review | front-refactor |
|---|---|---|---|---|---|
| `.js` `.ts` `.mjs` | JavaScript / TypeScript | Yes | - | Yes | Yes |
| `.jsx` `.tsx` | React | Yes | Yes | Yes | Yes |
| `.css` `.sass` `.scss` | CSS / Sass | Yes | - | Yes | Yes |
| `.html` | HTML | Yes | Yes | Yes | - |
| `.vue` | Vue SFC | Yes | Yes | Yes | Yes |
| `.svelte` | Svelte | Yes | Yes | Yes | Yes |
| `.astro` | Astro | Yes | Yes | Yes | Yes |

---

## Notes

### front-a11y does not support CSS and JS

Accessibility rules apply to markup and component structure, not to stylesheets or logic files in isolation. CSS color contrast warnings are included in the HTML / component audit when inline styles are present.

### front-refactor does not support HTML

HTML refactoring (semantic element substitution, attribute cleanup) overlaps significantly with accessibility fixes and code review. Structural HTML changes are covered by front-a11y (fix mode) and front-review.

### front-comments supports TypeScript

`.ts` files are handled by the same `front-comments-js.md` sub-file as `.js` files. TypeScript-specific constructs (interfaces, type annotations, generics) are recognized and documented accordingly.

### Sass variants

`.sass` (indented syntax) and `.scss` (CSS-like syntax) are both supported where CSS is listed. The skill detects the variant from the extension and adapts its comment and refactoring patterns accordingly.

---

## Unsupported file types

If you run a skill on an unsupported file type, the skill will inform you and list the supported extensions. No changes are made to the file.
