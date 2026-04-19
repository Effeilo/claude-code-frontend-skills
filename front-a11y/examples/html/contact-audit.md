# Accessibility Audit: contact.html

---

## 🔴 Critical

**[line 2] Missing `lang` attribute on `<html>`**
Element: `<html>`
Problem: The `<html>` element has no `lang` attribute. Screen readers cannot determine the document language, which affects pronunciation and voice selection.
Fix: Add `lang="en"` (or the appropriate language code).

---

**[line 11] Button has no accessible name**
Element: `<button onclick="toggleSearch()"><svg>...</svg></button>`
Problem: The button contains only an SVG with no `aria-label` or visible text. Assistive technologies cannot announce its purpose.
Fix: Add `aria-label="Open search"` to the button and `aria-hidden="true"` to the SVG.

---

**[line 22] Missing `alt` attribute on `<img>`**
Element: `<img src="/assets/contact-hero.jpg">`
Problem: The `alt` attribute is missing. Screen readers will announce the file path instead of a meaningful description.
Fix: Add a descriptive `alt` attribute, e.g. `alt="Our team working in a bright open-plan office"`.

---

**[line 35] Input has no associated label**
Element: `<input type="text" id="name" placeholder="Your name">`
Problem: No `<label>` is associated with this field. Placeholders disappear on input and are not a substitute for labels.
Fix: Add `<label for="name">Your name</label>` before the input.

---

**[line 39] Input has no associated label**
Element: `<input type="email" id="email" placeholder="Your email">`
Problem: No `<label>` is associated with this field.
Fix: Add `<label for="email">Your email</label>` before the input.

---

## 🟠 Major

**[line 52] Positive `tabindex` value**
Element: `<div ... tabindex="2">Clear</div>`
Problem: `tabindex="2"` overrides the natural tab order, which is confusing for keyboard users.
Fix: Replace with `tabindex="0"`.

---

**[line 53] Positive `tabindex` value**
Element: `<button type="submit" tabindex="3">Send message</button>`
Problem: `tabindex="3"` overrides the natural tab order.
Fix: Remove the `tabindex` attribute entirely, `<button>` is natively focusable.

---

**[line 52] Non-interactive element with click handler but no keyboard support**
Element: `<div onclick="clearForm()" class="btn-secondary" tabindex="2">Clear</div>`
Problem: This `<div>` acts as a button but is not announced as one, and has no keyboard handler for Enter/Space.
Fix: Add `role="button"`. Also add an `onkeydown` handler to trigger `clearForm()` on Enter/Space.

---

**[line 74] `<iframe>` has no `title` attribute**
Element: `<iframe src="https://www.openstreetmap.org/...">`
Problem: Screen readers cannot identify the purpose of the embedded content.
Fix: Add `title="Map showing our office location"`.

---

**[line 82] Non-interactive element with click handler but no keyboard support**
Element: `<div onclick="scrollToTop()" class="scroll-top"><svg>...</svg></div>`
Problem: This `<div>` acts as a button but is not reachable or operable by keyboard.
Fix: Add `role="button"`, `tabindex="0"`, an `aria-label="Scroll to top"`, and an `onkeydown` handler.

---

**[line 83] Decorative SVG not hidden from assistive technology**
Element: `<svg>` inside `.scroll-top` div
Problem: The SVG has no `aria-hidden="true"`. Screen readers will attempt to announce it.
Fix: Add `aria-hidden="true"` to the SVG.

---

## 🟡 Minor

**[line 25] Generic link text**
Element: `<a href="/faq" target="_blank">Read more</a>`
Problem: "Read more" is ambiguous without context. Screen reader users navigating by links cannot determine the destination.
Fix: Use descriptive text such as "Learn more about our response times", or add `aria-label="Learn more about our response times (opens in a new tab)"`.

---

**[line 25] New-tab link without user warning**
Element: `<a href="/faq" target="_blank">Read more</a>`
Problem: The link opens in a new tab but does not inform the user. This can disorient screen reader and keyboard users.
Fix: Add `(opens in a new tab)` to the visible text or as a `<span class="sr-only">` inside the link.

---

**[line 59] Generic link text**
Element: `<a href="/team/alice">Read more</a>`
Problem: "Read more" is ambiguous. A screen reader user navigating by links cannot tell this link is about Alice Martin.
Fix: Use `aria-label="Read more about Alice Martin"` or rewrite the text.

---

**[line 64] Generic link text**
Element: `<a href="/team/bob">Read more</a>`
Problem: Same as above, "Read more" is ambiguous without the context of the surrounding text.
Fix: Use `aria-label="Read more about Bob Chen"` or rewrite the text.

---

**[line 77] New-tab link without user warning**
Element: `<a href="/legal" target="_blank">Legal notices</a>`
Problem: Opens in a new tab without informing the user.
Fix: Add `aria-label="Legal notices (opens in a new tab)"` or a visually hidden notice inside the link.

---

**[line 57] Missing `alt` attribute on `<img>`**
Element: `<img src="/assets/team-alice.jpg">`
Problem: No `alt` attribute. The image appears to show a team member and should have a descriptive alternative.
Fix: Add `alt="Alice Martin"` or a more descriptive alternative.

---

**[line 62] Missing `alt` attribute on `<img>`**
Element: `<img src="/assets/team-bob.jpg">`
Problem: No `alt` attribute.
Fix: Add `alt="Bob Chen"` or a more descriptive alternative.

---

## Summary

| Severity | Count |
|---|---|
| 🔴 Critical | 5 |
| 🟠 Major | 6 |
| 🟡 Minor | 6 |
| **Total** | **17** |
