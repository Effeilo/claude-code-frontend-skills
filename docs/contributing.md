# Contributing

Contributions are welcome. Whether you want to report a bug, improve an existing skill, suggest a new one, or fix a typo, feel free to participate.

---

## Reporting an issue

Open an issue on [GitHub](https://github.com/Effeilo/claude-code-frontend-skills/issues) to:

- Report unexpected skill behavior (wrong output, missed issues, incorrect fixes).
- Suggest an improvement to an existing skill (new rules, new language support, new argument).
- Propose a new skill idea.
- Discuss a design decision before submitting a pull request.

All feedback is appreciated, including non-technical feedback.

---

## Submitting a pull request

1. Fork the repository.
2. Create a dedicated branch:

```bash
git checkout -b my-proposal
```

3. Make your changes.
4. Commit with a clear message:

```bash
git commit -m "Add: description of the change"
```

5. Push the branch:

```bash
git push origin my-proposal
```

6. Open a pull request on GitHub.

Before opening the pull request, run the repository validation script:

```powershell
pwsh ./scripts/validate-repo.ps1
```

---

## Adding a new skill

Before creating a new skill:

1. Check if a skill with a similar purpose already exists.
2. If one exists, evaluate whether the new behavior belongs in the existing skill as an argument or a new sub-file.
3. If a new skill is warranted, follow the conventions below.

### Directory structure

A new skill must follow the standard layout:

```text
front-<name>/
|- SKILL.md                     # Entry point
|- front-<name>-rules.md        # Shared rules (if applicable)
|- front-<name>-<language>.md   # One file per supported language
|- examples/                    # At least one source file and one output file
`- README.md
```

Version history for the collection is tracked in the repository root `CHANGELOG.md`.

### SKILL.md conventions

- `name`: must match the directory name exactly (`front-<name>`)
- `description`: one sentence, ends with the usage syntax (`Usage: /front-<name> [args]`)
- `argument-hint`: lists optional arguments in brackets
- `allowed-tools`: request only the tools the skill actually uses

### Sub-file conventions

- One file per supported language. Do not combine multiple languages in one file.
- Load a shared rules file for rules that apply to all languages.
- Language files must document detection patterns (how to find the issue in that language's syntax), not just rule descriptions.

### Optimization

Split rules into sub-files so that each run loads only what it needs. A skill that covers 6 languages and loads a single monolithic rules file on every run is not optimized. Each language file should be self-contained for its language, with shared concepts extracted to the rules file.

### Examples

Every skill must include at least one example:

- A source file (the input to the skill)
- The skill output (report, commented file, refactoring preview, or rewritten file)

Examples serve as documentation and as a manual regression test when rules are updated.

The repository validation script checks that the examples documented in each skill README actually exist:

```powershell
pwsh ./scripts/validate-repo.ps1
```

---

## Improving an existing skill

When modifying a skill's rules:

- Update the relevant sub-file, not `SKILL.md` (unless the orchestration logic changes).
- Update the repository root `CHANGELOG.md` with a summary of what changed.
- Update the `examples/` directory if the output of an existing example changes.
- If a new language is added, add the corresponding sub-file and update the matrix in `README.md` and `docs/reference/supported-languages.md`.

---

## Checklist before submitting a PR

- [ ] `SKILL.md` frontmatter is complete and correct
- [ ] Sub-files follow the naming convention (`<skill-name>-<language>.md`)
- [ ] At least one example source file and one output file in `examples/`
- [ ] `README.md` documents the skill (supported languages, usage, arguments, examples, file structure)
- [ ] Repository root `CHANGELOG.md` is up to date
- [ ] Install command in `README.md` uses the correct repository name
- [ ] No skill modifies files it has not read first
- [ ] Skills that produce reports do not request `Edit` or `Write` in `allowed-tools`
- [ ] `pwsh ./scripts/validate-repo.ps1` passes locally
