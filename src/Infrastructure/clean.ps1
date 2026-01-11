#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Clean all TSP build artifacts
.DESCRIPTION
    Cleans all build output, bin, obj directories from the TSP solution. Can be run locally or in CI.
.PARAMETER Deep
    Performs a deep clean including NuGet packages cache and test results.
.EXAMPLE
    ./clean.ps1
    ./clean.ps1 -Deep
#>

[CmdletBinding()]
param(
    [Parameter()]
    [switch]$Deep
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

# Get the repository root (two levels up from Infrastructure)
$RepoRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$SourceRoot = Join-Path $RepoRoot 'src'
$SolutionFile = Join-Path $SourceRoot 'Tsp.slnx'

Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Cleaning TSP Solution" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "Repository Root: $RepoRoot"
Write-Host "Source Root: $SourceRoot"
Write-Host "Solution: $SolutionFile"
if ($Deep) {
    Write-Host "Mode: Deep Clean" -ForegroundColor Yellow
}
Write-Host ""

# Clean using dotnet
Write-Host "Running: dotnet clean" -ForegroundColor Yellow
& dotnet clean $SolutionFile --verbosity minimal

if ($LASTEXITCODE -ne 0) {
    Write-Host "Clean failed with exit code $LASTEXITCODE" -ForegroundColor Red
    exit $LASTEXITCODE
}

# Remove bin and obj directories
Write-Host "Removing bin and obj directories..." -ForegroundColor Yellow
Get-ChildItem -Path $SourceRoot -Recurse -Directory -Filter 'bin' | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
Get-ChildItem -Path $SourceRoot -Recurse -Directory -Filter 'obj' | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

# Remove TestResults directories
Write-Host "Removing TestResults directories..." -ForegroundColor Yellow
Get-ChildItem -Path $SourceRoot -Recurse -Directory -Filter 'TestResults' | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue

if ($Deep) {
    Write-Host "Performing deep clean..." -ForegroundColor Yellow

    # Clear NuGet cache
    Write-Host "Clearing NuGet cache..." -ForegroundColor Yellow
    & dotnet nuget locals all --clear

    # Remove packages directories
    Write-Host "Removing packages directories..." -ForegroundColor Yellow
    Get-ChildItem -Path $SourceRoot -Recurse -Directory -Filter 'packages' | Remove-Item -Recurse -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "================================================" -ForegroundColor Green
Write-Host "Clean completed successfully!" -ForegroundColor Green
Write-Host "================================================" -ForegroundColor Green
