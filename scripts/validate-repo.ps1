#!/usr/bin/env pwsh

$ErrorActionPreference = "Stop"
Set-StrictMode -Version 3

$RepoRoot = Split-Path -Parent $PSScriptRoot

$ExpectedSkills = @(
  "front-comments",
  "front-a11y",
  "front-review",
  "front-refactor"
)

$ExpectedLogos = @(
  "assets/logos/logo-frontend-skills-300.png",
  "assets/logos/logo-frontend-skills-a11y-300.png",
  "assets/logos/logo-frontend-skills-comments-300.png",
  "assets/logos/logo-frontend-skills-refactor-300.png",
  "assets/logos/logo-frontend-skills-review-300.png"
)

$Errors = New-Object System.Collections.Generic.List[string]

function Add-Failure {
  param([string]$Message)

  $Errors.Add($Message) | Out-Null
  Write-Host "[FAIL] $Message" -ForegroundColor Red
}

function Add-Success {
  param([string]$Message)

  Write-Host "[ OK ] $Message" -ForegroundColor Green
}

function Test-RelativePath {
  param(
    [string]$RelativePath,
    [string]$Label
  )

  $FullPath = Join-Path $RepoRoot $RelativePath
  if (Test-Path -LiteralPath $FullPath) {
    Add-Success "$Label exists ($RelativePath)"
    return $true
  }

  Add-Failure "$Label is missing ($RelativePath)"
  return $false
}

function Get-InstallSkillListFromPowerShell {
  $Content = Get-Content -LiteralPath (Join-Path $RepoRoot "install.ps1") -Raw
  $Match = [regex]::Match($Content, '\$Available\s*=\s*@\((?<items>[^)]*)\)')

  if (-not $Match.Success) {
    Add-Failure "Unable to parse skill list from install.ps1"
    return @()
  }

  return [regex]::Matches($Match.Groups["items"].Value, '"([^"]+)"') |
    ForEach-Object { $_.Groups[1].Value }
}

function Get-InstallSkillListFromBash {
  $Content = Get-Content -LiteralPath (Join-Path $RepoRoot "install.sh") -Raw
  $Match = [regex]::Match($Content, 'AVAILABLE=\((?<items>[^)]*)\)')

  if (-not $Match.Success) {
    Add-Failure "Unable to parse skill list from install.sh"
    return @()
  }

  return [regex]::Matches($Match.Groups["items"].Value, '[A-Za-z0-9-]+') |
    ForEach-Object { $_.Value }
}

function Compare-NameLists {
  param(
    [string]$Label,
    [string[]]$Actual,
    [string[]]$Expected
  )

  $Diff = Compare-Object -ReferenceObject ($Expected | Sort-Object) -DifferenceObject ($Actual | Sort-Object)
  if ($null -eq $Diff) {
    Add-Success "$Label matches the expected skill list"
    return
  }

  $DiffText = ($Diff | ForEach-Object { "$($_.InputObject) [$($_.SideIndicator)]" }) -join ", "
  Add-Failure "$Label does not match the expected skill list: $DiffText"
}

function Get-DocumentedExamples {
  param([string]$ReadmeRelativePath)

  $ReadmePath = Join-Path $RepoRoot $ReadmeRelativePath
  $Lines = Get-Content -LiteralPath $ReadmePath
  $Examples = New-Object System.Collections.Generic.List[string]

  $Anchor = "Current examples included in this repository:"
  $StartIndex = [Array]::IndexOf($Lines, $Anchor)
  if ($StartIndex -lt 0) {
    Add-Failure "Missing documented examples section in $ReadmeRelativePath"
    return @()
  }

  for ($i = $StartIndex + 1; $i -lt $Lines.Count; $i++) {
    $Line = $Lines[$i].Trim()

    if ($Line -eq "---") {
      break
    }

    if (-not $Line.StartsWith("|")) {
      continue
    }

    if ($Line -match '^\|\s*-') {
      continue
    }

    foreach ($Match in [regex]::Matches($Line, '`([^`]+)`')) {
      $Examples.Add($Match.Groups[1].Value) | Out-Null
    }
  }

  if ($Examples.Count -eq 0) {
    Add-Failure "No example files were parsed from $ReadmeRelativePath"
    return @()
  }

  Add-Success "Parsed $($Examples.Count) documented example file(s) from $ReadmeRelativePath"
  return $Examples
}

