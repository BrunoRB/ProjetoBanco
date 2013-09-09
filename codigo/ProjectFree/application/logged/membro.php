<?php

require_once 'main.php';

class Fase extends Main {
	public function __construct() {
		$this->setTitle('Membros');
		parent::__construct();
	}

	public function loadBody() {
		if (true) { //TODO check permission. Page only for Project Manager
			$this->membros();
		}
		else {

		}
	}

	private function membros() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="membros">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#membros">Membros do projeto</a>
				 	</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Função</th>
							<th>N de atividades atuais</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Bruno</td>
							<td>Tal</td>
							<td>999</td>
						</tr>
						<tr>
							<td>Maikon</td>
							<td>Tal</td>
							<td>899</td>
						</tr>
						<tr>
							<td>Fabricio</td>
							<td>Tal</td>
							<td>799</td>

						</tr>
						<tr>
							<td>Ebara</td>
							<td>Tal</td>
							<td>699</td>

						</tr>
						<tr>
							<td>Roberto</td>
							<td>Tal</td>
							<td>599</td>

						</tr>
					</tbody>
				</table>
			</div>
			<div class="span4">
				<form action="<?php echo SAVE_FILE;?>" method="post">
					Convidar membro:
					<input type="text" class="input-xlarge" data-type="text-autocomplete" placeholder="Comece a digitar" name="membro" /> <br>

					<button type="button" class="btn btn-primary btn-large" name="submit">Convidar</button>

				</form>
			</div>
		</div>
		<?php
	}

	private function convidarMembro() {

	}

} new Fase();