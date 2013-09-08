<?php

require_once 'main.php';

class Page_Artefato extends Main {
	public function __construct() {
		$this->setTitle('Artefato');
		parent::__construct();
	}

	protected function listar() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="artefatos">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#artefatos">Artefatos</a>
				 	</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Tipo</th>
							<th>Descrição</th>
							<th>Porcentagem concluída</th>
						</tr>
					</thead>
					<tbody>
						<?php
						$this->retrieveList(array('nome', 'tipo', 'descricao', 'porcentagem_concluida'));
						?>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<a class="btn btn-primary btn-large" href="artefato.php?novo=true">Cadastrar novo artefato</a>
			</div>
		</div>
		<?php
	}

} new Page_Artefato();