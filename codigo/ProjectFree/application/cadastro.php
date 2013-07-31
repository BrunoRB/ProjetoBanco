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
		echo '<h1>';
		$this->testeConnection();
		echo '</h1>';
	}

	public function testeConnection() {
		$conn = pg_connect("host=localhost port=5432 dbname=projectfree user=postgres password=afxc3hi99");
		if (!$conn) {
			echo "An error occured.\n";
			exit;
		}

		$result = pg_query($conn, "SELECT * FROM tipo");
		if (!$result) {
			echo "An error occured.\n";
			exit;
		}

		while ($row = pg_fetch_row($result)) {
			echo "value1: $row[0]  value2: $row[1]";
			echo "<br />\n";
		}


	}

} new Cadastro();

