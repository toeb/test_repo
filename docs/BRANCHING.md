# Branching Strategy

This document describes the Git branching strategy and workflow for the TSP repository.

## Branch Structure

### Main Branch

- **Branch name**: `main`
- **Purpose**: Production-ready code
- **Protection**: Protected with the following rules:
  - Direct commits not allowed
  - Requires pull request with passing CI
  - Optionally requires code review
  - Branch deletion not allowed

### Feature Branches

- **Naming convention**: Use descriptive names
  - `feature/add-logging`
  - `fix/null-reference-bug`
  - `docs/update-readme`
  - `refactor/simplify-parser`

- **Lifecycle**: Short-lived
  - Create from `main`
  - Make focused changes
  - Create PR when ready
  - Delete after merge

- **Best practices**:
  - Keep branches small and focused on a single purpose
  - Sync frequently with `main` to avoid large merge conflicts
  - Use meaningful commit messages

## Workflow

### 1. Create an Issue

**Every PR must have an associated GitHub Issue.**

```bash
# Create issue on GitHub first
# Example: Issue #42: "Add user authentication"
```

### 2. Create Feature Branch

```bash
# Create and checkout feature branch
git checkout -b feature/add-user-auth main

# Or using GitHub CLI
gh issue develop 42 --checkout
```

### 3. Make Changes

```bash
# Make your changes
# Commit frequently with clear messages
git add .
git commit -m "Add authentication service"

# Test locally before pushing
cd src/Infrastructure
pwsh ./ci.ps1
```

### 4. Push and Create PR

```bash
# Push to remote
git push -u origin feature/add-user-auth

# Create pull request (via GitHub UI or CLI)
gh pr create --title "Add user authentication" --body "Closes #42"
```

**PR Requirements:**
- Link to issue (e.g., "Closes #42", "Fixes #42", "Resolves #42")
- Clear description of changes
- All CI checks must pass
- Follow commit message conventions

### 5. Code Review & CI

- CI automatically runs on PR
- Address any CI failures locally using the same scripts
- Respond to code review feedback
- Make additional commits if needed

### 6. Merge

Once approved and CI passes:

```bash
# Merge via GitHub UI (recommended)
# Or via CLI
gh pr merge --squash
```

The feature branch is automatically deleted after merge.

## Branch Protection Rules

The `main` branch is protected with these rules:

- ✅ Require pull request before merging
- ✅ Require status checks to pass before merging
  - `build-windows` - Windows build must pass
  - `build-linux` - Linux build must pass
- ✅ Require conversation resolution before merging (optional)
- ✅ Require linear history (optional)
- ✅ Do not allow bypassing the above settings
- ✅ Restrict who can push to matching branches

### Enabling Branch Protection

To enable these rules on GitHub:

1. Go to **Settings** > **Branches**
2. Click **Add rule** or edit existing rule
3. Branch name pattern: `main`
4. Enable:
   - ☑ Require a pull request before merging
   - ☑ Require status checks to pass before merging
     - Add required checks: `build-windows`, `build-linux`
   - ☑ Require conversation resolution before merging (recommended)
   - ☑ Do not allow bypassing the above settings

## Quick Reference

### Common Commands

```bash
# Start new feature
git checkout -b feature/my-feature main

# Keep feature branch updated
git checkout feature/my-feature
git fetch origin
git rebase origin/main

# Run CI locally
cd src/Infrastructure
pwsh ./ci.ps1

# Create PR
gh pr create

# Merge PR
gh pr merge --squash

# Clean up merged branches
git branch -d feature/my-feature
git remote prune origin
```

### Commit Message Format

```
<type>: <subject>

<body (optional)>

<footer (optional)>
```

**Types:**
- `feat`: New feature
- `fix`: Bug fix
- `docs`: Documentation changes
- `refactor`: Code refactoring
- `test`: Test changes
- `chore`: Build process or auxiliary tool changes

**Examples:**
```
feat: Add user authentication service

fix: Resolve null reference in parser

docs: Update branching strategy documentation

refactor: Simplify configuration loading
```

## Issue and PR Linking

Always link PRs to issues using keywords in the PR description:

- `Closes #123` - Closes the issue when PR is merged
- `Fixes #123` - Same as Closes
- `Resolves #123` - Same as Closes
- `Relates to #123` - Links but doesn't auto-close

## Enforcement

These branching rules are:
1. Documented in this file
2. Configured in `.claude_instructions`
3. Enforced via GitHub branch protection
4. Validated in CI

Non-compliance will result in:
- PR cannot be merged
- CI checks fail
- Review feedback to correct the issue

## Questions?

See also:
- [Contributing Guide](CONTRIBUTING.md) (if exists)
- [.claude_instructions](../.claude_instructions)
- [ADR Index](adr/README.md)
