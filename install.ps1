#!/usr/bin/env pwsh
param(
  [Parameter(Mandatory = $true, Position = 0)]
  [string]$Target,
  [switch]$Force
)

$ErrorActionPreference = "Stop"

$SkillsDir = Join-Path $HOME ".claude\skills"
$RepoDir   = $PSScriptRoot
$Available = @("front-comments", "front-a11y", "front-review", "front-refactor")

function Show-Usage {
  Write-Host "Usage: .\install.ps1 <skill-name|all> [-Force]"
  Write-Host ""
  Write-Host "Available skills:"
  foreach ($s in $Available) {
    Write-Host "  - $s"
  }
  Write-Host ""
  Write-Host "Examples:"
  Write-Host "  .\install.ps1 all"
  Write-Host "  .\install.ps1 front-a11y"
  Write-Host "  .\install.ps1 front-review -Force"
  exit 1
}

function Install-Skill {
  param(
    [string]$Skill,
    [bool]$ForceOverwrite
  )

  $src  = Join-Path $RepoDir $Skill
  $dest = Join-Path $SkillsDir $Skill

  if (-not (Test-Path $src)) {
    Write-Host "Error: skill '$Skill' not found in $RepoDir" -ForegroundColor Red
    return
  }

  if ((Test-Path $dest) -and (-not $ForceOverwrite)) {
    Write-Host "Skipped: $Skill (already installed, use -Force to overwrite)" -ForegroundColor Yellow
    return
  }

  New-Item -ItemType Directory -Force -Path $dest | Out-Null
  Get-ChildItem -Path $src -Filter "*.md" | Where-Object {
    $_.Name -ne "README.md" -and $_.Name -ne "CHANGELOG.md"
  } | ForEach-Object {
    Copy-Item -Path $_.FullName -Destination $dest -Force
  }

  Write-Host "Installed: $Skill -> $dest" -ForegroundColor Green
}

New-Item -ItemType Directory -Force -Path $SkillsDir | Out-Null

if ($Target -eq "all") {
  foreach ($skill in $Available) {
    Install-Skill -Skill $skill -ForceOverwrite:$Force
  }
}
elseif ($Available -contains $Target) {
  Install-Skill -Skill $Target -ForceOverwrite:$Force
}
else {
  Write-Host "Error: unknown skill '$Target'" -ForegroundColor Red
  Write-Host ""
  Show-Usage
}

Write-Host ""
Write-Host "Done. Skills are now available in $SkillsDir"
