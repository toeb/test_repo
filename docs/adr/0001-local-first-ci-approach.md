# ADR-0001: Local-First CI Approach

Date: 2026-01-11

## Status

Accepted

## Context

Continuous Integration (CI) systems often have custom configurations and behaviors that only run in the CI environment, making it difficult to reproduce CI failures locally. This leads to:

- Developers unable to debug CI failures without pushing commits
- "Works on my machine" syndrome extending to "Works locally but fails in CI"
- Black-box CI processes that are hard to understand and maintain
- Slow feedback loops when debugging CI issues

We need a CI approach that is transparent, reproducible, and easy to debug.

## Decision

We adopt a **local-first CI approach** where:

1. **All CI operations are implemented as local scripts** (PowerShell 7)
2. **CI workflows simply call these local scripts** - no special CI-only logic
3. **Scripts are stored in the repository** under `src/Infrastructure/`
4. **Same scripts run locally and in CI** - guaranteeing identical behavior

The CI pipeline (`ci.ps1`) orchestrates:
- `restore.ps1` - Restore NuGet packages
- `build.ps1` - Build all projects
- `test.ps1` - Run all tests

GitHub Actions workflows invoke these scripts using `pwsh` on both Windows and Linux runners.

## Consequences

### Positive Consequences

- **Reproducibility**: Developers can run the exact same CI pipeline locally
- **Debuggability**: CI failures can be reproduced and debugged on local machines
- **Transparency**: No hidden CI magic - everything is in version-controlled scripts
- **Faster feedback**: Debug issues locally without waiting for CI runs
- **Consistency**: Identical behavior between local and CI environments
- **Portability**: Easy to migrate to different CI systems (scripts remain the same)
- **Documentation**: Scripts serve as executable documentation of the build process

### Negative Consequences

- **Initial setup complexity**: Requires PowerShell 7 to be installed locally
- **Script maintenance**: Build logic must be maintained in scripts rather than CI config
- **CI-specific features**: Cannot easily use CI platform-specific features without breaking local-first principle

## References

- [Infrastructure Scripts Documentation](../../src/Infrastructure/README.md)
- [GitHub Actions Workflow](../../.github/workflows/pr-build.yml)
