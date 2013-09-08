<?php

require_once 'main.php';

class Page_Atividade extends Main {
	public function __construct() {
		$this->setTitle('Atividade');
		parent::__construct();
	}

	protected function listar() {
		?>
		<div class="row-fluid">
			<div class="span7 collapse-group accordion-group" id="atividades">
				<table class="table table-hover-mod">
				 	<caption>
				 		<a data-toggle="collapse" data-target="#atividades">Atividades</a>
				 	</caption>
					<thead>
						<tr>
							<th>Nome</th>
							<th>Descrição</th>
						</tr>
					</thead>
					<tbody>
						<?php
						$this->retrieveList(array('nome', 'descricao'));
						?>
					</tbody>
				</table>
			</div>
			<div class="span5">
				<a class="btn btn-primary btn-large" href="atividade.php?novo=true">Cadastrar nova fase</a>
			</div>
		</div>
		<?php
	}

} new Page_Atividade();