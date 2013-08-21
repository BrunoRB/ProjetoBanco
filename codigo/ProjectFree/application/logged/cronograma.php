<?php

require_once 'main.php';

class Cronograma extends Main {

	public function __construct() {
		$this->setTitle('Cronograma');
		parent::__construct();
	}

	public function loadBody() {
		$this->show();
	}

	private function show() {
		?>
		<div>
			<table class="table table-hover-mod table-bordered cronograma">
			 	<caption>Cronograma</caption>
				<thead>
					<tr>
						<th>Código</th>
						<th>Atividade</th>
						<th>Data início</th>
						<th>Data limite</th>
						<th>Data Término</th>
						<th>Predecessora</th>
						<th>Fase</th>
						<th>Nº de participantes</th>
						<th>Nº artefatos relacionados<th>
					</tr>
				</thead>
				<tbody>
				<?php for ($i=1; $i<20; $i++) {?>
					<tr>
						<td><?php echo $i;?></td>
						<td>Nome_Atividade</td>
						<td>dd/mm/yyyy</td>
						<td>dd/mm/yyyy</td>
						<td>dd/mm/yyyy</td>
						<td><?php echo $i + 2;?></td>
						<td><?php echo $i;?></td>
						<td><?php echo rand(0, 1000);?></td>
						<td><?php echo rand(0, 10);?></td>
					</tr>
				<?php }?>
				</tbody>
			</table>
		</div>
		<?php
	}

} new Cronograma();

