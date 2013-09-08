<?php


require_once 'main.php';

class Index extends Main {
	public function __construct() {
		$this->setTitle('Home');
		parent::__construct();
	}

	public function loadBody() {
		if (true) {
			$this->noProjectSelected();
		}
		else {
			$this->withProjectSelectd();
		}
	}

	private function noProjectSelected() {
		?>
		<div class="pagination-centered">
			<div class="row-fluid">
				<div class="span6">
					<h3>Meus projetos</h3>
				</div>
				<div class="span6">
					<h3>Últimas atividades</h3>
				</div>
			</div>
			<div class="row-fluid">
				<div class="span6">
					<h3>Mensagens recebidas</h3>
				</div>
				<div class="span6">
					<h3>Convites</h3>
				</div>
			</div>
		</div>
		<?php
	}

	private function withProjectSelectd() {
		?>

		<?php
	}
} new Index();