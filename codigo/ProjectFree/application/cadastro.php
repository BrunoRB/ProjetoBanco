<?php

require_once '../templates/body.php';
require_once 'entitys/Usuario.php';

class Cadastro extends Body {

	public function __construct() {
		$this->setTtile('Cadastro');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_POST['submit'])) {
			$this->save();
		}

		?>

		<div class="container">
			<form action="cadastro.php" method="post">
				<label for="nome">Nome: </label>
				<input id="nome" type="text" placeholder="Nome" name="nome" />
				<label for="login">Login: </label>
				<input id="login" type="text" placeholder="Login" name="login" />
				<label for="senha">Senha: </label>
				<input id="senha" type="password" placeholder="Senha" name="senha" /> <br />
				<button type="submit" class="btn btn-primary btn-medium" name="submit">Cadastrar !</button>
			</form>
		</div>

		<?php


	}

	private function save() {
		$usuario = $this->createObject();

		if (!isset($usuario)) {
			//TODO error message
		}

		$pgConnect = new PostgresConnection();

		$attrArray = array(
			$usuario->getNome(),
			$usuario->getLogin(),
			$usuario->getSenha()
		);

		$functionName = 'usuarioCadastrar';
		$parameters = array($usuario->getNome(), $usuario->getLogin(), $usuario->getSenha());

		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);


		if ($pgConnect->getResult($retval)) {

		}


		$pgConnect->closeConnection();


	}

	private function createObject() {
		if (isset($_POST['login']) && isset($_POST['senha']) && isset($_POST['nome'])) {
			$usuario = new Usuario();
			$usuario->setNome($_POST['nome']);
			$usuario->setLogin($_POST['login']);
			$usuario->setSenha($_POST['senha']);

			return $usuario;
		}

		return null;
	}


} new Cadastro();

