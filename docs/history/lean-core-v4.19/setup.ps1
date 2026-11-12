$ErrorActionPreference = 'Stop'
$taskRoot = $PSScriptRoot
$leanRoot = Join-Path $taskRoot 'tools/lean-4.19.0-windows'
$mathlibRoot = Join-Path $taskRoot 'vendor/mathlib'
$expectedMathlib = 'c44e0c8ee63ca166450922a373c7409c5d26b00b'
$expectedLeanHash = 'CF2EAB6EB2A688D07BACDFA7FB60751D93F959ACA04865EE5656523F6E885C8B'
New-Item -ItemType Directory -Force -Path (Join-Path $taskRoot 'tools'),(Join-Path $taskRoot 'vendor'),(Join-Path $taskRoot 'logs') | Out-Null
if (-not (Test-Path -LiteralPath (Join-Path $leanRoot 'bin/lean.exe'))) {
    $archive = Join-Path $taskRoot 'tools/lean-4.19.0-windows.tar.zst'
    & curl.exe -L --fail --retry 2 -o $archive 'https://github.com/leanprover/lean4/releases/download/v4.19.0/lean-4.19.0-windows.tar.zst'
    if ($LASTEXITCODE -ne 0) { throw 'Lean download failed' }
    if ((Get-FileHash -LiteralPath $archive -Algorithm SHA256).Hash -ne $expectedLeanHash) {
        throw 'Lean archive SHA256 mismatch'
    }
    & tar.exe -xf $archive -C (Join-Path $taskRoot 'tools')
    if ($LASTEXITCODE -ne 0) { throw 'Lean extraction failed' }
}
if (-not (Test-Path -LiteralPath (Join-Path $mathlibRoot '.git'))) {
    & git -c core.longpaths=true clone --depth 1 --branch v4.19.0 'https://github.com/leanprover-community/mathlib4.git' $mathlibRoot
    if ($LASTEXITCODE -ne 0) { throw 'mathlib clone failed' }
}
$mathlibCommit = (& git -C $mathlibRoot rev-parse HEAD).Trim()
if ($mathlibCommit -ne $expectedMathlib) { throw "Unexpected mathlib revision: $mathlibCommit" }
$env:PATH = (Join-Path $leanRoot 'bin') + [IO.Path]::PathSeparator + $env:PATH
$env:MATHLIB_CACHE_DIR = Join-Path $taskRoot '.cache/mathlib'
Push-Location $taskRoot
try {
    & lean.exe --version
    & lake.exe update 2>&1 | Tee-Object -FilePath (Join-Path $taskRoot 'logs/setup.log')
    if ($LASTEXITCODE -ne 0) { throw 'lake update failed' }
    & lake.exe exe cache get 2>&1 | Tee-Object -FilePath (Join-Path $taskRoot 'logs/cache.log')
    if ($LASTEXITCODE -ne 0) { throw 'mathlib cache download failed' }
    $expectedDeps = Get-Content -LiteralPath (Join-Path $taskRoot 'dependencies.json') -Raw | ConvertFrom-Json
    $actualDeps = (Get-Content -LiteralPath (Join-Path $taskRoot 'lake-manifest.json') -Raw | ConvertFrom-Json).packages
    foreach ($dep in $expectedDeps) {
        $actualDep = $actualDeps | Where-Object { $_.name -eq $dep.name }
        if ($actualDep.rev -ne $dep.rev) { throw "Dependency revision mismatch: $($dep.name)" }
    }
} finally { Pop-Location }
