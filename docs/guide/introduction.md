# Introduction

## What is Claude Code Frontend Skills?

Claude Code Frontend Skills is a collection of [Claude Code](https://claude.ai/code) skills that automate recurring frontend development tasks.

Each skill is invoked as a slash command (e.g. `/front-review`) and operates on the file currently open in your editor. Skills are self-contained, project-independent, and available across all your projects once installed.

This collection is not a linter, a formatter, or a build tool. It is a set of AI-powered workflows that understand context, apply language-specific rules, and produce structured, actionable output.

---

## Why skills?

Frontend development involves a set of repetitive, rule-driven tasks that are tedious to do manually but require enough context and judgment to be difficult to automate with traditional tools:

- Adding consistent, meaningful comments to a legacy file
- Auditing a Vue component for WCAG 2.1 AA accessibility violations
- Reviewing a CSS file for specificity issues, dead code, and performance problems
- Refactoring a JavaScript module to use modern syntax without breaking its behavior

Each of these tasks has well-defined rules, clear output expectations, and benefits from being language-aware. They are exactly what a skill is designed for.

---

## Design principles

Every skill in this collection is built around the same principles:

### Language-aware

Skills detect the file extension and load the appropriate rules for that language. A `.vue` file is reviewed with Vue-specific rules. A `.css` file uses CSS-specific checks. A `.jsx` file applies React-specific patterns. There is no one-size-fits-all approach.

### Structured output

Skills always produce consistent, readable output. Reports use severity levels (Critical, Important, Minor), categories (DEAD, NAMING, SIMPLIFY, MODERN), and explicit line references. Output is designed to be acted on, not just read.

### Behavior-preserving

Skills that modify files (front-comments, front-a11y fix mode, front-refactor apply mode) never change the behavior of your code. Comments are added, not code. Accessibility fixes are safe and deterministic. Refactoring changes are scoped to the file.

### Optimized for Claude Code

Skills are split into a main `SKILL.md` entry point and language-specific sub-files. Only the relevant sub-file is loaded for each run. This keeps each request focused and avoids loading rules that do not apply to the target file.

---

## What skills are not

- Not a linter (ESLint, Stylelint) : skills are not run automatically, have no configuration file, and do not integrate into a CI pipeline.
- Not a formatter (Prettier) : skills do not enforce formatting rules; they add comments or apply semantic changes.
- Not a code generator : skills work on existing files, they do not scaffold new ones.
- Not a replacement for a design system or component library.

Skills are run on demand, on a specific file, when you decide you need them.

---

## The collection

| Skill | Command | What it does |
|---|---|---|
| front-comments | `/front-comments` | Adds structured JSDoc and section comments to a frontend file |
| front-a11y | `/front-a11y` | Audits or fixes accessibility issues (WCAG 2.1 AA) |
| front-review | `/front-review` | Reviews a file for quality, bugs, performance, and maintainability |
| front-refactor | `/front-refactor` | Refactors a file : dead code, naming, simplification, modern syntax |
