<?php

include_once '../templates/body.php';

class Login extends Body {

	public function __construct() {
		$this->setTtile('Login');
		parent::__construct();
	}

	public function loadBody() {
		?>
		<div class="container">
			<label for="login">Login: </label>
			<input id="login" type="text" placeholder="Login" />
			<label for="senha">Senha: </label>
			<input id="senha" type="password" placeholder="Senha" /> <br />
			<button type="submit" class="btn btn-info btn-medium">Logar</button>
		</div>

		<?php
	}
} new Login();
