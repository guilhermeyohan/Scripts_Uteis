<!-- HTML para a interface da calculadora -->
<form method="post">
  <input type="text" name="input" value="<?php echo $input; ?>">
  <input type="submit" name="calculate" value="Calcular">
</form>

<!-- PHP para fazer os cálculos -->
<?php
if (isset($_POST['calculate'])) {
  // Obter a entrada do usuário
  $input = $_POST['input'];
  
  // Executar os cálculos e armazenar o resultado em uma variável
  $result = calculate($input);
  
  // Exibir o resultado para o usuário
  echo $result;
}

// Função para fazer os cálculos
function calculate($input) {
  return eval('return ' . $input . ';');
}

