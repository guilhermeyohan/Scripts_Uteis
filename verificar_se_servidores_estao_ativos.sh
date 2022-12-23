#!/bin/bash

# Esse scritp verifica se os seus servidores estão ativos ou não. Caso qualquer um deles fique offline você ouvirá um alarme no seu computador e em seguida receberá um email avisando. Vale lembrar que pra que isso dê certo, você precisa ter um speaker instalado no seu hardware (obviamente) e você também precisa configurar as informações de autenticação e configuração do seu servidor de e-mail

# Antes de tudo, pequeno gafanhoto, instale o apt de beep no seu computador com o comando "sudo apt install beep" e instale tbm o repositorio de email "sudo apt install mailutils"
# Depois disso, so definir no crontab os horarios que você quer que isso rode.


# Definir aqui seu email
seu_email=teste@teste.com.br

# Definir aqui local do log
caminho_do_log=etc/***

# Definir aqui os endereços dos servidores
server_a=192.168.0.1
server_b=192.168.0.2
server_c=192.168.0.3

#Daqui pra baixo, não mude nada.

# Realizar o ping nos servidores
ping -c 3 $server_a &> /dev/null
if [ $? -eq 0 ]
then
  echo "Servidor A respondeu" >> $caminho_do_log/log.txt
else
  echo "Servidor A não respondeu" >> $caminho_do_log/log.txt
  beep -f 500 -l 500 -r 4
  echo "O servidor A não respondeu ao ping" | mail -s "Erro no servidor A" $seu_email
fi

ping -c 3 $server_b &> /dev/null
if [ $? -eq 0 ]
then
  echo "Servidor B respondeu" >> $caminho_do_log/log.txt
else
  echo "Servidor B não respondeu" >> $caminho_do_log/log.txt
  beep -f 500 -l 500 -r 4
  echo "O servidor B não respondeu ao ping" | mail -s "Erro no servidor B" $seu_email
fi

ping -c 3 $server_c &> /dev/null
if [ $? -eq 0 ]
then
  echo "Servidor C respondeu" >> $caminho_do_log/log.txt
else
  echo "Servidor C não respondeu" >> log.txt
  beep -f 500 -l 500 -r 4
  echo "O servidor C não respondeu ao ping" | mail -s "Erro no servidor C" $seu_email
fi

