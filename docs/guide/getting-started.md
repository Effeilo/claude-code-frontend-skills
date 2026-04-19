# Getting started

Skills live in `~/.claude/skills/` and are available across all your projects once installed. Each skill is a self-contained directory that you copy from this repository.

---

## Prerequisites

- [Claude Code](https://claude.ai/code) installed and configured
- Git available in your terminal

---

## Step 1 : Clone the repository

```bash
git clone https://github.com/Effeilo/claude-code-frontend-skills.git
cd claude-code-frontend-skills
```

---

## Step 2 : Install the skill(s) you want

Two options are available.

### Option A : Install script (recommended)

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

The script copies `SKILL.md` and the language sub-files into `~/.claude/skills/<skill-name>/`. It skips skills that are already installed unless `--force` / `-Force` is passed.

### Option B : Manual install

Copy only the skills you need:

**front-comments**

```bash
mkdir -p ~/.claude/skills/front-comments
cp front-comments/SKILL.md \
   front-comments/front-comments-*.md \
   ~/.claude/skills/front-comments/
```

**front-a11y**

```bash
mkdir -p ~/.claude/skills/front-a11y
cp front-a11y/SKILL.md \
   front-a11y/front-a11y-*.md \
   ~/.claude/skills/front-a11y/
```

**front-review**

```bash
mkdir -p ~/.claude/skills/front-review
cp front-review/SKILL.md \
   front-review/front-review-*.md \
   ~/.claude/skills/front-review/
```

**front-refactor**

```bash
mkdir -p ~/.claude/skills/front-refactor
cp front-refactor/SKILL.md \
   front-refactor/front-refactor-*.md \
   ~/.claude/skills/front-refactor/
```

---

## Step 3 : Use the skill

Open a file in your editor, then run the corresponding command from Claude Code:

```
/front-comments
/front-a11y
/front-review
/front-refactor
```

Claude Code will apply the skill to the currently open file.

---

## Updating a skill

To update a skill to the latest version, pull the repository and re-run the install with the force flag:

```bash
cd claude-code-frontend-skills
git pull
./install.sh all --force        # bash
.\install.ps1 all -Force        # PowerShell
```

For a manual update, pull the repo then re-copy the files:

```bash
cp front-comments/SKILL.md front-comments/front-comments-*.md ~/.claude/skills/front-comments/
```

---

## Validate the repository

If you are contributing to this repository, run the validation script before opening a pull request:

```powershell
pwsh ./scripts/validate-repo.ps1
```

This checks the skill structure, documented examples, install scripts, and local logo assets.

The same validation also runs automatically in GitHub Actions.

---

## Skills directory structure

After installing all four skills, your `~/.claude/skills/` directory looks like this:

```
~/.claude/skills/
├── front-comments/
│   ├── SKILL.md
│   ├── front-comments-js.md
│   ├── front-comments-css.md
│   ├── front-comments-html.md
│   ├── front-comments-vue.md
│   ├── front-comments-svelte.md
│   └── front-comments-astro.md
├── front-a11y/
│   ├── SKILL.md
│   ├── front-a11y-rules.md
│   ├── front-a11y-html.md
│   ├── front-a11y-jsx.md
│   ├── front-a11y-vue.md
│   ├── front-a11y-svelte.md
│   └── front-a11y-astro.md
├── front-review/
│   ├── SKILL.md
│   ├── front-review-rules.md
│   ├── front-review-js.md
│   ├── front-review-css.md
│   ├── front-review-html.md
│   ├── front-review-vue.md
│   ├── front-review-svelte.md
│   └── front-review-astro.md
└── front-refactor/
    ├── SKILL.md
    ├── front-refactor-rules.md
    ├── front-refactor-js.md
    ├── front-refactor-css.md
    ├── front-refactor-vue.md
    ├── front-refactor-svelte.md
    └── front-refactor-astro.md
```

---

## Summary

| Step | Action |
|---|---|
| 1 | Clone the repository |
| 2 | Run `./install.sh all` (bash) or `.\install.ps1 all` (PowerShell), or copy the files manually |
| 3 | Open a file and run the slash command from Claude Code |
| 4 | If you contribute to the repo, run `pwsh ./scripts/validate-repo.ps1` |
