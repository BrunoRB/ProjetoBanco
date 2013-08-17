<?php

require_once 'main.php';

class Fase extends Main {
	public function __construct() {
		$this->setTitle('Fase');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->salvarFase();
		}
		else {
			$this->listarFase();
		}
	}

	private function listarFase() {
		?>
		<div class="row-fluid">
			<div class="span4 collapse-group accordion-group" id="fases">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#fases">Fases</a>
				 	</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Predecessora</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Elaboração</td>
							<td></td>
						</tr>
						<tr>
							<td>Construção</td>
							<td>Elaboração</td>
						</tr>
						<tr>
							<td>Documento de visão e escopo</td>
							<td>Testes</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<form action="<?php echo SAVE_FILE;?>" method="post">
					<a class="btn btn-primary btn-large" href="fase.php?novo=true">Cadastrar nova fase</a>
				</form>
			</div>
		</div>
		<?php
	}

	private function exibirFase() {

	}

	private function salvarFase() {
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

				<button type="submit" class="btn btn-primary btn-large" name="submit">Salvar</button>
			</form>
		</div>
		<?php
	}

} new Fase();