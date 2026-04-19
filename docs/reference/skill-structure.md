# Skill structure

Every skill in this collection follows the same directory layout and file conventions. This page documents the anatomy of a skill, the role of each file, and the design decisions behind the structure.

---

## Directory layout

```text
skill-name/
|- SKILL.md                   # Entry point, loaded by Claude Code on /command
|- skill-name-rules.md        # Shared rules (all languages), optional
|- skill-name-js.md           # JS / TS / JSX / TSX rules
|- skill-name-css.md          # CSS / Sass / SCSS rules
|- skill-name-html.md         # HTML rules
|- skill-name-vue.md          # Vue rules
|- skill-name-svelte.md       # Svelte rules
|- skill-name-astro.md        # Astro rules
|- examples/                  # Example source files and skill outputs
`- README.md                  # Skill documentation
```

Not every skill has all files. For example, `front-a11y` has no CSS sub-file because accessibility rules do not apply to stylesheets in isolation. The `front-comments` skill has no shared rules file because all rules are language-specific.
Version history for the collection is tracked in the repository root `CHANGELOG.md`.

---

## SKILL.md

The entry point. Loaded by Claude Code when the user runs the `/command`.

### Frontmatter

```yaml
---
name: front-review
description: Review a JS, TS, React (JSX/TSX), CSS, Sass, HTML, Vue, Svelte, or Astro file for code quality, potential bugs, performance, and maintainability. Usage: /front-review [strict]
argument-hint: [strict]
allowed-tools: Read Glob
---
```

| Field | Purpose |
|---|---|
| `name` | The skill name, used as the slash command (e.g. `/front-review`). Must match the directory name. |
| `description` | Shown in Claude Code's command picker. Should be a single sentence ending with the usage syntax. |
| `argument-hint` | The hint displayed in the picker. Lists optional arguments in brackets. |
| `allowed-tools` | Restricts the Claude Code tools available during execution. |

### Instruction body

The body defines the full execution logic in Markdown. It typically covers:

1. Parsing `$ARGUMENTS` to determine operating mode and options
2. Detecting the file extension to select the appropriate sub-file
3. Loading the shared rules file (if one exists)
4. Loading the language-specific sub-file
5. Applying both sets of rules to the target file
6. Producing structured output

---

## Sub-files

Sub-files contain the actual rules : they are never loaded directly by Claude Code, only by `SKILL.md` at runtime.

### Shared rules file

Present in skills that have rules common to all languages (front-review, front-a11y, front-refactor). Contains:

- Universal rule definitions
- Severity level descriptions
- Strict mode threshold overrides (front-review)
- Behavior constraints (front-refactor)

### Language-specific files

One file per supported language. Contains:

- Syntax notes specific to that language
- Detection patterns (how to find issues in that language's syntax)
- Framework-specific additional rules
- Overrides to shared rules that behave differently in this language

---

## Why sub-files?

Claude Code loads all files referenced in a skill run into its context window. Loading a single monolithic rules file for every language on every run would be wasteful and slow.

By splitting rules into language-specific sub-files and loading only the relevant one at runtime, each skill run is focused: only the rules that apply to the target file are loaded. A Vue review loads `front-review-rules.md` + `front-review-vue.md`. A CSS review loads `front-review-rules.md` + `front-review-css.md`. Nothing else.

---

## Examples directory

Each skill includes an `examples/` directory with:

- Source files (the input)
- Skill output files (the result of running the skill on the source)

Examples serve as documentation (showing what the skill produces) and as regression tests (verifying that the skill output matches expectations after a rule change).

In this repository, `scripts/validate-repo.ps1` also checks that the example files documented in each skill README actually exist.

---

## Naming conventions

| Pattern | Rule |
|---|---|
| Skill directory | `front-<name>` (kebab-case) |
| Entry point | Always `SKILL.md` |
| Sub-files | `<skill-name>-<language>.md` |
| Shared rules file | `<skill-name>-rules.md` |
| Examples | `<source-file>.<skill>.md` for report outputs, `<source-file>.applied.<ext>` for rewritten files |

---

## allowed-tools reference

| Tool | Purpose |
|---|---|
| `Read` | Read the target file and sub-files |
| `Glob` | Find files by pattern (used to locate sub-files) |
| `Edit` | Apply changes to the target file (partial edits) |
| `Write` | Rewrite the target file entirely |

Skills that only produce reports (`front-review`) do not request `Edit` or `Write`. Skills that modify files request only what they need.
