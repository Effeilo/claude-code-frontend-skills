# front-a11y: Shared Accessibility Rules

These rules apply to all supported file types (HTML, Vue, Svelte, Astro).
Read the target file entirely before reporting, collect all issues first, then output the report.

Each rule has an ID, severity, detection criterion, and fix instruction.
Syntax-specific examples and detection nuances are in the language sub-files.

---

## Category 1: Images

### IMG-1: Missing `alt` attribute (🔴 Critical)

Every `<img>` must have an `alt` attribute.

**Detect:** `<img>` with no `alt` attribute (static or dynamic binding).

**Fix:**
- Clearly decorative image (inside a button/link that already has a text label, or filename contains `icon`, `deco`, `divider`, `separator`, `bg`, `background`) → add `alt=""` (auto-fixable).
- Otherwise → flag for manual attention: a meaningful description is required.

### IMG-2: Decorative icon image missing `alt=""` (🟡 Minor)

An `<img>` sibling to a text node inside a `<button>` or link element should be marked as decorative.

**Detect:** `<img>` without `alt=""` inside a `<button>` or link element that already contains visible text.

**Fix:** Add `alt=""`, auto-fixable.

---

## Category 2: Links & Buttons

### LNK-1: Link with no accessible name (🔴 Critical)

Every link element must have a non-empty accessible name: visible text content, `aria-label`, or `aria-labelledby`.

**Detect:** A link element whose text content is empty or whitespace-only, with no `aria-label` / `aria-labelledby`, and whose only children are images with `alt=""` or SVGs with `aria-hidden="true"`.

**Fix:** Flag for manual attention, add a descriptive `aria-label`.

### LNK-2: Generic link text (🟡 Minor)

Links whose visible text is ambiguous without surrounding context.

**Detect:** A link whose trimmed, lowercased text content is one of: `click here`, `here`, `read more`, `more`, `learn more`, `link`, `download`, `this`.

**Fix:** Flag for manual attention, rewrite the link text or add a descriptive `aria-label`.

### LNK-3: New-tab link without user warning (🟡 Minor)

Links that open in a new tab should inform the user.

**Detect:** A link with `target="_blank"` and no `aria-label` containing "new tab" or "new window", and no visually hidden notice inside the element.

**Fix:** Flag for manual attention, add `(opens in a new tab)` to the `aria-label` or as a visually hidden text node.

### BTN-1: Button with no accessible name (🔴 Critical)

Every `<button>` must have a non-empty accessible name: visible text, `aria-label`, or `aria-labelledby`.

**Detect:** `<button>` with no text content, no `aria-label` / `aria-labelledby`, and whose only children are SVGs with `aria-hidden="true"` or images with `alt=""`.

**Fix:** Flag for manual attention, add a descriptive `aria-label`.

---

## Category 3: Forms

### FORM-1: Input without associated label (🔴 Critical)

Every `<input>` (except `type="hidden"`, `type="submit"`, `type="reset"`, `type="button"`), `<textarea>`, and `<select>` must have an associated label via: a `<label for="id">` pair, a wrapping `<label>`, `aria-label`, or `aria-labelledby`.

**Detect:** A form control that has none of the above associations.

**Fix:** Flag for manual attention, add a `<label>` and a matching `id`.

### FORM-2: `<label for>` points to non-existent element (🟠 Major)

**Detect:** `<label for="X">` where no element in the same file has `id="X"`.

**Fix:** Flag for manual attention, add or correct the `id` on the target control.

### FORM-3: Missing `autocomplete` on personal data fields (🟡 Minor)

**Detect:** `<input type="text|email|tel|url|password">` without an `autocomplete` attribute.

**Fix:** Flag for manual attention, suggest an appropriate value (`email`, `tel`, `name`, `current-password`, `new-password`, `username`, etc.).

---

## Category 4: ARIA & Roles

### ARIA-1: Invalid ARIA role (🟠 Major)

**Detect:** A `role` attribute whose static string value is not a valid ARIA role.

Valid roles: `alert`, `alertdialog`, `application`, `article`, `banner`, `button`, `cell`, `checkbox`, `columnheader`, `combobox`, `complementary`, `contentinfo`, `definition`, `dialog`, `document`, `feed`, `figure`, `form`, `grid`, `gridcell`, `group`, `heading`, `img`, `link`, `list`, `listbox`, `listitem`, `log`, `main`, `marquee`, `math`, `menu`, `menubar`, `menuitem`, `menuitemcheckbox`, `menuitemradio`, `navigation`, `none`, `note`, `option`, `presentation`, `progressbar`, `radio`, `radiogroup`, `region`, `row`, `rowgroup`, `rowheader`, `scrollbar`, `search`, `searchbox`, `separator`, `slider`, `spinbutton`, `status`, `switch`, `tab`, `table`, `tablist`, `tabpanel`, `term`, `textbox`, `timer`, `toolbar`, `tooltip`, `tree`, `treegrid`, `treeitem`.

