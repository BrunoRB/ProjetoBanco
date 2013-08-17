<?php

require_once 'main.php';

class Atividade extends Main {
	public function __construct() {
		$this->setTitle('Atividade');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->cadastrarAtividade();
		}
		else {

		}
	}

	private function atividades() {

	}

	private function cadastrarAtividade() {
		?>
		<div class="container">
			<form action="<?php echo SAVE_FILE;?>" method="post">
				Nome da atividade:
				<input type="text" data-type="text" placeholder="Nome" name="nome" /> <br>

				Data de início:
				<input type="text" data-type="timestamp" placeholder="xx/xx/xxxx" name="dataInicio" /> <br>

				Data limite:
				<input type="text" data-type="timestamp" placeholder="xx/xx/xxxx" name="dataLimite" /> <br>

				Fase do processo:
				<select>
					<option>asdf</option>
				</select> <br>

				<button type="submit" class="btn btn-success btn-medium" name="submit">Cadastrar</button>
			</form>
		</div>
		<?php
	}

} new Atividade();