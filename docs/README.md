# Toeb Software Platform (TSP) Documentation

[![PR Build](https://github.com/toeb/test_repo/actions/workflows/pr-build.yml/badge.svg)](https://github.com/toeb/test_repo/actions/workflows/pr-build.yml)

## Overview
This is a tech demo and playground repository showcasing multiple technology stacks.

## Project Structure

### Source Code (`src/`)
All projects are organized as direct subdirectories under `src/` in a flat structure.

#### C# Projects
- **Tsp.Core** - Core library (multi-targets net8.0 and net48)
- **Tsp.Core.Tests** - Unit tests for Tsp.Core
- **Tsp.Cli** - Command-line application
- **Infrastructure** - Build automation scripts (PowerShell 7)

#### Future Projects
- C++ projects
- Python projects

## Getting Started

### Prerequisites
- **PowerShell 7+** (pwsh) - For build scripts
- **.NET 8.0 SDK**
- **.NET Framework 4.8 Developer Pack** (Windows only, for net48 targets)

### Local-First Build Approach

This repository follows a **local-first** philosophy: all CI operations can be run locally using the same scripts.

#### Quick Start
```powershell
# Navigate to Infrastructure
cd src/Infrastructure

# Run full CI pipeline (restore, build, test)
./ci.ps1
```

#### Individual Operations
```powershell
# Restore packages
./restore.ps1

# Build projects
./build.ps1

# Run tests
./test.ps1

# Clean build artifacts
./clean.ps1
```

#### Advanced Options
```powershell
# Build specific configuration
./build.ps1 -Configuration Debug

# Build specific framework
./build.ps1 -Framework net8.0

# Run tests with code coverage
./test.ps1 -Collect

# Deep clean (includes NuGet cache)
./clean.ps1 -Deep
```

### Traditional .NET Commands
You can also use standard .NET CLI commands from the `src/` directory:

```bash
dotnet build Tsp.slnx
dotnet test Tsp.slnx
```

## Continuous Integration

CI runs automatically on pull requests using GitHub Actions:

- **Windows Runner**: Builds and tests all frameworks (net8.0 + net48)
- **Linux Runner**: Builds and tests net8.0 only

The CI workflow calls the same PowerShell scripts you use locally, ensuring consistency.

## Documentation

- [Infrastructure Scripts](../src/Infrastructure/README.md) - Detailed build script documentation
- Additional documentation will be added as the project grows.