**Fix:** Flag for manual attention, suggest the correct role (e.g. `role="modal"` → `role="dialog"`).

### ARIA-2: Focusable element with `aria-hidden="true"` (🔴 Critical)

Interactive elements (`<a>`, `<button>`, `<input>`, `<textarea>`, `<select>`) must not have `aria-hidden="true"`. This hides them from assistive technology while keeping them keyboard-reachable.

**Detect:** A focusable element with `aria-hidden="true"`.

**Fix:** Remove `aria-hidden="true"`, auto-fixable.

### ARIA-3: Decorative SVG not hidden from assistive technology (🟠 Major)

**Detect:** `<svg>` with no `aria-label`, `aria-labelledby`, or `<title>` as its first child, and no `aria-hidden="true"` or `role="img"`.

**Fix:**
- Clearly decorative (inside a button or link that has a text label) → add `aria-hidden="true"` (auto-fixable).
- Otherwise → flag for manual attention: add `role="img"` and `aria-label`.

---

## Category 5: Keyboard & Focus

### KEY-1: Positive `tabindex` value (🟠 Major)

`tabindex` values greater than 0 override the natural DOM tab order and are hard to maintain.

**Detect:** Any element with a `tabindex` value that is a positive integer.

**Fix:** Replace with `tabindex="0"`, auto-fixable. Note in the report that the tab order should be reviewed.

### KEY-2: Non-interactive element with click handler but no keyboard support (🟠 Major)

A `<div>` or `<span>` with a click handler must also be keyboard accessible.

**Detect:** `<div>` or `<span>` with a click event handler and no `role`, `tabindex`, or keyboard event handler (`keydown`/`keyup`).

**Fix:** Add `role="button"` and `tabindex="0"`, auto-fixable. Flag for manual attention to also add a keyboard handler for Enter/Space.

---

## Category 6: Semantic HTML

### SEM-1: Missing `lang` on `<html>` (🔴 Critical)

**Detect:** An `<html>` element without a `lang` attribute (static or dynamic). Only applies to files that contain an `<html>` element.

**Fix:** Add `lang="en"`, auto-fixable. Note that the correct language code should be verified.

### SEM-2: Heading hierarchy skipped (🟠 Major)

**Detect:** A heading `<hN>` that follows a heading `<hM>` anywhere in the document where N > M + 1.

**Fix:** Flag for manual attention, the heading level may need to be changed.

### SEM-3: Missing `<main>` landmark (🟠 Major)

**Detect:** A file containing a full page layout (has `<html>` or `<body>`) but no `<main>` element.

**Fix:** Flag for manual attention, structural changes are required.

### SEM-4: `<iframe>` without `title` (🟠 Major)

**Detect:** `<iframe>` without a `title` attribute (static or dynamic).

**Fix:** Flag for manual attention, the title must describe the embedded content.

### SEM-5: Layout `<table>` without `role="presentation"` (🟡 Minor)

A `<table>` without `<th>` elements is likely a layout table and should declare `role="presentation"`.

**Detect:** `<table>` with no `<th>` children and no existing `role` attribute.

**Fix:** Add `role="presentation"`, auto-fixable.

---

## Category 7: Color & Contrast

### COL-1: Color as sole visual indicator (🟡 Minor)

Informative states (errors, warnings, required fields) that use color alone must also have a non-color indicator (icon, pattern, or text).

**Detect (best-effort):** A form control or status element whose `class` contains `error`, `invalid`, `danger`, or `warning`, with no sibling icon or text indicator.

**Fix:** Flag for manual attention, add an icon, symbol, or visible text alongside the color indicator.

### COL-2: Inline color styles (🟡 Minor)

Inline `style` attributes with `color` or `background-color` values cannot be automatically verified for contrast compliance.

**Detect:** Any element with a `style` attribute containing `color:` or `background-color:`.

**Fix:** Flag for manual attention, verify the contrast ratio meets WCAG AA (4.5:1 for normal text, 3:1 for large text and UI components).

---

## Fix mode: Auto-fixable summary

| Rule | Auto-fix applied |
|---|---|
| IMG-1 | `alt=""` on clearly decorative images |
| IMG-2 | `alt=""` on decorative icon images inside labelled buttons/links |
| ARIA-2 | Remove `aria-hidden="true"` from focusable elements |
| ARIA-3 | Add `aria-hidden="true"` to clearly decorative SVGs |
| KEY-1 | Replace positive `tabindex` with `tabindex="0"` |
| KEY-2 | Add `role="button"` and `tabindex="0"` to click-only `<div>`/`<span>` |
| SEM-1 | Add `lang="en"` to `<html>` |
| SEM-5 | Add `role="presentation"` to layout tables |

All other rules require manual attention and appear in the ⚠️ section of the Fix Report.