function Test-DocumentedExamples {
  param([string]$SkillName)

  $ReadmeRelativePath = "$SkillName/README.md"
  $ExamplesDir = Join-Path $RepoRoot "$SkillName/examples"
  $DocumentedExamples = Get-DocumentedExamples -ReadmeRelativePath $ReadmeRelativePath

  foreach ($ExampleName in $DocumentedExamples) {
    $Matches = @(Get-ChildItem -LiteralPath $ExamplesDir -Recurse -File | Where-Object { $_.Name -eq $ExampleName })
    if ($Matches.Count -ge 1) {
      Add-Success "Documented example exists for $SkillName ($ExampleName)"
    }
    else {
      Add-Failure "Documented example is missing for $SkillName ($ExampleName)"
    }
  }
}

Write-Host "Validating repository structure..." -ForegroundColor Cyan

foreach ($Skill in $ExpectedSkills) {
  if (Test-RelativePath -RelativePath $Skill -Label "Skill directory $Skill") {
    Test-RelativePath -RelativePath "$Skill/SKILL.md" -Label "$Skill SKILL.md" | Out-Null
    Test-RelativePath -RelativePath "$Skill/README.md" -Label "$Skill README.md" | Out-Null

    $ExamplesDir = Join-Path $RepoRoot "$Skill/examples"
    if (Test-Path -LiteralPath $ExamplesDir -PathType Container) {
      $ExampleFiles = Get-ChildItem -LiteralPath $ExamplesDir -Recurse -File
      if ($ExampleFiles.Count -ge 2) {
        Add-Success "$Skill examples directory contains $($ExampleFiles.Count) file(s)"
      }
      else {
        Add-Failure "$Skill examples directory should contain at least 2 files"
      }
    }
    else {
      Add-Failure "$Skill examples directory is missing ($Skill/examples)"
    }
  }
}

Write-Host ""
Write-Host "Validating install scripts..." -ForegroundColor Cyan

$PowerShellSkillList = Get-InstallSkillListFromPowerShell
$BashSkillList = Get-InstallSkillListFromBash

Compare-NameLists -Label "install.ps1" -Actual $PowerShellSkillList -Expected $ExpectedSkills
Compare-NameLists -Label "install.sh" -Actual $BashSkillList -Expected $ExpectedSkills

Write-Host ""
Write-Host "Validating documented examples..." -ForegroundColor Cyan

foreach ($Skill in $ExpectedSkills) {
  Test-DocumentedExamples -SkillName $Skill
}

Write-Host ""
Write-Host "Validating local logos..." -ForegroundColor Cyan

foreach ($Logo in $ExpectedLogos) {
  Test-RelativePath -RelativePath $Logo -Label "Logo asset" | Out-Null
}

Write-Host ""
Write-Host "Checking for forbidden hotlinked logos..." -ForegroundColor Cyan

$MarkdownFiles = Get-ChildItem -LiteralPath $RepoRoot -Recurse -File -Include *.md
$HotlinkMatches = Select-String -Path $MarkdownFiles.FullName -Pattern 'https://browserux\.com/(img/logos|commons)/'

if ($null -eq $HotlinkMatches) {
  Add-Success "No external browserux.com logo hotlinks remain in Markdown files"
}
else {
  foreach ($Match in $HotlinkMatches) {
    Add-Failure "External logo hotlink found in $($Match.Path):$($Match.LineNumber)"
  }
}

Write-Host ""
if ($Errors.Count -eq 0) {
  Write-Host "Repository validation passed." -ForegroundColor Green
  exit 0
}

Write-Host "Repository validation failed with $($Errors.Count) issue(s)." -ForegroundColor Red
exit 1
