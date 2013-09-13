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
			<h2>Bem-vindo</h2>
		</div>
		<?php
	}

	private function withProjectSelectd() {
		?>

		<?php
	}
} new Index();