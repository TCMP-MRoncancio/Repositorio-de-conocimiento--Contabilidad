# Sube este banco de conocimiento a un repositorio PRIVADO de GitHub (Windows).
# Uso: clic derecho > "Ejecutar con PowerShell", o:  .\subir.ps1 [nombre-del-repo]
param([string]$Repo = "banco-instrumentos-financieros")
$ErrorActionPreference = "Stop"
Set-Location $PSScriptRoot
if (-not (Get-Command git -ErrorAction SilentlyContinue)) { Write-Host "Instala Git: https://git-scm.com/downloads"; exit 1 }
if (-not (Test-Path .git)) { git init -b main }
git add .
git commit -m "Banco de conocimiento v1"
$gh = Get-Command gh -ErrorAction SilentlyContinue
if ($gh) { gh auth status 2>$null; $ok = ($LASTEXITCODE -eq 0) } else { $ok = $false }
if ($ok) {
  gh repo create $Repo --private --source . --push
} else {
  Write-Host "Crea un repositorio PRIVADO vacio en https://github.com/new llamado $Repo"
  $Url = Read-Host "Pega aqui su URL (https://github.com/usuario/$Repo.git)"
  git remote remove origin 2>$null
  git remote add origin $Url
  git push -u origin main
}
Write-Host "Listo."
