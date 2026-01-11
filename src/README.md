# TSP Source Code

This directory contains all source code projects for the Toeb Software Platform.

## Structure

All projects live as direct subdirectories in a flat structure:

- `Tsp.Core/` - Core library (multi-targets net8.0 and net48)
- `Tsp.Core.Tests/` - Unit tests for Tsp.Core using xUnit
- `Tsp.Cli/` - Command-line application

## Solution

The solution file `Tsp.slnx` uses the new XML-based solution format.

## Building

From the `src/` directory:

```bash
dotnet build Tsp.slnx
```

## Running Tests

```bash
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
