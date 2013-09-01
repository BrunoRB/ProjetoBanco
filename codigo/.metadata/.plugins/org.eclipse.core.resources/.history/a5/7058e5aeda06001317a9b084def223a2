<?php

require_once 'main.php';

class Projeto extends Main {

	public function __construct() {
		$this->setTitle('Projetos');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->cadastrarProjeto();
		}
		else {
			$this->projetos();
		}
	}

	private function projetos() {
		?>
		<div>
			<h2>Meus projetos</h2>
		</div>
		<div>
			<a class="btn btn-primary" href="projeto.php?novo=true">Criar novo projeto</a>
		</div>
		<?php
	}

	private function cadastrarProjeto() {
		?>
		<div class="container">

			<form action="<?php echo SAVE_FILE;?>" method="post">
				<label for="nome">Nome do projeto: </label>
				<input id="nome" type="text" placeholder="Nome" name="nome" />
				<label for="login">Login: </label>
				<input id="login" type="text" placeholder="Login" name="login" />
				<label for="senha">Senha: </label>
				<input id="senha" type="password" placeholder="Senha" name="senha" /> <br />
				<button type="submit" class="btn btn-success btn-medium" name="submit">Cadastrar</button>
			</form>
		</div>
		<?php
	}


} new Projeto();