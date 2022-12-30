#!/bin/bash

#  PT-BR - Esse script usa o tcpdump para capturar 1000 pacotes da rede e armazena os resultados em um arquivo temporário. Em seguida, o awk é usado para processar os dados e verificar se há algum tráfego anormal. Se houver, um alerta é enviado por email para o endereço especificado. Por fim, o arquivo temporário é removido.
#  EN-US - This script uses tcpdump to capture 1000 packets from the network and stores the results in a temporary file. Then awk is used to process the data and check for any abnormal traffic. If so, an alert is emailed to the specified address. Finally, the temporary file is removed.

EMAIL_ADDRESS="teste@teste.com"
tcpdump -n -c 1000 > /tmp/packets.txt
if awk '{ print $5 }' /tmp/packets.txt | sort | uniq -c | sort -n | tail -n 1 | grep -q "1000"
then
  echo "Tráfego anormal detectado na rede!" | mail -s "Alerta de tráfego anormal" $EMAIL_ADDRESS
fi
rm /tmp/packets.tx
