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
				<input type="text" data-type="text-simple" placeholder="Nome" name="nome" /> <br>

				Descrição:
				<textarea data-type="text-multi" name="descricao"></textarea> <br>

				Data de início:
				<input type="text" data-type="timestamp" placeholder="xx/xx/xxxx" name="dataInicio" /> <br>

				Data limite:
				<input type="text" data-type="timestamp" placeholder="xx/xx/xxxx" name="dataLimite" /> <br>

				Atividade predecessora:
				<select>
					<option>asdf</option>
				</select> <br>

				Fase do processo:
				<select>
					<option>asdf</option>
				</select> <br>

				<button type="submit" class="btn btn-primary btn-medium" name="submit">Salvar</button>
			</form>
		</div>
		<?php
	}

} new Atividade();