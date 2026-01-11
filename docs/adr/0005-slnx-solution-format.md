# ADR-0005: XML-Based Solution Format (.slnx)

Date: 2026-01-11

## Status

Accepted

## Context

.NET solutions can be organized using different solution file formats. The traditional `.sln` format has been the standard but has limitations.

Options:
1. **Traditional .sln format** - Binary-like text format, difficult to read/edit manually
2. **New .slnx format** - XML-based, human-readable and editable
3. **No solution file** - Use directory-based builds with `dotnet build` on folders

## Decision

We use the **new XML-based .slnx solution format** for organizing C# projects:

File: `src/Tsp.slnx`

```xml
<Solution>
  <Folder Name="/src/">
    <Project Path="Tsp.Core\Tsp.Core.csproj" />
    <Project Path="Tsp.Core.Tests\Tsp.Core.Tests.csproj" />
    <Project Path="Tsp.Cli\Tsp.Cli.csproj" />
  </Folder>
</Solution>
```

## Consequences

### Positive Consequences

- **Readable**: XML format is human-readable and easy to understand
- **Editable**: Can be manually edited without corrupting the file
- **Version control friendly**: Easier to review changes in diffs
- **Simpler structure**: Less noise than traditional .sln format
- **Modern**: Aligns with .NET's move toward XML/JSON for configuration
- **Future-proof**: Microsoft's recommended format going forward
- **No GUID management**: Doesn't require tracking project GUIDs

### Negative Consequences

- **Newer format**: Not supported in older versions of Visual Studio (requires VS 2022+)
- **Limited IDE support**: Some older IDEs may not recognize .slnx files
- **Less documentation**: Fewer examples and documentation compared to .sln
- **Potential tooling issues**: Some third-party tools may not support .slnx yet

### Compatibility

- **Supported**: Visual Studio 2022+, Rider, VS Code with C# extension
- **dotnet CLI**: Fully supported by `dotnet build`, `dotnet test`, etc.
- **CI/CD**: Works seamlessly with build automation

### Migration Strategy

If .slnx proves incompatible with essential tools, we can:
1. Generate traditional .sln from .slnx using `dotnet sln`
2. Create a new ADR to supersede this decision
3. Maintain both formats if necessary (though not recommended)

## References

- [.slnx format documentation](https://learn.microsoft.com/en-us/visualstudio/ide/solution-file-schema-reference)
- [Flat Source Structure ADR](0003-flat-source-structure.md)
