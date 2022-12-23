#!/bin/bash

#PT-BR Shell script de bkp zipado. Você pode automatizar essa função no crontab.
#EN-US Backup shell script with zip. You can automate this function in crontab.

$1="CAMINHO DA PASTA DE ORIGEM"
$2="CAMINNHO DA PASTA DE DESTINO"
rsync -av --delay-updates "$1" "$2"
zip -r "$2/backup.zip" "$2"


#PT-BR Lembre-se de dar permissão de execução para o script com o comando chmod +x /path/to/script.sh.
#EN-US Remember to give execute permission to the script with the command chmod +x /path/to/script.sh.

