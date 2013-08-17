<?php

require_once 'main.php';

class Fase extends Main {
	public function __construct() {
		$this->setTitle('Fase');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->cadastrarFase();
		}
		else {

		}
	}

	private function fase() {

	}

	private function cadastrarFase() {
		?>
		<div class="container">
			<form action="<?php echo SAVE_FILE;?>" method="post">
				Nome da fase:
				<input type="text" class="input-xlarge" data-type="text" placeholder="Nome" name="nome" /> <br>

				Descrição:
				<textarea data-type="text-multi" name="descricao"></textarea> <br>

				Fase predecessora:
				<select>
					<option>asdf</option>
				</select> <br>

				<button type="submit" class="btn btn-primary btn-medium" name="submit">Salvar</button>
			</form>
		</div>
		<?php
	}

} new Fase();