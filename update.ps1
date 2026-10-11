# Copies ForeverExercise into the WoW Forever AddOns folder.
# Change $wow if the game is installed somewhere else.
$ErrorActionPreference = 'Stop'

$src = Join-Path $PSScriptRoot 'ForeverExercise'
$wow = 'C:\Program Files (x86)\World of Warcraft\_classic_beta_\Interface\AddOns'
$dest = Join-Path $wow 'ForeverExercise'

if (-not (Test-Path (Join-Path $src 'ForeverExercise.toc'))) {
    throw "Addon folder not found: $src"
}
if (-not (Test-Path $wow)) {
    throw "WoW Forever AddOns folder not found: $wow"
}

# Remove-Item on a junction can delete the repo it points at. rmdir removes only the link.
$existing = Get-Item -LiteralPath $dest -Force -ErrorAction SilentlyContinue
if ($existing -and $existing.LinkType) {
    cmd /c "rmdir `"$dest`""
    if ($LASTEXITCODE -ne 0) { throw "Could not remove the old link at $dest" }
}

# 0 and 1 mean nothing to copy or files copied. 8 and above are failures.
robocopy $src $dest /MIR /NFL /NDL /NJH /NJS /nc /ns /np
if ($LASTEXITCODE -ge 8) { throw "Copy failed (robocopy $LASTEXITCODE)" }

Write-Host "Updated $dest"
exit 0
