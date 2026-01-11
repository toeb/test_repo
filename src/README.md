# TSP Source Code

This directory contains all source code projects for the Toeb Software Platform.

## Structure

All projects live as direct subdirectories in a flat structure:

- `Tsp.Core/` - Core library (multi-targets net8.0 and net48)
- `Tsp.Core.Tests/` - Unit tests for Tsp.Core using xUnit
- `Tsp.Cli/` - Command-line application
- `Infrastructure/` - Build automation scripts (PowerShell 7)

## Solution

The solution file `Tsp.slnx` uses the new XML-based solution format.

## Building

### Recommended: Use Infrastructure Scripts

For the best experience, use the PowerShell build scripts in `Infrastructure/`:

```powershell
# Run full CI pipeline (restore, build, test)
./Infrastructure/ci.ps1

# Or individual steps
./Infrastructure/restore.ps1
./Infrastructure/build.ps1
./Infrastructure/test.ps1
```

See [Infrastructure/README.md](Infrastructure/README.md) for detailed documentation.

### Alternative: Direct .NET Commands

You can also use standard .NET CLI commands:

```bash
dotnet build Tsp.slnx
dotnet test Tsp.slnx
```

## Running the CLI

```bash
dotnet run --project Tsp.Cli
```

## Configuration Files

- `.editorconfig` - Editor configuration for consistent coding style
- `.gitignore` - Git ignore patterns for .NET projects

These dotfiles are maintained at the src/ level and apply to all projects.
