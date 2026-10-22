#!/usr/bin/env bash
# Sube este banco de conocimiento a un repositorio PRIVADO de GitHub.
# Uso: ./subir.sh [nombre-del-repo]
set -e
REPO="${1:-banco-instrumentos-financieros}"
cd "$(dirname "$0")"
command -v git >/dev/null || { echo "Instala Git: https://git-scm.com/downloads"; exit 1; }
[ -d .git ] || git init -b main
git add .
git commit -m "Banco de conocimiento v1" || true
if command -v gh >/dev/null && gh auth status >/dev/null 2>&1; then
  gh repo create "$REPO" --private --source . --push
else
  echo "Crea un repositorio PRIVADO vacío en https://github.com/new llamado $REPO"
  read -rp "Pega aquí su URL (https://github.com/usuario/$REPO.git): " URL
  git remote add origin "$URL" 2>/dev/null || git remote set-url origin "$URL"
  git push -u origin main
fi
echo "Listo."
