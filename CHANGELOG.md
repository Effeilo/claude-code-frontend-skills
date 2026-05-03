<div>
  <img src="./assets/logos/logo-frontend-skills-300.png" alt="Claude Code Front-end Skills logo" width="200" height="200"/>
</div>

# 📦 Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)  
and this project adheres to [Semantic Versioning (SemVer)](https://semver.org/).

---

<br>

## [1.0.0] – 2026-04-19

### ✨ Added

- Repository validation script (`scripts/validate-repo.ps1`) to verify skill structure, documented examples, install scripts, and local logo assets.
- GitHub Actions workflow (`.github/workflows/validate.yml`) to run the repository validation automatically on push and pull requests.

#### front-comments

Adds structured comments to frontend files at Level 1 (structure only) or Full (Level 1 + inline comments on every block).

- **JavaScript / TypeScript** (`.js`, `.ts`, `.mjs`, `.jsx`, `.tsx`)  
  File header, import JSDoc, section dividers, JSDoc before constants and class, JSDoc before each method, JSDoc for class properties.

- **CSS / Sass / SCSS** (`.css`, `.sass`, `.scss`)  
  Four-level hierarchy: file header, major section dividers, sub-section dividers, tertiary labels, and inline property group labels. Full level adds inline variable descriptions, numbered reference blocks, and explanatory blocks before every rule.

- **HTML** (`.html`)  
  Five-level hierarchy: file header, major section dividers (`<head>` / `<body>`), sub-section dividers, tertiary labels, and closing tag labels. Full level adds non-obvious attribute explanations, complex pattern blocks, web component documentation, and JS-powered hook annotations.

- **Vue SFC** (`.vue`)  
  Three-block architecture (template / script / style), each using its own native comment syntax. Level 1 adds `## emoji` headings only. Full adds import JSDoc, expanded descriptions, and inline comments inside callbacks.

- **Svelte** (`.svelte`)  
  Covers `export let` props, `$:` reactive declarations, `on:event` directives, `{#if}` / `{#each}` blocks. Props and reactive declarations are each grouped under a single heading.

- **Astro** (`.astro`)  
  Covers frontmatter as a build-time script block, `class:list` directive, JSX-style conditionals and `.map()` iterations, named `<slot>`, and dynamic attribute bindings.

##### Comment levels

- **Level 1**, Structure & JSDoc: file headers, section dividers, and JSDoc headings on every significant block. No inline descriptions.

- **Full**, Level 1 + inline comments on every block: expanded descriptions, directive explanations in templates, JSDoc on imports, inline `/** */` inside every function and hook body, numbered reference blocks for CSS.

##### Options

- **`full` argument**: switches from Level 1 to Full commenting.  
  Usage: `/front-comments full`

- **`lang:` argument**: sets the comment language. Supported: `lang:fr`, `lang:es`, `lang:de`. Defaults to English.  
  Usage: `/front-comments lang:fr` or `/front-comments full lang:fr`

##### Existing comment handling

Files that already have comments are handled gracefully: existing comments are scanned before processing, semantically valuable ones (business rules, browser workarounds, architectural decisions) are preserved and folded into the appropriate new structured blocks. Trivial comments are discarded. The output is always a clean, consistent structure with no useful information lost.

<br>

---

#### front-a11y

Audits or fixes accessibility issues (WCAG 2.1 AA) in frontend files.

- **HTML** (`.html`)  
  Full audit across all 7 categories. Auto-fixes: `lang` on `<html>`, decorative `alt=""`, `aria-hidden` on focusable elements and decorative SVGs, positive `tabindex`, `role="button"` + `tabindex` on click-only `<div>`/`<span>`, `role="presentation"` on layout tables.

- **React** (`.jsx`, `.tsx`)  
  JSX-specific syntax mapping (`className`, `htmlFor`, `tabIndex`, `onClick`…). Additional checks: Next.js `<Image>` without `alt`, `.map()` lists without semantic wrapper, `onClick` without `onKeyDown` equivalent.

- **Vue SFC** (`.vue`)  
  Dynamic binding detection (`:alt`, `:aria-label`). `<RouterLink>` and `<NuxtLink>` treated as `<a>`. Additional checks: `v-for` lists without semantic wrapper, `v-show` on interactive elements.

- **Svelte** (`.svelte`)  
  Dynamic binding detection (`alt={var}`, `{alt}` shorthand). Additional checks: `{#each}` lists without semantic wrapper, `createEventDispatcher` without keyboard parity.

- **Astro** (`.astro`)  
  Dynamic binding detection. `<Image>` from `astro:assets` treated as `<img>`. Additional checks: `<slot>` inside landmarks without accessible context.

##### Audit mode (`/front-a11y`)

- Structured report grouped by severity: 🔴 Critical, 🟠 Major, 🟡 Minor
- 7 categories: Images, Links & Buttons, Forms, ARIA & Roles, Keyboard & Focus, Semantic HTML, Color & Contrast
- Each issue includes: element, problem description, and recommended fix
- Summary table with issue counts per severity

##### Fix mode (`/front-a11y fix`)

- Applies all auto-fixable issues directly to the file
- Fix Report listing what was corrected and what requires manual attention

<br>

---

#### front-review

Reviews frontend files for code quality, potential bugs, performance, and maintainability.

- **JavaScript / TypeScript / React** (`.js`, `.ts`, `.mjs`, `.jsx`, `.tsx`)  
  Type safety (any, unsafe casts, missing return types), async & error handling (missing try/catch, floating promises, missing cleanup), correctness (loose equality, prop mutation, missing array bounds), performance (values recreated on render, large sync loops, deep clones), security (innerHTML injection, eval), React-specific (conditional hooks, missing useEffect deps, index keys, oversized components).

- **CSS / Sass / SCSS** (`.css`, `.sass`, `.scss`)  
  Specificity & cascade (over-specific selectors, !important misuse, duplicate rules), values & units (magic values, unitless zero, missing vendor prefix fallbacks), performance (universal selectors in compounds, layout-triggering transitions, CSS @import), maintainability (missing focus style, hardcoded colors, incompatible properties). Sass-specific: nesting depth, @extend misuse, deprecated @import, hardcoded values.

- **HTML** (`.html`)  
  Document structure (missing boilerplate, inline styles, deprecated elements), semantics (div/span instead of semantic elements, broken heading hierarchy, interactive content nesting), performance (render-blocking scripts, images without dimensions, missing resource hints), security (target="_blank" without rel, CSRF hints).

- **Vue SFC** (`.vue`)  
  Template directives (v-if + v-for on same element, missing/index-based :key, $parent access, prop mutation), component design (oversized components, missing emits declaration, untyped props), reactivity (non-reactive data patterns, async without error handling).

- **Svelte** (`.svelte`)  
  Reactivity (mutation without reassignment, $: missing dependency, unsubscribed store), template ({#each} without key, {@html} with non-static value, event handler mutating a prop), component design (oversized components, async without error handling).

- **Astro** (`.astro`)  
  Frontmatter (data fetch without error handling, sensitive data exposed to client, missing Props interface), template (set:html with non-static value, missing client: directive, unnecessary client:load), performance (raw img vs Image component, uncached data transforms).

##### Review modes

- **Standard mode** (`/front-review`) : balanced review flagging clear issues and actionable suggestions.
- **Strict mode** (`/front-review strict`) : tightened thresholds on quality, complexity, and performance rules. Promotes several Important issues to Critical, lowers function length and nesting depth limits.

##### Severity levels

- 🔴 **Critical**: Must be fixed before shipping (correctness, security, reliability)
- 🟠 **Important**: Should be fixed soon (maintainability, performance, readability)
- 🟡 **Minor**: Low-risk, worth addressing in a follow-up
- 💡 **Suggestion**: Optional improvement, a better pattern exists

##### Context7 integration (optional)

If the context7 MCP is available in the session, the skill automatically fetches the latest official documentation for the detected framework before applying the rules. This enriches the review with deprecated patterns and better alternatives specific to the latest library version. If context7 is not installed, the skill runs normally using its built-in rules.

<br>

---

#### front-refactor

Refactors frontend files, improved naming, simplified logic, dead code removal, and modern syntax, without changing behavior.

- **JavaScript / TypeScript / React** (`.js`, `.ts`, `.mjs`, `.jsx`, `.tsx`)  
  Dead code: unused imports/bindings, unreachable statements. Naming: cryptic names, boolean prefixes, magic numbers to constants. Simplify: early returns, guard clauses, ternaries, optional chaining, nullish coalescing, `.filter().map()` to `.reduce()`. Modern: `var` to `const/let`, `.then()` to `async/await`, spread, template literals, arrow callbacks. React: state setter naming, `React.createElement` to JSX.

- **CSS / Sass / SCSS** (`.css`, `.sass`, `.scss`)  
  Dead code: duplicate selectors, overridden properties, unitless zeros, dead vendor prefixes. Naming: repeated colors to custom properties, repeated spacing to custom properties. Simplify: overly specific selectors, longhand to shorthand, `!important` removal. Sass-specific: unused variables, `@import` to `@use`, deep nesting to BEM, `@extend` to mixin.

- **Vue SFC** (`.vue`)  
  Dead code: unused component registrations, computed properties, watchers, props. Naming: event names in kebab-case, PascalCase component names. Simplify: inline logic to computed properties, multiple `:prop` bindings to `v-bind`, candidate flagging for Options to Composition API migration. Modern: `this.$emit` to `defineEmits`, `this.$refs` to `ref()`.

- **Svelte** (`.svelte`)  
  Dead code: unused props, reactive declarations, store subscriptions. Naming: boolean prop prefixes, `dispatch` convention. Simplify: inline logic to reactive declarations, repeated conditions to single block, manual store update to `store.update()`.

- **Astro** (`.astro`)  
  Dead code: unused frontmatter variables/imports/components. Naming: untyped props to `interface Props`. Simplify: inline logic to frontmatter constants, repeated conditions to single block. Modern: raw `<img>` to `<Image />`, `define:vars` for script data injection.

##### Refactoring modes

- **Preview mode** (`/front-refactor`) : outputs a structured diff of all proposed changes grouped by category (DEAD / NAMING / SIMPLIFY / MODERN). The file is not modified.
- **Apply mode** (`/front-refactor apply`) : rewrites the file with all changes applied, followed by a summary report and notes for changes that could not be applied automatically (cross-file renames, public API changes).

##### Core principle

All refactorings are behavior-preserving. Changes that affect exported symbols, public component APIs, or cross-file references are flagged in Notes rather than applied silently.

##### Context7 integration (optional)

If the context7 MCP is available in the session, the skill automatically fetches the latest official documentation for the detected framework before applying the rules. This enriches the refactoring pass with deprecated patterns and their modern idiomatic replacements specific to the latest library version. If context7 is not installed, the skill runs normally using its built-in rules.

<br>

---

<br>

## 📊 Version History

- [`1.0.0`](https://github.com/Effeilo/claude-code-frontend-skills/releases/tag/v1.0.0) – 2026-04-16