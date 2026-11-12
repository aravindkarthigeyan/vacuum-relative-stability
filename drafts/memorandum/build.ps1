$ErrorActionPreference = 'Stop'
$taskCompiler = Get-Command pdflatex -ErrorAction Stop
Push-Location -LiteralPath $PSScriptRoot
try {
    New-Item -ItemType Directory -Path 'build' -Force | Out-Null
    for ($taskPass = 1; $taskPass -le 3; $taskPass++) {
        & $taskCompiler.Source --disable-installer -interaction=nonstopmode -halt-on-error -file-line-error -output-directory=build -jobname=stability-qed-paper main.tex
        if ($LASTEXITCODE -ne 0) {
            throw "LaTeX compilation failed on pass $taskPass. See build/stability-qed-paper.log."
        }
    }
    Copy-Item -LiteralPath 'build/stability-qed-paper.pdf' -Destination 'stability-qed-paper.pdf' -Force
    Write-Output (Join-Path $PSScriptRoot 'stability-qed-paper.pdf')
}
finally {
    Pop-Location
}
