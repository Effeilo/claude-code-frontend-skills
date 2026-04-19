<div>
  <img src="../../assets/logos/logo-frontend-skills-a11y-300.png" alt="Claude Code Front-end Skills a11y logo"  width="200" height="200"/>
</div>

# Claude Code Skill Front A11y

**Audit and fix accessibility issues against [WCAG 2.1 AA](https://www.w3.org/TR/WCAG21/), directly from [Claude Code](https://claude.ai/code).**

**Front-a11y** is a **Claude Code skill** that analyses frontend files for accessibility violations across images, forms, interactive elements, ARIA usage, keyboard navigation, and semantic structure. Using a single slash command, audit mode produces a structured report grouped by severity, fix mode applies all automatically-fixable issues directly to the file and lists what requires manual attention. Compatible with HTML, React, Vue, Svelte, and Astro, it covers the most widely used frontend templating languages.

> Part of the [claude-code-frontend-skills](https://github.com/Effeilo/claude-code-frontend-skills) collection.

Supports **Audit mode** (structured report of all accessibility issues found) and **Fix mode** (auto-fix all fixable issues and report what requires manual attention).

## 🎬 Quick Demo

https://github.com/user-attachments/assets/7e5c2b2c-b66d-48f1-90bd-6306ac8cb931

---

## 🌐 Supported languages

| Extension | Language |
|---|---|
| `.html` | HTML |
| `.jsx` `.tsx` | React |
| `.vue` | Vue SFC |
| `.svelte` | Svelte |
| `.astro` | Astro |

---

## 📦 Installation

Clone the repository:

```bash
git clone https://github.com/Effeilo/claude-code-frontend-skills.git
cd claude-code-frontend-skills
```

### Option A: install script (recommended)

```bash
./install.sh front-a11y              # macOS / Linux / WSL
.\install.ps1 front-a11y             # Windows PowerShell
```

Add `--force` / `-Force` to overwrite an existing install.

### Option B: manual install

```bash
mkdir -p ~/.claude/skills/front-a11y
cp front-a11y/SKILL.md \
   front-a11y/front-a11y-*.md \
   ~/.claude/skills/front-a11y/
```

---

## 🚀 Usage

Open a file in your editor, then run:

```
/front-a11y
```

### Arguments

| Argument | Effect |
|---|---|
| *(none)* | Audit mode : structured report of all issues found |
| `fix` | Fix mode : apply all auto-fixable issues + report what needs manual attention |

```
/front-a11y
/front-a11y fix
```

---

## Audit mode

Produces a structured accessibility report without modifying the file.

Issues are grouped by severity:

| Severity | Meaning |
|---|---|
| 🔴 Critical | Blocks assistive technology users entirely |
| 🟠 Major | Significantly degrades the accessible experience |
| 🟡 Minor | Reduces quality or consistency but has a workaround |

Each issue includes: the element, a description of the problem, and a recommended fix.

**Example output:**

```
## Accessibility Audit : contact.html

### 🔴 Critical

**[line 14] Missing alt attribute on <img>**
Element: `<img src="team-photo.jpg">`
Problem: The `alt` attribute is missing.
Fix: Add `alt="[description]"` for meaningful images, or `alt=""` for decorative ones.

---

### 🟠 Major

**[line 32] Button has no accessible name**
Element: `<button onclick="openMenu()"><svg>...</svg></button>`
Problem: The button contains only an SVG with no aria-label.
Fix: Add `aria-label="Open menu"` to the button, and `aria-hidden="true"` to the SVG.

---

### Summary
| Severity | Count |
|---|---|
| 🔴 Critical | 1 |
| 🟠 Major | 1 |
| 🟡 Minor | 0 |
| **Total** | **2** |
```

---

## 🔧 Fix mode

Applies all automatically-fixable issues directly to the file, then outputs a Fix Report.

### What gets auto-fixed

| Issue | Fix applied |
|---|---|
| Decorative `<img>` without `alt` | Adds `alt=""` |
| Decorative icon images in buttons or links | Adds `alt=""` |
| Focusable element with `aria-hidden="true"` | Removes `aria-hidden` |
| Decorative SVG not hidden | Adds `aria-hidden="true"` |
| `tabindex` > 0 | Replaced with `tabindex="0"` |
| `<div onclick>` without keyboard role | Adds `role="button"` and `tabindex="0"` |
| `<html>` without `lang` | Adds `lang="en"` |
| Layout `<table>` without `role` | Adds `role="presentation"` |

### What requires manual attention

- Meaningful `alt` text (requires understanding the image content)
- Accessible names for empty links and icon-only buttons
- Label associations for unlabelled form inputs
- Heading hierarchy corrections
- Color contrast compliance
- `onkeydown` handlers for click-only interactive elements
- Complex ARIA widget patterns

**Example Fix Report:**

```
## Fix Report : contact.html

### ✅ Fixed
- [line 8] Added lang="en" to <html>
- [line 41] Added aria-hidden="true" to decorative <svg> inside labelled button
- [line 67] Replaced tabindex="2" with tabindex="0"

### ⚠️ Requires manual attention
- [line 14] <img src="team-photo.jpg"> : add a meaningful alt description
- [line 32] <button> icon-only : add aria-label="[action]"
- [line 55] <input type="email" id="email"> : no associated <label> found
```

---

## 📋 Checks covered

| Category | Rules |
|---|---|
| **Images** | Missing `alt`, decorative images without `alt=""` |
| **Links & Buttons** | Empty accessible names, generic link text ("Read more"), new-tab warnings |
| **Forms** | Missing labels, broken `for`/`id` pairs, `autocomplete` hints |
| **ARIA & Roles** | Invalid roles, `aria-hidden` on focusable elements, unlabelled SVGs |
| **Keyboard & Focus** | Positive `tabindex`, click-only interactive elements without keyboard handlers |
| **Semantic HTML** | `lang` attribute, heading hierarchy, missing landmarks, `<iframe>` titles |
| **Color & Contrast** | Color-only indicators, inline color style warnings |

Plus framework-specific checks:

| Framework | Additional checks |
|---|---|
| **React** | Next.js `<Image>` missing `alt`, `.map()` lists without key, `onClick` without keyboard parity |
| **Vue** | `v-for` without `:key`, `v-show` hiding focusable content |
| **Svelte** | `{#each}` lists without key, event dispatcher accessibility |
| **Astro** | `<Image>` component missing `alt`, `<slot>` placement in landmark elements |

### Framework-specific checks

**React (JSX / TSX)**
- Next.js `<Image>` without `alt`
- `.map()` lists without semantic wrapper
- `onClick` without `onKeyDown` equivalent

**Vue SFC**
- `<RouterLink>` and `<NuxtLink>` treated as `<a>`
- `v-for` lists without semantic wrapper
- `v-show` on interactive elements

**Svelte**
- `{#each}` lists without semantic wrapper
- `createEventDispatcher` without keyboard parity

**Astro**
- `<Image>` from `astro:assets` treated as `<img>`
- `<slot>` inside landmarks without accessible context

---

## 🧪 Examples

Source file `contact.html`:

```html
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact us</title>
</head>
<body>

    <header>
        <img src="/assets/logo.png">
        <nav>
            <a href="/">Home</a>
            <a href="/about">About</a>
        </nav>
        <button onclick="toggleSearch()">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M21 21l-4.35-4.35M17 11A6 6 0 1 1 5 11a6 6 0 0 1 12 0z"/>
            </svg>
        </button>
    </header>

    <main>
        <section class="hero">
            <img src="/assets/contact-hero.jpg">
            <h1>Get in touch</h1>
            <p>We'd love to hear from you.
                <a href="/faq" target="_blank">Read more</a> about our response times.
            </p>
        </section>

        <section class="contact-form">
            <h2>Send us a message</h2>
            <form action="/submit" method="post">
                <div class="field">
                    <input type="text" id="name" placeholder="Your name">
                </div>
                <div class="field">
                    <input type="email" id="email" placeholder="Your email">
                </div>
                <div class="actions">
                    <div onclick="clearForm()" class="btn-secondary" tabindex="2">Clear</div>
                    <button type="submit" tabindex="3">Send message</button>
                </div>
            </form>
        </section>

        <section class="map">
            <h2>Find us</h2>
            <iframe src="https://www.openstreetmap.org/export/embed.html?bbox=2.3,48.8,2.4,48.9"
                width="100%" height="400">
            </iframe>
        </section>
    </main>

    <footer>
        <div onclick="scrollToTop()" class="scroll-top">
            <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24">
                <path d="M12 19V5M5 12l7-7 7 7"/>
            </svg>
        </div>
    </footer>

</body>
</html>
```

After `/front-a11y`:

```
## Accessibility Audit : contact.html

### 🔴 Critical

**[line 2] Missing `lang` attribute on `<html>`**
Element: `<html>`
Problem: Screen readers cannot determine the document language, which affects
pronunciation and voice selection.
Fix: Add `lang="en"` (or the appropriate language code).

**[line 18] Button has no accessible name**
Element: `<button onclick="toggleSearch()"><svg>...</svg></button>`
Problem: The button contains only an SVG with no aria-label or visible text.
Assistive technologies cannot announce its purpose.
Fix: Add `aria-label="Open search"` to the button and `aria-hidden="true"` to the SVG.

**[line 35] Input has no associated label**
Element: `<input type="text" id="name" placeholder="Your name">`
Problem: No <label> is associated with this field. Placeholders disappear on input
and are not a substitute for labels.
Fix: Add <label for="name">Your name</label> before the input.

### 🟠 Major

**[line 43] Positive `tabindex` value**
Element: `<div ... tabindex="2">Clear</div>`
Problem: tabindex="2" overrides the natural tab order, which is confusing for keyboard users.
Fix: Replace with tabindex="0".

**[line 43] Non-interactive element with click handler but no keyboard support**
Element: `<div onclick="clearForm()" tabindex="2">Clear</div>`
Problem: This div acts as a button but is not announced as one.
Fix: Add role="button" and an onkeydown handler for Enter/Space.

**[line 50] <iframe> has no title attribute**
Element: `<iframe src="https://www.openstreetmap.org/...">`
Problem: Screen readers cannot identify the purpose of the embedded content.
Fix: Add title="Map showing our office location".

### 🟡 Minor

**[line 29] Generic link text**
Element: `<a href="/faq" target="_blank">Read more</a>`
Problem: "Read more" is ambiguous without context and opens in a new tab without warning.
Fix: Add aria-label="Learn more about our response times (opens in a new tab)".

---

### Summary
| Severity | Count |
|---|---|
| 🔴 Critical | 5 |
| 🟠 Major | 6 |
| 🟡 Minor | 6 |
| **Total** | **17** |
```

After `/front-a11y fix`, the file is rewritten and a Fix Report is output:

```
## Fix Report : contact.html

### ✅ Fixed
- [line 2] Added lang="en" to <html>
- [line 19] Added aria-hidden="true" to the decorative SVG inside the search button
- [line 43] Replaced tabindex="2" with tabindex="0" on .btn-secondary div
- [line 43] Added role="button" to <div onclick="clearForm()">
- [line 44] Removed tabindex="3" from <button> (natively focusable)
- [line 57] Added role="button", tabindex="0", and aria-label="Scroll to top" to .scroll-top div
- [line 58] Added aria-hidden="true" to the decorative SVG inside .scroll-top

### ⚠️ Requires manual attention
- [line 18] <button onclick="toggleSearch()"> : add aria-label="Open search"
- [line 25] <img src="/assets/contact-hero.jpg"> : add a meaningful alt description
- [line 29] <a href="/faq" target="_blank">Read more</a> : generic link text + new tab, rewrite or add aria-label
- [line 35] <input type="text" id="name"> : add <label for="name">Your name</label>
- [line 39] <input type="email" id="email"> : add <label for="email">Your email</label>
- [line 43] <div onclick="clearForm()"> : add onkeydown handler for Enter/Space
- [line 50] <iframe> : add title="Map showing our office location"
```

Current examples included in this repository:

| Source | Audit | Fix report |
|---|---|---|
| `contact.html` | `contact-audit.md` | `contact-fix-report.md` |
| `PostCard.vue` | `PostCard-audit.md` | — |
| `PostCard.jsx` | `PostCard-jsx-audit.md` | — |

---

## 📁 File structure

```text
front-a11y/
|- SKILL.md                  # Skill entry point (orchestration)
|- front-a11y-rules.md       # Shared accessibility rules (all languages)
|- front-a11y-html.md        # HTML-specific notes and rules
|- front-a11y-jsx.md         # React (JSX / TSX) notes and rules
|- front-a11y-vue.md         # Vue notes and rules
|- front-a11y-svelte.md      # Svelte notes and rules
|- front-a11y-astro.md       # Astro notes and rules
|- examples/                 # Example source files, audits, and fix reports
`- README.md
```

Version history for the whole collection is tracked in the repository root `CHANGELOG.md`.

---

## ⚖️ License

[MIT](../LICENSE.md) © 2026 [Effeilo](https://github.com/Effeilo)