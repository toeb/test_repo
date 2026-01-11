#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Build all TSP projects
.DESCRIPTION
    Builds all projects in the TSP solution. Can be run locally or in CI.
.PARAMETER Configuration
    Build configuration (Debug or Release). Default: Release
.PARAMETER Framework
    Target framework to build. If not specified, builds all target frameworks.
.EXAMPLE
    ./build.ps1
    ./build.ps1 -Configuration Debug
    ./build.ps1 -Framework net8.0
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [Parameter()]
    [string]$Framework = ''
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Get the repository root (two levels up from Infrastructure)
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$SourceRoot = Join-Path $RepoRoot 'src'
$SolutionFile = Join-Path $SourceRoot 'Tsp.slnx'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Building TSP Solution" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Repository Root: $RepoRoot"
Write-Host "Source Root: $SourceRoot"
Write-Host "Solution: $SolutionFile"
Write-Host "Configuration: $Configuration"
if ($Framework) {
    Write-Host "Framework: $Framework"
}
Write-Host ""

# Build arguments
$buildArgs = @(
    'build'
    $SolutionFile
    '--configuration', $Configuration
    '--verbosity', 'minimal'
)

if ($Framework) {
    $buildArgs += '--framework', $Framework
}

# Execute build
Write-Host "Executing: dotnet $($buildArgs -join ' ')" -ForegroundColor Yellow
& dotnet $buildArgs

if ($LASTEXITCODE -ne 0) {
    Write-Host "Build failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
