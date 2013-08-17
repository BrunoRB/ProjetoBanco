<?php

require_once '../templates/body.php';

class Login extends Body {

	public function __construct() {
		$this->setTtile('Login');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_POST['submit'])) {
			$this->login();
		}
		else {
			?>
			<div class="container">
				<form action="login.php" method="post">
					<label for="login">Login: </label>
					<input id="login" type="text" placeholder="Login" name="login" />
					<label for="senha">Senha: </label>
					<input id="senha" type="password" placeholder="Senha" name="senha" /> <br />
					<button type="submit" class="btn btn-info btn-medium" name="submit">Logar</button>
				</form>
			</div>

			<?php
		}

	}

	private function login() {
		$user = $this->createObject();

		if (!isset($user)) {
			//TODO campos faltantes
		}
		else {
			$pgConnect = new PostgresConnection();

			$attrArray = array(
				$usuario->getLogin(),
				$usuario->getSenha()
			);

			$functionName = 'usuarioLogar';
			$parameters = array($usuario->getLogin(), $usuario->getSenha());

			$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
			$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);


			if ($pgConnect->getResult($retval)) {

			}


			$pgConnect->closeConnection();
		}
	}

	private function createObject() {
		if (isset($_POST['login']) && isset($_POST['senha'])) {
			$usuario = new Usuario();
			$usuario->setLogin($_POST['login']);
			$usuario->setSenha($_POST['senha']);
		}
		else {
			return null;
		}
	}

} new Login();
