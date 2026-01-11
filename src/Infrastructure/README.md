# TSP Infrastructure

This directory contains build automation and CI/CD scripts for the Toeb Software Platform.

## Philosophy: Local-First CI

All build scripts are designed to run **locally** first. The CI system simply calls these same scripts, ensuring:
- **Consistency**: Same behavior locally and in CI
- **Debuggability**: Easy to reproduce CI issues locally
- **Simplicity**: No hidden CI magic, everything is in scripts you can run

## Scripts

All scripts are written in **PowerShell 7 (pwsh)** for cross-platform compatibility.

### Core Scripts

#### `ci.ps1` - Complete CI Pipeline
Runs the full CI pipeline: restore, build, and test.

```powershell
# Run full CI pipeline
./ci.ps1

# Run with specific configuration
./ci.ps1 -Configuration Debug

# Run for specific framework
./ci.ps1 -Framework net8.0
```

#### `restore.ps1` - Restore Packages
Restores all NuGet package dependencies.

```powershell
# Restore packages
./restore.ps1

# Force restore
./restore.ps1 -Force
```

#### `build.ps1` - Build Projects
Builds all projects in the solution.

```powershell
# Build with default (Release) configuration
./build.ps1

# Build with Debug configuration
./build.ps1 -Configuration Debug

# Build specific framework
./build.ps1 -Framework net8.0
```

#### `test.ps1` - Run Tests
Runs all test projects.

```powershell
# Run all tests
./test.ps1

# Run tests without building
./test.ps1 -NoBuild

# Run with code coverage
./test.ps1 -Collect
```

#### `clean.ps1` - Clean Build Artifacts
Cleans build outputs and temporary files.

```powershell
# Standard clean
./clean.ps1

# Deep clean (includes NuGet cache)
./clean.ps1 -Deep
```

## GitHub Actions Integration

The `.github/workflows/pr-build.yml` workflow uses these scripts:

- **Windows Runner**: Builds and tests all target frameworks (net8.0 and net48)
- **Linux Runner**: Builds and tests net8.0 only (net48 requires Windows)

Both runners execute the same `ci.ps1` script you run locally.

## Requirements

- **PowerShell 7+** (pwsh)
- **.NET 8.0 SDK**
- **.NET Framework 4.8 Developer Pack** (Windows only, for net48 targets)

## Common Workflows

### Local Development
```powershell
# Quick build and test
./ci.ps1

# Clean and rebuild
./clean.ps1
./ci.ps1
```

### Debugging CI Failures
```powershell
# Run the exact same command as CI
./ci.ps1 -Configuration Release -Framework net8.0
```

### Before Committing
```powershell
# Full build and test
./ci.ps1 -Configuration Release
```
