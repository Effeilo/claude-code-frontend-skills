# front-a11y : Vue SFC Syntax Notes

Apply all shared rules from `front-a11y-rules.md` using Vue template syntax.
Apply accessibility checks to the `<template>` block only.

---

## Syntax reference

| Concept | Syntax |
|---|---|
| Static attribute | `alt="text"` |
| Dynamic binding | `:alt="variable"` or `v-bind:alt="variable"` |
| Click handler | `@click="handler"` or `v-on:click="handler"` |
| Keyboard handler | `@keydown="handler"` / `@keyup="handler"` |

**Dynamic bindings are considered valid : do not flag them as missing.**

---

## Elements to treat as native equivalents

| Vue component | Treat as |
|---|---|
| `<RouterLink>` | `<a>` |
| `<NuxtLink>` | `<a>` |
| `<component :is="'a'">` | `<a>` (string literal only) |
| `<component :is="'button'">` | `<button>` (string literal only) |

---

## Detection nuances

**IMG-1 / IMG-2:** A `:alt` binding counts as a valid `alt` attribute. Only flag `<img>` with no `alt` or `:alt` at all.

**LNK-1 / BTN-1:** Accept both `aria-label="..."` and `:aria-label="..."` as valid accessible names.

**FORM-1:** If `id` is dynamically bound (`:id="expr"`), check whether a `<label :for>` uses the same expression. If both are dynamic and appear to match, do not flag.

**KEY-2:** Detect `<div @click>` or `<span @click>` without `role`, `tabindex`, `@keydown`, or `@keyup`.

**SEM-1:** Only applies if the file contains an `<html>` element (e.g. layout components). Skip this rule for regular `.vue` components.

---

## Vue-specific examples

**IMG-1:**
```vue
<!-- ❌ --> <img :src="hero.src">
<!-- ✅ --> <img :src="hero.src" :alt="hero.alt">
```

**LNK-1:**
```vue
<!-- ❌ --> <RouterLink to="/profile"><img src="avatar.png" alt=""></RouterLink>
<!-- ✅ --> <RouterLink to="/profile" aria-label="View your profile"><img src="avatar.png" alt=""></RouterLink>
```

**KEY-2:**
```vue
<!-- ❌ --> <div @click="submit">Send</div>
<!-- ✅ partial --> <div @click="submit" role="button" tabindex="0">Send</div>
```

---

## Vue-specific additional rules

### VUE-1 : `v-for` list without semantic list element (🟡 Minor)

**Detect:** `<div v-for>` or `<span v-for>` rendering a list of items, where the container has no `role="list"` and the items have no `role="listitem"`. (Native `<ul>`/`<li>` do not need this.)

**Fix:** Flag for manual attention : prefer `<ul>`/`<li>`, or add `role="list"` on the container and `role="listitem"` on each item.

### VUE-2 : `v-show` on an interactive element (🟡 Minor)

`v-show` uses `display: none`, which does remove the element from the accessibility tree in modern browsers, but unlike `v-if`, the element remains in the DOM and can cause issues with some assistive technologies.

**Detect:** `<a>`, `<button>`, or `<input>` with `v-show`.

**Fix:** Flag for manual attention : consider `v-if`, or pair `v-show` with `:aria-hidden="!condition"` to keep the accessibility tree in sync.
