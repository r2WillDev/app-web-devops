#!/bin/bash

echo "Iniciando teste automatizado da aplicação..."

ARQUIVOS_OBRIGATORIOS=(
  "index.html"
  "style.css"
  "script.js"
  "Dockerfile"
  "Jenkinsfile"
)

for arquivo in "${ARQUIVOS_OBRIGATORIOS[@]}"; do
  if [ ! -f "$arquivo" ]; then
    echo "ERRO: arquivo obrigatório não encontrado: $arquivo"
    exit 1
  fi

  echo "OK: arquivo encontrado: $arquivo"
done

echo "Todos os arquivos obrigatórios foram encontrados."
echo "Teste automatizado concluído com sucesso."

exit 0
