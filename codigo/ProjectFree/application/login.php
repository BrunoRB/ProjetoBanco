<?php


require_once 'main.php';


class Page_Login extends Main {

	public function __construct() {
		$this->setTitle('Home');
		parent::__construct();
	}

	protected function loadBody() {
		global $userId;
		if ($userId === false || !isset($userId)) {
			if (isset($_POST['submit'])) {
				$this->login();
			}
			else {
				$this->show();
			}
		}
		else {
			if (isset($_GET['logout']) && $_GET['logout'] == true) {
				$this->deslogar();
			}
			else {
				$this->showAlredyLogged();
			}
		}
	}

	protected function show() {
		?>
		<div class="pagination-centered">
			<form method="post" action="login.php">
				<div class="input-prepend">
					<span class="add-on"><i class="icon-envelope"></i></span> <input
						class="input-xlarge" type="text" placeholder="E-mail" name="email">
				</div>
				<br>
				<div class="input-prepend">
					<span class="add-on"><i class="icon-key"></i> </span> <input
						class="input-xlarge" type="password" placeholder="Senha"
						name="senha">
				</div>
				<br>
				<button class="btn btn-index btn-primary" type="submit" name="submit">Logar</button>
			</form>
		</div>
		<?php
	}

	protected function showAlredyLogged() {
		?>
			<h2>
				Você já se encontra logado nesse momento,
				<a href="login.php?logout=true">
					clique aqui para deslogar
					<i class="icon-signout"></i>
				</a>
			</h2>
		<?php
	}

	protected function login() {
		if (empty($_POST['email']) || empty($_POST['senha'])) {
			$this->show();
			printErrorMessage('Erro, preencha os campos login e senha !');
		}
		else {
			$pgConnect = new PostgresConnection();
			$functionName = 'logar';
			$parameters = array($_POST['email'], $_POST['senha']);
			$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));
			$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);
			$result = $pgConnect->getResult($retval);
			$result = current($result)['logar'];
			$pgConnect->closeConnection();

			if (isset($result) && $result > 0) {
				$this->storeloginOnSession($result);
				redirect('logged/index.php');
			}
			else {
				unset($_POST);
				$this->show();
				printErrorMessage('Erro, login e/ou senha inválidos !');
			}
		}
	}

	protected function storeloginOnSession($id) {
		if (isset($id) && $id !== false) {
			$_SESSION['userId'] = $id;
		}
		else {
			unset($_SESSION['userId']);
			unset($_SESSION['projectId']);
		}
	}

	protected function deslogar() {
		$pgConnect = new PostgresConnection();
		$functionName = 'deslogar';
		global $userId;
		$parameters = array($userId);

		$prepare = $pgConnect->prepareFunctionStatement($functionName, count($parameters));

		$retval = $pgConnect->executeFunctionStatement($functionName, $parameters);

		$result = $pgConnect->getResult($retval);

		$id = current(current($result));

		$pgConnect->closeConnection();
		$this->storeloginOnSession(false);
		redirect('index.php');
	}

} new Page_Login();
