# front-a11y : Svelte Syntax Notes

Apply all shared rules from `front-a11y-rules.md` using Svelte template syntax.
Svelte has built-in a11y compile-time warnings, this skill goes further by checking WCAG 2.1 AA compliance.

---

## Syntax reference

| Concept | Syntax |
|---|---|
| Static attribute | `alt="text"` |
| Dynamic binding | `alt={variable}` or shorthand `{alt}` |
| Click handler | `on:click={handler}` |
| Keyboard handler | `on:keydown={handler}` / `on:keyup={handler}` |

**Dynamic bindings are considered valid : do not flag them as missing.**

---

## Elements to treat as native equivalents

| Svelte pattern | Treat as |
|---|---|
| `<svelte:element this="a">` | `<a>` |
| `<svelte:element this="button">` | `<button>` |

---

## Detection nuances

**IMG-1 / IMG-2:** Both `alt="text"` and `alt={variable}` and `{alt}` shorthand are valid. Only flag `<img>` with no `alt` attribute in any form.

**LNK-1 / BTN-1:** Accept both `aria-label="..."` and `aria-label={variable}` as valid accessible names.

**ARIA-2:** Also detect `aria-hidden={true}` (expression form) in addition to `aria-hidden="true"`.

**KEY-2:** Detect `<div on:click>` or `<span on:click>` without `role`, `tabindex`, `on:keydown`, or `on:keyup`.

**SEM-1:** Only applies if the file contains an `<html>` element. Skip for regular components.

---

## Svelte-specific examples

**IMG-1:**
```svelte
<!-- ❌ --> <img src={hero.src}>
<!-- ✅ --> <img src={hero.src} alt={hero.alt}>
```

**KEY-2:**
```svelte
<!-- ❌ --> <div on:click={submit}>Send</div>
<!-- ✅ partial --> <div on:click={submit} role="button" tabindex="0">Send</div>
```

---

## Svelte-specific additional rules

### SVE-1 : `{#each}` list without semantic list element (🟡 Minor)

**Detect:** `{#each}` block rendering items inside a `<div>` or `<span>` container with no `role="list"` on the wrapper and no `role="listitem"` on each item. (Native `<ul>`/`<li>` do not need this.)

**Fix:** Flag for manual attention : prefer `<ul>`/`<li>`, or add `role="list"` / `role="listitem"`.

### SVE-2 : `createEventDispatcher` dispatching `click` without keyboard parity (🟡 Minor)

A component that dispatches a custom `click` event from a `<div>` or `<span>` in its template should also dispatch the event on Enter/Space keypress.

**Detect:** A `dispatch('click', ...)` call (via `createEventDispatcher`) where the triggering element in the template is a `<div>` or `<span>` with no `on:keydown` or `on:keyup`.

**Fix:** Flag for manual attention : add an `on:keydown` handler that dispatches the same event on Enter/Space.
