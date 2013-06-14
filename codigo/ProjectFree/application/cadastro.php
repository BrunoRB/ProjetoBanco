<?php

include_once '../templates/header.php';

?>

<div class="container">
	<label for="nome">Nome: </label>
	<input id="nome" type="text" placeholder="Nome" />
	<label for="login">Login: </label>
	<input id="login" type="text" placeholder="Login" />
	<label for="senha">Senha: </label>
	<input id="senha" type="password" placeholder="Senha" /> <br />
	<button type="submit" class="btn btn-success btn-medium">Cadastrar !</button>
</div>

<?php

include_once '../templates/footer.php';