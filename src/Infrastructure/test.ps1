#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Run all TSP tests
.DESCRIPTION
    Runs all test projects in the TSP solution. Can be run locally or in CI.
.PARAMETER Configuration
    Build configuration (Debug or Release). Default: Release
.PARAMETER Framework
    Target framework to test. If not specified, tests all target frameworks.
.PARAMETER NoBuild
    Skip building the projects before testing.
.PARAMETER Collect
    Enable code coverage collection.
.EXAMPLE
    ./test.ps1
    ./test.ps1 -Configuration Debug
    ./test.ps1 -Framework net8.0 -Collect
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [Parameter()]
    [string]$Framework = '',

    [Parameter()]
    [switch]$NoBuild,

    [Parameter()]
    [switch]$Collect
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Get the repository root (two levels up from Infrastructure)
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$SourceRoot = Join-Path $RepoRoot 'src'
$SolutionFile = Join-Path $SourceRoot 'Tsp.slnx'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Running TSP Tests" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Repository Root: $RepoRoot"
Write-Host "Source Root: $SourceRoot"
Write-Host "Solution: $SolutionFile"
Write-Host "Configuration: $Configuration"
if ($Framework) {
    Write-Host "Framework: $Framework"
}
Write-Host ""

# Test arguments
$testArgs = @(
    'test'
    $SolutionFile
    '--configuration', $Configuration
    '--verbosity', 'normal'
    '--logger', 'trx'
)

if ($NoBuild) {
    $testArgs += '--no-build'
}

if ($Framework) {
    $testArgs += '--framework', $Framework
}

if ($Collect) {
    $testArgs += '--collect:XPlat Code Coverage'
}

# Execute tests
Write-Host "Executing: dotnet $($testArgs -join ' ')" -ForegroundColor Yellow
& dotnet $testArgs

if ($LASTEXITCODE -ne 0) {
    Write-Host "Tests failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "All tests passed!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
