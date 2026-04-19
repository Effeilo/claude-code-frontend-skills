# How skills work

A Claude Code skill is a directory containing a `SKILL.md` entry point and, optionally, supporting sub-files. When you run `/skill-name`, Claude Code loads `SKILL.md` and follows the instructions it contains.

---

## SKILL.md

Every skill starts with `SKILL.md`. It is the entry point Claude Code reads when the command is invoked. It contains two parts: a frontmatter header and the instruction body.

### Frontmatter

```yaml
---
name: front-review
description: Review a JS, TS, React, CSS, Sass, HTML, Vue, Svelte, or Astro file for code quality, potential bugs, performance, and maintainability. Usage: /front-review [strict]
argument-hint: [strict]
allowed-tools: Read Glob
---
```

| Field | Role |
|---|---|
| `name` | The skill name, used as the slash command (`/front-review`) |
| `description` | Shown in Claude Code's command picker |
| `argument-hint` | Hint displayed next to the command in the picker |
| `allowed-tools` | The Claude Code tools the skill is permitted to use |

### Instruction body

The body is a Markdown document with step-by-step instructions. It tells Claude what to do, in what order, and how to produce the output. Instructions reference `$ARGUMENTS` (the text the user typed after the command) and the target file.

---

## Sub-files

Skills that cover multiple languages split their rules into sub-files, one per language. The main `SKILL.md` detects the file extension and loads only the relevant sub-file.

This design keeps each request focused: only the rules for the language being processed are loaded.

```
front-review/
├── SKILL.md               # Entry point : orchestration
├── front-review-rules.md  # Shared rules (all languages)
├── front-review-js.md     # JS / TS / JSX / TSX rules
├── front-review-css.md    # CSS / Sass / SCSS rules
├── front-review-html.md   # HTML rules
├── front-review-vue.md    # Vue rules
├── front-review-svelte.md # Svelte rules
└── front-review-astro.md  # Astro rules
```

The pattern is consistent across all skills:

1. `SKILL.md` detects the file extension.
2. `SKILL.md` loads a shared rules file (if one exists).
3. `SKILL.md` loads the language-specific file.
4. Both files are applied together.

---

## Arguments

Arguments are the text the user types after the command:

```
/front-comments full lang:fr
/front-a11y fix
/front-review strict
/front-refactor apply
```

Inside `SKILL.md`, arguments are available as `$ARGUMENTS`. The skill parses them to determine the operating mode and options.

| Skill | Arguments | Effect |
|---|---|---|
| front-comments | `full` | Switches from Level 1 to Full commenting |
| front-comments | `lang:fr` / `lang:es` / `lang:de` | Sets the comment language |
| front-a11y | `fix` | Switches from audit mode to fix mode |
| front-review | `strict` | Tightens quality and complexity thresholds |
| front-refactor | `apply` | Switches from preview mode to apply mode |

Arguments can be combined in any order when a skill supports multiple:

```
/front-comments full lang:fr
```

---

## Tool access

Each skill declares which Claude Code tools it is allowed to use in its `allowed-tools` frontmatter field. Skills only request what they actually need.

| Skill | Tools | Reason |
|---|---|---|
| front-comments | Read, Edit, Write, Glob | Needs to read and rewrite the target file |
| front-a11y | Read, Edit, Write, Glob | Fix mode rewrites the target file |
| front-review | Read, Glob | Review only, never modifies files |
| front-refactor | Read, Glob, Edit, Write | Apply mode rewrites the target file |

---

## Target file detection

Skills operate on the file that is currently open in your editor, or on a file explicitly mentioned by the user. They do not scan directories or process multiple files at once.

File type detection is based on the file extension:

```
.js .ts .mjs .jsx .tsx   → JavaScript / TypeScript / React
.css .sass .scss          → CSS / Sass
.html                     → HTML
.vue                      → Vue SFC
.svelte                   → Svelte
.astro                    → Astro
```

If the file extension is not supported by a skill, the skill informs the user and lists the supported types.

---

## Execution flow

A typical skill run follows this sequence:

```
User runs /front-review strict
       |
       v
Claude Code loads SKILL.md
       |
       v
SKILL.md reads $ARGUMENTS → strict mode detected
       |
       v
SKILL.md detects .vue extension → loads front-review-vue.md
       |
       v
SKILL.md loads front-review-rules.md (shared rules)
       |
       v
Claude reads the target file
       |
       v
Claude applies all rules (shared + Vue-specific + strict thresholds)
       |
       v
Claude outputs the structured review report
```
