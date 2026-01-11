# ADR-0004: PowerShell 7 for Build Automation

Date: 2026-01-11

## Status

Accepted

## Context

Build automation scripts need to work across multiple platforms (Windows, Linux, macOS) and multiple technology stacks. We need to choose a scripting language for the Infrastructure scripts.

Options considered:
1. **Bash scripts** (.sh) - Unix/Linux standard
2. **Batch scripts** (.bat/.cmd) - Windows standard
3. **PowerShell 7** (.ps1) - Cross-platform, modern
4. **Node.js scripts** (.js) - Cross-platform, requires Node.js
5. **Python scripts** (.py) - Cross-platform, requires Python
6. **Make** - Cross-platform build tool
7. **MSBuild/dotnet CLI** - .NET specific

## Decision

We use **PowerShell 7 (pwsh)** for all build automation scripts:

- All scripts in `src/Infrastructure/` use `.ps1` extension
- Scripts include shebang `#!/usr/bin/env pwsh` for Unix systems
- Scripts use modern PowerShell features (parameter validation, strict mode)
- Scripts are self-documenting with comment-based help

Key scripts:
- `ci.ps1` - Complete CI pipeline orchestration
- `build.ps1` - Build all projects
- `test.ps1` - Run tests
- `restore.ps1` - Restore packages
- `clean.ps1` - Clean artifacts

## Consequences

### Positive Consequences

- **Cross-platform**: PowerShell 7 runs on Windows, Linux, and macOS
- **Modern language**: Object-oriented, strongly typed, rich standard library
- **Native .NET integration**: Excellent support for .NET build operations
- **Self-documenting**: Comment-based help (`Get-Help ./script.ps1`)
- **Error handling**: Robust error handling with `$ErrorActionPreference` and try/catch
- **Consistency**: Single language for all automation across platforms
- **IDE support**: Good IntelliSense and debugging in VS Code and other IDEs
- **Familiar to Windows developers**: Many .NET developers already know PowerShell

### Negative Consequences

- **Additional dependency**: Requires PowerShell 7 to be installed (not included by default on Linux/macOS)
- **Learning curve**: Developers unfamiliar with PowerShell need to learn syntax
- **Verbosity**: PowerShell can be more verbose than Bash for simple tasks
- **Not POSIX standard**: Unlike Bash, not a Unix standard shell

### Alternatives Considered and Rejected

- **Bash**: Not native on Windows, harder .NET integration
- **Batch**: Windows-only, limited functionality
- **Node.js/Python**: Extra runtime dependency, no clear advantage over PowerShell for .NET builds
- **Make**: Less expressive for complex logic, harder to maintain

## References

- [Infrastructure Scripts Documentation](../../src/Infrastructure/README.md)
- [PowerShell 7 Documentation](https://learn.microsoft.com/en-us/powershell/)
- [Local-First CI ADR](0001-local-first-ci-approach.md)
