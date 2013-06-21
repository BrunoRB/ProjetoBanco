<?php

include_once '../templates/body.php';

class Cadastro extends Body {

	public function __construct() {
		$this->setTtile('Cadastro');
		parent::__construct();
	}

	public function loadBody() {
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
	}
} new Cadastro();
