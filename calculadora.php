<form method="post">
  <input type="text" name="input" value="<?php echo $input; ?>">
  <input type="submit" name="calculate" value="Calcular">
</form>
<?php
if (isset($_POST['calculate'])) {
  $input = $_POST['input'];
  $result = calculate($input);
  echo $result;
}
function calculate($input) {
  return eval('return ' . $input . ';');
}
