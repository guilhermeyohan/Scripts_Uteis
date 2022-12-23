#!/bin/bash

#Shell script de bkp zipado. Você pode automatizar essa função no crontab.

$1="CAMINHO DA PASTA DE ORIGEM"
$2="CAMINNHO DA PASTA DE DESTINO"
rsync -av --delay-updates "$1" "$2"
zip -r "$2/backup.zip" "$2"


#Lembre-se de dar permissão de execução para o script com o comando chmod +x /path/to/script.sh.

