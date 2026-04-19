<div>
  <img src="../assets/logos/logo-frontend-skills-300.png" alt="Claude Code Front-end Skills logo" width="200" height="200"/>
</div>

# Documentation Claude Code Frontend Skills

## The project

Claude Code Frontend Skills is a collection of [Claude Code](https://claude.ai/code) skills that automate recurring frontend tasks: structured commenting, accessibility audits, code review, and refactoring.

Each skill is invoked as a slash command (e.g. `/front-review`) directly in Claude Code. Skills are self-contained, project-independent, and work across any frontend codebase.

---

## Table of contents

### Guide

- [Introduction](guide/introduction.md) : philosophy, design principles, what skills are and are not
- [Getting started](guide/getting-started.md) : installation per skill and global project structure
- [How skills work](guide/how-skills-work.md) : SKILL.md, sub-files, argument handling, tool access

### Skills

- [front-comments](skills/front-comments.md) : add structured comments to a frontend file
- [front-a11y](skills/front-a11y.md) : audit or fix accessibility issues (WCAG 2.1 AA)
- [front-review](skills/front-review.md) : review a frontend file for quality, bugs, and performance
- [front-refactor](skills/front-refactor.md) : refactor a frontend file without changing behavior

### Reference

- [Supported languages](reference/supported-languages.md) : language support matrix across all skills
- [Skill structure](reference/skill-structure.md) : anatomy of a skill (SKILL.md, sub-files, conventions)

### Additional

- [Contributing](contributing.md) : report a bug, suggest a skill, submit a pull request
