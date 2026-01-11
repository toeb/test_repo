#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Run full CI pipeline for TSP
.DESCRIPTION
    Executes the complete CI pipeline: restore, build, and test.
    This script is used both locally and in CI environments.
.PARAMETER Configuration
    Build configuration (Debug or Release). Default: Release
.PARAMETER Framework
    Target framework. If not specified, builds all target frameworks.
.PARAMETER SkipRestore
    Skip the restore step.
.PARAMETER SkipBuild
    Skip the build step.
.PARAMETER SkipTest
    Skip the test step.
.EXAMPLE
    ./ci.ps1
    ./ci.ps1 -Configuration Debug
    ./ci.ps1 -Framework net8.0
#>

[CmdletBinding()]
param(
    [Parameter()]
    [ValidateSet('Debug', 'Release')]
    [string]$Configuration = 'Release',

    [Parameter()]
    [string]$Framework = '',

    [Parameter()]
    [switch]$SkipRestore,

    [Parameter()]
    [switch]$SkipBuild,

    [Parameter()]
    [switch]$SkipTest
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$ScriptDir = $PSScriptRoot

Write-Host "================================================" -ForegroundColor Magenta
Write-Host "TSP CI Pipeline" -ForegroundColor Magenta
Write-Host "================================================" -ForegroundColor Magenta
Write-Host "Configuration: $Configuration"
if ($Framework) {
    Write-Host "Framework: $Framework"
}
Write-Host ""

$startTime = Get-Date

try {
    # Step 1: Restore
    if (-not $SkipRestore) {
        Write-Host ""
        Write-Host "STEP 1: Restore" -ForegroundColor Magenta
        Write-Host "-----------------------------------------------"
        & (Join-Path $ScriptDir 'restore.ps1')
        if ($LASTEXITCODE -ne 0) {
            throw "Restore failed"
        }
    }

    # Step 2: Build
    if (-not $SkipBuild) {
        Write-Host ""
        Write-Host "STEP 2: Build" -ForegroundColor Magenta
        Write-Host "-----------------------------------------------"
        $buildParams = @{
            Configuration = $Configuration
        }
        if ($Framework) {
            $buildParams.Framework = $Framework
        }
        & (Join-Path $ScriptDir 'build.ps1') @buildParams
        if ($LASTEXITCODE -ne 0) {
            throw "Build failed"
        }
    }

    # Step 3: Test
    if (-not $SkipTest) {
        Write-Host ""
        Write-Host "STEP 3: Test" -ForegroundColor Magenta
        Write-Host "-----------------------------------------------"
        $testParams = @{
            Configuration = $Configuration
            NoBuild = $true
        }
        if ($Framework) {
            $testParams.Framework = $Framework
        }
        & (Join-Path $ScriptDir 'test.ps1') @testParams
        if ($LASTEXITCODE -ne 0) {
            throw "Tests failed"
        }
    }

    $duration = (Get-Date) - $startTime
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Green
    Write-Host "CI Pipeline Completed Successfully!" -ForegroundColor Green
    Write-Host "Duration: $($duration.ToString('mm\:ss'))" -ForegroundColor Green
    Write-Host "================================================" -ForegroundColor Green
    exit 0
}
catch {
    $duration = (Get-Date) - $startTime
    Write-Host ""
    Write-Host "================================================" -ForegroundColor Red
    Write-Host "CI Pipeline Failed!" -ForegroundColor Red
    Write-Host "Error: $_" -ForegroundColor Red
    Write-Host "Duration: $($duration.ToString('mm\:ss'))" -ForegroundColor Red
    Write-Host "================================================" -ForegroundColor Red
    exit 1
}
