<div>
  <img src="./assets/logos/logo-frontend-skills-300.png" alt="Claude Code Front-end Skills logo" width="200" height="200"/>
</div>

# Claude Code Frontend Skills

[![Version](https://img.shields.io/github/v/release/Effeilo/claude-code-frontend-skills?label=version)](https://github.com/Effeilo/claude-code-frontend-skills/releases)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](./LICENSE.md)
[![Claude Code](https://img.shields.io/badge/Claude%20Code-compatible-8A2BE2)](https://claude.ai/code)
[![Skills](https://img.shields.io/badge/skills-4-brightgreen)](#-available-skills)

**Frontend skills for [Claude Code](https://claude.ai/code) to review code, refactor safely, add structured comments, and audit accessibility faster.**

Claude Code Frontend Skills is a collection of AI-powered frontend skills for code review, safe refactoring, structured comments, and accessibility audits. Use simple slash commands to analyze or improve code directly in your editor. Supports JavaScript, TypeScript, React, CSS, Sass, HTML, Vue, Svelte, and Astro.

- [Project website](https://browserux.com/claude-code/frontend-skills/)
- [Documentation](./docs/index.md)
- [Releases](https://github.com/Effeilo/claude-code-frontend-skills/releases)

---

## ✨ Why this project

- Review frontend files with structured findings and severity levels
- Refactor safely without changing behavior
- Add clean, structured comments to legacy code
- Audit and fix common WCAG 2.1 AA issues

---

## 📦 Quick Start 

Clone this repository:

```bash
git clone https://github.com/Effeilo/claude-code-frontend-skills.git
cd claude-code-frontend-skills
```

### Option 1: install script (recommended)

**macOS / Linux / WSL (bash):**

```bash
./install.sh all              # install every skill
./install.sh front-a11y       # install a single skill
./install.sh all --force      # reinstall (overwrite existing)
```

**Windows (PowerShell):**

```powershell
.\install.ps1 all             # install every skill
.\install.ps1 front-a11y      # install a single skill
.\install.ps1 all -Force      # reinstall (overwrite existing)
```

Skills are installed into `~/.claude/skills/<skill-name>/` and become available as slash commands in Claude Code across all your projects.

### Option 2: manual install

```bash
mkdir -p ~/.claude/skills/<skill-name>
cp <skill-name>/SKILL.md <skill-name>/<skill-name>-*.md ~/.claude/skills/<skill-name>/
```

Each skill's README contains the exact manual install command.

---

## 🧩 Available skills


### [front-review](https://github.com/Effeilo/claude-code-frontend-skills/tree/main/front-review)

<img src="./assets/logos/logo-frontend-skills-review-300.png" alt="Claude Code Front-end Skills review logo" width="100" height="100"/>

Reviews a frontend file for code quality, potential bugs, performance, and maintainability. Issues are grouped by severity (Critical / Important / Minor / Suggestion) in standard or strict mode.

```
/front-review
/front-review strict
```

**Supported languages:** JS, TS, React (JSX/TSX), CSS, Sass, HTML, Vue, Svelte, Astro

---

### [front-refactor](https://github.com/Effeilo/claude-code-frontend-skills/tree/main/front-refactor)

<img src="./assets/logos/logo-frontend-skills-refactor-300.png" alt="Claude Code Front-end Skills refactor logo" width="100" height="100"/>

Refactors a frontend file, dead code removal, naming improvements, logic simplification, and modern syntax, without changing behavior. Preview mode shows a structured diff; apply mode rewrites the file.

```
/front-refactor
/front-refactor apply
```

**Supported languages:** JS, TS, React (JSX/TSX), CSS, Sass, Vue, Svelte, Astro

---

### [front-comments](https://github.com/Effeilo/claude-code-frontend-skills/tree/main/front-comments)

<img src="./assets/logos/logo-frontend-skills-comments-300.png" alt="Claude Code Front-end Skills comments logo" width="100" height="100"/>

Adds structured comments to a frontend file at **Level 1** (structure only) or **Full** (Level 1 + inline comments on every block).

```
/front-comments
/front-comments full
/front-comments lang:fr
/front-comments full lang:fr
```

**Supported languages:** JS, TS, React (JSX/TSX), CSS, Sass, HTML, Vue, Svelte, Astro

---

### [front-a11y](https://github.com/Effeilo/claude-code-frontend-skills/tree/main/front-a11y)

<img src="./assets/logos/logo-frontend-skills-a11y-300.png" alt="Claude Code Front-end Skills a11y logo" width="100" height="100"/>

Audits or fixes accessibility issues (WCAG 2.1 AA) in a frontend file. Reports issues grouped by severity (Critical / Major / Minor) or applies all auto-fixable corrections directly.

```
/front-a11y
/front-a11y fix
```

**Supported languages:** HTML, React (JSX/TSX), Vue, Svelte, Astro

---

## 🧪 Examples

- **front-review**: [example report](./front-review/examples/js/cart-service.review.md)
- **front-refactor**: [preview diff](./front-refactor/examples/js/order-utils.preview.md)
- **front-comments**: [commented file](./front-comments/examples/js/navigate-loader-comments-full.js)
- **front-a11y**: [audit report](./front-a11y/examples/html/contact-audit.md)

---

## 🌐 Language support matrix

| Language | front-comments | front-a11y | front-review | front-refactor |
|---|:---:|:---:|:---:|:---:|
| JS / TS / MJS | ✓ | | ✓ | ✓ |
| JSX / TSX (React) | ✓ | ✓ | ✓ | ✓ |
| CSS / Sass / SCSS | ✓ | | ✓ | ✓ |
| HTML | ✓ | ✓ | ✓ | |
| Vue SFC | ✓ | ✓ | ✓ | ✓ |
| Svelte | ✓ | ✓ | ✓ | ✓ |
| Astro | ✓ | ✓ | ✓ | ✓ |

---

## 🗺️ Documentation

### Guide

- [Introduction](./docs/guide/introduction.md) : philosophy, design principles, what skills are and are not
- [Getting started](./docs/guide/getting-started.md) : installation per skill and global project structure
- [How skills work](./docs/guide/how-skills-work.md) : SKILL.md, sub-files, argument handling, tool access

### Skills

- [front-comments](./docs/skills/front-comments.md) : add structured comments to a frontend file
- [front-a11y](./docs/skills/front-a11y.md) : audit or fix accessibility issues (WCAG 2.1 AA)
- [front-review](./docs/skills/front-review.md) : review a frontend file for quality, bugs, and performance
- [front-refactor](./docs/skills/front-refactor.md) : refactor a frontend file without changing behavior

### Reference

- [Supported languages](./docs/reference/supported-languages.md) : language support matrix across all skills
- [Skill structure](./docs/reference/skill-structure.md) : anatomy of a skill (SKILL.md, sub-files, conventions)

### Additional

- [Contributing](./docs/contributing.md) : report a bug, suggest a skill, submit a pull request
- [Changelog](./CHANGELOG.md) : version history and release notes

---

## 💡 What are Claude Code skills?

Claude Code skills are reusable, project-independent workflows that extend Claude Code. Each skill is a self-contained directory with a `SKILL.md` file that defines its behavior, arguments, and instructions, and is invoked as a slash command (e.g. `/front-review`).

Skills live in `~/.claude/skills/` and are available across all your projects once installed.

[Learn more about Claude Code skills](https://docs.anthropic.com/claude-code)

---

## ⚖️ License

[MIT](./LICENSE.md) © 2026 [Effeilo](https://github.com/Effeilo)
