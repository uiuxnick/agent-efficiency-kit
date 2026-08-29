param(
  [Parameter(Mandatory=$true)]
  [ValidateSet('all','claude','codex','opencode','antigravity')]
  [string]$Platform,
  [Parameter(Mandatory=$true)]
  [string]$Target
)

$ErrorActionPreference = 'Stop'
$Target = (Resolve-Path $Target).Path
$Root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$Marker = 'AGENT-CONTEXT-OPTIMIZER'

function Add-InstructionBlock([string]$Source, [string]$Destination) {
  if (Test-Path $Destination) {
    $existing = Get-Content $Destination -Raw
    if ($existing.Contains($Marker)) {
      Write-Host "Already installed in $Destination"
      return
    }
    $backup = "$Destination.bak.$(Get-Date -Format yyyyMMddHHmmss)"
    Copy-Item $Destination $backup
    Add-Content $Destination "`n`n<!-- $Marker -->`n"
    Get-Content $Source -Raw | Add-Content $Destination
    Add-Content $Destination "`n<!-- /$Marker -->`n"
    Write-Host "Merged into $Destination (backup: $backup)"
  } else {
    Copy-Item $Source $Destination
    Write-Host "Created $Destination"
  }
}

if ($Platform -in @('all','claude')) {
  Add-InstructionBlock (Join-Path $Root 'adapters/claude/CLAUDE.md') (Join-Path $Target 'CLAUDE.md')
}

if ($Platform -in @('all','codex','opencode')) {
  $source = Join-Path $Root 'adapters/codex/AGENTS.md'
  if ($Platform -eq 'opencode') { $source = Join-Path $Root 'adapters/opencode/AGENTS.md' }
  Add-InstructionBlock $source (Join-Path $Target 'AGENTS.md')
}

if ($Platform -in @('all','antigravity')) {
  $ruleDir = Join-Path $Target '.agents/rules'
  New-Item -ItemType Directory -Force -Path $ruleDir | Out-Null
  Copy-Item (Join-Path $Root 'adapters/antigravity/production-context-discipline.md') (Join-Path $ruleDir 'production-context-discipline.md') -Force
  Write-Host 'Installed Antigravity workspace rule'
}

$memoryDir = Join-Path $Target '.agent-memory'
New-Item -ItemType Directory -Force -Path $memoryDir | Out-Null
foreach ($file in @('PROJECT_MAP.md','TASK_STATE.md','HANDOFF.md')) {
  $dest = Join-Path $memoryDir $file
  if (-not (Test-Path $dest)) {
    Copy-Item (Join-Path $Root "templates/memory/$file") $dest
  }
}

$gitignore = Join-Path $Target '.gitignore'
if (-not (Test-Path $gitignore)) { New-Item -ItemType File $gitignore | Out-Null }
$content = Get-Content $gitignore -Raw
if (-not $content.Contains('.agent-memory/')) {
  Add-Content $gitignore "`n# Local AI coding task state`n.agent-memory/`n"
}

Write-Host "`nAgent Context Optimizer installed for: $Platform"
Write-Host "Target: $Target"
