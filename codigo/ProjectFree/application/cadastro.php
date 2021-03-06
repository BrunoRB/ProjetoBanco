<?php

require_once 'main.php';

class Cadastro extends Main {

	public function __construct() {
		$this->setTitle('Cadastro');
		parent::__construct();

		if (isset($_POST['salvar'])) {
			$this->salvar();
		}
	}

	protected function loadBody() {
		$this->show();
	}

	protected function show() {
		?>
		<div class="pagination-centered">
			<form method="post" action="cadastro.php">
				<div class="input-prepend">
					<span class="add-on">a-z</span>
					<input class="input-xlarge" type="text" placeholder="Nome" name="nome">
				</div>
				<br>
				<div class="input-prepend">
					<span class="add-on"><i class="icon-envelope"></i></span>
					<input class="input-xlarge" type="text" placeholder="E-mail" name="email">
				</div>
				<br>
				<div class="input-prepend">
					<span class="add-on"><i class="icon-key"></i> </span>
					<input class="input-xlarge" type="password" placeholder="Senha" name="senha">
				</div>
				<br>
				<button class="btn btn-index btn-primary" type="submit" name="salvar">Cadastrar !</button>
				<input type="hidden" name="entity" value="usuario" >
				<input type="hidden" name="fields" value="nome,email,senha">
			</form>
		</div>
		<?php
	}


} new Cadastro();

