#!/bin/bash

#  PT-BR - Esse script usa o tcpdump para capturar 1000 pacotes da rede e armazena os resultados em um arquivo temporário. Em seguida, o awk é usado para processar os dados e verificar se há algum tráfego anormal. Se houver, um alerta é enviado por email para o endereço especificado. Por fim, o arquivo temporário é removido.
#  EN-US - This script uses tcpdump to capture 1000 packets from the network and stores the results in a temporary file. Then awk is used to process the data and check for any abnormal traffic. If so, an alert is emailed to the specified address. Finally, the temporary file is removed.



# Defina o endereço de email para o qual o alerta será enviado
# set the email address to which the alert will be sent
EMAIL_ADDRESS="teste@teste.com"

# Usa o tcpdump para capturar pacotes da rede e armazena os resultados em um arquivo temporário
# here, the tcpdump to capture packets from the network and store the results in a temporary file
tcpdump -n -c 1000 > /tmp/packets.txt

# Utiliza o awk para processar os dados e verificar se há algum tráfego anormal
# now awk to process the data and check for any abnormal traffic
if awk '{ print $5 }' /tmp/packets.txt | sort | uniq -c | sort -n | tail -n 1 | grep -q "1000"
then
  # Se houver tráfego anormal, envia um alerta por email
  # If there is abnormal traffic, send an alert by email
  echo "Tráfego anormal detectado na rede!" | mail -s "Alerta de tráfego anormal" $EMAIL_ADDRESS
fi

# Remove o arquivo temporário
# Remove the temp file
rm /tmp/packets.txt