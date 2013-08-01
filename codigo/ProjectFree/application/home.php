<?php

include_once '../templates/body.php';

class Home extends Body {

	public function __construct() {
		$this->setTtile('Projeto');
		parent::__construct();
	}

	public function loadBody() {
		?>
			bem vindo
		<?php
	}

} new Home();