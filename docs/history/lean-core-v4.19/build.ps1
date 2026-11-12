$ErrorActionPreference = 'Stop'
$taskRoot = $PSScriptRoot
$leanBin = Join-Path $taskRoot 'tools/lean-4.19.0-windows/bin'
$env:PATH = $leanBin + [IO.Path]::PathSeparator + $env:PATH
$env:MATHLIB_CACHE_DIR = Join-Path $taskRoot '.cache/mathlib'
Push-Location $taskRoot
try {
    & lake.exe build 2>&1 | Tee-Object -FilePath (Join-Path $taskRoot 'logs/build.log')
    if ($LASTEXITCODE -ne 0) { throw 'Lean build failed' }
    & lake.exe env lean.exe Audit.lean 2>&1 | Tee-Object -FilePath (Join-Path $taskRoot 'logs/axioms.log')
    if ($LASTEXITCODE -ne 0) { throw 'Lean axiom audit failed' }
    $auditText = Get-Content -LiteralPath (Join-Path $taskRoot 'logs/axioms.log') -Raw
    if ($auditText -match 'sorryAx') { throw 'Unfinished proof detected by axiom audit' }
    foreach ($match in [regex]::Matches($auditText, 'depends on axioms: \[([^\]]*)\]')) {
        foreach ($axiomName in ($match.Groups[1].Value -split ',')) {
            if ($axiomName.Trim() -notin @('propext','Classical.choice','Quot.sound')) {
                throw "Unexpected axiom in completed theorem: $axiomName"
            }
        }
    }
} finally { Pop-Location }
