#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Restore NuGet packages for TSP projects
.DESCRIPTION
    Restores all NuGet package dependencies for the TSP solution. Can be run locally or in CI.
.PARAMETER Force
    Force restore even if packages are already restored.
.EXAMPLE
    ./restore.ps1
    ./restore.ps1 -Force
#>

[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Force
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Get the repository root (two levels up from Infrastructure)
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$SourceRoot = Join-Path $RepoRoot 'src'
$SolutionFile = Join-Path $SourceRoot 'Tsp.slnx'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Restoring TSP Packages" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Repository Root: $RepoRoot"
Write-Host "Source Root: $SourceRoot"
Write-Host "Solution: $SolutionFile"
Write-Host ""

# Restore arguments
$restoreArgs = @(
    'restore'
    $SolutionFile
    '--verbosity', 'minimal'
)

if ($Force) {
    $restoreArgs += '--force'
    Write-Host "Force restore enabled" -ForegroundColor Yellow
}

# Execute restore
Write-Host "Executing: dotnet $($restoreArgs -join ' ')" -ForegroundColor Yellow
& dotnet $restoreArgs

if ($LASTEXITCODE -ne 0) {
    Write-Host "Restore failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "Restore completed successfully!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
