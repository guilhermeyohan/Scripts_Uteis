/* Esse script seleciona todas as consultas que estão levando mais tempo que o limite definido na variável @slow_query_time. A visualização INFORMATION_SCHEMA.PROCESSLIST contém informações como
 o ID do processo, o usuário, o host, o banco de dados, o comando em execução, 
 o tempo de execução e o estado atual da consulta.
 
 
 Para usar esse script, basta definir o limite de tempo em segundos para considerar uma consulta lenta na variável @slow_query_time e executá-lo na sua conexão MySQL.
 Ele retornará todas as consultas que estão levando mais tempo que o limite especificado.
 
 
 vale lembrar que, este NÃO MOSTRA todos os problemas do banco.
 
 ************** EXECUTE PRIMEIRO NO SEU BANCO DE TESTES ************** 
 */


SET @slow_query_time = 5;

/* Seleciona as consultas que estão levando mais tempo que o limite definido*/
SELECT
  id,
  user,
  host,
  db,
  command,
  time,
  state,
  info
FROM INFORMATION_SCHEMA.PROCESSLIST
WHERE time > @slow_query_time;
