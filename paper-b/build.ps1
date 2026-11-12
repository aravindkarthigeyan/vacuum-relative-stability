$ErrorActionPreference = 'Stop'
$taskCompiler = Get-Command pdflatex -ErrorAction Stop
Push-Location -LiteralPath $PSScriptRoot
try {
    New-Item -ItemType Directory -Path 'build' -Force | Out-Null
    for ($taskPass = 1; $taskPass -le 3; $taskPass++) {
        & $taskCompiler.Source --disable-installer -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build -jobname=paper-b-momentum main.tex
        if ($LASTEXITCODE -ne 0) { throw "Compilation failed on pass $taskPass." }
    }
    Copy-Item -LiteralPath 'build/paper-b-momentum.pdf' -Destination 'paper-b-momentum.pdf' -Force
    Write-Output (Join-Path $PSScriptRoot 'paper-b-momentum.pdf')
}
finally { Pop-Location }
