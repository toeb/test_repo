# ADR-0003: Flat Source Directory Structure

Date: 2026-01-11

## Status

Accepted

## Context

Source code organization significantly impacts maintainability and discoverability. We need to decide how to organize projects across multiple technology stacks (C#, C++, Python).

Common approaches:
1. **Nested by technology**: `src/csharp/`, `src/cpp/`, `src/python/`
2. **Nested by domain**: `src/core/`, `src/cli/`, `src/web/`
3. **Flat structure**: All projects as direct subdirectories of `src/`
4. **Monorepo with workspaces**: Each project in its own directory with metadata

## Decision

We adopt a **flat structure** where:

- All projects (DLLs, EXEs, modules) live as **direct subdirectories of `src/`**
- No technology-specific or domain-specific nesting
- Dotfiles (`.editorconfig`, `.gitignore`) are placed directly in `src/` and apply to all projects
- Each project is self-contained in its subdirectory

Example:
```
src/
├── .editorconfig
├── .gitignore
├── Tsp.Core/
├── Tsp.Core.Tests/
├── Tsp.Cli/
├── Infrastructure/
└── Tsp.slnx
```

## Consequences

### Positive Consequences

- **Simplicity**: Easy to navigate - all projects at the same level
- **Discoverability**: Quick to find any project (no nested searching)
- **Uniform tooling**: All projects use the same dotfiles configuration
- **Easy automation**: Build scripts can easily enumerate all projects
- **Technology agnostic**: No reorganization needed when adding new tech stacks
- **IDE friendly**: Most IDEs handle flat structures well
- **Clear boundaries**: Each project directory is self-contained

### Negative Consequences

- **Potential clutter**: `src/` directory may become crowded with many projects
- **No visual grouping**: Cannot see technology groupings from directory structure alone
- **Naming responsibility**: Project names must be clear about their purpose (can't rely on parent directory context)
- **Dotfile compatibility**: Must ensure `.editorconfig` and `.gitignore` work across all technologies

### Mitigation Strategies

- Use clear, descriptive project names with prefixes (e.g., `Tsp.Core`, `Tsp.Cli`)
- Maintain comprehensive documentation in README files
- Keep dotfiles compatible across all technologies
- If `src/` becomes too large, can revisit organization in a new ADR

## References

- [Repository Structure Documentation](../README.md#project-structure)
- [.claude_instructions](../../.claude_instructions)
