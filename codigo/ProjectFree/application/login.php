<?php

require_once 'main.php';

class Login extends Main {

	public function __construct() {
		$this->setTitle('Home');
		parent::__construct();
	}

	public function loadBody() {
		global $userId;
		if ($userId === false) {
			if (isset($_POST['submit'])) {
				$this->login();
			}
			else {
				$this->show();
			}
		}
		else {
			if (isset($_GET['logout']) && $_GET['logout'] == true) {
				$this->storeloginOnSession(false);
				redirect('index.php');
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



} new Login();
