# Toeb Software Platform (TSP)

[![PR Build](https://github.com/toeb/test_repo/actions/workflows/pr-build.yml/badge.svg)](https://github.com/toeb/test_repo/actions/workflows/pr-build.yml)

A tech demo and playground repository showcasing multiple technology stacks with a local-first CI/CD approach.

## Quick Start

```powershell
# Clone the repository
git clone https://github.com/toeb/test_repo.git
cd test_repo

# Run the CI pipeline
cd src/Infrastructure
pwsh ./ci.ps1
```

## What's Inside

### C# Projects (.NET 8.0 + .NET Framework 4.8)
- **Tsp.Core** - Core library
- **Tsp.Core.Tests** - Unit tests (xUnit)
- **Tsp.Cli** - Command-line application
- **Infrastructure** - Build automation scripts (PowerShell 7)

### Future Tech Stacks
- C++ projects (coming soon)
- Python projects (coming soon)

## Documentation

- **[Full Documentation](docs/README.md)** - Comprehensive getting started guide
- **[Source Code](src/README.md)** - Source code structure and build instructions
- **[Infrastructure Scripts](src/Infrastructure/README.md)** - Build automation details

## Local-First Philosophy

All CI operations can be run locally using the same scripts that run in GitHub Actions. No surprises, easy debugging, complete transparency.

## Prerequisites

- PowerShell 7+ (pwsh)
- .NET 8.0 SDK
- .NET Framework 4.8 Developer Pack (Windows only)

## Build Status

The PR Build workflow runs on:
- **Windows**: All frameworks (net8.0 + net48)
- **Linux**: .NET 8.0 only

## License

See repository for license information.
