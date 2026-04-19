<div align="center">

# ⚡ Toeb Software Platform

**A multi-stack tech demo & playground — local-first, CI-ready, cross-platform.**

[![PR Build](https://github.com/toeb/test_repo/actions/workflows/pr-build.yml/badge.svg)](https://github.com/toeb/test_repo/actions/workflows/pr-build.yml)
[![.NET](https://img.shields.io/badge/.NET-8.0%20%7C%20net48-512BD4?logo=dotnet)](https://dotnet.microsoft.com/)
[![Platform](https://img.shields.io/badge/platform-Windows%20%7C%20Linux-0078D4?logo=windows)](https://github.com/toeb/test_repo)
[![PowerShell](https://img.shields.io/badge/scripts-PowerShell%207-5391FE?logo=powershell)](https://github.com/PowerShell/PowerShell)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![xUnit](https://img.shields.io/badge/tests-xUnit-512BD4)](https://xunit.net/)

</div>

---

## What is TSP?

**Toeb Software Platform (TSP)** is a polyglot tech demo repository exploring multiple technology stacks under one roof. It demonstrates a **local-first CI philosophy** — every pipeline step you see in GitHub Actions is a script you can run on your own machine.

> _"No CI magic. What runs in the cloud runs on your laptop."_

---

## Tech Stacks

| Stack | Status | Notes |
|-------|--------|-------|
| **C# / .NET** | Active | Multi-targets `net8.0` + `net48` |
| **C++** | Planned | Build system TBD |
| **Python** | Planned | Project structure TBD |

---

## Quick Start

### Prerequisites

- [PowerShell 7+](https://github.com/PowerShell/PowerShell) (`pwsh`)
- [.NET 8.0 SDK](https://dotnet.microsoft.com/download)
- .NET Framework 4.8 Developer Pack _(Windows only, for `net48` targets)_

### Run the full CI pipeline locally

```powershell
cd src/Infrastructure
./ci.ps1
```

That's it. Same command runs in GitHub Actions.

### Individual steps

```powershell
./restore.ps1          # Restore NuGet packages
./build.ps1            # Build all projects
./test.ps1             # Run all tests
./clean.ps1            # Clean build artifacts
```

### Advanced options

```powershell
./build.ps1 -Configuration Debug        # Debug build
./build.ps1 -Framework net8.0           # Specific framework
./test.ps1 -Collect                     # With code coverage
./clean.ps1 -Deep                       # Deep clean (incl. NuGet cache)
./ci.ps1 -Configuration Release -Framework net8.0  # Mirror CI exactly
```

---

## Project Structure

```
test_repo/
├── .github/
│   └── workflows/
│       └── pr-build.yml       # GitHub Actions — calls Infrastructure scripts
├── docs/
│   └── README.md              # Full documentation
└── src/
    ├── Tsp.slnx               # XML-based solution file
    ├── Tsp.Core/              # Core library
    ├── Tsp.Core.Tests/        # xUnit tests for Tsp.Core
    ├── Tsp.Cli/               # Command-line application
    └── Infrastructure/        # PowerShell build scripts
```

---

## CI / GitHub Actions

CI triggers on pull requests and runs two parallel jobs:

| Job | Runner | Frameworks |
|-----|--------|------------|
| Build & Test | `windows-latest` | `net8.0` + `net48` |
| Build & Test | `ubuntu-latest` | `net8.0` |

Both jobs call the same `ci.ps1` script used locally — zero divergence.

---

## Documentation

- [docs/README.md](docs/README.md) — Full project documentation
- [src/Infrastructure/README.md](src/Infrastructure/README.md) — Build script reference
- [src/README.md](src/README.md) — Source code layout

---

## Running the CLI

```bash
dotnet run --project src/Tsp.Cli
```

---

<div align="center">

Built with ❤️ by [toeb](https://github.com/toeb)

</div>
