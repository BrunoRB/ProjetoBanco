<?php

require_once 'main.php';

class Artefato extends Main {
	public function __construct() {
		$this->setTitle('Membros');
		parent::__construct();
	}

	public function loadBody() {
		if (isset($_GET['novo'])) {
			$this->salvarArtefato();
		}
		else {
			$this->artefatos();
		}
	}

	private function artefatos() {
		?>
		<div class="row-fluid">
			<div class="span6">
				<table class="table table-hover-mod">
				 	<caption>Membros participantes no projeto</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Tipo</th>
							<th>Concluído</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td>Diagrama de caso de uso</td>
							<td>Diagrama UML</td>
							<td>90%</td>
						</tr>
						<tr>
							<td>Protótipos de tela</td>
							<td>~</td>
							<td>100%</td>
						</tr>
						<tr>
							<td>Documento de visão e escopo</td>
							<td>Documentação do processo</td>
							<td>50%</td>
						</tr>
					</tbody>
				</table>
			</div>
			<div class="span6">
				<form action="<?php echo SAVE_FILE;?>" method="post">
					<a class="btn btn-primary btn-large" href="artefato.php?novo=true">Cadastrar novo artefato</a>
				</form>
			</div>
		</div>
		<?php
	}

	private function salvarArtefato() {
		?>
		<div class="container">

			<form action="<?php echo SAVE_FILE;?>" method="post">
				Nome do artefato:
				<input type="text" data-type="text" placeholder="Nome" name="nome" /> <br>
				Tipo:
				<input type="text" data-type="text" placeholder="Tipo" name="tipo" /> <br>

				Descrição:
				<textarea data-type="text-multi"></textarea> <br>

				Porcentagem concluída:
				<input type="text" placeholder="0-100%" data-type="text-number" name="porcentagemConcluida" /> <br>

				<input type="hidden" name="entity" value="artefato" >

				<button type="submit" class="btn btn-primary btn-large" name="submit">Salvar</button>
			</form>
		</div>
		<?php
	}

} new Artefato();