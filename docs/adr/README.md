# Architecture Decision Records (ADRs)

This directory contains Architecture Decision Records (ADRs) for the Toeb Software Platform.

## What is an ADR?

An Architecture Decision Record (ADR) captures an important architectural decision made along with its context and consequences.

## ADR Index

- [ADR-0000](0000-template.md) - ADR Template
- [ADR-0001](0001-local-first-ci-approach.md) - Local-First CI Approach
- [ADR-0002](0002-multi-targeting-dotnet.md) - Multi-Targeting .NET Frameworks
- [ADR-0003](0003-flat-source-structure.md) - Flat Source Directory Structure
- [ADR-0004](0004-powershell-build-scripts.md) - PowerShell 7 for Build Automation
- [ADR-0005](0005-slnx-solution-format.md) - XML-Based Solution Format (.slnx)

## Creating a New ADR

1. Copy the template: `cp 0000-template.md XXXX-your-title.md`
2. Fill in the sections with your decision
3. Add it to the index above
4. Commit with a clear message

## ADR Lifecycle

- **Proposed**: Under discussion
- **Accepted**: Approved and active
- **Deprecated**: No longer recommended
- **Superseded**: Replaced by a newer ADR

## Principles

- ADRs are **immutable** once accepted
- To change a decision, create a new ADR that supersedes the old one
- Keep ADRs concise and focused on one decision
- Document the **why**, not just the **what**
