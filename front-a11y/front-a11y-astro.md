# front-a11y : Astro Syntax Notes

Apply all shared rules from `front-a11y-rules.md` using Astro template syntax.
Astro files mix a frontmatter block (`---`) with an HTML-like template. Apply accessibility checks to the template part only.

---

## Syntax reference

| Concept | Syntax |
|---|---|
| Static attribute | `alt="text"` |
| Dynamic binding | `alt={variable}` |
| Click handler | `onclick="..."` (inline) or `onclick={handler}` |
| Keyboard handler | `onkeydown="..."` / `onkeydown={handler}` |

**Dynamic bindings are considered valid : do not flag them as missing.**

---

## Elements to treat as native equivalents

Astro component imports (e.g. `<Button>`, `<Link>`) are treated as opaque : do not flag missing attributes on them unless a native element is directly visible in this file.

The `<Image>` component from `astro:assets` or `@astrojs/image` is an exception, see rule AST-1 below.

---

## Detection nuances

**IMG-1 / IMG-2:** Both `alt="text"` and `alt={variable}` are valid. Only flag `<img>` with no `alt` in any form.

**LNK-1 / BTN-1:** Accept both `aria-label="..."` and `aria-label={variable}` as valid accessible names.

**ARIA-2:** Also detect `aria-hidden={true}` in addition to `aria-hidden="true"`.

**KEY-2:** Detect `<div onclick>` or `<span onclick>` (both inline and expression forms) without `role`, `tabindex`, `onkeydown`, or `onkeyup`.

**SEM-1:** Astro layout files typically define `<html>`. Always check for `lang` when `<html>` is present.

**SEM-3:** If the file uses `<slot>` inside a `<main>`, this counts as having a `<main>` landmark : do not flag.

---

## Astro-specific examples

**IMG-1:**
```astro
<!-- ❌ --> <img src={hero.src}>
<!-- ✅ --> <img src={hero.src} alt={hero.alt}>
```

**SEM-1:**
```astro
<!-- ❌ --> <html>
<!-- ✅ --> <html lang="en">
<!-- ✅ --> <html lang={lang}>
```

---

## Astro-specific additional rules

### AST-1 : `<Image>` component without `alt` prop (🔴 Critical)

The `<Image>` component from `astro:assets` or `@astrojs/image` requires an `alt` prop, exactly like a native `<img>`.

**Detect:** `<Image src={...}>` with no `alt` or `alt={...}` prop.

**Fix:** Flag for manual attention : `alt` text must describe the image content. If decorative, use `alt=""`.

```astro
<!-- ❌ --> <Image src={heroImage} />
<!-- ✅ --> <Image src={heroImage} alt="Hero banner showing the product dashboard" />
<!-- ✅ --> <Image src={icon} alt="" />
```

### AST-2 : `<slot>` inside a landmark without accessible context (🟡 Minor)

A `<slot>` directly inside `<header>`, `<nav>`, `<main>`, or `<footer>` with no surrounding description can make it hard for assistive technologies to announce the landmark's purpose when the slot is empty.

**Detect:** `<slot>` as a direct child of a landmark element with no `aria-label` or `aria-labelledby` on the landmark, and no visible heading or static text sibling.

**Fix:** Flag for manual attention : consider adding an `aria-label` to the landmark or a heading inside it.
