# front-a11y : HTML Syntax Notes

Apply all shared rules from `front-a11y-rules.md` using standard HTML syntax.
No dynamic binding syntax, all attributes are static strings.

---

## Syntax reference

| Concept | Syntax |
|---|---|
| Static attribute | `alt="text"` |
| Link elements | `<a href>` |
| Click handler | `onclick="..."` |
| Keyboard handler | `onkeydown="..."` / `onkeyup="..."` |

---

## Detection nuances

**IMG-1:** Flag `<img>` with no `alt` attribute at all.

**LNK-1 / BTN-1:** Check the full text content of the element, including nested elements. A `<button><span>Label</span></button>` has a valid accessible name.

**KEY-2:** Detect `<div onclick>` or `<span onclick>` without `role`, `tabindex`, `onkeydown`, or `onkeyup`.

**SEM-1:** The `<html>` element is typically present in `.html` files, always check for `lang`.

---

## HTML-specific examples

**IMG-1:**
```html
<!-- ❌ --> <img src="hero.jpg">
<!-- ✅ --> <img src="hero.jpg" alt="A developer at a standing desk">
<!-- ✅ --> <img src="divider.svg" alt="">
```

**BTN-1:**
```html
<!-- ❌ --> <button onclick="close()"><svg aria-hidden="true">...</svg></button>
<!-- ✅ --> <button onclick="close()" aria-label="Close modal"><svg aria-hidden="true">...</svg></button>
```

**KEY-2:**
```html
<!-- ❌ --> <div onclick="submit()">Send</div>
<!-- ✅ partial --> <div onclick="submit()" role="button" tabindex="0">Send</div>
```

**FORM-1:**
```html
<!-- ❌ --> <input type="email" id="email" placeholder="Email">
<!-- ✅ --> <label for="email">Email</label><input type="email" id="email">
```
