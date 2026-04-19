# front-a11y : React JSX/TSX Syntax Notes

Apply all shared rules from `front-a11y-rules.md` using React JSX syntax.
Applies to `.jsx` and `.tsx` files.

---

## Syntax reference

JSX uses camelCase for HTML attributes and event handlers:

| HTML | JSX/TSX |
|---|---|
| `class` | `className` |
| `for` | `htmlFor` |
| `tabindex` | `tabIndex` |
| `onclick` | `onClick` |
| `onkeydown` | `onKeyDown` |
| `onkeyup` | `onKeyUp` |
| `aria-label` | `aria-label` *(unchanged)* |
| `aria-hidden` | `aria-hidden` *(unchanged)* |

Dynamic bindings use `{expression}` syntax. **Dynamic bindings are considered valid : do not flag them as missing.**

```jsx
// Static
<img src="hero.jpg" alt="Hero image" />

// Dynamic
<img src={post.src} alt={post.alt} />
```

---

## Elements to treat as native equivalents

| React/library component | Treat as |
|---|---|
| `<Link>` (React Router, Next.js) | `<a>` |
| `<NavLink>` (React Router) | `<a>` |
| `<Image>` (Next.js `next/image`) | `<img>`, see rule JSX-1 |

---

## Detection nuances

**IMG-1 / IMG-2:** Both `alt="text"` and `alt={variable}` are valid. Only flag `<img>` with no `alt` prop at all.

**LNK-1 / BTN-1:** Accept `aria-label="..."` and `aria-label={variable}` as valid accessible names.

**ARIA-2:** Also detect `aria-hidden={true}` (boolean expression) in addition to `aria-hidden="true"`.

**FORM-1:** In JSX, `<label>` uses `htmlFor` instead of `for`. Check for `<label htmlFor="X">` matching an input's `id="X"` or `id={variable}`.

**KEY-2:** Detect `<div onClick>` or `<span onClick>` without `role`, `tabIndex`, `onKeyDown`, or `onKeyUp`.

**SEM-1:** Only applies if the file renders an `<html>` element directly (e.g. Next.js `_document.tsx`, Remix root). Skip for regular components.

---

## JSX-specific examples

**IMG-1:**
```jsx
{/* ❌ */} <img src={post.thumbnail} />
{/* ✅ */} <img src={post.thumbnail} alt={post.title} />
{/* ✅ */} <img src="divider.svg" alt="" />
```

**BTN-1:**
```jsx
{/* ❌ */}
<button onClick={closeModal}>
    <svg aria-hidden="true">...</svg>
</button>

{/* ✅ */}
<button onClick={closeModal} aria-label="Close modal">
    <svg aria-hidden="true">...</svg>
</button>
```

**FORM-1:**
```jsx
{/* ❌ */}
<input type="email" id="email" placeholder="Email" />

{/* ✅ */}
<label htmlFor="email">Email</label>
<input type="email" id="email" placeholder="Email" />
```

**KEY-2:**
```jsx
{/* ❌ */}
<div onClick={submit}>Send</div>

{/* ✅ partial (keyboard handler still needed) */}
<div onClick={submit} role="button" tabIndex={0}>Send</div>
```

---

## React-specific additional rules

### JSX-1 : Next.js `<Image>` without `alt` prop (🔴 Critical)

The `<Image>` component from `next/image` requires an `alt` prop.

**Detect:** `<Image src={...}>` or `<Image src="...">` with no `alt` prop.

**Fix:** Flag for manual attention : `alt` must describe the image content. Use `alt=""` for decorative images.

```jsx
{/* ❌ */} <Image src={heroImage} width={800} height={400} />
{/* ✅ */} <Image src={heroImage} width={800} height={400} alt="Hero banner showing the product dashboard" />
```

### JSX-2 : `.map()` list without semantic list element (🟡 Minor)

Arrays rendered with `.map()` inside a `<div>` are not announced as lists by screen readers.

**Detect:** `.map(...)` returning JSX elements inside a `<div>` or `<span>` container with no `role="list"` on the wrapper and no `role="listitem"` on each item. (Native `<ul>`/`<li>` do not need this.)

**Fix:** Flag for manual attention : prefer `<ul>`/`<li>`, or add `role="list"` on the container and `role="listitem"` on each mapped item.

```jsx
{/* ❌ */}
<div>
    {items.map(item => <span key={item.id}>{item.label}</span>)}
</div>

{/* ✅ */}
<ul>
    {items.map(item => <li key={item.id}>{item.label}</li>)}
</ul>
```

### JSX-3 : `onClick` handler without `onKeyDown` equivalent on non-interactive element (🟠 Major)

Same as KEY-2 but specific to React's event naming. Flagged separately to suggest the complete React fix.

**Detect:** `<div onClick>` or `<span onClick>` without `role`, `tabIndex`, `onKeyDown`, or `onKeyUp`.

**Fix:** Add `role="button"` and `tabIndex={0}`, auto-fixable. Flag for manual attention to add:
```jsx
onKeyDown={(e) => { if (e.key === 'Enter' || e.key === ' ') handler(); }}
```
