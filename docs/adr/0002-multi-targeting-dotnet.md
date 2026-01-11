# ADR-0002: Multi-Targeting .NET Frameworks

Date: 2026-01-11

## Status

Accepted

## Context

The TSP platform needs to support both modern .NET applications and legacy .NET Framework applications. We must decide how to structure our projects to maximize compatibility and code reuse.

Options considered:
1. **Separate projects** for each framework (e.g., Tsp.Core.NetCore, Tsp.Core.NetFramework)
2. **Multi-targeting** within single projects using `<TargetFrameworks>`
3. **Only .NET 8.0** and drop .NET Framework support

## Decision

We will use **multi-targeting** with `net8.0` and `net48` as target frameworks:

```xml
<TargetFrameworks>net8.0;net48</TargetFrameworks>
```

All C# projects (libraries, applications, and test projects) will multi-target both frameworks.

## Consequences

### Positive Consequences

- **Code reuse**: Single codebase serves both frameworks
- **Easier maintenance**: Changes apply to both targets automatically
- **Modern features**: Can use .NET 8.0 features with conditional compilation when needed
- **Backward compatibility**: Supports legacy .NET Framework applications
- **Testing**: Both targets are tested in the same test projects
- **Single deployment**: One build produces both framework versions

### Negative Consequences

- **Increased build time**: Must build for both frameworks
- **API constraints**: Limited to APIs available in .NET Framework 4.8 (lowest common denominator)
- **Conditional compilation**: May need `#if` directives for framework-specific code
- **CI complexity**: Linux CI can only build net8.0, Windows CI needed for net48
- **Larger artifacts**: Produces binaries for both frameworks

### Platform-Specific Considerations

- **Windows**: Can build both net8.0 and net48
- **Linux/macOS**: Can only build net8.0 (net48 requires Windows)

## References

- [Multi-targeting documentation](https://learn.microsoft.com/en-us/dotnet/standard/frameworks)
- [CI Pipeline ADR](0001-local-first-ci-approach.md)
