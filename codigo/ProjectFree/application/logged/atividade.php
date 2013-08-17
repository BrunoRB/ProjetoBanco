<?php

require_once 'main.php';

class Atividade extends Main {
	public function __construct() {
		$this->setTitle('Atividade');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo']) && $_GET['novo'] == true) {
			$this->salvarAtividade();
		}
		else {
			if (false) { //TODO Check gerente do projeto
				$this->atividadesGerente();
			}
			else {
				$this->atividadesMembro();
			}
		}
	}

	private function atividadesGerente() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="emAndamento">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#emAndamento">Atividades em andamento</a>
				 	</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Iníciada em</th>
							<th>Data limite</th>
							<th>Predecessora</th>
							<th>Fase</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Definição do escopo</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td></td>
							<td>Elaboração</td>
						</tr>
						<tr>
							<td>Protótipos de tela</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td></td>
							<td>Construção</td>
						</tr>
						<tr>
							<td>Documento de visão e escopo</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td>Definição do escopo</td>
							<td>Levantamento de requisitos</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<form action="<?php echo SAVE_FILE;?>" method="post">
					<a class="btn btn-primary btn-large" href="atividade.php?novo=true">Cadastrar nova atividade</a>
				</form>
			</div>
		</div>

		<br> <!-- REMOVER BRBR! -->

		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="completas">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#completas">Atividades completas</a>
				 	</caption>
					<thead>
						<tr>
							<th>Terminada em</th>
							<th>Nome</th>
							<th>Iníciada em</th>
							<th>Data limite</th>
							<th>Predecessora</th>
							<th>Fase</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>xx/xx/xxxx</td>
							<td>Definição do escopo</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td></td>
							<td>Elaboração</td>
						</tr>
						<tr>
							<td>xx/xx/xxxx</td>
							<td>Protótipos de tela</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td></td>
							<td>Construção</td>
						</tr>
						<tr>
							<td>xx/xx/xxxx</td>
							<td>Documento de visão e escopo</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td>Definição do escopo</td>
							<td>Levantamento de requisitos</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<?php
	}

	private function atividadesMembro() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="emAndamento">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#emAndamento">Minhas atividades</a>
				 	</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Iníciada em</th>
							<th>Data limite</th>
							<th>Atrubuída em</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Definição do escopo</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
						</tr>
						<tr>
							<td>Protótipos de tela</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
						</tr>
						<tr>
							<td>Documento de visão e escopo</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
							<td>xx/xx/xxxx</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<?php
	}

	private function exibirAtividade() {

	}

	private function salvarAtividade() {
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

				<button type="submit" class="btn btn-primary btn-large" name="submit">Salvar</button>
			</form>
		</div>
		<?php
	}

} new Atividade();